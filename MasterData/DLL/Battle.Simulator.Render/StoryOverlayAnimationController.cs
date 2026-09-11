using System.Collections.Generic;
using Sirenix.OdinInspector;
using UnityEngine;
using UnityEngine.Animations;
using UnityEngine.Playables;

[ExecuteInEditMode]
public class StoryOverlayAnimationController : SerializedMonoBehaviour
{
	private bool _hasInsertedClip;

	private AnimationClipPlayable m_clip;

	private AnimationMixerPlayable m_mixer;

	private AnimationLayerMixerPlayable m_layerMixer;

	private int m_layerIndex;

	private float _playStartTime;

	private float _playDuration;

	private float _blendInTime;

	private float _blendOutTime;

	private bool _playing;

	private void TestPlayOverlayAnimation(PlayableDirector director, StoryOverlayAnimationConfig config, string clipName, string avatarMaskName, float blendInTime, float blendOutTime)
	{
		if (director.state != PlayState.Playing)
		{
			director.Play();
		}
		PlayOverlayAnimation(director, config, clipName, avatarMaskName, blendInTime, blendOutTime);
	}

	private void Update()
	{
		UpdateOverlayAnimation();
	}

	public void PlayOverlayAnimation(PlayableDirector director, Object config, string clipName, string avatarMaskName, float blendInTime, float blendOutTime)
	{
		if (_hasInsertedClip)
		{
			DestroyOverlayAnimation();
		}
		InsertAnimationPlayableToPlayableGraph(director, config as StoryOverlayAnimationConfig, clipName, avatarMaskName);
		if (!_hasInsertedClip)
		{
			Debug.LogError($"没有成功把动画:{clipName} 插入{director}", director.gameObject);
			return;
		}
		_playStartTime = Time.time;
		_blendInTime = blendInTime;
		_blendOutTime = blendOutTime;
		m_clip.SetTime(0.0);
		m_clip.SetDuration(_playDuration);
		m_clip.Play();
		_playing = true;
	}

	private void UpdateOverlayAnimation()
	{
		if (!_playing)
		{
			return;
		}
		if (m_layerMixer.IsNull())
		{
			_playing = false;
			return;
		}
		float num = Time.time - _playStartTime;
		float num2 = 1f;
		if (_blendInTime > 0f && num <= _blendInTime)
		{
			num2 = Mathf.Clamp01(num / _blendInTime);
		}
		if (_blendOutTime > 0f && num >= _playDuration)
		{
			num2 = 1f - Mathf.Clamp01((num - _playDuration) / _blendOutTime);
		}
		if (num > _playDuration + _blendOutTime)
		{
			_playing = false;
			num2 = 0f;
		}
		float weight = (1f - num2) / (float)Mathf.Max(m_layerMixer.GetInputCount() - 1, 1);
		for (int i = 0; i < m_layerMixer.GetInputCount(); i++)
		{
			if (i != m_layerIndex)
			{
				m_layerMixer.SetInputWeight(i, weight);
			}
		}
		m_layerMixer.SetInputWeight(m_layerIndex, num2);
		if (!_playing)
		{
			DestroyOverlayAnimation();
		}
	}

	private void DestroyOverlayAnimation()
	{
		if (_hasInsertedClip)
		{
			_hasInsertedClip = false;
			if (!m_layerMixer.IsNull())
			{
				Playable input = m_layerMixer.GetInput(m_layerIndex);
				m_layerMixer.DisconnectInput(m_layerIndex);
				DestroyPlayableRecursive(input);
			}
		}
	}

	private void DestroyPlayableRecursive(Playable playable)
	{
		if (!playable.IsValid())
		{
			return;
		}
		for (int i = 0; i < playable.GetInputCount(); i++)
		{
			Playable input = playable.GetInput(i);
			if (input.IsValid())
			{
				DestroyPlayableRecursive(input);
				playable.DisconnectInput(i);
			}
		}
		playable.Destroy();
	}

	private void InsertAnimationPlayableToPlayableGraph(PlayableDirector director, StoryOverlayAnimationConfig config, string clipName, string avatarMaskName)
	{
		if (_hasInsertedClip || director == null || config == null)
		{
			return;
		}
		PlayableGraph playableGraph = director.playableGraph;
		if (playableGraph.IsValid() && config.animationClips.TryGetValue(clipName, out var value) && config.avatarMasks.TryGetValue(avatarMaskName, out var value2))
		{
			AnimationLayerMixerPlayable? animationLayerMixerPlayable = FindAnimationLayerMixer(playableGraph);
			if (!animationLayerMixerPlayable.HasValue)
			{
				Debug.LogError("找不到 AnimationLayerMixerPlayable 节点");
				return;
			}
			AnimationLayerMixerPlayable value3 = animationLayerMixerPlayable.Value;
			AnimationClipPlayable animationClipPlayable = AnimationClipPlayable.Create(playableGraph, value);
			animationClipPlayable.SetTime(0.0);
			m_clip = animationClipPlayable;
			AnimationMixerPlayable animationMixerPlayable = AnimationMixerPlayable.Create(playableGraph, 1, normalizeWeights: true);
			playableGraph.Connect(animationClipPlayable, 0, animationMixerPlayable, 0);
			animationMixerPlayable.SetInputWeight(0, 1f);
			m_mixer = animationMixerPlayable;
			m_layerIndex = value3.GetInputCount();
			value3.AddInput(animationMixerPlayable, 0);
			value3.SetLayerMaskFromAvatarMask((uint)m_layerIndex, value2);
			value3.SetInputWeight(m_layerIndex, 1f);
			m_layerMixer = value3;
			_playDuration = value.length;
			_hasInsertedClip = true;
		}
	}

	private AnimationLayerMixerPlayable? FindAnimationLayerMixer(PlayableGraph graph, int maxDepth = 10)
	{
		Playable rootPlayable = graph.GetRootPlayable(0);
		if (rootPlayable.IsNull())
		{
			return null;
		}
		HashSet<Playable> visited = new HashSet<Playable>();
		return FindAnimationLayerMixerRecursive(graph, rootPlayable, 0, maxDepth, visited);
	}

	private static AnimationLayerMixerPlayable? FindAnimationLayerMixerRecursive(PlayableGraph graph, Playable current, int currentDepth, int maxDepth, HashSet<Playable> visited)
	{
		if (currentDepth > maxDepth || visited.Contains(current))
		{
			return null;
		}
		visited.Add(current);
		if (current.IsPlayableOfType<AnimationLayerMixerPlayable>())
		{
			return (AnimationLayerMixerPlayable)current;
		}
		for (int i = 0; i < current.GetInputCount(); i++)
		{
			if (!current.GetInput(i).IsNull())
			{
				AnimationLayerMixerPlayable? result = FindAnimationLayerMixerRecursive(graph, current.GetInput(i), currentDepth + 1, maxDepth, visited);
				if (result.HasValue)
				{
					return result;
				}
			}
		}
		int outputCount = graph.GetOutputCount();
		for (int j = 0; j < outputCount; j++)
		{
			PlayableOutput output = graph.GetOutput(j);
			if (!output.IsOutputNull() && output.GetSourcePlayable().Equals(current))
			{
				AnimationLayerMixerPlayable? result2 = FindAnimationLayerMixerRecursive(graph, output.GetSourcePlayable(), currentDepth + 1, maxDepth, visited);
				if (result2.HasValue)
				{
					return result2;
				}
			}
		}
		return null;
	}
}
