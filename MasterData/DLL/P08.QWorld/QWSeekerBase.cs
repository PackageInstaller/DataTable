using UnityEngine;

public abstract class QWSeekerBase
{
	public abstract void Init(Transform agent, QWSeekerMoveComponent comp);

	public abstract void Tick();

	public abstract void Stop();

	public abstract void StopNoNotify();

	public abstract void Pause();

	public abstract void Dispose();

	public abstract bool IsSeeking();

	public abstract bool IsPausing();
}
