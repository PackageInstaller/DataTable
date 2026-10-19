using System;
using ACT.Model;
using Cinemachine;
using Runtime.Model;
using UnityEngine;
using UnityEngine.Animations;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace ACT;

public abstract class GetTrackObjectBase
{
	public abstract void GetTrackObject(PlayableDirector pd, PlayableBinding pb, Type type, string trackData, int outputIndex, out UnityEngine.Object trackObject);

	protected void SetAnimator(PlayableDirector pd, Animator animator, int outputIndex, out UnityEngine.Object trackObject)
	{
		trackObject = null;
		if (!(animator == null))
		{
			if (!animator.applyRootMotion)
			{
				Model<RuntimeTimelineModel>.Interface.AddAnimationChangeInfo(pd, animator);
				animator.applyRootMotion = true;
			}
			pd.Play();
			trackObject = animator;
			PlayableOutput output = pd.playableGraph.GetOutput(outputIndex);
			if (!output.IsOutputNull() && output.IsPlayableOutputOfType<AnimationPlayableOutput>())
			{
				((AnimationPlayableOutput)pd.playableGraph.GetOutput(outputIndex)).SetTarget(animator);
			}
			pd.Pause();
		}
	}

	protected void SetCinemachineBrain(PlayableDirector pd, PlayableBinding pb, Transform targetTransform)
	{
		if (targetTransform == null)
		{
			return;
		}
		pd.Play();
		CinemachineTrack cinemachineTrack = pb.sourceObject as CinemachineTrack;
		if (cinemachineTrack != null)
		{
			foreach (TimelineClip clip in cinemachineTrack.GetClips())
			{
				CinemachineShot cinemachineShot = clip.asset as CinemachineShot;
				if (!(cinemachineShot != null))
				{
					continue;
				}
				CinemachineVirtualCameraBase cinemachineVirtualCameraBase = cinemachineShot.VirtualCamera.Resolve(pd.playableGraph.GetResolver());
				if (cinemachineVirtualCameraBase != null)
				{
					if (cinemachineVirtualCameraBase.LookAt == null)
					{
						cinemachineVirtualCameraBase.LookAt = targetTransform;
					}
					if (cinemachineVirtualCameraBase.Follow == null)
					{
						cinemachineVirtualCameraBase.Follow = targetTransform;
					}
				}
			}
		}
		pd.Pause();
	}
}
