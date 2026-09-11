namespace NewChess;

public class NewChessScene : NewChessSceneLoader
{
	public override void OnSceneReady()
	{
		base.OnSceneReady();
	}

	public override void OnSceneEnter()
	{
	}

	public override void OnSceneExit(NScene nextScene)
	{
		base.hexGridCoord.Shutdown();
		NewHexManager.Instance.Shutdown();
		mapData.Dispose();
		LuaHelper.CallFunction("OnExitNewChessScene");
		NewHexFogManager.Instance.ShutDown();
	}
}
