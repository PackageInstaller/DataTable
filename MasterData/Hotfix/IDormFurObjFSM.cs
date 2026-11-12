public abstract class IDormFurObjFSM
{
	public abstract int State { get; }

	public abstract void OnEnter(object data = null);

	public abstract void OnExit();

	public abstract void OnUpdate();

	public virtual void OnLateUpdate()
	{
	}
}
