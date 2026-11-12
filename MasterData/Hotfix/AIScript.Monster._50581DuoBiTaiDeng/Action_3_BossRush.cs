#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._50581DuoBiTaiDeng;

public class Action_3_BossRush : MonsterActionBase
{
	private static readonly int Attack_JinZhan = 5058181;

	private static readonly int Attack_JinZhanB = 5058183;

	private static readonly int Attack_JinZhanC = 5058184;

	private static readonly int Skill1_ZhaoHuan = 5058182;

	private static readonly int Skill2_LuoDeng = 5058103;

	private static readonly int Skill3_LeiDian = 5058104;

	private static readonly int Skill3_LeiDian_P1 = 5058114;

	private static readonly int Skill4_ZhuaZi = 5058105;

	private static readonly int Skill5_XuanZhuan = 5058106;

	private static readonly int Attack_Laser = 5058107;

	private static readonly int Ground_Light = 5058110;

	private static readonly int Wander = 5058199;

	private static readonly FP HpPercentStage2 = 0.65;

	private static readonly FP FarSkillOutRadius = 12;

	private static readonly FP FarSkillinnerRadius = 7.5;

	private static readonly FP NearSkillOutRadius = 5;

	private static readonly FP fanAngle = 90;

	private static readonly int testSkillId = 0;

	private static readonly int intervaltime = 1;

	private static readonly int Stage2RequireLevel = 20;

	private int SmallNearSkillCount;

	private int TmpSkillID;

	private static List<int> _availableAttacks;

	private int MeleeAttackCount = 1;

	private bool IsPhase2;

	private bool IsPhase3;

	protected override void SetConfig()
	{
		_monsterAIType = MonsterAIType.SEQUENCE;
		List<BaseBranchInfo> list = new List<BaseBranchInfo>();
		OperateDelegate operateIEnumerator = JinZhanSkill;
		list.Add(new BaseBranchInfo(1001, default, default, default, null, operateIEnumerator));
		operateIEnumerator = MediumSkillCast;
		list.Add(new BaseBranchInfo(1002, default, default, default, null, operateIEnumerator));
		operateIEnumerator = SummonSkillCast;
		list.Add(new BaseBranchInfo(1003, default, default, default, null, operateIEnumerator));
		operateIEnumerator = StressSkillCast;
		list.Add(new BaseBranchInfo(1004, default, default, default, null, operateIEnumerator));
		operateIEnumerator = UltraSkillCast;
		list.Add(new BaseBranchInfo(1005, default, default, default, null, operateIEnumerator));
		operateIEnumerator = ShootSkillCast;
		list.Add(new BaseBranchInfo(1006, default, default, default, null, operateIEnumerator));
		operateIEnumerator = GroundSkillCast;
		list.Add(new BaseBranchInfo(1007, default, default, default, null, operateIEnumerator));
		operateIEnumerator = FanSkillCast;
		list.Add(new BaseBranchInfo(1008, default, default, default, null, operateIEnumerator));
		operateIEnumerator = LaserSkillCast;
		list.Add(new BaseBranchInfo(1009, default, default, default, null, operateIEnumerator));
		operateIEnumerator = P1ThunderSkillCast;
		list.Add(new BaseBranchInfo(1010, default, default, default, null, operateIEnumerator));
		List<BaseBranchInfo> sequenceBranches = list;
		Dictionary<int, List<int>> sequenceDict = new Dictionary<int, List<int>>
		{
			[1] = new List<int>
			{
				1003, 1010, 1009, 1004, 1001, 1006, 1003, 1008, 1009, 1004,
				1010, 1001
			},
			[2] = new List<int>
			{
				1007, 1003, 1009, 1001, 1004, 1005, 1006, 1003, 1009, 1008,
				1004, 1005, 1001
			}
		};
		InitSequenceBranches(1, sequenceBranches, sequenceDict);
	}

