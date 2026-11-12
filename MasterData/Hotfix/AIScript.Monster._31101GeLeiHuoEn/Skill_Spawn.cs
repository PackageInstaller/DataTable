using System.Collections;
using TrueSync;

namespace AIScript.Monster._31101GeLeiHuoEn;

public class Skill_Spawn : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Born = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.Y };

	private readonly string fx_Alias = "fx_common_base_monster_in";

	private readonly string fx_Alias1 = "fx_common_base_monster_in_ground";

	protected TSVector2 TargetPosition;

	protected override void OnSkillEnable()
	{
		SetBattleOutEnable();
		AddBuffToTarget(_actor, 990020140);
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		PlayEffect(fx_Alias, 1f, default, GetPosition(), GetEntityAngle(_actor));
		PlayEffect(fx_Alias1, 1f, default, GetPosition(), GetEntityAngle(_actor));
		yield return WaitTime(0.65);
		BeginAttack(1, Born, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(1.15);
		RemoveBuffFromTarget(_actor, 990020140);
		SetBattleOutDisable();
		ShowCenterHpBar();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
