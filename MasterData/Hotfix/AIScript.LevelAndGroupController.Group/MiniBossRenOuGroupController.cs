#define LOG_ERROR
using System.Collections;
using System.Collections.Generic;
using AIScript.Monster._73001KuiLeiShi;
using TrueSync;
using UnityEngine;

namespace AIScript.LevelAndGroupController.Group;

public class MiniBossRenOuGroupController : GroupControllerBase
{
	private readonly int ShiTiMonsterID = 1900703;

	private readonly int JuNuMonsterID = 1900706;

	private readonly int BiaoQiangMonsterID = 1900705;

	private readonly int MagicCircleID = 1900701;

	private const string Op_BattleStart = "BattleStart";

	private const string Op_FeiYueLianZhan = "FeiYueLianZhan";

	private const string Op_SiXianLianShe = "SiXianLianShe";

	private const string Op_QiangHuaJuNu = "QiangHua_JuNu";

	private const string Op_QiangHuaBiaoQiang = "QiangHua_BiaoQiang";

	private const string Op_XiShuaXianJing_BaoZha = "XiShuaXianJing_BaoZha";

	private const string Op_XiShuaXianJing_ChanRao = "XiShuaXianJing_ChanRao";

	private const string Op_PuTongSheJi = "PuTongSheJi";

	private const string Op_PuGongDanDuan = "PuGongDanDuan";

	private const string Op_FengKuangTouZhi = "FengKuangTouZhi";

	private const string Op_XiShuaSaoJi = "XiShuaSaoJi";

	private const string Op_ShiFangQiangHuaJi = "ShiFangQiangHuaJi";

	private const int HuanYinMonster_XuanFeng = 1900708;

	private const int HuanYinMonster_TiaoYue = 1900704;

	private const int HuanYinMonster_SiXian = 1900709;

	private const int HuanYinMonster_ChongFeng = 1900710;

	private const string Op_QuanTiQiangHua = "QuanTiQiangHua";

	private const string Op_ZhongYan = "ZhongYan";

	private const string Msg_BeEnhanced = "BeEnhanced";

	private const string Msg_FaZhenActivated = "FaZhenActivated";

	private LogicEntity ShiTi;

	private LogicEntity JuNu;

	private LogicEntity BiaoQiang;

	private bool _shiTiAlive = true;

	private bool _juNuAlive = true;

	private bool _biaoQiangAlive = true;

	private bool _xianJingToggle = true;

	private const bool DEBUG_OnlyQiangHuaJuNu = false;

	private PoolGroupBranchInfo _branchFeiYueLianZhan;

	private PoolGroupBranchInfo _branchSiXianLianShe;

	private PoolGroupBranchInfo _branchFengKuangTouZhi;

	private static readonly FP BiaoQiangTouZhiCD_Normal = 20;

	private static readonly FP BiaoQiangTouZhiCD_Enhanced = 10;

	private const int BiaoQiangQiangHuaBuffId = 720140110;

	private CoroutineNode _huanYinTimelineNode;

	private int _activatedTriggerCount;

	private bool _enraged;

	protected override void OnStart()
	{
		base.OnStart();
		EenterPause();
		StartCor(WaitForResidentMonstersAndBattleStart());
	}

	private IEnumerator WaitForResidentMonstersAndBattleStart()
	{
		while (GetTargetsByDataId(ShiTiMonsterID).Count < 1)
		{
			yield return null;
		}
		ShiTi = GetTargetsByDataId(ShiTiMonsterID).get_Item(0);
		_shiTiAlive = true;
		while (GetTargetsByDataId(JuNuMonsterID).Count < 1)
		{
			yield return null;
		}
		JuNu = GetTargetsByDataId(JuNuMonsterID).get_Item(0);
		_juNuAlive = true;
		while (GetTargetsByDataId(BiaoQiangMonsterID).Count < 1)
		{
			yield return null;
		}
		BiaoQiang = GetTargetsByDataId(BiaoQiangMonsterID).get_Item(0);
		_biaoQiangAlive = true;
		while (!IsAnyResidentInAction())
		{
			yield return null;
		}
		ExitPause();
		if (ShiTi != null)
		{
			SendMessageToMonster(ShiTi.Id, "BattleStart");
		}
		if (JuNu != null)
		{
			SendMessageToMonster(JuNu.Id, "BattleStart");
		}
		if (BiaoQiang != null)
		{
			SendMessageToMonster(BiaoQiang.Id, "BattleStart");
		}
		StartCor(FixedTimeline());
		_huanYinTimelineNode = StartCor(HuanYinTimeline());
	}

