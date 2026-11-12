using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._70061WuYu;

public class Action : MonsterActionBase
{
	private static readonly int testSkillId = 0;

	private static readonly int testPhase = 0;

	private static readonly FP testCastInterval = 0;

	private static readonly FP testPerfume = 0;

	private static readonly FP testPlayerPerfume = 0;

	private const int BranchId_FullTerrorSummon = 3;

	private const int BranchId_FullBroomRiding = 4;

	private const int BranchId_FullGiantGhost = 5;

	private const int BranchId_Stun = 6;

	private const int BranchId_SummonBoomGhost = 10;

	private const int BranchId_SummonBigHeadGhost = 11;

	private const int BranchId_SummonMagicGhost = 12;

	private const int BranchId_GhostArmy = 13;

	private const int BranchId_BroomShoot = 14;

	private const int BranchId_BroomRing = 15;

	private const int BranchId_PerfumeBoom = 16;

	private const int BranchId_BroomAttack = 17;

	private const int BranchId_BroomAttackP3 = 18;

	private const int BranchId_Wander = 21;

	private const int BranchId_Wait = 22;

	private const int BranchId_Decoy = 23;

	private const int Seq_1 = 1;

	private const int Seq_2 = 2;

	private const int Seq_3 = 3;

	private const int Seq_FullP1 = 4;

	private const int Seq_FullP2 = 5;

	private const int Seq_FullP3 = 6;

	private const int Seq_Stun = 7;

	private const int Seq_Decoy = 8;

	private const int Seq_Switch = 9;

	private FP _decoyCdExpireTime;

	private readonly Queue<(FP time, FP damage)> _recentDamageQueue = new Queue<(FP, FP)>();

	private FP _recentDamageAccum;

	private bool _pendingBroomRiding;

	private int _normalSeqBookmarkSeq = -1;

	private int _normalSeqBookmarkIndex;

	private CoroutineNode _dispelStunTimerCor;

	private CoroutineNode GotoCastSkill(int id)
	{
		if (testSkillId != 0)
		{
			id = testSkillId;
		}
		CastSkill(id);
		return StartCor(GotoCastSkillRoutine());
	}

	private IEnumerator GotoCastSkillRoutine()
	{
		yield return WaitSkillFinish();
		if (testCastInterval > 0)
		{
			yield return WaitTime(testCastInterval);
		}
	}

	private static bool IsNormalSeq(int seqIndex)
	{
		if (seqIndex != 1 && seqIndex != 2)
		{
			return seqIndex == 3;
		}
		return true;
	}

	private static bool IsFullSkillSeq(int seqIndex)
	{
		if (seqIndex != 4 && seqIndex != 5)
		{
			return seqIndex == 6;
		}
		return true;
	}

	private static int FullSkillSeq(int phase)
	{
		return phase switch
		{
			1 => 4, 
			2 => 5, 
			_ => 6, 
		};
	}

