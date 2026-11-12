using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._Boss._Dark._50251ShanDianLieQuan;

public class Shadow_Dash : SkillSimpleBase
{
	private readonly string Dash = "ShadowDash1";

	private FP WaitTime1;

	private List<LogicEntity> Boss = new List<LogicEntity>();

	private long DashFX;

	protected override void OnSkillEnable()
	{
		WaitTime1 = 0;
		Boss.Clear();
		Boss.AddRange(GetTargetByTeammateIndex(0));
		SetCloseBlockEnable();
	}

	protected override void OnSkillDisable()
	{
		StopEffect(DashFX);
		_actor.ClearMonsterSelf();
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginLookAt_NotWait(Boss.get_Item(0), 0.1, 3600);
		yield return WaitTime(0.1);
		BeginAttack(1, Dash, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(1);
		BeginDashActorForward(1, 15, Distance(GetPosition(), GetEntityPosition(Boss.get_Item(0))), 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false, 0.1);
		yield return WaitDashFinish();
	}
}
