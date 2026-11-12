using System.Collections;
using System.Runtime.CompilerServices;
using TrueSync;

namespace AIScript.Monster._50281LeiSheZhu;

public class Skill_Spawn : SkillSimpleBase
{
	private LogicEntity target;

	private bool isActionOver;

	private readonly ComboInputBuffer.ActionKey[] _actionKey1;

	private readonly ComboInputBuffer.ActionKey[] _actionKey2;

	protected TSVector2 TargetPosition;

	private readonly string actionOverCustom;

	private readonly string MonsterShowBlood;

	protected override void OnSkillEnable()
	{
		isActionOver = false;
		target = GetTarget();
		SetCloseBlockEnable();
		SetBattleOutEnable();
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, _actionKey1, flushInputedKeys: true);
		TriggerOpLisener("CloseFX");
		yield return WaitTime(1);
		BeginAttack(2, _actionKey2, flushInputedKeys: true);
		BeginLookAt_NotWait(target, 3, 540);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		yield return StartCor(CheckDistance());
	}

	private LogicEntity GetTarget()
	{
		if (CheckTargetIsValid(GetAttackTarget()))
		{
			return GetAttackTarget();
		}
		return GetCurrentPlayer();
	}

	private IEnumerator CheckDistance()
	{
		while (Distance(GetEntityPositionObsoleted(target), GetPosition()) >= 9)
		{
			yield return WaitTime(0.2);
		}
		SetCloseBlockDisable();
		SetBattleOutDisable();
		ShowCenterHpBar();
		if (!isActionOver)
		{
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		if (eventName == actionOverCustom && comboIndex == 2)
		{
			isActionOver = true;
		}
	}

	public Skill_Spawn()
	{
		//IL_000d: Field data (rva=0x490) could not be found in any section!
		//IL_000d: Field data (rva=0x490) could not be found in any section!
		ComboInputBuffer.ActionKey[] array = new ComboInputBuffer.ActionKey[3];
		RuntimeHelpers.InitializeArray(array, __ldtoken(_003CPrivateImplementationDetails_003E._0003EFA4385939447DFE84045067331BBBF255A96C85DDAB40810DA8B86F4E16));
		_actionKey1 = array;
		_actionKey2 = new ComboInputBuffer.ActionKey[3]
		{
			(ComboInputBuffer.ActionKey)1919249516,
			(ComboInputBuffer.ActionKey)777275743,
			(ComboInputBuffer.ActionKey)29539
		};
		actionOverCustom = "ActionIsOver";
		MonsterShowBlood = "ShowBlood";
		base._002Ector();
	}
}
