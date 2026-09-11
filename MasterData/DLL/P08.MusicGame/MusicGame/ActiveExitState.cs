namespace MusicGame;

public class ActiveExitState : MusicState
{
	public override void Enter()
	{
		owner.gameStatus = GameStatus.Undefine;
		owner.StopSound();
		LuaHelper.CallFunction("MusicToLuaBridge.OnMusicActiveExit");
	}

	public override void Exit()
	{
	}
}
