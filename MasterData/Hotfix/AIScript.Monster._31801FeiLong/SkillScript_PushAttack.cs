using System.Collections;
using TrueSync;

namespace AIScript.Monster._31801FeiLong;

public class SkillScript_PushAttack : SkillScript_Base
{
	private CoroutineNode _dashGenerateBaoLinCor;

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(0, "Dash_Ready");
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		yield return WaitTime(Config.loopTime_Charge_Push);
		BeginAttack(1, "Dash_Mode1");
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		BeginDashActorForward(0, Config.dashSpeed_Push, Config.dashDistance_Push, default, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		_dashGenerateBaoLinCor = StartCor(DashGenerateBaoLinLogic());
		yield return WaitDashFinish();
		StopCor(_dashGenerateBaoLinCor);
		CancelAttack();
		BeginDashActorForward(1, Config.driftDashSpeed_Push, Config.driftDashDistance_Push, default, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		BeginLookAt_NotWait(GetAttackTarget(), 0, Config.driftRotateSpeed_Push);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		if (_actor.logicVariable.GetLogicTagToggle("SkillStrength"))
		{
			StopDash();
			StopLookAt();
			BeginAttack(2, "Dash_Mode2");
			yield return WaitCombo(ComboAttackType.isAnticipationEnd);
			BeginDashActorForward(2, Config.dashSpeed_Push, Config.dashDistance_Push, default, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
			_dashGenerateBaoLinCor = StartCor(DashGenerateBaoLinLogic());
			yield return WaitDashFinish();
			StopCor(_dashGenerateBaoLinCor);
			CancelAttack();
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
	}

	private IEnumerator DashGenerateBaoLinLogic()
	{
		int count = ((!_actor.logicVariable.GetLogicTagToggle("SkillStrength")) ? 1 : 2);
		while (true)
		{
			yield return WaitTime(Config.interval_GenerateBaoLin_Dash_Push);
			SkillScript_PushAttack skillScript_PushAttack = this;
			SkillScript_PushAttack skillScript_PushAttack2 = this;
			SkillScript_PushAttack skillScript_PushAttack3 = this;
			TSVector2 position = _actor.tsTransform.Position + _actor.tsTransform.Back * Config.offset_GenerateBaoLin_Dash_Push;
			FP width_GenerateBaoLin_Dash_Push = Config.width_GenerateBaoLin_Dash_Push;
			FP length_GenerateBaoLin_Dash_Push = Config.length_GenerateBaoLin_Dash_Push;
			FP rotation = _actor.tsTransform.Rotation;
			yield return skillScript_PushAttack.StartCor(skillScript_PushAttack2.GenerateBaoLinLogic(skillScript_PushAttack3.GetShapeData(DeterministicShape.ShapeType.Rectangle, position, width_GenerateBaoLin_Dash_Push, length_GenerateBaoLin_Dash_Push, default, default, default, rotation), count, 0));
		}
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		base.OnCustomEvent(comboIndex, eventName);
		if (comboIndex == 2 && string.Equals(eventName, "BaoLin"))
		{
			TSVector2 position = _actor.tsTransform.Position;
			FP outerRadius_GenerateBaoLin_Push_Strength = Config.outerRadius_GenerateBaoLin_Push_Strength;
			FP innerRadius_GenerateBaoLin_Push_Strength = Config.innerRadius_GenerateBaoLin_Push_Strength;
			FP angle_GenerateBaoLin_Push_Strength = Config.angle_GenerateBaoLin_Push_Strength;
			FP rotation = _actor.tsTransform.Rotation + Config.offsetAngle_GenerateBaoLin_Push_Strength;
			StartCor(GenerateBaoLinLogic(GetShapeData(DeterministicShape.ShapeType.Fan, position, default, default, outerRadius_GenerateBaoLin_Push_Strength, innerRadius_GenerateBaoLin_Push_Strength, angle_GenerateBaoLin_Push_Strength, rotation), 4, Config.interval_GenerateBaoLin_Push_Strength));
		}
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopCor(_dashGenerateBaoLinCor);
		_dashGenerateBaoLinCor = null;
	}
}
