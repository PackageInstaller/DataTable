namespace ChessBoard;

public class ChessBoardScene : ChessBoardSceneLoader
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
		ChessBoardHexManager.Instance.Shutdown();
		mapData.Dispose();
		LuaHelper.CallFunction("OnExitChessBoardScene");
		ChessBoardNPCManager.Instance.DestroyAllNPC();
		ChessBoardEffectManager.Instance.DestroyAllEffect();
	}
}
