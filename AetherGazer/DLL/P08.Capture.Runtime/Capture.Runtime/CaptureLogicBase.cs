namespace Capture.Runtime;

public abstract class CaptureLogicBase : MonoUpdateProxy
{
	protected CaptureGameDataForExchange context => WorldManager.Instance.GetGameContext();

	public abstract void Init();

	public abstract void Execute();

	public abstract void Dispose();

	public override void LateUpdate()
	{
	}

	public override void FixedUpdate()
	{
	}
}
