using System.Collections;
using UnityEngine;

namespace AIScript;

internal class TowerDefenseGameplay_Template : TowerDefenseGameplayBase
{
	protected override void InitSpawnContainer()
	{
	}

	internal override IEnumerator DoMainLogic()
	{
		Debug.LogError("abc");
		ActiveSpecialGroup(0);
		ActiveWave(1);
		ActiveGroup(1);
		yield return null;
		Debug.LogError("等待2");
		yield return WaitTime(2);
		Debug.LogError("等待3");
		SetRoleOnStage(4, 8101110);
		SetRoleOnStage(10, 8101030);
		yield return WaitFrame(5);
		ShowRoutes();
		yield return WaitTime(3);
		HideRoutes();
	}
}
