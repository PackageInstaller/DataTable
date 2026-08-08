namespace Chess;

public class ChessScene : ChessSceneLoader
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
		HexManager.Instance.Shutdown();
		mapData.Dispose();
		HexFogManager.Instance.ShutDown();
	}
}
