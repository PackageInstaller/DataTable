using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._30931HaSaNa;

public class ActionScript : MonsterActionBase
{
	private readonly int skillId_Test = 3093104;

	private readonly int Ini_Seq = 1;

	private readonly int skillId_HorizontalSlash = 3093101;

	private readonly int skillId_RushAttack = 3093102;

	private readonly int skillId_Burrow = 3093103;

	private readonly int skillId_Thumping = 3093104;

	private readonly FP castDistance_HorizontalSlashOrRushAttack = 4;

	private readonly int skillId_DustSpraying = 3093105;

	private readonly int skillId_DustMissile = 3093106;

	private readonly int skillId_BeginTransform_Transform = 3093108;

	private readonly int skillId_MeleeAttack_Transform = 3093109;

	private readonly int skillId_Hammering_Transform = 3093110;

	private readonly int skillId_DustSpraying_Transform = 3093111;

	private readonly int skillId_DustExplosion_Transform = 3093112;

	private readonly int skillId_TransformBack_Transform = 3093119;

	private readonly int skillId_Alert = 3093113;

	private readonly int skillId_ActiveDevice = 3093114;

	private readonly int skillId_SandStorm = 3093115;

	private int CurSequence;

	private bool isStop;

	private int _skillId_OperateAttack_1_2;

	private readonly List<int> _skillIdPool_Melee = new List<int>(3);

	private int SkillID_Melee5;

	private int _enterTimes_S3;

	private readonly List<int> _skillIdPool_O1_O2_O3_S3 = new List<int>(3);

