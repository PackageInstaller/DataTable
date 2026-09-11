using System.Collections;

public class RogueCardGameScene : NScene
{
	public override void ShowLoadUI()
	{
		LoadingUIManager.inst.ShowLoadUI();
	}

	public override void CloseLoadUI()
	{
		LoadingUIManager.inst.CloseLoadUI();
	}

	public override IEnumerator OnLoadCoroutine()
	{
		LuaHelper.CallFunction("AutoChessLuaBridge.SetUpAutoChess");
		yield return null;
	}

	public override void OnSceneReady()
	{
		LuaHelper.GetFunc("RogueCardGameBridge.OnStartGame")?.Call();
	}

	public override void OnSceneExit(NScene nextScene)
	{
		base.OnSceneExit(nextScene);
		LuaHelper.GetFunc("RogueCardGameBridge.FinishRogueCardGameCallback")?.Call();
	}
}
