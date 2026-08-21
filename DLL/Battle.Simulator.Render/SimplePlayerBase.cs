using UnityEngine;

public abstract class SimplePlayerBase : MonoBehaviour
{
	public abstract void OnGraphStart();

	public abstract void OnBehaviourPlay();

	public abstract void OnBehaviourPause();

	public abstract void OnGraphStop();

	public abstract void OnPlayableDestroy();
}
