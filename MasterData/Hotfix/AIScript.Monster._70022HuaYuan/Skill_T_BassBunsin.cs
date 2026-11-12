using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._70022HuaYuan;

public class Skill_T_BassBunsin : Skill_Base
{
	private int SkillBranch;

	private bool IsNormalEnd;

	private readonly string FlashFx = "fx_70022_base_Kagebunsin_Flash";

	private readonly string ControlFx = "fx_70022_bullet_Kagebunsin_Control";

	private List<long> ControlFxList = new List<long>();

	private readonly string ControllineFx = "fx_70022_loop_Kagebunsin_Control_line";

	private List<long> ControllineFxList = new List<long>();

	private readonly string ClockFx = "fx_70022_ground_Kagebunsin_Clock";

	private List<long> ClockFxList = new List<long>();

	private readonly string ActiveFx = "fx_70022_loop_Kagebunsin_Active";

	private List<long> ActiveFxList = new List<long>();

	private TSVector2 SelfPOS;

	private TSVector2 TargetPOS;

	private TSVector2 SummonPOS;

	private int MonsterID = 1;

	private List<LogicEntity> SummonList = new List<LogicEntity>();

	private DeterministicShape Fan;

	private FP SpawnRadius = 10;

	private FP SpawnInnerRadius = 8.5;

	protected override void OnSkillEnable()
	{
		IsNormalEnd = false;
		SkillBranch = 0;
		SummonList.Clear();
		ControlFxList.Clear();
		ControllineFxList.Clear();
		ClockFxList.Clear();
		ActiveFxList.Clear();
	}

	protected override void OnSkillDisable()
	{
		SummonList.Clear();
		ControlFxList.Clear();
		ControllineFxList.Clear();
		ClockFxList.Clear();
		if (!IsNormalEnd)
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
		}
		ActiveFxList.Clear();
	}

	protected override IEnumerator DoMainLogic()
	{
		yield return StartCor(Summon_One());
		yield return StartCor(Control());
		yield return StartCor(Link());
		yield return StartCor(Attack_Master());
		yield return StartCor(Tag_Bunsin());
		IsNormalEnd = true;
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected IEnumerator Summon_One()
	{
		BeginAttack(ninjutsuIndex, ninjutsuKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		Fan = GetShapeData(DeterministicShape.ShapeType.Fan, GetPosition(), default, default, SpawnRadius, SpawnInnerRadius, 90, GetTSVectToAngle(new TSVector2(0, 0) - GetPosition(), 0));
		SummonPOS = GetShapeRandomPoint(Fan, _actor, isReachable: true);
		SummonTeammate(MonsterID, SummonPOS, new TSVector2(0, 0));
		PlayEffect(FlashFx, 1f, default, SummonPOS, default, 2.2f);
		yield return WaitTime(0.1);
		SummonList.AddRange(GetTargetByTeammateIndex(MonsterID));
		for (int i = 0; i < SummonList.Count; i++)
		{
			SetLogicTagToggleValue(SummonList.get_Item(i), "release", value: false);
		}
	}

	protected IEnumerator Control()
	{
		SelfPOS = GetPosition();
		for (int i = 0; i < SummonList.Count; i++)
		{
			TargetPOS = GetEntityPosition(SummonList.get_Item(i));
			ControlFxList.Add(PlayLinkEffect(ControlFx, useCustomSource: true, null, SelfPOS, default, null, TargetPOS, default, breakWhenLostSourceOrTarget: true, 1f, actorScale: true));
		}
		yield return WaitTime(0.25);
		for (int j = 0; j < SummonList.Count; j++)
		{
			TargetPOS = GetEntityPosition(SummonList.get_Item(j));
			ControllineFxList.Add(PlayLinkEffect(ControllineFx, useCustomSource: true, null, SelfPOS, 0.3, null, TargetPOS, default, breakWhenLostSourceOrTarget: true, 1f, actorScale: true));
		}
		yield return WaitTime(0.4);
	}

	protected IEnumerator Attack_Master()
	{
		SkillBranch = (int)(long)GetRandomValue(0, 2.5, isInt: true);
		switch (SkillBranch)
		{
		case 0:
		{
			yield return StartCor(CircleAOE(2));
			for (int j = 0; j < SummonList.Count; j++)
			{
				SetLogicTagFpValue(SummonList.get_Item(j), "bunsinSkill", 0);
			}
			break;
		}
		case 1:
		{
			yield return StartCor(RingAOE(3));
			for (int k = 0; k < SummonList.Count; k++)
			{
				SetLogicTagFpValue(SummonList.get_Item(k), "bunsinSkill", 1);
			}
			break;
		}
		case 2:
		{
			LogicEntity target = GetTarget();
			yield return BeginLookAtByPos(GetEntityPosition(target), 0.3, 600);
			yield return StartCor(FanAOE());
			for (int l = 0; l < SummonList.Count; l++)
			{
				SetLogicTagFpValue(SummonList.get_Item(l), "bunsinSkill", 2);
			}
			break;
		}
		default:
		{
			yield return StartCor(FanAOE());
			for (int i = 0; i < SummonList.Count; i++)
			{
				SetLogicTagFpValue(SummonList.get_Item(i), "bunsinSkill", 2);
			}
			break;
		}
		}
		yield return WaitTime(0.4);
	}

	private IEnumerator Link()
	{
		for (int i = 0; i < SummonList.Count; i++)
		{
			TargetPOS = GetEntityPosition(SummonList.get_Item(i));
			ActiveFxList.Add(PlayEffect(ActiveFx, 1f, 3.7, TargetPOS, default, 1.2f, actorScale: true));
		}
		yield return null;
	}

	private IEnumerator Tag_Bunsin()
	{
		for (int i = 0; i < SummonList.Count; i++)
		{
			StopEffect(ControlFxList.get_Item(i));
			StopEffect(ControllineFxList.get_Item(i));
			StopEffect(ActiveFxList.get_Item(i));
			TargetPOS = GetEntityPosition(SummonList.get_Item(i));
			ClockFxList.Add(PlayEffect(ClockFx, 0.45f, default, TargetPOS, default, 1.5f, actorScale: true));
			SetLogicTagToggleValue(SummonList.get_Item(SummonList.Count - 1), "release", value: true);
		}
		yield return null;
	}
}
