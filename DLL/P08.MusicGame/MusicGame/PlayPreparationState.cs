using UnityEngine;

namespace MusicGame;

public class PlayPreparationState : MusicState
{
	private bool isPlay;

	private int preparationTime;

	public override void Enter()
	{
		if (GameStatus.Preparation != owner.gameStatus)
		{
			AudioManager.Instance.StopImmediate("music");
			owner.StopSound();
			owner.ResumeSound();
			owner.ResetTrack();
			owner.gameObject.SetActive(value: false);
			owner.gameObject.SetActive(value: true);
			preparationTime = MusicController.preparationTime;
			owner.gameStatus = GameStatus.Preparation;
			LuaHelper.CallFunction("MusicToLuaBridge.MusicInitPlay");
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
			preparationTime -= (int)(Time.deltaTime * 1000f);
			if ((float)preparationTime <= 16.66f)
			{
				owner.ChangeState<PlayState>();
			}
			else
			{
				owner.Process();
			}
		}
	}

	public int GetTime()
	{
		return -1 * preparationTime;
	}
}
