namespace MusicGame;

public class PauseState : MusicState
{
	public override void Enter()
	{
		owner.PauseSound();
		LuaHelper.CallFunction("MusicToLuaBridge.OnMusicPause");
	}

	public override void Exit()
	{
	}
}