	protected override void SetConfig()
	{
		_thinkInterval = 0.1;
		_monsterAIType = MonsterAIType.SEQUENCE;
		List<BaseBranchInfo> list = new List<BaseBranchInfo>
		{
			new BaseBranchInfo(10, 20, 15, 5, null, SummonBoomGhostCast)
		};
		FP releaseDistance = 20;
		FP traceDuration = 5;
		OperateDelegate operateIEnumerator = SummonBigHeadGhostCast;
		list.Add(new BaseBranchInfo(11, releaseDistance, default, traceDuration, null, operateIEnumerator));
		traceDuration = 5;
		operateIEnumerator = SummonMagicGhostCast;
		list.Add(new BaseBranchInfo(12, default, default, traceDuration, null, operateIEnumerator));
		traceDuration = 15;
		FP traceDuration2 = 5;
		operateIEnumerator = GhostArmyCast;
		list.Add(new BaseBranchInfo(13, default, traceDuration, traceDuration2, null, operateIEnumerator));
		list.Add(new BaseBranchInfo(14, 15, 15, 5, null, BroomShootCast));
		list.Add(new BaseBranchInfo(15, 15, 15, 5, null, BroomRingCast));
		list.Add(new BaseBranchInfo(16, 15, 15, 5, null, PerfumeBoomCast));
		list.Add(new BaseBranchInfo(17, 5, 15, 5, null, BroomAttackCast));
		list.Add(new BaseBranchInfo(18, 15, 15, 5, null, BroomAttackCast));
		operateIEnumerator = FullTerrorSummonCast;
		list.Add(new BaseBranchInfo(3, default, default, default, null, operateIEnumerator));
		operateIEnumerator = FullBroomRidingCast;
		list.Add(new BaseBranchInfo(4, default, default, default, null, operateIEnumerator));
		operateIEnumerator = FullGiantGhostCast;
		list.Add(new BaseBranchInfo(5, default, default, default, null, operateIEnumerator));
		operateIEnumerator = StunCast;
		list.Add(new BaseBranchInfo(6, default, default, default, null, operateIEnumerator));
		operateIEnumerator = WanderCast;
		list.Add(new BaseBranchInfo(21, default, default, default, null, operateIEnumerator));
		operateIEnumerator = WaitCast;
		list.Add(new BaseBranchInfo(22, default, default, default, null, operateIEnumerator));
		operateIEnumerator = DecoyCast;
		list.Add(new BaseBranchInfo(23, default, default, default, null, operateIEnumerator));
		List<BaseBranchInfo> sequenceBranches = list;
		List<int> value = new List<int>
		{
			10, 21, 14, 15, 21, 11, 21, 16, 17, 21,
			12, 21, 14, 15, 21, 10, 21, 22, 16, 17,
			21, 11, 21, 14, 15, 21, 12, 21, 16, 17,
			21
		};
		Dictionary<int, List<int>> sequenceDict = new Dictionary<int, List<int>>
		{
			[1] = value,
			[2] = value,
			[3] = new List<int>
			{
				13, 21, 14, 21, 10, 21, 18, 21, 11, 21,
				15, 21, 12, 21, 16, 21
			},
			[4] = new List<int> { 3 },
			[5] = new List<int> { 3 },
			[6] = new List<int> { 5 },
			[7] = new List<int> { 6 },
			[8] = new List<int> { 23 },
			[9] = new List<int> { 4 }
		};
		InitSequenceBranches(1, sequenceBranches, sequenceDict);
	}

