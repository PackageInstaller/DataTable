using System.Collections;

namespace AIScript.Monster._FanRong_Wind._10012FanRongZhiShiTi;

public class FanRong_Wind_StageChange : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Attack01 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.F };

	protected override void OnSkillEnable()
	{
		SetSuperArmorEnable();
		SetLockToughnessEnable();
		AddBuffToTarget(_actor, 990020140);
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Attack01, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitFrame(60);
		AddBuffToTarget(_actor, 100120910);
		SetSuperArmorDisable();
		SetLockToughnessDisable();
		RemoveBuffFromTarget(_actor, 990020140);
		yield return WaitFrame(70);
	}
}
