using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._30931HaSaNa_MiniBoss;

public class Action_Lv1 : MonsterActionBase
{
	private static readonly int Attack01_HorizontalSlash = 3093156;

	private static readonly int Attack02_RushAttack = 3093162;

	private static readonly int Skill01_SandBullet = 3093151;

	private static readonly int Skill02_SandPillar = 3093152;

	private static readonly int Skill03_CallSandSoldier = 3093153;

	private static readonly int Skill04_SandWave = 3093154;

	private static readonly int Skill05_CallArmy = 3093155;

	private static readonly int Skill06_ActivateSandArea = 3093157;

	private static readonly int Wander = 3093161;

	private static readonly int testSkillId = 0;

	private static readonly FP MeleeRange = 5;

	private static readonly FP HP_P2 = 0.75;

	private static readonly FP HP_SkillUp_Lv1 = 0.5;

	private static readonly FP HP_SkillUp1_Lv2 = 0.75;

	private static readonly FP HP_SkillUp2_Lv2 = 0.5;

	private static readonly FP OffTime_Max = 15;

	private static readonly FP BigSkillCd = 70;

	private bool MagicSwitch;

	private bool IsP2;

	private bool SkillLv2;

	private bool SkillLv3;

	private FP OffTime;

	private FP BigSkillTime;

	private bool ReActive;

	private bool BigSkill;

	private int SequenceIndex;

	protected override void SetConfig()
	{
		_monsterAIType = MonsterAIType.SEQUENCE;
		List<BaseBranchInfo> list = new List<BaseBranchInfo>();
		OperateDelegate operateIEnumerator = Cast1;
		list.Add(new BaseBranchInfo(1001, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Cast2;
		list.Add(new BaseBranchInfo(1002, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Cast4;
		list.Add(new BaseBranchInfo(1004, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Cast5;
		list.Add(new BaseBranchInfo(1005, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Cast6;
		list.Add(new BaseBranchInfo(1006, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Cast7;
		list.Add(new BaseBranchInfo(1007, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Cast8;
		list.Add(new BaseBranchInfo(1008, default, default, default, null, operateIEnumerator));
		List<BaseBranchInfo> sequenceBranches = list;
		Dictionary<int, List<int>> sequenceDict = new Dictionary<int, List<int>>
		{
			[1] = new List<int> { 1001, 1004, 1008, 1002, 1001, 1008, 1002 },
			[2] = new List<int>
			{
				1005, 1001, 1004, 1008, 1002, 1001, 1005, 1001, 1008, 1002,
				1001
			},
			[3] = new List<int> { 1007 },
			[4] = new List<int> { 1006 }
		};
		InitSequenceBranches(3, sequenceBranches, sequenceDict);
	}

	protected override void OnActionStart()
	{
		base.OnActionStart();
		StartCor(Timer1());
		StartCor(Timer2());
	}

	protected override void OnActionEnable()
	{
		IsP2 = false;
		SkillLv2 = false;
		SkillLv3 = false;
		MagicSwitch = false;
		BigSkillTime = 0;
		BigSkill = true;
		SetLogicTagStringValue(_actor, "SkillLv", "SkillLv_1");
		OffTime = 0;
		ReActive = true;
	}

	protected override void SetListenEvents()
	{
		InitListenEvent(MonsterEventType.SelfHpChanged, active: true, PhaseChange);
	}

	private void PhaseChange(IEvent evt)
	{
		if (_actor.actorHealthInfo.hpPercentage <= HP_P2 && !IsP2)
		{
			SwitchSequence(2);
			IsP2 = true;
		}
		if (IsP2 && ReActive)
		{
			SequenceIndex = GetCurrentSequenceIndex();
			SwitchSequence(3);
		}
		if (GetMonsterTagValue(_actor, 1) == "Hard")
		{
			if (_actor.actorHealthInfo.hpPercentage <= HP_SkillUp1_Lv2 && _actor.actorHealthInfo.hpPercentage > HP_SkillUp2_Lv2 && !SkillLv2)
			{
				SetLogicTagStringValue(_actor, "SkillLv", "SkillLv_2");
				SkillLv2 = true;
			}
			else if (_actor.actorHealthInfo.hpPercentage <= HP_SkillUp2_Lv2)
			{
				if (!SkillLv3)
				{
					SetLogicTagStringValue(_actor, "SkillLv", "SkillLv_3");
					SkillLv3 = true;
				}
				if (BigSkill)
				{
					SequenceIndex = GetCurrentSequenceIndex();
					SwitchSequence(4);
				}
			}
		}
		else if (_actor.actorHealthInfo.hpPercentage <= HP_SkillUp_Lv1 && !SkillLv2)
		{
			SetLogicTagStringValue(_actor, "SkillLv", "SkillLv_2");
			SkillLv2 = true;
		}
	}

	private IEnumerator Timer1()
	{
		while (OffTime <= OffTime_Max)
		{
			yield return null;
			if (GetTargetByTeammateIndex(1).Count != 0 && !GetLogicTagToggleValue(GetTargetByTeammateIndex(1).get_Item(0), "IsActive") && !ReActive)
			{
				OffTime += _actor.LogicDeltaTime;
			}
		}
		ReActive = true;
	}

	private IEnumerator Timer2()
	{
		while (BigSkillTime <= BigSkillCd)
		{
			yield return null;
			if (!BigSkill)
			{
				BigSkillTime += _actor.LogicDeltaTime;
			}
		}
		BigSkill = true;
	}

	private void GotoCastSkill(int ID)
	{
		if (testSkillId != 0)
		{
			ID = testSkillId;
		}
		CastSkill(ID);
	}

	private IEnumerator Cast1()
	{
		if (GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) < MeleeRange)
		{
			GotoCastSkill(Attack01_HorizontalSlash);
			yield return WaitSkillFinish();
		}
		else
		{
			GotoCastSkill(Attack02_RushAttack);
			yield return WaitSkillFinish();
		}
	}

	private IEnumerator Cast2()
	{
		if (!MagicSwitch)
		{
			GotoCastSkill(Skill01_SandBullet);
			yield return WaitSkillFinish();
		}
		else
		{
			GotoCastSkill(Skill02_SandPillar);
			yield return WaitSkillFinish();
		}
	}

	private IEnumerator Cast4()
	{
		if (GetTargetByTeammateIndex(2).Count < 4)
		{
			GotoCastSkill(Skill03_CallSandSoldier);
			yield return WaitSkillFinish();
		}
	}

	private IEnumerator Cast5()
	{
		GotoCastSkill(Skill04_SandWave);
		yield return WaitSkillFinish();
		MagicSwitch = !MagicSwitch;
	}

	private IEnumerator Cast6()
	{
		GotoCastSkill(Skill05_CallArmy);
		BigSkill = false;
		BigSkillTime = 0;
		SwitchSequence(2);
		SetCurrentSequenceIndex(SequenceIndex);
		yield return WaitSkillFinish();
	}

	private IEnumerator Cast7()
	{
		GotoCastSkill(Skill06_ActivateSandArea);
		yield return WaitSkillFinish();
		ReActive = false;
		OffTime = 0;
		if (!IsP2)
		{
			SwitchSequence(1);
			yield break;
		}
		SwitchSequence(2);
		SetCurrentSequenceIndex(SequenceIndex);
	}

	private IEnumerator Cast8()
	{
		GotoCastSkill(Wander);
		yield return WaitSkillFinish();
	}
}
