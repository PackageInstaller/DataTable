using System.Collections;
using UnityEngine;

namespace MusicGame;

public class OverState : MusicState
{
	public override void Enter()
	{
		owner.gameStatus = GameStatus.Undefine;
		AudioManager.Instance.Play("music", owner.fade_out_cueSheetName, owner.fade_out_cueName, !string.IsNullOrEmpty(owner.fade_out_awbFile));
		StartCoroutine(GameOver());
	}

	public IEnumerator GameOver()
	{
		yield return new WaitForSeconds(2f);
		LuaHelper.CallFunction("MusicToLuaBridge.OnMusicOver");
	}

	public override void Exit()
	{
	}
}