	private bool IsAnyResidentInAction()
	{
		AdventureActor obj = ShiTi as AdventureActor;
		if ((object)obj == null || obj.state != ActorState.Action)
		{
			AdventureActor obj2 = JuNu as AdventureActor;
			if ((object)obj2 == null || obj2.state != ActorState.Action)
			{
				AdventureActor obj3 = BiaoQiang as AdventureActor;
				if ((object)obj3 == null)
				{
					return false;
				}
				return obj3.state == ActorState.Action;
			}
		}
		return true;
	}

	protected override IEnumerator CheckQualifiedPoolBranch()
	{
		if (_delayStartTime > 0)
		{
			while (_delayStartTime > 0)
			{
				_delayStartTime -= LockStepManager.deltaTime;
				yield return null;
			}
		}
		while (true)
		{
			if (pause)
			{
				yield return null;
				continue;
			}
			while (_branchRunning)
			{
				yield return null;
			}
			PoolGroupBranchInfo poolGroupBranchInfo = CheckQualifiedPoolBranchInfo();
			if (poolGroupBranchInfo != null && poolGroupBranchInfo != _executeGroupBranch && ((_executeGroupBranch != null && poolGroupBranchInfo.priority > (_executeGroupBranch as PoolGroupBranchInfo).priority) || _executeGroupBranch == null))
			{
				_executeGroupBranch = poolGroupBranchInfo;
				StartWaitingOperateCoroutine(poolGroupBranchInfo);
			}
			FP thinkInterval = _thinkInterval;
			while (thinkInterval > 0)
			{
				thinkInterval -= LockStepManager.deltaTime;
				yield return null;
			}
		}
	}

	protected override void OnStop()
	{
		base.OnStop();
		_huanYinTimelineNode = null;
	}

	private LogicEntity GetMonster(int dataId, string monsterName)
	{
		List<LogicEntity> targetsByDataId = GetTargetsByDataId(dataId);
		if (targetsByDataId == null || targetsByDataId.Count == 0)
		{
			return null;
		}
		return targetsByDataId.get_Item(0);
	}

	protected override void SetConfig()
	{
		GroupAIType = GroupAIType.POOL;
		_branchFeiYueLianZhan = new PoolGroupBranchInfo(2001, 3, 30, 24, active: true, CanFeiYueLianZhan, DoFeiYueLianZhan);
		_branchSiXianLianShe = new PoolGroupBranchInfo(2002, 3, 30, 33, active: true, CanSiXianLianShe, DoSiXianLianShe);
		_branchFengKuangTouZhi = new PoolGroupBranchInfo(3005, 1, 20, 12, active: true, CanFengKuangTouZhi, () => DoSingleSkill(BiaoQiang, "FengKuangTouZhi"));
		List<PoolGroupBranchesInfo> poolBranches = new List<PoolGroupBranchesInfo>
		{
			new PoolGroupBranchesInfo
			{
				index = 1,
				braches = new List<PoolGroupBranchInfo>
				{
					_branchFeiYueLianZhan,
					_branchSiXianLianShe,
					new PoolGroupBranchInfo(2003, 3, 35, 26, active: true, CanQiangHuaJuNu, DoQiangHuaJuNu),
					new PoolGroupBranchInfo(2004, 2, 30, 20, active: true, CanQiangHuaBiaoQiang, DoQiangHuaBiaoQiang),
					new PoolGroupBranchInfo(3001, 1, 12, 3, active: true, () => _juNuAlive && PlayerInRange(JuNu, 8), DoXiShuaXianJing),
					new PoolGroupBranchInfo(3004, 1, 5, 0, active: true, () => _biaoQiangAlive && PlayerInRange(BiaoQiang, 3), () => DoSingleSkill(BiaoQiang, "PuGongDanDuan")),
					_branchFengKuangTouZhi,
					new PoolGroupBranchInfo(3006, 1, 12, 7, active: true, () => _biaoQiangAlive && PlayerInRange(BiaoQiang, 6), () => DoSingleSkill(BiaoQiang, "XiShuaSaoJi"))
				}
			}
		};
		InitPoolBranches(1, poolBranches);
	}

	protected override void SetListenEvents()
	{
		InitListenEvent(GroupEventType.ReceiveMonsterOperation, active: true, OnMonsterMessage);
		InitListenEvent(GroupEventType.MonsterDie, true, OnMonsterDie, ShiTiMonsterID, JuNuMonsterID, BiaoQiangMonsterID);
	}

	private IEnumerator FixedTimeline()
	{
		yield return WaitTime(90);
		OnBattleSettle();
	}

	private void OnBattleSettle()
	{
		Debug.Log(GetType().Name + " 到达90s结算节点（超时/团灭结算）");
	}

