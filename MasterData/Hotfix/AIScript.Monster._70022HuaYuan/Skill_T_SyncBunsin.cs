#define LOG_DEBUG
using System;
using System.Collections;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using TrueSync;
using UnityEngine;

namespace AIScript.Monster._70022HuaYuan;

public class Skill_T_SyncBunsin : Skill_Base
{
	private CoroutineNode damageCor;

	private int[] atkType = new int[3];

	private readonly Dictionary<int, List<int>> dicAtkType = new Dictionary<int, List<int>>
	{
		{
			0,
			new List<int> { 0, 1 }
		},
		{
			1,
			new List<int> { 0, 1, 2, 3 }
		}
	};

	private readonly Dictionary<int, List<string>> dicAtkTypeFx = new Dictionary<int, List<string>>
	{
		{
			0,
			new List<string> { "fx_70022_loop_warning_Kagebunsin_DIFF_A_Adjoin", "fx_70022_loop_warning_Kagebunsin_DIFF_A_Intersect" }
		},
		{
			1,
			new List<string> { "fx_70022_loop_warning_Kagebunsin_Same_B_CIR", "fx_70022_loop_warning_Kagebunsin_Same_B_Ring", "fx_70022_loop_warning_Kagebunsin_DIFF_B_Adjoin", "fx_70022_loop_warning_Kagebunsin_DIFF_B_Intersect" }
		}
	};

	private readonly Dictionary<int, int[]> dicAtkShape;

	private bool normalTermination;

	private long atkFxID;

	private readonly string FlashFx;

	private readonly string ControlFx;

	private List<long> ControlFxList;

	private readonly string ControllineFx;

	private List<long> ControllineFxList;

	private readonly string ActiveFx;

	private List<long> ActiveFxList;

	private List<long> ClockFxList;

	private List<TSVector2> SummonPOS;

	private List<TSVector2> SummonPOS01;

	private List<TSVector2> SummonPOS00;

	private int MonsterID;

	private List<LogicEntity> SummonList;

	protected override void OnSkillEnable()
	{
		SetBlockPriorityToStatic();
		NovaLogger.Debug("花原.同步分身技能.开始");
	}

	protected override void OnSkillDisable()
	{
		Array.Clear(atkType, 0, atkType.Length);
		SummonPOS.Clear();
		SummonList.Clear();
		ControlFxList.Clear();
		ControllineFxList.Clear();
		if (!normalTermination)
		{
			List<LogicEntity> targetsByFaction = GetTargetsByFaction(isFriend: true);
			if (targetsByFaction.Count > 0)
			{
				for (int i = 0; i < targetsByFaction.Count; i++)
				{
					PlayEffect(FlashFx, 1f, default, GetEntityPosition(targetsByFaction.get_Item(i)), default, 2.2f);
				}
				ClearActors(targetsByFaction);
			}
			if (ActiveFxList.Count > 0)
			{
				for (int j = 0; j < ActiveFxList.Count; j++)
				{
					StopEffect(ActiveFxList.get_Item(j));
				}
			}
			if (ClockFxList.Count > 0)
			{
				for (int k = 0; k < ClockFxList.Count; k++)
				{
					StopEffect(ClockFxList.get_Item(k));
				}
			}
		}
		ActiveFxList.Clear();
		ClockFxList.Clear();
		NovaLogger.Debug("花原.同步分身技能.结束");
	}