	protected override void SetConfig()
	{
		_monsterAIType = MonsterAIType.SEQUENCE;
		List<BaseBranchInfo> list = new List<BaseBranchInfo>();
		OperateDelegate operateIEnumerator = Operate_Alert;
		list.Add(new BaseBranchInfo(1001, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Operate_Attack_1_1;
		list.Add(new BaseBranchInfo(1002, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Operate_Alert;
		list.Add(new BaseBranchInfo(1003, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Operate_Attack_1_2;
		list.Add(new BaseBranchInfo(1004, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Operate_2;
		list.Add(new BaseBranchInfo(1005, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Operate_SandStorm;
		list.Add(new BaseBranchInfo(2001, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Operate_ActiveDevice;
		list.Add(new BaseBranchInfo(2002, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Operate_Melee_1;
		list.Add(new BaseBranchInfo(2003, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Operate_Melee_2;
		list.Add(new BaseBranchInfo(2004, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Operate_Magic_1;
		list.Add(new BaseBranchInfo(2005, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Operate_Melee_3;
		list.Add(new BaseBranchInfo(2006, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Operate_Melee_4;
		list.Add(new BaseBranchInfo(2007, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Operate_Magic_2;
		list.Add(new BaseBranchInfo(2008, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Operate_Alert;
		list.Add(new BaseBranchInfo(2009, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Operate_Melee_5;
		list.Add(new BaseBranchInfo(2010, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Operate_Transform;
		list.Add(new BaseBranchInfo(3001, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Operate2_S3;
		list.Add(new BaseBranchInfo(3002, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Operate3_S3;
		list.Add(new BaseBranchInfo(3003, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Operate4_S3;
		list.Add(new BaseBranchInfo(3004, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Operate_TransformBack;
		list.Add(new BaseBranchInfo(3005, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Operate_Test;
		list.Add(new BaseBranchInfo(9999, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Operate_TestHuanXing;
		list.Add(new BaseBranchInfo(9998, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Operate_TestJuRen;
		list.Add(new BaseBranchInfo(9997, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Operate_TestShaBao;
		list.Add(new BaseBranchInfo(9996, default, default, default, null, operateIEnumerator));
		List<BaseBranchInfo> sequenceBranches = list;
		Dictionary<int, List<int>> sequenceDict = new Dictionary<int, List<int>>
		{
			[1] = new List<int> { 1001, 1002, 1005, 1004 },
			[2] = new List<int> { 2001, 2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010 },
			[3] = new List<int> { 3001, 3002, 3003, 3004, 3005 },
			[4] = new List<int> { 3001, 3002, 3003, 3005 },
			[94] = new List<int> { 9999 },
			[95] = new List<int> { 9998 },
			[96] = new List<int> { 9997 },
			[97] = new List<int> { 9996 }
		};
		InitSequenceBranches(Ini_Seq, sequenceBranches, sequenceDict);
	}

	protected override void OnActionEnable()
	{
		CurSequence = 1;
	}

	protected override void OnActionStart()
	{
		base.OnActionStart();
		isStop = false;
	}

	protected override void OnActionStop()
	{
		base.OnActionStop();
		isStop = true;
		OnSequenceBranchOperateComplete(CurrentSeqIndex, CurrentIndex, CurrentIndex == 0);
	}

	protected override void SetListenEvents()
	{
		InitListenEvent(MonsterEventType.BattleLevelChange, active: true, OnBattleLevelChange);
	}

	private void OnBattleLevelChange(IEvent evt)
	{
		int newLevel = (evt as AdventureMonsterBattleLevelChangedEvent).newLevel;
		AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
		adventureActorCustomEvent.sender = _actor;
		adventureActorCustomEvent.eventName = "HaSaNaBossRushLvUp";
		adventureActorCustomEvent.intParam = newLevel;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorCustomEvent);
	}

	protected override void OnSequenceBranchOperateComplete(int curSeqIndex, int curBranchIndex, bool isSeqEnd)
	{
		if (isSeqEnd)
		{
			SetLockToughnessEnable(autoDisableWhenSkillDisable: false);
			switch (curSeqIndex)
			{
			case 1:
				CurSequence = 4;
				SwitchSequence(CurSequence);
				OnEnterSequenc3_4();
				break;
			case 2:
				CurSequence = 3;
				SwitchSequence(CurSequence);
				OnEnterSequenc3_4();
				break;
			case 3:
				CurSequence = 2;
				SwitchSequence(CurSequence);
				OnEnterSequenc2();
				break;
			case 4:
				CurSequence = 2;
				SwitchSequence(CurSequence);
				OnEnterSequenc2();
				break;
			case 95:
				SwitchSequence(94);
				break;
			case 96:
				SwitchSequence(94);
				break;
			case 97:
				SwitchSequence(94);
				break;
			}
		}
		else
		{
			if (!isStop)
			{
				return;
			}
			switch (curSeqIndex)
			{
			case 1:
				SetLockToughnessEnable(autoDisableWhenSkillDisable: false);
				CurSequence = 4;
				SwitchSequence(4);
				OnEnterSequenc3_4();
				break;
			case 4:
				SetLockToughnessEnable(autoDisableWhenSkillDisable: false);
				if (GetCurrentSequenceIndex() < 3)
				{
					SetCurrentSequenceIndex(3);
				}
				break;
			case 3:
				if (GetCurrentSequenceIndex() == 3)
				{
					SetLockToughnessEnable(autoDisableWhenSkillDisable: false);
				}
				break;
			case 2:
				break;
			}
		}
	}

	private IEnumerator Operate_Test()
	{
		CastSkill(skillId_Test);
		yield return WaitSkillFinish();
	}

	private IEnumerator Operate_TestHuanXing()
	{
		CastSkill(3093114);
		yield return WaitSkillFinish();
	}

	private IEnumerator Operate_TestJuRen()
	{
		CastSkill(3093114);
		yield return WaitSkillFinish();
		CastSkill(3093108);
		yield return WaitSkillFinish();
	}

	private IEnumerator Operate_TestShaBao()
	{
		CastSkill(3093115);
		yield return WaitSkillFinish();
	}

	private IEnumerator Operate_Alert()
	{
		CastSkill(skillId_Alert);
		yield return WaitSkillFinish();
	}

	private IEnumerator Operate_Attack_1_1()
	{
		if (GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) <= castDistance_HorizontalSlashOrRushAttack)
		{
			CastSkill(skillId_HorizontalSlash);
			_skillId_OperateAttack_1_2 = skillId_RushAttack;
		}
		else
		{
			CastSkill(skillId_RushAttack);
			_skillId_OperateAttack_1_2 = skillId_HorizontalSlash;
		}
		yield return WaitSkillFinish();
	}

	private IEnumerator Operate_Attack_1_2()
	{
		CastSkill(_skillId_OperateAttack_1_2);
		yield return WaitSkillFinish();
	}

	private IEnumerator Operate_2()
	{
		CastSkill(skillId_Burrow);
		yield return WaitSkillFinish();
	}

	private void OnEnterSequenc2()
	{
		SkillID_Melee5 = skillId_HorizontalSlash;
		_skillIdPool_Melee.Clear();
		_skillIdPool_Melee.Add(skillId_HorizontalSlash);
		_skillIdPool_Melee.Add(skillId_RushAttack);
	}

	private IEnumerator Operate_SandStorm()
	{
		if (_enterTimes_S3 == 2)
		{
			CastSkill(skillId_SandStorm);
			yield return WaitSkillFinish();
		}
	}

	private IEnumerator Operate_ActiveDevice()
	{
		CastSkill(skillId_ActiveDevice);
		yield return WaitSkillFinish();
	}

	private IEnumerator Operate_Melee_1()
	{
		int index = TSRandom.Range(0, _skillIdPool_Melee.Count);
		int num = _skillIdPool_Melee.get_Item(index);
		_skillIdPool_Melee.Remove(num);
		SkillID_Melee5 = num;
		CastSkill(num);
		yield return WaitSkillFinish();
	}

	private IEnumerator Operate_Melee_2()
	{
		SetLogicTagToggleValue(_actor, "IsSkillStrength", value: true);
		_skillIdPool_Melee.Add(skillId_Burrow);
		int index = TSRandom.Range(0, _skillIdPool_Melee.Count);
		int num = _skillIdPool_Melee.get_Item(index);
		_skillIdPool_Melee.Remove(num);
		CastSkill(num);
		yield return WaitSkillFinish();
	}

	private IEnumerator Operate_Magic_1()
	{
		CastSkill(skillId_DustSpraying);
		yield return WaitSkillFinish();
	}

	private IEnumerator Operate_Melee_3()
	{
		SetLogicTagToggleValue(_actor, "IsSkillStrength", value: true);
		_skillIdPool_Melee.Add(skillId_Thumping);
		int index = TSRandom.Range(0, _skillIdPool_Melee.Count);
		int num = _skillIdPool_Melee.get_Item(index);
		_skillIdPool_Melee.Remove(num);
		CastSkill(num);
		yield return WaitSkillFinish();
	}

	private IEnumerator Operate_Melee_4()
	{
		SetLogicTagToggleValue(_actor, "IsSkillStrength", value: true);
		int index = TSRandom.Range(0, _skillIdPool_Melee.Count);
		int num = _skillIdPool_Melee.get_Item(index);
		_skillIdPool_Melee.Remove(num);
		CastSkill(num);
		yield return WaitSkillFinish();
	}

	private IEnumerator Operate_Magic_2()
	{
		CastSkill(skillId_DustMissile);
		yield return WaitSkillFinish();
	}

	private IEnumerator Operate_Melee_5()
	{
		SetLogicTagToggleValue(_actor, "IsSkillStrength", value: true);
		CastSkill(SkillID_Melee5);
		yield return WaitSkillFinish();
	}

	private void OnEnterSequenc3_4()
	{
		_enterTimes_S3++;
		_skillIdPool_O1_O2_O3_S3.Clear();
		_skillIdPool_O1_O2_O3_S3.Add(skillId_MeleeAttack_Transform);
		_skillIdPool_O1_O2_O3_S3.Add(skillId_Hammering_Transform);
		_skillIdPool_O1_O2_O3_S3.Add(skillId_DustSpraying_Transform);
	}

	private IEnumerator Operate_Transform()
	{
		CastSkill(skillId_BeginTransform_Transform);
		yield return WaitSkillFinish();
		int index = TSRandom.Range(0, _skillIdPool_O1_O2_O3_S3.Count);
		int num = _skillIdPool_O1_O2_O3_S3.get_Item(index);
		_skillIdPool_O1_O2_O3_S3.Remove(num);
		CastSkill(num);
		yield return WaitSkillFinish();
	}

	private IEnumerator Operate2_S3()
	{
		int index = TSRandom.Range(0, _skillIdPool_O1_O2_O3_S3.Count);
		int num = _skillIdPool_O1_O2_O3_S3.get_Item(index);
		_skillIdPool_O1_O2_O3_S3.Remove(num);
		CastSkill(num);
		yield return WaitSkillFinish();
		yield return WaitTime(0.5);
	}

	private IEnumerator Operate3_S3()
	{
		int index = TSRandom.Range(0, _skillIdPool_O1_O2_O3_S3.Count);
		int num = _skillIdPool_O1_O2_O3_S3.get_Item(index);
		_skillIdPool_O1_O2_O3_S3.Remove(num);
		CastSkill(num);
		yield return WaitSkillFinish();
		yield return WaitTime(0.5);
	}

	private IEnumerator Operate4_S3()
	{
		CastSkill(skillId_DustExplosion_Transform);
		yield return WaitSkillFinish();
		yield return WaitTime(0.5);
	}

	private IEnumerator Operate_TransformBack()
	{
		CastSkill(skillId_TransformBack_Transform);
		yield return WaitSkillFinish();
	}
}
