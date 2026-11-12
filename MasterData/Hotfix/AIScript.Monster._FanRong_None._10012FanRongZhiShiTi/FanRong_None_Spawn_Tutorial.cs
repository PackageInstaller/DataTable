using System.Collections;
using TrueSync;

namespace AIScript.Monster._FanRong_None._10012FanRongZhiShiTi;

public class FanRong_None_Spawn_Tutorial : SkillSimpleBase
{
	protected readonly ComboInputBuffer.ActionKey[] A1 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.Y,
		ComboInputBuffer.ActionKey._0
	};

	protected readonly ComboInputBuffer.ActionKey[] A2 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.Y,
		ComboInputBuffer.ActionKey._1
	};

	protected readonly FP disWithPlayer = 15;

	protected TSVector2 TargetPosition;

	protected override void OnSkillEnable()
	{
		SetBattleOutEnable();
		AddBuffToTarget(_actor, 990020140);
		ShowCenterHpBar();
		MonsterAdventureActor monsterAdventureActor = _actor as MonsterAdventureActor;
		monsterAdventureActor.monsterToughnessInfo.toughness = (int)((double)monsterAdventureActor.monsterToughnessInfo.toughnessMax * 0.5);
	}

	protected override IEnumerator DoMainLogic()
	{
		yield return WaitTime(2);
		SetBattleOutDisable();
		RemoveBuffFromTarget(_actor, 990020140);
	}
}
