namespace Capture.Runtime;

public class TaskLogic : CaptureLogicBase
{
	public override void Dispose()
	{
		LuaHelper.CallFunction("CaptureGameBridge.TaskLogicStop");
	}

	public override void Execute()
	{
	}

	public override void LateUpdate()
	{
		if (!base.context.isFreeCapture)
		{
			LuaHelper.CallFunction("CaptureGameBridge.TaskLogicExecute");
		}
	}

	public override void Init()
	{
		LuaHelper.CallFunction("CaptureGameBridge.TaskLogicStart");
	}
}
