using System.Collections;
using AdventureBehaviour;

namespace AIScript.Character._16101.Summoned.FangWeiBiao;

public class SkillScript_FangWeiBiao_Death : SkillSimpleBase
{
	private int keyIndex = 1;

	private string key = "Sup_Dead";

	private const string areaEffect_FWB_ChaCha = "AreaEffect_16101_ChaCha";

	private const int perkId_23 = 516123;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override IEnumerator DoMainLogic()
	{
		_actor.PlayDeathAnim();
		BeginAttack(keyIndex, key, flushInputedKeys: true, forceInterruptAttack: true);
		if (GetPerk(516123))
		{
			ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_16101_ChaCha", _actor.tsTransform.Position);
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnInterrupt(int comboIndex)
	{
		_skill?.Clear();
	}
}
