using System.Collections;
using TrueSync;

namespace AIScript.Monster._70001JuYuanMeiYing;

public class Skill_Summon_Born_Phase_1 : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Born = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.Y };

	protected TSVector2 TargetPosition;

	protected override void OnSkillEnable()
	{
		SetBattleOutEnable();
		SetUnparalleledEnable();
		SetImmuneControlEnable(autoDisableWhenSkillDisable: false);
		SetSuperArmorEnable(autoDisableWhenSkillDisable: false);
		_actor.PauseMovementBlock();
		_actor.PauseMovementAvoidance();
		_actor.LockHpAbs((int)_actor.actorHealthInfo.hpMax);
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Born, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(1);
		SetBattleOutDisable();
		ShowCenterHpBar();
	}
}
