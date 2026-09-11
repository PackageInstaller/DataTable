using Dorm;
using Dorm.Furniture;

public class DormScene : DormSceneLoader
{
	public override void OnSceneReady()
	{
		LuaHelper.CallFunction("OnEnterDormScene");
	}

	public override void OnSceneEnter()
	{
		base.OnSceneEnter();
	}

	public override void OnSceneExit(NScene nextScene)
	{
		OnSceneExit(nextScene, cleanUp: true);
	}

	public void OnSceneExit(NScene nextScene, bool cleanUp)
	{
		LuaHelper.CallFunction("OnExitDormScene");
		if (cleanUp)
		{
			DormCoordinate.Cleanup();
			FurnitureManager.Instance.ShutDown();
			DormCfgManager.Instance.ShutDown();
		}
	}
}
