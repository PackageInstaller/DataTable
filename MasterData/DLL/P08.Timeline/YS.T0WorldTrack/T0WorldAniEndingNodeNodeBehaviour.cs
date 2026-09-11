using T0World;
using UnityEngine;
using UnityEngine.Playables;

namespace YS.T0WorldTrack;

public class T0WorldAniEndingNodeNodeBehaviour : PlayableBehaviour
{
	public GameObject owner;

	private T0WorldInteractionBehavior behavior;

	public override void OnBehaviourPlay(Playable playable, FrameData info)
	{
		if (Application.isPlaying)
		{
			if (behavior == null)
			{
				behavior = owner.transform.parent.GetComponent<T0WorldInteractionBehavior>();
			}
			behavior?.TriggerHoldPlayable();
		}
	}
}
