using T0World;
using UnityEngine;
using UnityEngine.Playables;

namespace YS.T0WorldTrack;

public class T0WorldIKControlNodeBehaviour : PlayableBehaviour
{
	public GameObject owner;

	private T0CharacterIkBehavior ikBehavior;

	public override void OnBehaviourPlay(Playable playable, FrameData info)
	{
		if (Application.isPlaying && (Object)(object)ikBehavior == null)
		{
			ikBehavior = owner.transform.parent.GetComponent<T0CharacterIkBehavior>();
		}
		ikBehavior?.ChangeIkState(T0CharacterIkControlerStateEnum.open);
	}

	public override void OnBehaviourPause(Playable playable, FrameData info)
	{
		if (Application.isPlaying && (Object)(object)ikBehavior == null)
		{
			ikBehavior = owner.transform.parent.GetComponent<T0CharacterIkBehavior>();
		}
		ikBehavior?.ChangeIkState(T0CharacterIkControlerStateEnum.close);
	}
}
