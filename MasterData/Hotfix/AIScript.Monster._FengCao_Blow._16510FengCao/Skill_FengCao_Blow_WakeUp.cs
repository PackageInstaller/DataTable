using System.Collections;

namespace AIScript.Monster._FengCao_Blow._16510FengCao;

public class Skill_FengCao_Blow_WakeUp : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] _actionKey1 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.B };

	private readonly string FuYouJianFxAlias1 = "fx_16511FengCao_zzz";

	private readonly string FuYouJianFxAlias2 = "fx_16511FengCao_suxing";

	protected override void OnSkillEnable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		long FxLoopA = PlayEffect(FuYouJianFxAlias1, 1f, 0, GetPosition(), 1f);
		BeginAttack(1, _actionKey1, flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		while (GetBuffNum(_actor, 160510132) <= 0)
		{
			yield return null;
		}
		StopEffect(FxLoopA);
		PlayEffect(FuYouJianFxAlias2, 1f, 0, GetPosition(), 1f);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
