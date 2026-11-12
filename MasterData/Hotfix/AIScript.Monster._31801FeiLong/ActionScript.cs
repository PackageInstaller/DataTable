using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Monster._31801FeiLong;

public class ActionScript : MonsterActionBase
{
	private int _lastMeeleSkillId;

	private bool _canTriggerBurst;

	private int _lastFireSkillId;

	private int _lastFlySkillId;

	private bool _canTriggerTired;

	private int _triggerTriedTimes;

	protected override void SetConfig()
	{
		_monsterAIType = MonsterAIType.SEQUENCE;
		List<BaseBranchInfo> list = new List<BaseBranchInfo>();
		OperateDelegate operateIEnumerator = Operate_MeeleSkill;
		list.Add(new BaseBranchInfo(1001, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Operate_PushSkill;
		list.Add(new BaseBranchInfo(1002, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Operate_TiredSkill;
		list.Add(new BaseBranchInfo(1003, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Operate_FireSkill;
		list.Add(new BaseBranchInfo(1004, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Operate_FireBurst;
		list.Add(new BaseBranchInfo(1005, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Operate_FlySkill;
		list.Add(new BaseBranchInfo(1006, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Operate_FireBall;
		list.Add(new BaseBranchInfo(1007, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Operate_CriticalityDischarge;
		list.Add(new BaseBranchInfo(1008, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Operate_Fly;
		list.Add(new BaseBranchInfo(1009, default, default, default, null, operateIEnumerator));
		operateIEnumerator = Operate_ExitToughnessBroken;
		list.Add(new BaseBranchInfo(1010, default, default, default, null, operateIEnumerator));
		List<BaseBranchInfo> sequenceBranches = list;
		Dictionary<int, List<int>> sequenceDict = new Dictionary<int, List<int>>
		{
			[1] = new List<int> { 1001, 1002, 1001, 1003, 1004 },
			[2] = new List<int> { 1001, 1002, 1001 },
			[3] = new List<int> { 1005 },
			[4] = new List<int> { 1006, 1007, 1006, 1008 },
			[5] = new List<int> { 1001, 1001, 1009, 1006, 1008 },
			[6] = new List<int> { 1010 }
		};
		InitSequenceBranches(1, sequenceBranches, sequenceDict);
	}

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
		_lastMeeleSkillId = 0;
		_canTriggerBurst = false;
		_lastFireSkillId = 0;
		_lastFlySkillId = 0;
		_canTriggerTired = false;
		_triggerTriedTimes = 0;
	}

	protected override void OnActionStart()
	{
		base.OnActionStart();
		if (_actor.logicVariable.GetLogicTagToggle("ExitBurstByToughnessBroken"))
		{
			if (_actor.logicVariable.GetLogicTagToggle("IsFlyState"))
			{
				SwitchSequence(6);
				return;
			}
			_actor.logicVariable.ToggleLogicTag("ExitBurstByToughnessBroken", value: false);
			SwitchSequence(2);
		}
	}

	protected override void OnSequenceBranchOperateComplete(int curSeqIndex, int curBranchIndex, bool isSeqEnd)
	{
		base.OnSequenceBranchOperateComplete(curSeqIndex, curBranchIndex, isSeqEnd);
		switch (curSeqIndex)
		{
		case 1:
			if (isSeqEnd)
			{
				_lastMeeleSkillId = 0;
				if (!_canTriggerBurst)
				{
					_canTriggerBurst = true;
				}
			}
			if (_canTriggerBurst && _actor.logicVariable.GetLogicTagToggle("logicTag_CanTriggerBurst"))
			{
				SwitchSequence(3);
			}
			break;
		case 2:
			if (isSeqEnd)
			{
				SwitchSequence(3);
			}
			break;
		case 3:
			if (isSeqEnd)
			{
				_lastFlySkillId = 0;
				if (_actor.logicVariable.GetLogicTagToggle("IsFlyState"))
				{
					SwitchSequence(4);
				}
				else
				{
					SwitchSequence(5);
				}
			}
			break;
		case 4:
		case 5:
		case 6:
			if (isSeqEnd)
			{
				_lastMeeleSkillId = 0;
				SwitchSequence(1);
			}
			break;
		}
	}

	protected override void OnActionStop()
	{
		base.OnActionStop();
	}

	private IEnumerator Operate_MeeleSkill()
	{
		FP fP = CommonUtils_MonsterAPI.CalcAngleBetweenSelfAndAttackTarget(_actor);
		if (_lastMeeleSkillId != 3180102 && fP <= 90)
		{
			CastSkill(3180102);
			_lastMeeleSkillId = 3180102;
		}
		else if (_lastMeeleSkillId != 3180101 && fP <= 180)
		{
			CastSkill(3180101);
			_lastMeeleSkillId = 3180101;
		}
		else
		{
			CastSkill(3180103);
			_lastMeeleSkillId = 3180103;
		}
		yield return WaitSkillFinish();
	}

	private IEnumerator Operate_PushSkill()
	{
		CastSkill(3180104);
		yield return WaitSkillFinish();
	}

	private IEnumerator Operate_TiredSkill()
	{
		if (_canTriggerTired)
		{
			FP fP = ((_triggerTriedTimes > 0) ? (Config.defautRate_TriggerTiredSkill - Config.reduceRate_TriggerTiredSkill * _triggerTriedTimes) : Config.defautRate_TriggerTiredSkill);
			if (!(fP <= 0) && TSRandom.Range(0, 100) <= fP)
			{
				CastSkill(3180132);
				yield return WaitSkillFinish();
			}
		}
	}

	private IEnumerator Operate_FireSkill()
	{
		if (_lastFireSkillId == 0)
		{
			int num = ((TSRandom.Range(0, 2) == 0) ? 3180111 : 3180112);
			CastSkill(num);
			_lastFireSkillId = num;
		}
		else if (_lastFireSkillId == 3180111)
		{
			CastSkill(3180112);
			_lastFireSkillId = 3180112;
		}
		else
		{
			CastSkill(3180111);
			_lastFireSkillId = 3180111;
		}
		yield return WaitSkillFinish();
	}

	private IEnumerator Operate_FireBurst()
	{
		CastSkill(3180113);
		yield return WaitSkillFinish();
	}

	private IEnumerator Operate_FlySkill()
	{
		FP distanceWithTarget = CommonUtils_MonsterAPI.GetDistanceWithTarget(_actor, calcDistanceWithoutEntityRadius: true);
		if (_lastFlySkillId != 3180123 && distanceWithTarget >= 8)
		{
			CastSkill(3180123);
			_lastFlySkillId = 3180123;
		}
		else
		{
			CastSkill(3180122);
			_lastFlySkillId = 3180122;
		}
		yield return WaitSkillFinish();
	}

	private IEnumerator Operate_FireBall()
	{
		CastSkill(3180121);
		yield return WaitSkillFinish();
	}

	private IEnumerator Operate_CriticalityDischarge()
	{
		CastSkill(3180124);
		_canTriggerTired = true;
		yield return WaitSkillFinish();
	}

	private IEnumerator Operate_Fly()
	{
		CastSkill(3180131);
		yield return WaitSkillFinish();
	}

	private IEnumerator Operate_ExitToughnessBroken()
	{
		CastSkill(3180133);
		yield return WaitSkillFinish();
	}
}
