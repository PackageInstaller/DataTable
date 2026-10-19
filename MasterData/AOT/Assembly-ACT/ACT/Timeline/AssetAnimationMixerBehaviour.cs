using System;
using ACT.UI;
using Bamboo.AssetField;
using Fundamental;
using UnityEngine;
using UnityEngine.Animations;
using UnityEngine.Playables;

namespace ACT.Timeline;

[Serializable]
public class AssetAnimationMixerBehaviour : PlayableBehaviour
{
	public string assetPath;

	private bool m_Initialized;

	private GameObject m_LoadedInstance;

	private AssetLoadHandle m_LoadHandle;

	private Animator m_Animator;

	private AnimationMixerPlayable m_AnimationMixer;

	private AnimationPlayableOutput m_AnimationOutput;

	public override void OnGraphStart(Playable playable)
	{
		if (m_Initialized || string.IsNullOrEmpty(assetPath))
		{
			return;
		}
		m_Initialized = true;
		FullScreenVideoView fullScreenVideoView = Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_FULLSCREENVIDEO) as FullScreenVideoView;
		Transform transform = ((fullScreenVideoView != null) ? fullScreenVideoView.hangObject.transform : null);
		if (transform != null)
		{
			m_LoadHandle = AssetStationManager.Root.Instantiate(assetPath, transform);
		}
		else
		{
			m_LoadHandle = AssetStationManager.Root.Instantiate(assetPath);
		}
		m_LoadedInstance = m_LoadHandle.AsGameObject();
		if (m_LoadedInstance == null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("[AssetAnimationTrack] Failed to load asset: " + assetPath);
			}
			return;
		}
		m_LoadedInstance.SetActive(value: true);
		m_Animator = m_LoadedInstance.GetComponent<Animator>();
		if (m_Animator == null)
		{
			m_Animator = m_LoadedInstance.AddComponent<Animator>();
		}
		PlayableGraph graph = playable.GetGraph();
		int inputCount = playable.GetInputCount();
		m_AnimationMixer = AnimationMixerPlayable.Create(graph, inputCount);
		for (int i = 0; i < inputCount; i++)
		{
			AssetAnimationBehaviour behaviour = ((ScriptPlayable<AssetAnimationBehaviour>)playable.GetInput(i)).GetBehaviour();
			if (!(behaviour.animationClip == null))
			{
				AnimationClipPlayable animationClipPlayable = AnimationClipPlayable.Create(graph, behaviour.animationClip);
				animationClipPlayable.SetSpeed(0.0);
				animationClipPlayable.SetTime(0.0);
				graph.Connect(animationClipPlayable, 0, m_AnimationMixer, i);
				behaviour.animationClipPlayable = animationClipPlayable;
				behaviour.animationMixerPlayable = m_AnimationMixer;
				behaviour.index = i;
			}
		}
		m_AnimationOutput = AnimationPlayableOutput.Create(graph, "AssetAnimation", m_Animator);
		m_AnimationOutput.SetSourcePlayable(m_AnimationMixer);
	}

	public override void OnGraphStop(Playable playable)
	{
		ReleaseAsset();
	}

	public override void OnPlayableDestroy(Playable playable)
	{
		ReleaseAsset();
	}

	private void ReleaseAsset()
	{
		if (m_LoadedInstance != null)
		{
			AssetStationManager.Root.ReleaseInstance(m_LoadHandle);
			m_LoadedInstance = null;
		}
		m_Initialized = false;
	}
}
