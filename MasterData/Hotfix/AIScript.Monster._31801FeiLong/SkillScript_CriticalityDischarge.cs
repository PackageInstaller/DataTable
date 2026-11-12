using System.Collections;
using TrueSync;

namespace AIScript.Monster._31801FeiLong;

public class SkillScript_CriticalityDischarge : SkillScript_Base
{
	private bool _isHide;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		SetLockToughnessEnable();
		_actor.logicVariable.SetLogicTagValue("GenerateInterval_Burst", Config.generateInterval_Burst_CriticalityDischarge);
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(0, "Ultra_Ready");
		_actor.ResumeAnimationGroup();
		_actor.logicVariable.ToggleLogicTag("IsFlyState", value: false);
		StartCor(EarlyWarningLogic());
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		yield return WaitTime(Config.loopTime_Ready_CriticalityDischarge);
		BeginAttack(1, "");
		yield return WaitCombo(ComboAttackType.isComboFinish);
		BeginAttack(2, "Ultra_Attack");
		ShowSelf();
		SetCloseBlockDisable();
		_isHide = false;
		yield return WaitCombo(ComboAttackType.isActivationEnd);
		BeginAttack(3, "");
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private IEnumerator EarlyWarningLogic()
	{
		SkillScript_CriticalityDischarge skillScript_CriticalityDischarge = this;
		float duration = Config.duration_EarlyWarning_CriticalityDischarge.AsFloat();
		TSVector2 entityPosition = GetEntityPosition(GetCurrentPlayer());
		long earlyWarningFxId = skillScript_CriticalityDischarge.PlayEarlyWarningEffect("fx_warning_circular_10", duration, default, entityPosition);
		FP duration2 = Config.duration_EarlyWarning_CriticalityDischarge;
		FP followDuration = Config.followTime_EarlyWarning_CriticalityDischarge;
		while (duration2 > 0)
		{
			duration2 -= _actor.LogicDeltaTime;
			if (followDuration > 0)
			{
				ModifyEffectPosition(earlyWarningFxId, GetEntityPosition(GetCurrentPlayer()));
				followDuration -= _actor.LogicDeltaTime;
			}
			yield return null;
		}
		StopEffect(earlyWarningFxId);
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		base.OnCustomEvent(comboIndex, eventName);
		if (comboIndex == 1 && string.Equals(eventName, "Hide"))
		{
			HideSelf();
			SetCloseBlockEnable();
			_isHide = true;
		}
		else if (comboIndex == 2 && string.Equals(eventName, "BaoLin"))
		{
			TSVector2 position = _actor.tsTransform.Position;
			FP radius_GenerateBaoLin_CriticalityDischarge = Config.radius_GenerateBaoLin_CriticalityDischarge;
			FP innerRadius = 0;
			StartCor(GenerateBaoLinLogic(GetShapeData(DeterministicShape.ShapeType.Circle, position, default, default, radius_GenerateBaoLin_CriticalityDischarge, innerRadius), 12, Config.interval_GenerateBaoLin_CriticalityDischarge));
		}
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.buffComponent.RemoveBuffByBuffId(318010010);
		_actor.logicVariable.SetLogicTagValue("GenerateInterval_Burst", Config.generateInterval_Burst);
		SetLockToughnessDisable();
		if (_isHide)
		{
			ShowSelf();
			SetCloseBlockDisable();
		}
		_isHide = false;
	}
}
