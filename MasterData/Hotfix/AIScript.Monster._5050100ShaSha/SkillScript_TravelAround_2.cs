using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._5050100ShaSha;

public class SkillScript_TravelAround_2 : SkillSimpleBase
{
	protected readonly ComboInputBuffer.ActionKey[] _actionKeyJumpInto = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.Y };

	protected readonly ComboInputBuffer.ActionKey[] _actionKeyJumpOut = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.X };

	public const string cameraTriggerName = "Travel";

	private string fxAlias = "AreaEffect_WaterFallenStone";

	protected List<List<TSVector2>> fanOffsetList = new List<List<TSVector2>>
	{
		new List<TSVector2>
		{
			new TSVector2(0, 0),
			new TSVector2(0, 12),
			new TSVector2(0, -12),
			new TSVector2(12, 0),
			new TSVector2(-12, 0),
			new TSVector2(-6, 10),
			new TSVector2(-6, -10),
			new TSVector2(-10, 6),
			new TSVector2(-10, -6),
			new TSVector2(6, 10),
			new TSVector2(6, -10),
			new TSVector2(10, 6),
			new TSVector2(10, -6)
		},
		new List<TSVector2>
		{
			new TSVector2(0, 0),
			new TSVector2(0, 8),
			new TSVector2(0, -8),
			new TSVector2(8, 0),
			new TSVector2(-8, 0),
			new TSVector2(-4, 7),
			new TSVector2(-4, -7),
			new TSVector2(-7, 4),
			new TSVector2(-7, -4),
			new TSVector2(4, 7),
			new TSVector2(4, -7),
			new TSVector2(7, 4),
			new TSVector2(7, -4)
		},
		new List<TSVector2>
		{
			new TSVector2(0, 0),
			new TSVector2(0, 6.5),
			new TSVector2(0, -6.5),
			new TSVector2(6.5, 0),
			new TSVector2(-6.5, 0),
			new TSVector2(4, 4),
			new TSVector2(4, -4),
			new TSVector2(-4, 4),
			new TSVector2(-4, -4)
		},
		new List<TSVector2>
		{
			new TSVector2(0, 0),
			new TSVector2(0, 12),
			new TSVector2(0, -12),
			new TSVector2(12, 0),
			new TSVector2(-12, 0),
			new TSVector2(-6, 10),
			new TSVector2(-6, -10),
			new TSVector2(-10, 6),
			new TSVector2(-10, -6),
			new TSVector2(6, 10),
			new TSVector2(6, -10),
			new TSVector2(10, 6),
			new TSVector2(10, -6),
			new TSVector2(0, 6.5),
			new TSVector2(0, -6.5),
			new TSVector2(6.5, 0),
			new TSVector2(-6.5, 0)
		},
		new List<TSVector2>
		{
			new TSVector2(0, 12),
			new TSVector2(0, -12),
			new TSVector2(12, 0),
			new TSVector2(-12, 0),
			new TSVector2(-6, 10),
			new TSVector2(-6, -10),
			new TSVector2(-10, 6),
			new TSVector2(-10, -6),
			new TSVector2(6, 10),
			new TSVector2(6, -10),
			new TSVector2(10, 6),
			new TSVector2(10, -6),
			new TSVector2(0, 6.5),
			new TSVector2(-2.5, 2),
			new TSVector2(2.5, 2),
			new TSVector2(-5.5, -3),
			new TSVector2(0, -2.5),
			new TSVector2(5.5, -3)
		},
		new List<TSVector2>
		{
			new TSVector2(0, 12),
			new TSVector2(0, -12),
			new TSVector2(12, 0),
			new TSVector2(-12, 0),
			new TSVector2(-6, 10),
			new TSVector2(-6, -10),
			new TSVector2(-10, 6),
			new TSVector2(-10, -6),
			new TSVector2(6, 10),
			new TSVector2(6, -10),
			new TSVector2(10, 6),
			new TSVector2(10, -6),
			new TSVector2(0, 6.5),
			new TSVector2(0, -6.5),
			new TSVector2(6.5, 0),
			new TSVector2(-6.5, 0),
			new TSVector2(-2.5, 2.5),
			new TSVector2(2.5, 2.5),
			new TSVector2(-2.5, -2.5),
			new TSVector2(2.5, -2.5)
		}
	};

	protected PlayFX _playFX;

	protected ComboInputBuffer.ActionKey[] _actionKey;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		SetUnparalleledEnable();
		SetLockToughnessEnable();
		SetBattleOutEnable();
		SetCloseBlockEnable();
	}

	protected void UpdateData()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		GetAttackTarget();
		SwitchCameraSetting(active: true, "Travel");
		BeginLookAtByPos(new TSVector2(-7, 10), 0, 400);
		yield return WaitTime(0.6);
		MoveToPosition(new TSVector2(-7, 10), 0.1f, AdventureActor.MovementMode.Walk);
		yield return WaitMoveStatus();
		BeginLookAtByPos(new TSVector2(-11, 14), 0, 400);
		BeginAttack(1, _actionKeyJumpInto, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(1.3);
		TriggerOpLisener("TravelAround");
		SetHideModelEnable();
		Teleport(new TSVector2(0, 12));
		BeginLookAtByPos(new TSVector2(0, 0), 0, 900);
		StartCoroutine(AreaEffect1());
		StartCoroutine(AreaEffect2());
		yield return WaitTime(12);
		SetHideModelDisable();
		BeginAttack(2, _actionKeyJumpOut, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		SwitchCameraSetting(active: false, "Travel");
		SetUnparalleledDisable();
		SetCloseBlockDisable();
		MoveToPosition(new TSVector2(0, 0), 0.1f, AdventureActor.MovementMode.Walk);
		yield return WaitMoveStatus();
	}

	private IEnumerator AreaEffect1()
	{
		for (FP time = 12; time > 0; time -= (FP)1)
		{
			doAreaEffect1();
			yield return WaitTime(1);
		}
	}

	private void doAreaEffect1()
	{
		TSVector2 entityPositionObsoleted = GetEntityPositionObsoleted(GetCurrentPlayer());
		PlayAreaEffect(fxAlias, entityPositionObsoleted);
	}

	private IEnumerator AreaEffect2()
	{
		for (int i = 0; i < fanOffsetList.Count; i++)
		{
			for (int j = 0; j < fanOffsetList.get_Item(i).Count; j++)
			{
				TSVector2 position = fanOffsetList.get_Item(i).get_Item(j);
				PlayAreaEffect(fxAlias, position);
			}
			yield return WaitTime(2);
		}
	}

	protected void OnFinish()
	{
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		OnFinish();
	}

	protected override void OnSkillDisable()
	{
		SetUnparalleledDisable();
		SwitchCameraSetting(active: false, "Travel");
	}
}
