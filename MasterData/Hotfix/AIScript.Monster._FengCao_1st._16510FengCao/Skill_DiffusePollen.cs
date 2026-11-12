using System.Collections;
using TrueSync;

namespace AIScript.Monster._FengCao_1st._16510FengCao;

public class Skill_DiffusePollen : SkillSimpleBase
{
	private static readonly int startKeyIndex1 = 1;

	private static readonly ComboInputBuffer.ActionKey[] startKey = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.J };

	private TSVector2 SelfPos;

	private readonly string AreaEffectAlias02 = "Weapon_16510FengCao_Huan_Suo";

	private static readonly string Start_AreaEffect_Event = "Start_AreaEffect";

	private LogicEntity AttackTarget;

	protected override void OnSkillEnable()
	{
		AttackTarget = GetAttackTarget(isUpToDate: true);
		if (!CheckTargetIsValid(AttackTarget))
		{
			AttackTarget = GetCurrentPlayer();
		}
		SelfPos = GetPosition();
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(startKeyIndex1, startKey);
		yield return WaitCustomEvent(Start_AreaEffect_Event);
		PlayAreaEffect(AreaEffectAlias02, SelfPos);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		yield return WaitTime(4);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
