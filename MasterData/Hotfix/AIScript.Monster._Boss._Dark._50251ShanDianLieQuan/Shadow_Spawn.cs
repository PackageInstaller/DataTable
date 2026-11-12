using System.Collections;

namespace AIScript.Monster._Boss._Dark._50251ShanDianLieQuan;

public class Shadow_Spawn : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Born = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.Y };

	private readonly ComboInputBuffer.ActionKey[] Move = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.M };

	protected override void OnSkillEnable()
	{
		SetHideModelEnable();
		AddBuffToTarget(_actor, 990020140);
		SetUnparalleledEnable(autoDisableWhenSkillDisable: false);
		SetCloseBlockEnable();
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Move, flushInputedKeys: true, forceInterruptAttack: true);
		BeginLookAt_NotWait(GetCurrentPlayer(), 0.5, 3600);
		PlayEffect("fx_m50251_base_Dark_Atk04_Shadow", 1f, 1, GetPosition(), 0, 1f, actorScale: true);
		yield return WaitTime(0.5);
		RemoveBuffFromTarget(_actor, 990020140);
		SetHideModelDisable();
	}
}
