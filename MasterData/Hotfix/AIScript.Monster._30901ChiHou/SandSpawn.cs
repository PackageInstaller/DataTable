using System.Collections;
using TrueSync;

namespace AIScript.Monster._30901ChiHou;

public class SandSpawn : SkillSimpleBase
{
	private readonly string SandBorn = "SandBorn";

	private TSVector2 DashForward;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		SetHideModelEnable();
		SetUnparalleledEnable();
		AddBuffToTarget(_actor, 990020140);
		ModelNodeShow("shield", isShow: false);
		if (GetPosition().x < 0)
		{
			DashForward = TSVector2.right;
		}
		else
		{
			DashForward = TSVector2.left;
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginLookAtByDir_NotWait(DashForward, 0.1, 3600);
		PlayEffect("fx_m30901_base_sandborn", 1f, 0, GetPosition());
		yield return WaitTime(1);
		BeginAttack(1, SandBorn, flushInputedKeys: true, forceInterruptAttack: true);
		SetHideModelDisable();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		RemoveBuffFromTarget(_actor, 990020140);
	}
}
