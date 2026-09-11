public abstract class NEventBase : IFramePooledObject
{
	public const int kApproxNumberOfDerivedTypes = 200;

	public abstract void Release();

	public abstract void OnEnterPool();
}
