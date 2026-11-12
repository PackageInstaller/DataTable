using System.Collections;

namespace AIScript.Monster._FanRong_Earth._10012FanRongZhiShiTi;

public class FanRong_Earth_StageChange : SkillSimpleBase
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
		if (GetBuffNum(_actor, 100129910) >= 1)
		{
			AddBuffToTarget(_actor, 100121110);
		}
		else
		{
			AddBuffToTarget(_actor, 100121110);
		}
		SetSuperArmorDisable();
		SetLockToughnessDisable();
		RemoveBuffFromTarget(_actor, 990020140);
		yield return WaitFrame(70);
	}
}
