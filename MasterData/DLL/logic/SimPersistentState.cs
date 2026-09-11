public abstract class SimPersistentState : IFramePooledObject
{
	public int EntityID { get; set; }

	public abstract void Release();

	public abstract void OnEnterPool();
}
