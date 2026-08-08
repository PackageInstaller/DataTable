using System.Collections;

internal class EatSnakesGameScene : NScene
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
		LuaHelper.CallFunction("EatSnakesLuaBridge.SetUpEatSnake");
		yield return null;
	}

	public override void OnSceneReady()
	{
		LuaHelper.GetFunc("EatSnakesLuaBridge.OnStartGame")?.Call();
	}

	public override void OnSceneExit(NScene nextScene)
	{
		base.OnSceneExit(nextScene);
		LuaHelper.GetFunc("EatSnakesLuaBridge.OnEndGame")?.Call();
	}
}
