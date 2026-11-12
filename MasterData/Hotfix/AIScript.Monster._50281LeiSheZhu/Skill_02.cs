using System.Collections;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using TrueSync;

namespace AIScript.Monster._50281LeiSheZhu;

public class Skill_02 : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] _actionKey1;

	private readonly ComboInputBuffer.ActionKey[] _actionKey2;

	private readonly ComboInputBuffer.ActionKey[] _actionKey3;

	private readonly ComboInputBuffer.ActionKey[] _actionKey4;

	private readonly ComboInputBuffer.ActionKey[] _actionKey5;

	private readonly ComboInputBuffer.ActionKey[] _actionKey6;

	private LogicEntity AttackTarget;

	private readonly TSVector2 centerPosition;

	private static readonly string StartAttack = "StartAttack";

	private static readonly string StopAttack = "StopAttack";

	private static readonly string StartDash = "Dash";

	private static readonly string StartUP = "UP";

	private static readonly string Down = "Down";

	protected override void OnSkillEnable()
	{
		AttackTarget = GetAttackTarget(isUpToDate: true);
		if (!CheckTargetIsValid(AttackTarget))
		{
			AttackTarget = _actor;
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, _actionKey1, flushInputedKeys: true);
		BeginLookAtByPos(centerPosition, 0.1, 560, 0);
		yield return WaitCustomEvent(StartUP);
		AddBuffToTarget(_actor, 505210310);
		AddBuffToTarget(_actor, 990010030);
		SetLockToughnessEnable();
		RemoveBuffFromTarget(_actor, 0, 0, CommonHelper.StringToHash("DeBuff"));
		RemoveBuffFromTarget(_actor, 0, 0, CommonHelper.StringToHash("Fire"));
		RemoveBuffFromTarget(_actor, 0, 0, CommonHelper.StringToHash("Water"));
		RemoveBuffFromTarget(_actor, 0, 0, CommonHelper.StringToHash("Wind"));
		RemoveBuffFromTarget(_actor, 0, 0, CommonHelper.StringToHash("Light"));
		RemoveBuffFromTarget(_actor, 0, 0, CommonHelper.StringToHash("Dark"));
		RemoveBuffFromTarget(_actor, 0, 0, CommonHelper.StringToHash("Earth"));
		yield return WaitCustomEvent(StartDash);
		Teleport(centerPosition);
		BeginLookAt_NotWait(AttackTarget, 2, 540);
		yield return WaitCustomEvent(Down);
		SetLockToughnessDisable();
		RemoveBuffFromTarget(_actor, 505210310);
		RemoveBuffFromTarget(_actor, 990010030);
		yield return WaitCustomEvent(StartAttack);
		StopLookAt();
		List<char> options = new List<char> { '0', '1', '2', '3' };
		HashSet<int> usedIndices = new HashSet<int>();
		for (int i = 0; i < 3; i++)
		{
			int index;
			do
			{
				index = TSRandom.Range(0, options.Count);
			}
			while (usedIndices.Contains(index));
			usedIndices.Add(index);
			if (index == 0)
			{
				BeginAttack(2, _actionKey2, flushInputedKeys: true);
				yield return WaitTime(2.55);
				yield return WaitCustomEvent(StopAttack);
			}
			if (index == 1)
			{
				BeginAttack(3, _actionKey3, flushInputedKeys: true);
				yield return WaitTime(2.55);
				yield return WaitCustomEvent(StopAttack);
			}
			if (index == 2)
			{
				BeginAttack(4, _actionKey4, flushInputedKeys: true);
				yield return WaitTime(2.55);
				yield return WaitCustomEvent(StopAttack);
			}
			if (index == 3)
			{
				BeginAttack(5, _actionKey5, flushInputedKeys: true);
				yield return WaitTime(2.55);
				yield return WaitCustomEvent(StopAttack);
			}
		}
		BeginAttack(6, _actionKey6, flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	public Skill_02()
	{
		//IL_0052: Field data (rva=0x638) could not be found in any section!
		//IL_0052: Field data (rva=0x638) could not be found in any section!
		//IL_000d: Field data (rva=0x628) could not be found in any section!
		//IL_000d: Field data (rva=0x628) could not be found in any section!
		ComboInputBuffer.ActionKey[] array = new ComboInputBuffer.ActionKey[3];
		RuntimeHelpers.InitializeArray(array, __ldtoken(_003CPrivateImplementationDetails_003E._1D624F842EA26DD40E456D899D9D434952F9D753E9277DE063E7227048AA86D4));
		_actionKey1 = array;
		_actionKey2 = new ComboInputBuffer.ActionKey[3]
		{
			(ComboInputBuffer.ActionKey)1835362388,
			(ComboInputBuffer.ActionKey)1919242341,
			(ComboInputBuffer.ActionKey)1750359147
		};
		_actionKey3 = new ComboInputBuffer.ActionKey[3]
		{
			(ComboInputBuffer.ActionKey)1953450079,
			(ComboInputBuffer.ActionKey)1551395174,
			(ComboInputBuffer.ActionKey)1734963796
		};
		ComboInputBuffer.ActionKey[] array2 = new ComboInputBuffer.ActionKey[3];
		RuntimeHelpers.InitializeArray(array2, __ldtoken(_003CPrivateImplementationDetails_003E._224B9D215CE0809AC1C0FD95409FF4879538ADF5C0D8D209FCFB8DDCE4DDD8AB));
		_actionKey4 = array2;
		_actionKey5 = new ComboInputBuffer.ActionKey[3]
		{
			(ComboInputBuffer.ActionKey)1073741824,
			(ComboInputBuffer.ActionKey)1936933212,
			(ComboInputBuffer.ActionKey)1551070309
		};
		_actionKey6 = new ComboInputBuffer.ActionKey[3]
		{
			(ComboInputBuffer.ActionKey)1702064961,
			(ComboInputBuffer.ActionKey)1398567796,
			(ComboInputBuffer.ActionKey)1214210930
		};
		centerPosition = new TSVector2(0, 0);
		base._002Ector();
	}
}
