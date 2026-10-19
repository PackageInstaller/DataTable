using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;
using UnityEngine.Animations;
using UnityEngine.Playables;
using UnityEngine.Timeline;
using uLipSync;

namespace ACT.Timeline;

public sealed class GachaLipSyncMixer : PlayableBehaviour
{
	private sealed class MouthClipBinding
	{
		public uLipSyncAnimator.AnimatorInfo animatorInfo;

		public int mixerInputIndex;

		public float smoothedWeight;

		public float weightVelocity;
	}

	public TimelineClip[] clips;

	private uLipSyncAnimator target;

	private Animator animator;

	private AnimationMixerPlayable mouthMixer;

	private AnimationLayerMixerPlayable animationLayerMixer;

	private readonly List<MouthClipBinding> mouthClipBindings = new List<MouthClipBinding>();

	private readonly Dictionary<string, float> phonemeRatios = new Dictionary<string, float>();

	private float smoothedVolume;

	private float volumeVelocity;

	private bool playableLayerInitialized;

	private bool connectionFailed;

	private bool initializationWarningLogged;

	private GachaLipSyncMouthGate mouthGate;

	private bool mouthGateCreated;

	private const float SpeakingEnergyThreshold = 0.02f;

	public override void OnBehaviourPause(Playable playable, FrameData info)
	{
		if (target != null)
		{
			target.OnLipSyncUpdate(BakedData.GetLipSyncInfo(BakedFrame.zero));
		}
		ResetMouthLayer();
	}

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		uLipSyncAnimator uLipSyncAnimator2 = playerData as uLipSyncAnimator;
		if (uLipSyncAnimator2 != null)
		{
			target = uLipSyncAnimator2;
		}
		if (target == null || clips == null)
		{
			return;
		}
		TryInitializePlayableLayer(playable, target);
		float num = 0f;
		bool hasActiveLipSyncClip = false;
		phonemeRatios.Clear();
		for (int i = 0; i < clips.Length; i++)
		{
			GachaLipSyncClip gachaLipSyncClip = clips[i].asset as GachaLipSyncClip;
			if (gachaLipSyncClip == null || gachaLipSyncClip.behaviour == null || gachaLipSyncClip.bakedData == null)
			{
				continue;
			}
			float inputWeight = playable.GetInputWeight(i);
			if (inputWeight > 0.0001f)
			{
				hasActiveLipSyncClip = true;
			}
			num += gachaLipSyncClip.behaviour.frame.volume * gachaLipSyncClip.volume * inputWeight;
			foreach (BakedPhonemeRatio phoneme in gachaLipSyncClip.behaviour.frame.phonemes)
			{
				phonemeRatios.TryGetValue(phoneme.phoneme, out var value);
				phonemeRatios[phoneme.phoneme] = value + phoneme.ratio * inputWeight;
			}
		}
		LipSyncInfo lipSyncInfo = BakedData.GetLipSyncInfo(new BakedFrame
		{
			volume = num,
			phonemes = phonemeRatios.Select((KeyValuePair<string, float> pair) => new BakedPhonemeRatio
			{
				phoneme = pair.Key,
				ratio = pair.Value
			}).ToList()
		});
		target.OnLipSyncUpdate(lipSyncInfo);
		UpdateMouthLayer(lipSyncInfo, hasActiveLipSyncClip, info.deltaTime);
	}

	private bool TryInitializePlayableLayer(Playable playable, uLipSyncAnimator boundTarget)
	{
		if (playableLayerInitialized)
		{
			return true;
		}
		if (connectionFailed)
		{
			return false;
		}
		if (boundTarget == null)
		{
			return false;
		}
		target = boundTarget;
		animator = (target.animator ? target.animator : target.GetComponent<Animator>());
		if (!animator || !animator.runtimeAnimatorController)
		{
			LogInitializationWarning("绑定对象缺少 Animator 或 RuntimeAnimatorController");
			return false;
		}
		PlayableGraph graph = playable.GetGraph();
		if (!graph.IsValid())
		{
			return false;
		}
		if (!TryFindCharacterAnimationOutput(graph, animator, out var animationOutput))
		{
			return false;
		}
		if (!TryResolveTimelineAnimationTrack(animationOutput, out var timelinePlayable, out var timelineInputPort, out var bodyAnimationPlayable, out var timelineInputWeight))
		{
			return false;
		}
		List<(uLipSyncAnimator.AnimatorInfo, AnimationClip)> list = CollectMouthClipMappings(animator.runtimeAnimatorController, target);
		if (list.Count == 0)
		{
			LogInitializationWarning("AnimatorController 中没有找到与 A/E/I/O/U/V 参数对应的口型 Clip");
			return false;
		}
		mouthMixer = AnimationMixerPlayable.Create(graph, list.Count, normalizeWeights: false);
		mouthClipBindings.Clear();
		for (int i = 0; i < list.Count; i++)
		{
			(uLipSyncAnimator.AnimatorInfo, AnimationClip) tuple = list[i];
			AnimationClipPlayable animationClipPlayable = AnimationClipPlayable.Create(graph, tuple.Item2);
			animationClipPlayable.SetTime(0.0);
			animationClipPlayable.SetSpeed(0.0);
			animationClipPlayable.SetApplyFootIK(value: false);
			animationClipPlayable.SetApplyPlayableIK(value: false);
			graph.Connect(animationClipPlayable, 0, mouthMixer, i);
			mouthMixer.SetInputWeight(i, 0f);
			mouthClipBindings.Add(new MouthClipBinding
			{
				animatorInfo = tuple.Item1,
				mixerInputIndex = i
			});
		}
		AnimationLayerMixerPlayable animationLayerMixerPlayable = AnimationLayerMixerPlayable.Create(graph, 2);
		graph.Disconnect(timelinePlayable, timelineInputPort);
		bool flag = graph.Connect(bodyAnimationPlayable, 0, animationLayerMixerPlayable, 0);
		bool flag2 = graph.Connect(mouthMixer, 0, animationLayerMixerPlayable, 1);
		bool flag3 = (flag & flag2) && graph.Connect(animationLayerMixerPlayable, 0, timelinePlayable, timelineInputPort);
		if (!flag || !flag2 || !flag3)
		{
			RestoreBodyAnimationConnection(graph, timelinePlayable, timelineInputPort, timelineInputWeight, bodyAnimationPlayable, animationLayerMixerPlayable);
			connectionFailed = true;
			LogInitializationWarning("连接 Timeline 身体动画与口型动画层失败");
			return false;
		}
		animationLayerMixerPlayable.SetInputWeight(0, 1f);
		animationLayerMixerPlayable.SetInputWeight(1, 0f);
		animationLayerMixerPlayable.SetLayerAdditive(0u, value: false);
		animationLayerMixerPlayable.SetLayerAdditive(1u, value: false);
		timelinePlayable.SetInputWeight(timelineInputPort, timelineInputWeight);
		animationLayerMixer = animationLayerMixerPlayable;
		EnsureMouthGate(animator);
		CapturePhonemePoses();
		playableLayerInitialized = true;
		initializationWarningLogged = false;
		return true;
	}

	private void UpdateMouthLayer(LipSyncInfo lipSyncInfo, bool hasActiveLipSyncClip, float deltaTime)
	{
		if (!playableLayerInitialized || !mouthMixer.IsValid() || !animationLayerMixer.IsValid())
		{
			return;
		}
		float targetValue = NormalizeVolume(lipSyncInfo.rawVolume);
		smoothedVolume = SmoothDamp(smoothedVolume, targetValue, ref volumeVelocity, deltaTime);
		float num = 0f;
		for (int i = 0; i < mouthClipBindings.Count; i++)
		{
			MouthClipBinding mouthClipBinding = mouthClipBindings[i];
			float value = 0f;
			if (lipSyncInfo.phonemeRatios != null && !string.IsNullOrEmpty(mouthClipBinding.animatorInfo.phoneme))
			{
				lipSyncInfo.phonemeRatios.TryGetValue(mouthClipBinding.animatorInfo.phoneme, out value);
			}
			mouthClipBinding.smoothedWeight = SmoothDamp(mouthClipBinding.smoothedWeight, value, ref mouthClipBinding.weightVelocity, deltaTime);
			num += mouthClipBinding.smoothedWeight;
		}
		float num2 = 0f;
		for (int j = 0; j < mouthClipBindings.Count; j++)
		{
			MouthClipBinding mouthClipBinding2 = mouthClipBindings[j];
			float num3 = ((num > 0f) ? (mouthClipBinding2.smoothedWeight / num) : 0f) * mouthClipBinding2.animatorInfo.maxWeight * smoothedVolume;
			mouthMixer.SetInputWeight(mouthClipBinding2.mixerInputIndex, num3);
			num2 += num3;
			animator.SetFloat(mouthClipBinding2.animatorInfo.nameHash, num3);
		}
		bool flag = hasActiveLipSyncClip && num2 > 0.02f;
		animationLayerMixer.SetInputWeight(1, flag ? 1f : 0f);
		ApplyMouthGate(hasActiveLipSyncClip);
	}

	private float NormalizeVolume(float rawVolume)
	{
		if (rawVolume <= 0f)
		{
			return 0f;
		}
		return Mathf.Clamp01((Mathf.Log10(rawVolume) - target.minVolume) / Mathf.Max(target.maxVolume - target.minVolume, 0.0001f));
	}

	private float SmoothDamp(float current, float targetValue, ref float velocity, float deltaTime)
	{
		if (target.smoothness <= 0f || deltaTime <= 0f)
		{
			velocity = 0f;
			if (!(Mathf.Abs(targetValue) < target.minimalValueThreshold))
			{
				return targetValue;
			}
			return 0f;
		}
		float num = Mathf.SmoothDamp(current, targetValue, ref velocity, target.smoothness, float.PositiveInfinity, deltaTime);
		if (!(Mathf.Abs(num) < target.minimalValueThreshold))
		{
			return num;
		}
		return 0f;
	}

	private void ResetMouthLayer()
	{
		if (mouthMixer.IsValid())
		{
			for (int i = 0; i < mouthClipBindings.Count; i++)
			{
				mouthMixer.SetInputWeight(mouthClipBindings[i].mixerInputIndex, 0f);
			}
		}
		if (animationLayerMixer.IsValid())
		{
			animationLayerMixer.SetInputWeight(1, 0f);
		}
		if (mouthGate != null)
		{
			mouthGate.SetSuppressIdleMouth(suppress: false);
		}
		for (int j = 0; j < mouthClipBindings.Count; j++)
		{
			mouthClipBindings[j].smoothedWeight = 0f;
			mouthClipBindings[j].weightVelocity = 0f;
		}
		smoothedVolume = 0f;
		volumeVelocity = 0f;
	}

	private static bool TryFindCharacterAnimationOutput(PlayableGraph graph, Animator targetAnimator, out AnimationPlayableOutput animationOutput)
	{
		animationOutput = default;
		int num = -1;
		bool result = false;
		for (int i = 0; i < graph.GetOutputCount(); i++)
		{
			PlayableOutput output = graph.GetOutput(i);
			if (!output.IsOutputValid() || output.GetPlayableOutputType() != typeof(AnimationPlayableOutput))
			{
				continue;
			}
			AnimationPlayableOutput animationPlayableOutput = (AnimationPlayableOutput)output;
			if (!(animationPlayableOutput.GetTarget() != targetAnimator))
			{
				result = true;
				int num2 = CountAnimationClipInputs(animationPlayableOutput);
				if (num2 >= num)
				{
					num = num2;
					animationOutput = animationPlayableOutput;
				}
			}
		}
		return result;
	}

	private static int CountAnimationClipInputs(AnimationPlayableOutput animationOutput)
	{
		Playable sourcePlayable = animationOutput.GetSourcePlayable();
		int sourceOutputPort = animationOutput.GetSourceOutputPort();
		if (!sourcePlayable.IsValid() || sourceOutputPort < 0 || sourceOutputPort >= sourcePlayable.GetInputCount())
		{
			return 0;
		}
		return CountAnimationClipInputs(sourcePlayable.GetInput(sourceOutputPort));
	}

	private static int CountAnimationClipInputs(Playable node)
	{
		if (!node.IsValid())
		{
			return 0;
		}
		if (node.GetPlayableType() == typeof(AnimationClipPlayable))
		{
			return 1;
		}
		int num = 0;
		for (int i = 0; i < node.GetInputCount(); i++)
		{
			num += CountAnimationClipInputs(node.GetInput(i));
		}
		return num;
	}

	private static bool TryResolveTimelineAnimationTrack(AnimationPlayableOutput animationOutput, out Playable timelinePlayable, out int timelineInputPort, out Playable bodyAnimationPlayable, out float timelineInputWeight)
	{
		timelinePlayable = animationOutput.GetSourcePlayable();
		timelineInputPort = animationOutput.GetSourceOutputPort();
		bodyAnimationPlayable = Playable.Null;
		timelineInputWeight = 0f;
		if (!timelinePlayable.IsValid() || timelineInputPort < 0 || timelineInputPort >= timelinePlayable.GetInputCount())
		{
			return false;
		}
		bodyAnimationPlayable = timelinePlayable.GetInput(timelineInputPort);
		if (!bodyAnimationPlayable.IsValid() || bodyAnimationPlayable.GetOutputCount() <= 0)
		{
			return false;
		}
		timelineInputWeight = timelinePlayable.GetInputWeight(timelineInputPort);
		return true;
	}

	private static void RestoreBodyAnimationConnection(PlayableGraph graph, Playable timelinePlayable, int timelineInputPort, float timelineInputWeight, Playable bodyAnimationPlayable, AnimationLayerMixerPlayable failedLayerMixer)
	{
		graph.Disconnect(timelinePlayable, timelineInputPort);
		if (failedLayerMixer.IsValid())
		{
			graph.Disconnect(failedLayerMixer, 0);
			graph.Disconnect(failedLayerMixer, 1);
		}
		if (graph.Connect(bodyAnimationPlayable, 0, timelinePlayable, timelineInputPort))
		{
			timelinePlayable.SetInputWeight(timelineInputPort, timelineInputWeight);
		}
	}

	private static List<(uLipSyncAnimator.AnimatorInfo animatorInfo, AnimationClip clip)> CollectMouthClipMappings(RuntimeAnimatorController controller, uLipSyncAnimator lipSyncAnimator)
	{
		List<(uLipSyncAnimator.AnimatorInfo, AnimationClip)> list = new List<(uLipSyncAnimator.AnimatorInfo, AnimationClip)>();
		AnimationClip[] source = controller.animationClips.Distinct().ToArray();
		for (int i = 0; i < lipSyncAnimator.parameters.Count; i++)
		{
			uLipSyncAnimator.AnimatorInfo animatorInfo = lipSyncAnimator.parameters[i];
			if (animatorInfo.index >= 0 && !string.IsNullOrEmpty(animatorInfo.phoneme))
			{
				AnimationClip animationClip = source.FirstOrDefault((AnimationClip candidate) => IsMouthClipForPhoneme(candidate.name, animatorInfo.phoneme));
				if (animationClip != null)
				{
					list.Add((animatorInfo, animationClip));
				}
			}
		}
		return list;
	}

	private static bool IsMouthClipForPhoneme(string clipName, string phoneme)
	{
		int num = clipName.LastIndexOf('@');
		if (num < 0 || num >= clipName.Length - 1)
		{
			return false;
		}
		string a = clipName.Substring(num + 1);
		if (string.Equals(phoneme, "V", StringComparison.OrdinalIgnoreCase))
		{
			if (!string.Equals(a, "V", StringComparison.OrdinalIgnoreCase))
			{
				return string.Equals(a, "Ü", StringComparison.OrdinalIgnoreCase);
			}
			return true;
		}
		return string.Equals(a, phoneme, StringComparison.OrdinalIgnoreCase);
	}

	private void EnsureMouthGate(Animator boundAnimator)
	{
		if (Application.isPlaying && !(boundAnimator == null))
		{
			mouthGate = boundAnimator.GetComponent<GachaLipSyncMouthGate>();
			if (mouthGate == null)
			{
				mouthGate = boundAnimator.gameObject.AddComponent<GachaLipSyncMouthGate>();
				mouthGateCreated = true;
			}
			mouthGate.Initialize(boundAnimator);
		}
	}

	private void CapturePhonemePoses()
	{
		if (mouthGate == null || !mouthMixer.IsValid())
		{
			return;
		}
		for (int i = 0; i < mouthClipBindings.Count; i++)
		{
			MouthClipBinding mouthClipBinding = mouthClipBindings[i];
			Playable input = mouthMixer.GetInput(mouthClipBinding.mixerInputIndex);
			if (input.IsValid() && !(input.GetPlayableType() != typeof(AnimationClipPlayable)))
			{
				AnimationClip animationClip = ((AnimationClipPlayable)input).GetAnimationClip();
				mouthGate.CapturePhonemePose(mouthClipBinding.animatorInfo.phoneme, animationClip);
			}
		}
	}

	private void ApplyMouthGate(bool hasActiveLipSyncClip)
	{
		if (mouthGate == null)
		{
			return;
		}
		mouthGate.BeginLipSyncFrame(hasActiveLipSyncClip);
		if (hasActiveLipSyncClip)
		{
			for (int i = 0; i < mouthClipBindings.Count; i++)
			{
				MouthClipBinding mouthClipBinding = mouthClipBindings[i];
				float weight = (mouthMixer.IsValid() ? mouthMixer.GetInputWeight(mouthClipBinding.mixerInputIndex) : 0f);
				mouthGate.SetVisemeWeight(mouthClipBinding.animatorInfo.phoneme, weight);
			}
		}
	}

	public override void OnPlayableDestroy(Playable playable)
	{
		if (mouthGate != null)
		{
			mouthGate.SetSuppressIdleMouth(suppress: false);
			if (mouthGateCreated)
			{
				UnityEngine.Object.Destroy(mouthGate);
			}
		}
		mouthGate = null;
		mouthGateCreated = false;
	}

	private void LogInitializationWarning(string reason)
	{
		if (!initializationWarningLogged)
		{
			initializationWarningLogged = true;
			Debug.LogWarning("[GachaLipSyncTrack] 无法创建 Timeline 口型动画层：" + reason + "。", target);
		}
	}
}
