using Dorm;
using Dorm.Furniture;
using UnityEngine;

public class CanteenScene : DormSceneLoader
{
	public override void OnSceneReady()
	{
		DormTagBase.Collect(GameObject.FindGameObjectsWithTag("Scene"));
		LuaHelper.CallFunction("OnEnterCanteenScene");
	}

	public override void OnSceneEnter()
	{
		base.OnSceneEnter();
	}

	public override void OnSceneExit(NScene nextScene)
	{
		LuaHelper.CallFunction("OnExitCanteenScene");
		DormTagBase.Cleanup();
		DormCoordinate.Cleanup();
		FurnitureManager.Instance.ShutDown();
		DormCfgManager.Instance.ShutDown();
	}
}
