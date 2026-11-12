using System.Collections;
using TrueSync;

namespace AIScript.Monster._50551CanCha;

public class Skill_StarTowerSpawn : SkillSimpleBase
{
	protected readonly FP disWithPlayer = 15;

	protected TSVector2 TargetPosition;

	protected override void OnSkillDisable()
	{
		ShowCenterHpBar();
	}

	protected override IEnumerator DoMainLogic()
	{
		SetHideModelEnable();
		SetBattleOutEnable();
		TSVector2 position = TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 0));
		PlayEffect("SpwanEffect", 1f, 0, position, default, 2f);
		yield return WaitTime(1);
		SetHideModelDisable();
		LogicEntity player = GetCurrentPlayer();
		TSVector2 playerPOS = GetEntityPositionObsoleted(player);
		TSVector2 selfPOS = GetPosition();
		while (Distance(playerPOS, selfPOS) > 12)
		{
			playerPOS = GetEntityPositionObsoleted(player);
			selfPOS = GetPosition();
			yield return WaitTime(0.15);
		}
		SetBattleOutDisable();
	}
}
