using System.Collections;
using AdventureBehaviour;

namespace AIScript.Monster._10007KuangFengQingXiao;

public class Skill_Spawn_Boss : SkillSimpleBase
{
	private readonly string fx_Alias = "fx_switch_monster_actor";

	private readonly ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.Y };

	private PlayFX _playFx;

	protected override void OnSkillEnable()
	{
		SetHideOutEnable();
		SetHideModelEnable();
		SetImmuneControlEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity target = GetCurrentPlayer();
		while (Distance(GetPosition(), GetEntityPosition(target)) >= 15)
		{
			yield return WaitTime(0.1f);
		}
		BeginAttack(1, _actionKeys, flushInputedKeys: true);
		SetImmuneControlDisable();
		SetHideModelDisable();
		SetHideOutDisable();
		ShowCenterHpBar();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		yield return WaitTime(1);
	}
}
