using System.Collections;
using TrueSync;

namespace AIScript.Monster._13061XiaoGaoDa;

public class Skill3_Charge_Light : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.H };

	private string fxAlias = "AreaEffect_Huan_6";

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, _actionKeys, flushInputedKeys: true);
		LogicEntity _target = GetAttackTarget();
		BeginLookAt_NotWait(_target, 0.8, 240);
		yield return WaitTime(1.3);
		SetCloseBlockEnable();
		doDash_A();
		yield return WaitDashFinish();
		SetCloseBlockDisable();
		doDash_B();
		yield return WaitTime(0.3);
		doAreaEffect();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		BeginLookAt(_target, 1, 400);
	}

	private void doDash_A()
	{
		BeginDashActorForward(1, 45, 15, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false, 4);
	}

	private void doDash_B()
	{
		BeginDashActorForward(2, 6, 3, 0, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
	}

	private void doAreaEffect()
	{
		TSVector2 position = _actor.tsTransform.Position;
		PlayAreaEffect(fxAlias, position);
	}
}
