using System.Collections;

namespace AIScript.Monster._FanRong_Fire._10012FanRongZhiShiTi;

public class FanRong_Fire_StageChange_Lv2 : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] FireAttack01 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.F };

	protected override void OnSkillEnable()
	{
		SetSuperArmorEnable();
		SetLockToughnessEnable();
		AddBuffToTarget(_actor, 990020140);
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, FireAttack01, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitFrame(60);
		SetSuperArmorDisable();
		SetLockToughnessDisable();
		AddBuffToTarget(_actor, 100120210);
		RemoveBuffFromTarget(_actor, 990020140);
		yield return WaitFrame(70);
	}
}
