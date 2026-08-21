namespace P08.Quiz;

public class QuizScene : QuizSceneLoader
{
	public override void OnSceneReady()
	{
		LuaHelper.CallFunction("OnEnterQuizScene");
	}

	public override void OnSceneEnter()
	{
		base.OnSceneEnter();
	}

	public override void OnSceneExit(NScene nextScene)
	{
		LuaHelper.CallFunction("OnExitQuizScene");
		Singleton<PlayerManager>.Instance.DoDestroy();
	}
}
