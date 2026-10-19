using UnityEngine;
using UnityEngine.Animations;
using UnityEngine.Playables;

namespace ACT.Timeline;

public class StartAnimationTrackBehaviour : PlayableBehaviour
{
	public Animator animator;

	public AvatarMask avatarMask;

	public bool applyAvatarMask;

	public StartAnimationTrackAsset trackAsset;

	private AnimationPlayableOutput animationOutput;

	private bool inited;

	private bool outputCreated;

	private AnimationMixerPlayable animationMixer;

	private AnimationLayerMixerPlayable animationLayerMixer;

	public override void OnGraphStart(Playable playable)
	{
		if (inited)
		{
			return;
		}
		inited = true;
		PlayableGraph graph = playable.GetGraph();
		int inputCount = playable.GetInputCount();
		animationMixer = AnimationMixerPlayable.Create(graph, inputCount);
		for (int i = 0; i < inputCount; i++)
		{
			StartAnimationClipBehaviour behaviour = ((ScriptPlayable<StartAnimationClipBehaviour>)playable.GetInput(i)).GetBehaviour();
			if (behaviour.animationPlayable.IsValid())
			{
				graph.Connect(behaviour.animationPlayable, 0, animationMixer, i);
				behaviour.animationMixerPlayable = animationMixer;
				behaviour.index = i;
			}
		}
		Playable value = animationMixer;
		if (applyAvatarMask && avatarMask != null)
		{
			animationLayerMixer = AnimationLayerMixerPlayable.Create(graph, 1);
			graph.Connect(animationMixer, 0, animationLayerMixer, 0);
			animationLayerMixer.SetInputWeight(0, 1f);
			animationLayerMixer.SetLayerMaskFromAvatarMask(0u, avatarMask);
			value = animationLayerMixer;
		}
		animator = ResolveAnimator(playable, null);
		animationOutput = AnimationPlayableOutput.Create(graph, "StartAnimation", animator);
		outputCreated = true;
		animationOutput.SetSourcePlayable(value);
	}

	public override void PrepareFrame(Playable playable, FrameData info)
	{
		UpdateOutput(playable, null);
	}

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		UpdateOutput(playable, playerData);
	}

	private void UpdateOutput(Playable playable, object playerData)
	{
		SetOutputTarget(ResolveAnimator(playable, playerData));
		if (animationMixer.IsValid())
		{
			int inputCount = playable.GetInputCount();
			for (int i = 0; i < inputCount && i < animationMixer.GetInputCount(); i++)
			{
				animationMixer.SetInputWeight(i, playable.GetInputWeight(i));
			}
		}
	}

	private Animator ResolveAnimator(Playable playable, object playerData)
	{
		if (playerData is Animator result)
		{
			return result;
		}
		if (playerData is GameObject gameObject)
		{
			return gameObject.GetComponent<Animator>();
		}
		if (trackAsset != null)
		{
			PlayableDirector director = playable.GetGraph().GetResolver() as PlayableDirector;
			Animator binding = trackAsset.GetBinding(director);
			if (binding != null)
			{
				return binding;
			}
		}
		return animator;
	}

	private void SetOutputTarget(Animator targetAnimator)
	{
		if (outputCreated && !(targetAnimator == null) && !(animationOutput.GetTarget() == targetAnimator))
		{
			animator = targetAnimator;
			animationOutput.SetTarget(targetAnimator);
		}
	}

	public override void OnGraphStop(Playable playable)
	{
	}

	public override void OnPlayableDestroy(Playable playable)
	{
		inited = false;
		outputCreated = false;
	}
}