	protected override void SetListenEvents()
	{
		InitListenEvent(MonsterEventType.SelfToughnessBroken, active: true, OnToughnessState);
		InitListenEvent(MonsterEventType.BattleLevelChange, active: true, LevelUp);
	}

	protected override void OnActionEnable()
	{
		StartCor(StageTimeCount());
	}

	private IEnumerator StageTimeCount()
	{
		yield return WaitTime(60);
		if (!IsPhase2)
		{
			SwitchSequence(2);
			NovaLogger.Debug("时间转阶段");
			IsPhase2 = true;
		}
		yield return WaitTime(120);
		NovaLogger.Debug("3分钟到了");
	}

	private void GotoCastSkill(int ID)
	{
		if (testSkillId != 0)
		{
			ID = testSkillId;
		}
		TmpSkillID = ID;
		CastSkill(ID);
	}

	private IEnumerator JinZhanSkill()
	{
		if (_availableAttacks == null || _availableAttacks.Count == 0)
		{
			_availableAttacks = new List<int> { Attack_JinZhan, Attack_JinZhanB, Attack_JinZhanC };
		}
		int index = (int)(long)GetRandomValue(0, _availableAttacks.Count - 1, isInt: true);
		int iD = _availableAttacks.get_Item(index);
		GotoCastSkill(iD);
		_availableAttacks.RemoveAt(index);
		yield return WaitSkillFinish();
	}

	private IEnumerator MediumSkillCast()
	{
		if (GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) <= FarSkillinnerRadius)
		{
			GotoCastSkill(Skill5_XuanZhuan);
		}
		else
		{
			GotoCastSkill(Skill4_ZhuaZi);
		}
		SmallNearSkillCount = 0;
		yield return WaitSkillFinish();
		GotoCastSkill(Skill3_LeiDian_P1);
		yield return WaitSkillFinish();
		GotoCastSkill(Wander);
		yield return WaitSkillFinish();
		yield return WaitTime(intervaltime);
	}

	private IEnumerator SummonSkillCast()
	{
		GotoCastSkill(Skill1_ZhaoHuan);
		yield return WaitSkillFinish();
	}

	private IEnumerator P1ThunderSkillCast()
	{
		GotoCastSkill(Skill3_LeiDian_P1);
		yield return WaitSkillFinish();
	}

	private IEnumerator FanSkillCast()
	{
		GotoCastSkill(Skill5_XuanZhuan);
		yield return WaitSkillFinish();
	}

	private IEnumerator LaserSkillCast()
	{
		GotoCastSkill(Attack_Laser);
		yield return WaitSkillFinish();
	}

	private IEnumerator StressSkillCast()
	{
		GotoCastSkill(Skill2_LuoDeng);
		yield return WaitSkillFinish();
	}

	private IEnumerator UltraSkillCast()
	{
		GotoCastSkill(Skill3_LeiDian);
		yield return WaitSkillFinish();
		GotoCastSkill(Wander);
		yield return WaitSkillFinish();
	}

	private IEnumerator ShootSkillCast()
	{
		GotoCastSkill(Skill4_ZhuaZi);
		yield return WaitSkillFinish();
	}

	private IEnumerator GroundSkillCast()
	{
		GotoCastSkill(Ground_Light);
		yield return WaitSkillFinish();
	}

	private void PhaseChange(IEvent evt)
	{
		if (_actor.actorHealthInfo.hpPercentage <= HpPercentStage2 && !IsPhase2)
		{
			SetLogicTagFpValue(_actor, "TaiDeng_Stage", 2);
			SwitchSequence(2);
			IsPhase2 = true;
		}
	}

	private void LevelUp(IEvent evt)
	{
		if ((evt as AdventureMonsterBattleLevelChangedEvent).newLevel >= Stage2RequireLevel && !IsPhase2)
		{
			SwitchSequence(2);
			IsPhase2 = true;
			NovaLogger.Debug("等级转阶段");
		}
	}

	private void OnToughnessState(IEvent evt)
	{
	}
}
