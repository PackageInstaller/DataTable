using System.Collections;
using TrueSync;

namespace AIScript.Monster._FengCao_2rd._16510FengCao;

public class Skill_DiffusePollen_01_2rd : SkillSimpleBase
{
	private static readonly int startKeyIndex1 = 1;

	private static readonly ComboInputBuffer.ActionKey[] startKey = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.K };

	private TSVector2 SelfPos;

	private static readonly string AreaEffectAlias01 = "Weapon_16510FengCao_Huan_Kuo";

	private static readonly string AreaEffectAlias02 = "Weapon_16510FengCao_Huan_Suo";

	private static readonly string Start_AreaEffect_Event = "Start_AreaEffect";

	private LogicEntity AttackTarget;

	protected override void OnSkillEnable()
	{
		AttackTarget = GetAttackTarget(isUpToDate: true);
		if (!CheckTargetIsValid(AttackTarget))
		{
			AttackTarget = _actor;
		}
		SelfPos = GetPosition();
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(startKeyIndex1, startKey);
		yield return WaitCustomEvent(Start_AreaEffect_Event);
		PlayAreaEffect(AreaEffectAlias02, SelfPos);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		yield return WaitTime(3.8);
		PlayAreaEffect(AreaEffectAlias01, SelfPos);
		yield return WaitTime(4);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
