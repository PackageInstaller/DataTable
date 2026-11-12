using System.Collections;

namespace AIScript.Monster._FanRong_None._10012FanRongZhiShiTi;

public class FanRong_None_StageChange : SkillSimpleBase
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
		AddBuffToTarget(_actor, 100120810);
		SetSuperArmorDisable();
		SetLockToughnessDisable();
		RemoveBuffFromTarget(_actor, 990020140);
		yield return WaitFrame(70);
	}
}