	protected override void SetListenEvents()
	{
		InitListenEvent(MonsterEventType.SelfReceiveDamage, active: true, OnReceiveDamageForDecoy);
		InitListenEvent(MonsterEventType.SelfToughnessBroken, active: true, OnToughnessBroken);
	}

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
		SetLogicTagToggleValue(_actor, "CanGetPerfume", value: true);
		SetLogicTagToggleValue(_actor, "CanUseBroomDodge", value: true);
		_decoyCdExpireTime = 0;
		_recentDamageQueue.Clear();
		_recentDamageAccum = 0;
		_pendingBroomRiding = false;
		_normalSeqBookmarkSeq = -1;
		_normalSeqBookmarkIndex = 0;
		if (_dispelStunTimerCor != null)
		{
			_actor.StopLogicCoroutine(_dispelStunTimerCor);
			_dispelStunTimerCor = null;
		}
		AddBuffToTarget(_actor, 700619100);
		SetLogicTagFpValue(_actor, "Phase", 1);
		if (testPhase >= 1 && testPhase <= 3)
		{
			SetLogicTagFpValue(_actor, "Phase", testPhase);
		}
		SetLogicTagFpValue(_actor, "FullSkillPhase", GetLogicTagFpValue(_actor, "Phase"));
		if (testPerfume > 0)
		{
			FP value = ((testPerfume > 100) ? ((FP)100) : testPerfume);
			SetLogicTagFpValue(_actor, "PerfumeValue", value);
			PerfumeHelper.FireBossPerfumeChange(_actor, value.AsInt(), 100, forceSend: true);
		}
		if (testPlayerPerfume > 0)
		{
			LogicEntity currentPlayer = GetCurrentPlayer();
			FP value2 = ((testPlayerPerfume > 100) ? ((FP)100) : testPlayerPerfume);
			SetLogicTagFpValue(currentPlayer, "PerfumeValue", value2);
			PerfumeHelper.FireMoWangPerfumeChange(currentPlayer, value2.AsInt(), 100, forceSend: true);
		}
	}

	protected override void OnActionStart()
	{
		base.OnActionStart();
		if (GetLogicTagFpValue(_actor, "DispelStunPending").AsInt() == 1 && CurrentSeqIndex != 7)
		{
			SetLogicTagFpValue(_actor, "DispelStunPending", 0);
			SwitchSequence(7);
			InterruptSkill();
		}
	}

	private void OnToughnessBroken(IEvent evt)
	{
		if (CurrentSeqIndex == 9)
		{
			int phase = GetLogicTagFpValue(_actor, "Phase").AsInt();
			SwitchToNormalSeq(phase);
		}
		else if (IsFullSkillSeq(CurrentSeqIndex))
		{
			int num = GetLogicTagFpValue(_actor, "Phase").AsInt();
			if (num < 1)
			{
				num = 1;
			}
			bool logicTagToggleValue = GetLogicTagToggleValue(_actor, "BossPerfumeFullTag");
			if (_pendingBroomRiding)
			{
				ResumePendingBroomRiding();
			}
			else if (logicTagToggleValue)
			{
				SwitchSequence(FullSkillSeq(num));
			}
			else
			{
				SwitchToNormalSeq(num);
			}
		}
	}

	private IEnumerator SummonBoomGhostCast()
	{
		yield return GotoCastSkill(7006110);
	}

	private IEnumerator SummonBigHeadGhostCast()
	{
		yield return GotoCastSkill(7006120);
	}

	private IEnumerator SummonMagicGhostCast()
	{
		yield return GotoCastSkill(7006130);
	}

	private IEnumerator GhostArmyCast()
	{
		yield return GotoCastSkill(7006190);
	}

	private IEnumerator BroomShootCast()
	{
		yield return GotoCastSkill(7006150);
	}

	private IEnumerator BroomRingCast()
	{
		yield return GotoCastSkill(7006160);
	}

	private IEnumerator PerfumeBoomCast()
	{
		yield return GotoCastSkill(7006170);
	}

	private IEnumerator BroomAttackCast()
	{
		yield return GotoCastSkill(7006180);
	}

	private IEnumerator WanderCast()
	{
		yield return GotoCastSkill(7006197);
	}

	private IEnumerator WaitCast()
	{
		yield return GotoCastSkill(9999999);
	}

	private IEnumerator DecoyCast()
	{
		yield return GotoCastSkill(7006192);
	}

	private void AdvancePhase()
	{
		int num = GetLogicTagFpValue(_actor, "Phase").AsInt();
		if (num < 3)
		{
			SetLogicTagFpValue(_actor, "Phase", num + 1);
		}
	}

	private IEnumerator FullTerrorSummonCast()
	{
		if (CurrentSeqIndex == 5)
		{
			_pendingBroomRiding = true;
		}
		SetLogicTagFpValue(_actor, "FullSkillPhase", GetLogicTagFpValue(_actor, "Phase"));
		if (CurrentSeqIndex == 4)
		{
			AdvancePhase();
		}
		SetLogicTagToggleValue(_actor, "BossPerfumeFullTag", value: false);
		yield return GotoCastSkill(7006140);
	}

	private IEnumerator FullBroomRidingCast()
	{
		_pendingBroomRiding = false;
		AdvancePhase();
		yield return GotoCastSkill(7006193);
	}

	private IEnumerator FullGiantGhostCast()
	{
		SetLogicTagToggleValue(_actor, "BossPerfumeFullTag", value: false);
		yield return GotoCastSkill(7006191);
	}

	protected override void OnSequenceBranchOperateComplete(int curSeqIndex, int curBranchIndex, bool isSeqEnd)
	{
		int num = GetLogicTagFpValue(_actor, "Phase").AsInt();
		if (num < 1)
		{
			num = 1;
		}
		bool logicTagToggleValue = GetLogicTagToggleValue(_actor, "BossPerfumeFullTag");
		if (IsNormalSeq(curSeqIndex))
		{
			_normalSeqBookmarkSeq = curSeqIndex;
			_normalSeqBookmarkIndex = curBranchIndex;
		}
		if (curSeqIndex != 8 && GetLogicTagToggleValue(_actor, "CastDecoyLogicTag"))
		{
			SetLogicTagToggleValue(_actor, "CastDecoyLogicTag", value: false);
			SwitchSequence(8);
		}
		else if ((curSeqIndex == 8) & isSeqEnd)
		{
			SwitchToNormalSeq(num);
		}
		else if (curSeqIndex != 7 && GetLogicTagFpValue(_actor, "DispelStunPending").AsInt() == 1)
		{
			SetLogicTagFpValue(_actor, "DispelStunPending", 0);
			SwitchSequence(7);
		}
		else if ((curSeqIndex == 7) & isSeqEnd)
		{
			if (_pendingBroomRiding)
			{
				ResumePendingBroomRiding();
			}
			else if (logicTagToggleValue)
			{
				SwitchSequence(FullSkillSeq(num));
			}
			else
			{
				SwitchToNormalSeq(num);
			}
		}
		else if (IsNormalSeq(curSeqIndex) && _pendingBroomRiding)
		{
			ResumePendingBroomRiding();
		}
		else if ((curSeqIndex == 9) & isSeqEnd)
		{
			SwitchToNormalSeq(num);
		}
		else if (IsNormalSeq(curSeqIndex) & logicTagToggleValue)
		{
			SwitchSequence(FullSkillSeq(num));
		}
		else if (IsFullSkillSeq(curSeqIndex) & isSeqEnd)
		{
			if (_pendingBroomRiding)
			{
				ResumePendingBroomRiding();
				return;
			}
			int phase = GetLogicTagFpValue(_actor, "Phase").AsInt();
			SwitchToNormalSeq(phase);
		}
	}

	private void SwitchToNormalSeq(int phase)
	{
		SwitchSequence(phase);
		if (_normalSeqBookmarkSeq == phase)
		{
			SetCurrentSequenceIndex(_normalSeqBookmarkIndex);
		}
		_normalSeqBookmarkSeq = -1;
	}

	private void ResumePendingBroomRiding()
	{
		SwitchSequence(9);
	}

	private IEnumerator StunCast()
	{
		if (_dispelStunTimerCor != null)
		{
			_actor.StopLogicCoroutine(_dispelStunTimerCor);
		}
		_dispelStunTimerCor = _actor.StartLogicCoroutine(DispelStunTimer());
		CastSkill(7006195);
		yield return WaitSkillFinish();
		yield return _dispelStunTimerCor;
		_dispelStunTimerCor = null;
	}

	private IEnumerator DispelStunTimer()
	{
		yield return WaitTime(Config.DispelStunTime);
		MonsterAdventureActor monsterAdventureActor = _actor as MonsterAdventureActor;
		if (monsterAdventureActor != null && monsterAdventureActor.monsterToughnessInfo.isToughnessBroken)
		{
			yield return WaitTime(Config.PerfumeDisableTime);
		}
		AddBuffToTarget(_actor, 700619100);
	}

	private void OnReceiveDamageForDecoy(IEvent iEvt)
	{
		if (!(iEvt is AdventureActorReceiveDamageEvent adventureActorReceiveDamageEvent) || adventureActorReceiveDamageEvent.to == null || adventureActorReceiveDamageEvent.to.Id != _actor.Id || GetBuffNum(_actor, 700619100) <= 0)
		{
			return;
		}
		MonsterAdventureActor monsterAdventureActor = _actor as MonsterAdventureActor;
		if ((monsterAdventureActor != null && monsterAdventureActor.monsterToughnessInfo.isToughnessBroken) || !GetLogicTagToggleValue(_actor, "CanUseBroomDodge"))
		{
			return;
		}
		FP logicTime = _actor.LogicTime;
		_recentDamageQueue.Enqueue((logicTime, (FP)adventureActorReceiveDamageEvent.damage));
		_recentDamageAccum += (FP)adventureActorReceiveDamageEvent.damage;
		while (_recentDamageQueue.Count > 0 && logicTime - _recentDamageQueue.Peek().Item1 >= Config.BroomDecoyDamageWindow)
		{
			_recentDamageAccum -= _recentDamageQueue.Dequeue().Item2;
		}
		long hpMax = _actor.actorHealthInfo.hpMax;
		if (hpMax > 0)
		{
			FP fP = hpMax * Config.BroomDecoyDamageThresholdPercent;
			if (!(_recentDamageAccum < fP) && !(logicTime < _decoyCdExpireTime))
			{
				_recentDamageQueue.Clear();
				_recentDamageAccum = 0;
				_decoyCdExpireTime = logicTime + Config.BroomDecoyCd;
				SetLogicTagToggleValue(_actor, "CastDecoyLogicTag", value: true);
				_actor.actorSkillManage.DestoryAllSkill();
			}
		}
	}
}