	private IEnumerator HuanYinTimeline()
	{
		yield return WaitTime(8);
		yield return StartCor(SummonHuanYinAttack(1900708, 6, 5));
		yield return WaitTime(15);
		yield return StartCor(SummonHuanYinAttack(1900710, 12, 10));
		yield return WaitTime(15);
		yield return StartCor(SummonHuanYinAttack(1900708, 6, 5));
		yield return WaitTime(15);
		yield return StartCor(SummonHuanYinAttack(1900710, 12, 10));
		yield return WaitTime(15);
		yield return StartCor(SummonHuanYinAttack(1900708, 6, 5));
		yield return WaitTime(15);
		yield return StartCor(SummonHuanYinAttack(1900710, 12, 10));
	}

	private IEnumerator SummonHuanYinAttack(int huanYinMonsterId, FP offsetRadius, FP innerRadius)
	{
		LogicEntity logicEntity;
		if (_biaoQiangAlive)
		{
			logicEntity = BiaoQiang;
		}
		else if (_juNuAlive)
		{
			logicEntity = JuNu;
		}
		else
		{
			logicEntity = (_shiTiAlive ? ShiTi : null);
		}
		AdventureActor summoner = logicEntity as AdventureActor;
		if (summoner == null)
		{
			NovaLogger.Error(GetType().Name + " 召唤幻影失败：无可用召唤锚点（三只常驻人偶均死亡）");
			yield break;
		}
		LogicEntity currentPlayer = GetCurrentPlayer();
		if (currentPlayer == null)
		{
			yield break;
		}
		TSVector2 entityPosition = GetEntityPosition(logicEntity, currentPlayer);
		TSVector2 tSVector = entityPosition;
		if (offsetRadius > 0)
		{
			DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Circle, entityPosition, default, default, offsetRadius, innerRadius);
			tSVector = GetShapeRandomPoint(shapeData, logicEntity, isReachable: true);
		}
		SetLogicTagFpValue(summoner, Common_73001.PuppetSeqCounter_Tag, 0);
		TSVector2 spawnDirection = entityPosition - tSVector;
		if (spawnDirection.LengthSquared() > 0)
		{
			spawnDirection.Normalize();
		}
		SummonMonster(summoner, huanYinMonsterId, tSVector, spawnDirection);
		int timeoutFrames = 0;
		yield return WaitUntil(() =>
		{
			List<LogicEntity> targetsByDataId = GetTargetsByDataId(huanYinMonsterId);
			if (targetsByDataId == null || targetsByDataId.Count == 0)
			{
				return ++timeoutFrames > 300;
			}
			return targetsByDataId.TrueForAll((LogicEntity x) =>
			{
				MonsterAdventureActor monsterAdventureActor = x as MonsterAdventureActor;
				return monsterAdventureActor == null || monsterAdventureActor.state == ActorState.Action;
			}) || ++timeoutFrames > 300;
		});
		DispatchPuppetSyncAttack(summoner);
	}

	private void DispatchPuppetSyncAttack(AdventureActor summoner)
	{
		AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
		adventureActorCustomEvent.sender = summoner;
		adventureActorCustomEvent.actor = summoner;
		adventureActorCustomEvent.eventHashCode = Common_73001.evt_PuppetSyncAttack;
		summoner.DispatchEvent(adventureActorCustomEvent);
	}

	private bool CanFeiYueLianZhan()
	{
		if (_biaoQiangAlive)
		{
			return PlayerInRange(BiaoQiang, 6);
		}
		return false;
	}

	private IEnumerator DoFeiYueLianZhan()
	{
		SendMessageToMonster(BiaoQiang.Id, "FeiYueLianZhan");
		yield return WaitTime(4);
	}

	private bool CanSiXianLianShe()
	{
		return _juNuAlive;
	}

	private IEnumerator DoSiXianLianShe()
	{
		SendMessageToMonster(JuNu.Id, "SiXianLianShe");
		yield return WaitTime(5);
	}

	private bool CanQiangHuaJuNu()
	{
		if (_shiTiAlive)
		{
			return _juNuAlive;
		}
		return false;
	}

	private IEnumerator DoQiangHuaJuNu()
	{
		SendMessageToMonster(ShiTi.Id, "QiangHua_JuNu");
		yield break;
	}

	private bool CanQiangHuaBiaoQiang()
	{
		if (_shiTiAlive)
		{
			return _biaoQiangAlive;
		}
		return false;
	}

	private IEnumerator DoQiangHuaBiaoQiang()
	{
		SendMessageToMonster(ShiTi.Id, "QiangHua_BiaoQiang");
		yield break;
	}

	private IEnumerator DoXiShuaXianJing()
	{
		if (!(JuNu == null))
		{
			if (_xianJingToggle)
			{
				SendMessageToMonster(JuNu.Id, "XiShuaXianJing_BaoZha");
			}
			else
			{
				SendMessageToMonster(JuNu.Id, "XiShuaXianJing_ChanRao");
			}
			_xianJingToggle = !_xianJingToggle;
		}
		yield break;
	}

	private bool CanFengKuangTouZhi()
	{
		if (!_biaoQiangAlive)
		{
			return false;
		}
		FP fP = PlayerDistanceTo(BiaoQiang);
		if (fP >= 0 && fP <= 12)
		{
			return fP > 6;
		}
		return false;
	}

	private IEnumerator DoSingleSkill(LogicEntity monster, string operation)
	{
		if (monster != null)
		{
			SendMessageToMonster(monster.Id, operation);
		}
		yield break;
	}

	private void OnMonsterMessage(IEvent evt)
	{
		if (!(evt is AdventureMonsterToGroupControllerMessage { operationType: var operationType }))
		{
			return;
		}
		if (!(operationType == "BeEnhanced"))
		{
			if (operationType == "FaZhenActivated")
			{
				OnTriggerActivated();
			}
		}
		else if (_biaoQiangAlive && BiaoQiang != null)
		{
			SendMessageToMonster(BiaoQiang.Id, "ShiFangQiangHuaJi");
			if (_branchFengKuangTouZhi != null)
			{
				_branchFengKuangTouZhi.cd = BiaoQiangTouZhiCD_Enhanced;
			}
			StartCor(WaitBiaoQiangBuffEnd());
		}
	}

	private IEnumerator WaitBiaoQiangBuffEnd()
	{
		while (_biaoQiangAlive && BiaoQiang != null && GetBuffNum(BiaoQiang, 720140110) > 0)
		{
			yield return WaitTime(0.5f);
		}
		if (_branchFengKuangTouZhi != null)
		{
			_branchFengKuangTouZhi.cd = BiaoQiangTouZhiCD_Normal;
		}
	}

	private void OnMonsterDie(IEvent evt)
	{
		if (evt is AdventureMonsterDiedEvent { monsterID: var monsterID })
		{
			if (monsterID == BiaoQiangMonsterID)
			{
				_biaoQiangAlive = false;
				SetPoolBranchActive(2001, active: false);
				SetPoolBranchActive(2004, active: false);
			}
			else if (monsterID == JuNuMonsterID)
			{
				_juNuAlive = false;
				SetPoolBranchActive(2002, active: false);
				SetPoolBranchActive(2003, active: false);
			}
			else if (monsterID == ShiTiMonsterID)
			{
				_shiTiAlive = false;
				SetPoolBranchActive(2003, active: false);
				SetPoolBranchActive(2004, active: false);
			}
		}
	}

	private void OnTriggerActivated()
	{
		_activatedTriggerCount++;
		if (_activatedTriggerCount == 1)
		{
			_enraged = true;
			_branchFeiYueLianZhan.cd = 22;
			_branchSiXianLianShe.cd = 22;
			if (_shiTiAlive && ShiTi != null)
			{
				SendMessageToMonster(ShiTi.Id, "QuanTiQiangHua");
			}
		}
		else if (_activatedTriggerCount == 2)
		{
			ClearHuanYin();
			ZhongYan();
		}
	}

	private void ClearHuanYin()
	{
		StopCor(_huanYinTimelineNode);
		_huanYinTimelineNode = null;
		SetPoolBranchActive(2001, active: false);
		SetPoolBranchActive(2002, active: false);
		if (_branchFeiYueLianZhan != null)
		{
			_branchFeiYueLianZhan.active = false;
		}
		if (_branchSiXianLianShe != null)
		{
			_branchSiXianLianShe.active = false;
		}
	}

	private void ZhongYan()
	{
		List<LogicEntity> targetByDataIDs = GetTargetByDataIDs(new List<int> { 1900704, 1900708, 1900709, 1900710 });
		KillActors(targetByDataIDs);
		AdventureActor adventureActor = (_shiTiAlive ? ShiTi : (_juNuAlive ? JuNu : (_biaoQiangAlive ? BiaoQiang : null))) as AdventureActor;
		if (adventureActor != null)
		{
			foreach (LogicEntity item in GetTargetByBuffID(317010030))
			{
				AddBuffToTarget(adventureActor, item, 317010020);
			}
		}
		foreach (LogicEntity targetByDataID in GetTargetByDataIDs(new List<int> { MagicCircleID }))
		{
			SendMessageToMonster(targetByDataID.Id, "ZhongYan");
		}
	}

	private bool PlayerInRange(LogicEntity monster, FP range)
	{
		FP fP = PlayerDistanceTo(monster);
		if (fP >= 0)
		{
			return fP <= range;
		}
		return false;
	}

	private FP PlayerDistanceTo(LogicEntity monster)
	{
		if (monster == null)
		{
			return -1;
		}
		LogicEntity currentPlayer = GetCurrentPlayer();
		if (currentPlayer == null)
		{
			return -1;
		}
		TSVector2 entityPosition = GetEntityPosition(monster, monster);
		TSVector2 entityPosition2 = GetEntityPosition(monster, currentPlayer);
		return Distance(entityPosition, entityPosition2);
	}
}