	protected override IEnumerator DoMainLogic()
	{
		if (GetLogicTagToggleValue(_actor, "SyncBunsin_SWC"))
		{
			InterruptSkill();
		}
		SetSearchedImmunityEnable();
		yield return StartCor(BackToZeroPos());
		SetSearchedImmunityDisable();
		int[] attackType = GetAttackType();
		if (attackType != null)
		{
			Array.Copy(attackType, atkType, attackType.Length);
		}
		yield return StartCor(Summon());
		yield return StartCor(MasterAttack(atkType, SummonList));
		yield return WaitTime(0.5);
		yield return StartCor(CoordinatedAttack(atkType, SummonList));
		yield return WaitTime(3);
		StopEffect(atkFxID);
		StopCor(damageCor);
		yield return WaitTime(0.5);
		KillBunsin(SummonList);
		yield return WaitTime(1.5);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void KillBunsin(List<LogicEntity> targets)
	{
		if (targets.Count > 1 && targets != null)
		{
			for (int i = 0; i < targets.Count; i++)
			{
				PlayEffect(FlashFx, 1f, default, GetEntityPosition(targets.get_Item(i)), default, 2.2f);
			}
			KillActors(targets);
		}
	}

	private IEnumerator CoordinatedAttack(int[] type, List<LogicEntity> bunsin)
	{
		BunsinAction(SummonList);
		normalTermination = true;
		yield return WaitTime(0.7);
		if ((bunsin != null) & (bunsin.Count > 0))
		{
			for (int i = 0; i < bunsin.Count; i++)
			{
				PlayEffect(WarningFx_Actor, 1f, 2, GetEntityPosition(bunsin.get_Item(i)), default, 2.5f);
			}
		}
		if (ClockFxList.Count > 0)
		{
			for (int j = 0; j < ClockFxList.Count; j++)
			{
				StopEffect(ClockFxList.get_Item(j));
			}
		}
		yield return WaitTime(0.3);
		string fxAlias = dicAtkTypeFx.get_Item(type[0]).get_Item(type[1]);
		atkFxID = PlayEffect(fxAlias, 1f, default, TSVector2.zero, 0);
		ActiveFxList.Add(atkFxID);
		if (SummonPOS == null || SummonPOS.Count <= 0 || SummonPOS.Count > 4)
		{
			yield break;
		}
		FP radius = 0;
		FP fP = 0;
		int[] array = dicAtkShape.get_Item(atkType[0] * 2 + atkType[1]);
		List<DeterministicShape> list = new List<DeterministicShape>();
		List<DeterministicShape> list2 = new List<DeterministicShape>();
		for (int k = 0; k < array.Length; k++)
		{
			if (array[k] == 0)
			{
				radius = 7.5;
				fP = 0;
			}
			else if (array[k] == 1)
			{
				radius = 15;
				fP = 4;
				list2.Add(GetShapeData(DeterministicShape.ShapeType.Circle, SummonPOS.get_Item(k), default, default, fP, 0));
			}
			else
			{
				InterruptAttack();
			}
			list.Add(GetShapeData(DeterministicShape.ShapeType.Circle, SummonPOS.get_Item(k), default, default, radius, fP));
		}
		damageCor = StartCor(CoordinathedAtkDMG(list, list2));
	}

	private int[] GetAttackType()
	{
		if (dicAtkType != null && dicAtkType.Count > 0)
		{
			int value = (int)(long)GetRandomValue(0, (double)dicAtkType.Count - 0.5);
			value = Mathf.Clamp(value, 0, dicAtkType.Count - 1);
			int value2 = (int)(long)GetRandomValue(0, (double)dicAtkType.get_Item(value).Count - 0.5);
			value2 = Mathf.Clamp(value2, 0, dicAtkType.get_Item(value).Count - 1);
			int num = ((value == 1 && value2 < 2) ? 1 : 2);
			return new int[3] { value, value2, num };
		}
		InterruptAttack();
		return null;
	}

	private IEnumerator Summon()
	{
		List<LogicEntity> summons = new List<LogicEntity>();
		List<LogicEntity> entitiesFromShape = new List<LogicEntity>();
		List<LogicEntity> friendEntity = new List<LogicEntity>();
		BeginAttack(ninjutsuIndex, ninjutsuKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		switch (atkType[0])
		{
		case 0:
			SummonPOS.AddRange(SummonPOS00);
			break;
		case 1:
			SummonPOS.AddRange(SummonPOS01);
			break;
		default:
			InterruptAttack();
			break;
		}
		for (int i = 0; i < 4; i++)
		{
			PlayEffect(FlashFx, 1f, default, SummonPOS.get_Item(i), default, 2.2f);
			SummonTeammate(MonsterID, SummonPOS.get_Item(i), TSVector2.zero - SummonPOS.get_Item(i));
			yield return null;
		}
		yield return WaitTime(0.2);
		SummonList.AddRange(GetTargetByTeammateIndex(MonsterID));
		for (int i = 0; i < SummonList.Count; i++)
		{
			DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Circle, SummonPOS.get_Item(i), default, default, 2);
			friendEntity.AddRange(GetTargetsByFaction(isFriend: true));
			entitiesFromShape.AddRange(GetTargetsFromShape(shapeData, friendEntity));
			if (entitiesFromShape.Count > 0 && entitiesFromShape != null)
			{
				summons.Add(entitiesFromShape.get_Item(0));
				SetLogicTagToggleValue(summons.get_Item(i), "SyncRelease", value: false);
				SetLogicTagFpValue(summons.get_Item(i), "bunsinSkill", 3);
				SetLogicTagFpValue(summons.get_Item(i), "bunsinIndex", i);
				entitiesFromShape.Clear();
				friendEntity.Clear();
			}
			else
			{
				InterruptAttack();
			}
			yield return null;
		}
		SummonList.Clear();
		SummonList.AddRange(summons);
		summons.Clear();
	}

	private IEnumerator ControlBunsin(List<LogicEntity> targets)
	{
		TSVector2 selfPOS = GetPosition();
		for (int i = 0; i < targets.Count; i++)
		{
			TSVector2 entityPosition = GetEntityPosition(targets.get_Item(i));
			ControlFxList.Add(PlayLinkEffect(ControlFx, useCustomSource: true, null, selfPOS, default, null, entityPosition, default, breakWhenLostSourceOrTarget: true, 1f, actorScale: true));
		}
		yield return WaitTime(0.25);
		for (int j = 0; j < targets.Count; j++)
		{
			TSVector2 entityPosition = GetEntityPosition(targets.get_Item(j));
			ControllineFxList.Add(PlayLinkEffect(ControllineFx, useCustomSource: true, null, selfPOS, 0.3, null, entityPosition, default, breakWhenLostSourceOrTarget: true, 1f, actorScale: true));
		}
	}

	private IEnumerator RecordingFx(List<LogicEntity> targets)
	{
		for (int i = 0; i < targets.Count; i++)
		{
			TSVector2 entityPosition = GetEntityPosition(targets.get_Item(i));
			ActiveFxList.Add(PlayEffect(ActiveFx, 1f, 3.7, entityPosition, default, 1.2f, actorScale: true));
		}
		yield return null;
	}

	private IEnumerator MasterAttack(int[] atkType, List<LogicEntity> targets)
	{
		List<LogicEntity> list = new List<LogicEntity>();
		List<LogicEntity> targetsGroup2 = new List<LogicEntity>();
		if (atkType[2] == 1)
		{
			list.AddRange(targets);
			if (atkType[1] == 0)
			{
				yield return StartCor(ConnectBunshinProcess(list, 2, 0, 0.8f));
			}
			else if (atkType[1] == 1)
			{
				yield return StartCor(ConnectBunshinProcess(list, 2, 1, 0.8f));
			}
			else
			{
				InterruptAttack();
			}
			yield break;
		}
		if (atkType[0] == 0)
		{
			switch (atkType[1])
			{
			case 0:
				if (targets.Count > 0 && targets != null)
				{
					list.Add(targets.get_Item(1));
					list.Add(targets.get_Item(2));
					targetsGroup2.Add(targets.get_Item(0));
					targetsGroup2.Add(targets.get_Item(3));
				}
				else
				{
					InterruptAttack();
				}
				break;
			case 1:
				if (targets.Count > 0 && targets != null)
				{
					list.Add(targets.get_Item(1));
					list.Add(targets.get_Item(3));
					targetsGroup2.Add(targets.get_Item(0));
					targetsGroup2.Add(targets.get_Item(2));
				}
				else
				{
					InterruptAttack();
				}
				break;
			default:
				InterruptAttack();
				break;
			}
		}
		else
		{
			switch (atkType[1])
			{
			case 2:
				if (targets.Count > 0 && targets != null)
				{
					list.Add(targets.get_Item(1));
					list.Add(targets.get_Item(2));
					targetsGroup2.Add(targets.get_Item(0));
					targetsGroup2.Add(targets.get_Item(3));
				}
				else
				{
					InterruptAttack();
				}
				break;
			case 3:
				if (targets.Count > 0 && targets != null)
				{
					list.Add(targets.get_Item(1));
					list.Add(targets.get_Item(3));
					targetsGroup2.Add(targets.get_Item(0));
					targetsGroup2.Add(targets.get_Item(2));
				}
				else
				{
					InterruptAttack();
				}
				break;
			default:
				InterruptAttack();
				break;
			}
		}
		yield return StartCor(ConnectBunshinProcess(list, 1.5, 1, 0.13f));
		yield return WaitTime(0.5);
		yield return StartCor(ConnectBunshinProcess(targetsGroup2, 1.5, 0, 0.8f));
	}

	private void BunsinAction(List<LogicEntity> targets)
	{
		for (int i = 0; i < targets.Count; i++)
		{
			SetLogicTagToggleValue(targets.get_Item(i), "SyncRelease", value: true);
		}
	}

	private void ReleaseBunsin()
	{
		if (ControlFxList != null && ControlFxList.Count > 0)
		{
			for (int i = 0; i < ControlFxList.Count; i++)
			{
				StopEffect(ControlFxList.get_Item(i));
			}
			ControlFxList.Clear();
		}
		if (ControllineFxList != null && ControllineFxList.Count > 0)
		{
			for (int j = 0; j < ControllineFxList.Count; j++)
			{
				StopEffect(ControllineFxList.get_Item(j));
			}
			ControllineFxList.Clear();
		}
		if (ActiveFxList != null && ActiveFxList.Count > 0)
		{
			for (int k = 0; k < ActiveFxList.Count; k++)
			{
				StopEffect(ActiveFxList.get_Item(k));
			}
			ActiveFxList.Clear();
		}
	}

	private IEnumerator ConnectBunshinProcess(List<LogicEntity> targets, FP durationOfAction, int type, float clockFxPlaySpeed)
	{
		yield return StartCor(ControlBunsin(targets));
		yield return StartCor(RecordingFx(targets));
		switch (type)
		{
		case 0:
			yield return StartCor(CircleAOE(durationOfAction));
			break;
		case 1:
			yield return StartCor(RingAOE(durationOfAction));
			break;
		default:
			InterruptAttack();
			break;
		}
		ReleaseBunsin();
		if (targets != null && targets.Count > 0)
		{
			for (int i = 0; i < targets.Count; i++)
			{
				ClockFxList.Add(PlayEffect(clockFx, clockFxPlaySpeed, default, GetEntityPosition(targets.get_Item(i)), default, 2f));
			}
		}
	}

	private IEnumerator CoordinathedAtkDMG(List<DeterministicShape> affectedArea, List<DeterministicShape> safetyArea)
	{
		FP damageInterval = 0.5;
		int duration = 10;
		LogicEntity player = GetCurrentPlayer();
		List<bool> searchResults = new List<bool>();
		List<LogicEntity> targetsFromShape = new List<LogicEntity>();
		HitFeatureData hitData = GetHitFeatureData(HitBox.FeatureFlag.None, default, default, UseAtttackForward: false, default, null, null, default, default, default, default, default, default, default, default, default, null, null, null, null, 3);
		if (affectedArea == null || affectedArea.Count <= 0)
		{
			yield break;
		}
		for (int j = 0; j < (int)(long)(duration / damageInterval); j++)
		{
			searchResults.Clear();
			if (safetyArea != null && safetyArea.Count > 0)
			{
				for (int i = 0; i < safetyArea.Count; i++)
				{
					targetsFromShape.Clear();
					targetsFromShape.AddRange(GetTargetsFromShape(safetyArea.get_Item(i), null, includeSelf: false, player));
					if (targetsFromShape != null && targetsFromShape.Count > 0)
					{
						searchResults.Add(item: true);
					}
					else
					{
						searchResults.Add(item: false);
					}
				}
				if (searchResults.Contains(item: true))
				{
					yield return WaitTime(damageInterval);
					continue;
				}
			}
			for (int k = 0; k < affectedArea.Count; k++)
			{
				AreaHit_Simple(_actor, affectedArea.get_Item(k), hitData, 70022010, 0.4, HitBox.HurtAnimType.Small, "fx_70022_hit_Skill01");
			}
			yield return WaitTime(damageInterval);
		}
	}

	public Skill_T_SyncBunsin()
	{
		//IL_0106: Field data (rva=0x5f8) could not be found in any section!
		//IL_0106: Field data (rva=0x5f8) could not be found in any section!
		Dictionary<int, int[]> dictionary = new Dictionary<int, int[]>
		{
			{
				0,
				new int[4] { 0, 1, 1, 0 }
			},
			{
				1,
				new int[4] { 0, 1, 0, 0 }
			},
			{
				2,
				new int[4]
			}
		};
		int[] array = new int[4];
		RuntimeHelpers.InitializeArray(array, __ldtoken(_003CPrivateImplementationDetails_003E._1B897DDDD4C151E2A2E6E3E91B7EA0F7FC4FD5ED00EF1C9669E8566393A02586));
		dictionary.Add(3, array);
		dictionary.Add(4, new int[4] { 0, 1, 1, 0 });
		dictionary.Add(5, new int[4] { 0, 1, 0, 1 });
		dicAtkShape = dictionary;
		FlashFx = "fx_70022_base_Kagebunsin_Flash";
		ControlFx = "fx_70022_bullet_Kagebunsin_Control";
		ControlFxList = new List<long>();
		ControllineFx = "fx_70022_loop_Kagebunsin_Control_line";
		ControllineFxList = new List<long>();
		ActiveFx = "fx_70022_loop_Kagebunsin_Active";
		ActiveFxList = new List<long>();
		ClockFxList = new List<long>();
		SummonPOS = new List<TSVector2>();
		SummonPOS01 = new List<TSVector2>
		{
			new TSVector2(-8, 8),
			new TSVector2(8, 8),
			new TSVector2(8, -8),
			new TSVector2(-8, -8)
		};
		SummonPOS00 = new List<TSVector2>
		{
			new TSVector2(0, 10),
			new TSVector2(10, 0),
			new TSVector2(0, -10),
			new TSVector2(-10, 0)
		};
		MonsterID = 1;
		SummonList = new List<LogicEntity>();
		base._002Ector();
	}
}
