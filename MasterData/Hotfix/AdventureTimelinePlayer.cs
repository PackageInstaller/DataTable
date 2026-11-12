using Cinemachine;
using UnityEngine;
using UnityEngine.Playables;

[AddComponentMenu("Game/FX/Adventure Timeline Player")]
public class AdventureTimelinePlayer
{
	protected const string CameraTrackName = "CAMERA";

	protected const string ActorAnimatorTrackName = "ACTOR";

	public static void BindCameraBrain(PlayableDirector director, CinemachineBrain cameraBrain)
	{
		director.SetGenericBinding("CAMERA", cameraBrain);
	}

	public static void BindActorAnimator(PlayableDirector director, Animator actorAnimator)
	{
		Animator animator = director.GetGenericBinding("ACTOR") as Animator;
		if (animator != null && animator != actorAnimator)
		{
			director.SetGenericBinding("ACTOR", actorAnimator);
			animator.gameObject.SetActive(value: false);
		}
	}
}
