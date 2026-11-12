using System.Collections;

namespace AIScript.Monster._50541ChuShi;

public class Skill_Transform : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Transform = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.W };

	protected override IEnumerator DoMainLogic()
	{
		SetSuperArmorEnable();
		SetLockToughnessEnable();
		BeginAttack(1, Transform, flushInputedKeys: true);
		yield return WaitCustomEvent("AddBuff");
		AddBuffToTarget(_actor, 505415010);
		Singleton<InteractiveManager>.Instance.triggerOpListener("FX1to2");
		PlayEffect("Transform21");
		PlayEffect("Transform22");
		PlayEffect("Transform23");
		PlayEffect("Transform24");
		yield return WaitCombo(ComboAttackType.isComboFinish);
		SetLogicTagFpValue(_actor, "actionPhase", 2);
		SetSuperArmorDisable();
		SetLockToughnessDisable();
		yield return WaitTime(0.5);
	}
}
