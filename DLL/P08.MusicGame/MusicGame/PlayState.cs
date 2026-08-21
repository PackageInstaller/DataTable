namespace MusicGame;

public class PlayState : MusicState
{
	private bool isPlay;

	public override void Enter()
	{
		if (GameStatus.Play != owner.gameStatus)
		{
			owner.PlaySound();
			owner.ResumeSound();
			owner.gameStatus = GameStatus.Play;
		}
		else
		{
			owner.ResumeSound();
		}
		isPlay = true;
		owner.SetClickEnable(value: true);
	}

	public override void Exit()
	{
		isPlay = false;
		owner.SetClickEnable(value: false);
	}

	private void Update()
	{
		if (isPlay)
		{
			owner.Process();
			if (owner.CheckOver())
			{
				owner.ChangeState<OverState>();
			}
		}
	}
}
