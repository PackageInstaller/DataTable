using System.Collections;

namespace AIScript.Monster._31801FeiLong;

public class SkillScript_FireBurst : SkillScript_Base
{
	private int _useTimes;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_useTimes = _actor.logicVariable.GetLogicTagValue("FireBurst_Times").AsInt();
	}

	protected override IEnumerator DoMainLogic()
	{
		if (_useTimes % 2 == 0)
		{
			BeginAttack(0, "Transform_Fly");
			ReplaceAnimationGroup();
			_actor.logicVariable.ToggleLogicTag("IsFlyState", value: true);
		}
		else
		{
			BeginAttack(0, "Transform_Ground");
			_actor.logicVariable.ToggleLogicTag("IsFlyState", value: false);
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
		_actor.buffComponent.AddBuff(318010010, _actor);
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.logicVariable.SetLogicTagValue("FireBurst_Times", _useTimes + 1);
	}
}
