using System;
using System.Collections;
using System.Collections.Generic;
using AIScript.DynamicLevel;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Monster.TowerDefense;

public class TowerMonsterBaseAI : MonsterActionBase
{
	private int curActionIndex;

	private string curActionParam;

	private int curGridId;

	private bool isBegin;

	private int routeId;

	private TowerMonsterInfo towerMonsterInfo;

	private CoroutineNode corPatrol;

	private CoroutineNode corStartAction;

	private CoroutineNode corAction;

	private CoroutineNode corRouteAction;

	private bool isPause;

	private TSVector2 nextPoint;

	private bool isInAction;

	private Action<MonsterRecGridInfo> recGridInfoCallback;

	private Action<MonsterRecGridInfo> recNextNGridInfoCallback;

	private Action<List<GridInfoData>> recGridInfosCallback;

	private Action<GridInfoData> recGridInfoByPosCallback;

	private Action<List<GridInfoData>> recItemGridInfosCallback;

	private bool stopCor;

	private bool doNotResume;

	protected void Dispatch_GetNextGridInfo(Action<MonsterRecGridInfo> callback)
	{
		recGridInfoCallback = callback;
		ModuleController<AdventureModuleController>.Instance.DispatchEventWithData("TOWERDEFENSE_REC_GET_NEXT_GRID_INFO", _actor, _actor.Id.ToString());
	}

	private void Rec_GetNextGridInfo(IEvent iEvent)
	{
		MonsterRecGridInfo monsterRecGridInfo = (MonsterRecGridInfo)((GeneralEvent)iEvent).data;
		if (monsterRecGridInfo != null && monsterRecGridInfo.monsterID == _actor.Id)
		{
			recGridInfoCallback?.Invoke(monsterRecGridInfo);
			recGridInfoCallback = null;
		}
	}

	protected void Dispatch_GetNextNGridInfo(int step, Action<MonsterRecGridInfo> callback)
	{
		recNextNGridInfoCallback = callback;
		ModuleController<AdventureModuleController>.Instance.DispatchEventWithData("TOWERDEFENSE_REC_GET_NEXT_N_GRID_INFO", _actor, new NextGridQueryParam(_actor.Id, step));
	}

	private void Rec_GetNextNGridInfo(IEvent iEvent)
	{
		MonsterRecGridInfo monsterRecGridInfo = (MonsterRecGridInfo)((GeneralEvent)iEvent).data;
		if (monsterRecGridInfo != null && monsterRecGridInfo.monsterID == _actor.Id)
		{
			recNextNGridInfoCallback?.Invoke(monsterRecGridInfo);
			recNextNGridInfoCallback = null;
		}
	}

	protected void Dispatch_CreateGrass(int gridIndex)
	{
		ModuleController<AdventureModuleController>.Instance.DispatchEventWithData("TOWERDEFENSE_REC_CREATE_GRASS", _actor, gridIndex.ToString());
	}

	protected void Dispatch_ClearGrass(int gridIndex)
	{
		ModuleController<AdventureModuleController>.Instance.DispatchEventWithData("TOWERDEFENSE_REC_CLEAR_GRASS", _actor, gridIndex.ToString());
	}

	protected void Dispatch_GetGridsInfoInCircle(TSVector2 center, FP range, bool preferNonFlame, Action<List<GridInfoData>> callback)
	{
		recGridInfosCallback = callback;
		GridQueryParam data = new GridQueryParam(center, range, preferNonFlame);
		ModuleController<AdventureModuleController>.Instance.DispatchEventWithData("TOWERDEFENSE_REC_GET_GRID_INFO_IN_CIRCLE", _actor, data);
	}

	private void Rec_GetGridInfoInCircle(IEvent iEvent)
	{
		List<GridInfoData> list = (List<GridInfoData>)((GeneralEvent)iEvent).data;
		if (list != null)
		{
			recGridInfosCallback?.Invoke(list);
			recGridInfoCallback = null;
		}
	}

	protected void Dispatch_CreateFire(int gridIndex)
	{
		ModuleController<AdventureModuleController>.Instance.DispatchEventWithData("TOWERDEFENSE_REC_CREATE_FIRE", _actor, gridIndex.ToString());
	}

	protected void Dispatch_GetGridInfoByPosition(TSVector2 position, Action<GridInfoData> callback)
	{
		recGridInfoByPosCallback = callback;
		ModuleController<AdventureModuleController>.Instance.DispatchEventWithData("TOWERDEFENSE_REC_GET_GRID_INFO_BY_POS", _actor, position);
	}

	private void Rec_GetGridInfoByPos(IEvent iEvent)
	{
		GridInfoData obj = ((GeneralEvent)iEvent).data as GridInfoData;
		recGridInfoByPosCallback?.Invoke(obj);
		recGridInfoByPosCallback = null;
	}

	protected void Dispatch_DarkenItemGrid(int itemGridIndex)
	{
		ModuleController<AdventureModuleController>.Instance.DispatchEventWithData("TOWERDEFENSE_REC_DARKEN_ITEM_GRID", _actor, itemGridIndex.ToString());
	}

	protected void Dispatch_DarkenRoleGrid(int roleDataID)
	{
		ModuleController<AdventureModuleController>.Instance.DispatchEventWithData("TOWERDEFENSE_REC_DARKEN_ROLE_GRID", _actor, roleDataID.ToString());
	}

	protected void Dispatch_GetItemGridInfo(Action<List<GridInfoData>> callback)
	{
		recItemGridInfosCallback = callback;
		ModuleController<AdventureModuleController>.Instance.DispatchEventWithData("TOWERDEFENSE_REC_GET_ITEM_GRID_INFO", _actor, _actor.Id.ToString());
	}

	private void Rec_GetItemGridInfo(IEvent iEvent)
	{
		List<GridInfoData> list = (List<GridInfoData>)((GeneralEvent)iEvent).data;
		if (list != null)
		{
			recItemGridInfosCallback?.Invoke(list);
			recItemGridInfosCallback = null;
		}
	}

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("TOWERDEFENSE_PAUSE_MONSTER_MOVE_EVT", OnPauseMove);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("TOWERDEFENSE_MONSTER_ACTION_EVT", OnTowerSimulate);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("TOWERDEFENSE_DIS_GET_NEXT_GRID_INFO", Rec_GetNextGridInfo);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("TOWERDEFENSE_DIS_GET_NEXT_N_GRID_INFO", Rec_GetNextNGridInfo);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("TOWERDEFENSE_DIS_GET_GRID_INFO_IN_CIRCLE", Rec_GetGridInfoInCircle);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("TOWERDEFENSE_DIS_GET_GRID_INFO_BY_POS", Rec_GetGridInfoByPos);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("TOWERDEFENSE_DIS_GET_ITEM_GRID_INFO", Rec_GetItemGridInfo);
		isInAction = false;
		isBegin = false;
		isPause = false;
		doNotResume = false;
		towerMonsterInfo = _actor.AddOrGetLogicComponent<TowerMonsterInfo>();
		_actor.EnableDefense();
	}

	protected override void OnActionDisable()
	{
		base.OnActionDisable();
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("TOWERDEFENSE_PAUSE_MONSTER_MOVE_EVT", OnPauseMove);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("TOWERDEFENSE_MONSTER_ACTION_EVT", OnTowerSimulate);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("TOWERDEFENSE_DIS_GET_NEXT_GRID_INFO", Rec_GetNextGridInfo);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("TOWERDEFENSE_DIS_GET_NEXT_N_GRID_INFO", Rec_GetNextNGridInfo);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("TOWERDEFENSE_DIS_GET_GRID_INFO_IN_CIRCLE", Rec_GetGridInfoInCircle);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("TOWERDEFENSE_DIS_GET_GRID_INFO_BY_POS", Rec_GetGridInfoByPos);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("TOWERDEFENSE_DIS_GET_ITEM_GRID_INFO", Rec_GetItemGridInfo);
		StopCoroutine(ref corPatrol);
		StopCoroutine(ref corStartAction);
		StopCoroutine(ref corAction);
		StopCoroutine(ref corRouteAction);
		isBegin = false;
	}

	protected override void OnActionStart()
	{
		if (!isBegin)
		{
			isBegin = true;
			TSVector2 logicTagTSVector2Value = _actor.logicVariable.GetLogicTagTSVector2Value("nextPoint");
			int actionIndex = _actor.logicVariable.GetLogicTagValue("actionIndex").AsInt();
			string logicTagStringValue = _actor.logicVariable.GetLogicTagStringValue("actionParam");
			int gridId = _actor.logicVariable.GetLogicTagValue("nextGridIndex").AsInt();
			int num = _actor.logicVariable.GetLogicTagValue("routeID").AsInt();
			int leftRouteLen = _actor.logicVariable.GetLogicTagValue("leftRouteLen").AsInt();
			BeginNextPoint(logicTagTSVector2Value, actionIndex, logicTagStringValue, gridId, num, leftRouteLen);
		}
		if (isPause)
		{
			ResumeMove();
		}
	}

	protected override void OnActionStop()
	{
		if (!isPause)
		{
			PauseMove();
		}
	}

	protected override void SetConfig()
	{
		_monsterAIType = MonsterAIType.POOL;
		_thinkInterval = 0.05;
		List<PoolBranchesInfo> poolBranches = new List<PoolBranchesInfo>
		{
			new PoolBranchesInfo
			{
				index = 1,
				braches = new List<PoolBranchInfo>()
			}
		};
		InitPoolBranches(1, poolBranches);
	}

	protected override IEnumerator CheckQualifiedPoolBranch()
	{
		while (true)
		{
			if (!isBegin)
			{
				yield return null;
			}
			while (_branchRunning)
			{
				LogicVariable logicVariable = _actor.logicVariable;
				if (logicVariable == null || logicVariable.GetLogicTagToggle("ExecutingCanBreakBranch"))
				{
					break;
				}
				yield return null;
			}
			PoolBranchInfo poolBranchInfo = CheckQualifiedPoolBranchInfo();
			if (poolBranchInfo != null && poolBranchInfo != _executeBranch && ((_executeBranch != null && poolBranchInfo.priority > (_executeBranch as PoolBranchInfo).priority) || _executeBranch == null))
			{
				_executeBranch = poolBranchInfo;
				StartWaitingOperateCoroutine(poolBranchInfo);
			}
			yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(_thinkInterval), runImmediately: true);
		}
	}

	private void OnTowerSimulate(IEvent evt)
	{
		if (evt is TowerDefenseMonsterActionEvent towerDefenseMonsterActionEvent && towerDefenseMonsterActionEvent.monsterID == _actor.Id)
		{
			BeginNextPoint(towerDefenseMonsterActionEvent.nextPoint, towerDefenseMonsterActionEvent.actionIndex, towerDefenseMonsterActionEvent.actionParam, towerDefenseMonsterActionEvent.nextGridIndex, towerDefenseMonsterActionEvent.routeID, towerDefenseMonsterActionEvent.leftRouteLen);
		}
	}

	private void OnPauseMove(IEvent evt)
	{
		if (evt is TowerDefensePauseMonsterMoveEvent towerDefensePauseMonsterMoveEvent && towerDefensePauseMonsterMoveEvent.monsterID == _actor.Id)
		{
			PauseMove();
			doNotResume = true;
		}
	}

	private void BeginNextPoint(TSVector2 nextPoint, int actionIndex, string actionParam, int gridId, int routeId, int leftRouteLen)
	{
		if (gridId != -1 && !doNotResume && !isPause)
		{
			curActionIndex = actionIndex;
			curActionParam = actionParam;
			this.nextPoint = nextPoint;
			curGridId = gridId;
			this.routeId = routeId;
			towerMonsterInfo.leftRouteLen = leftRouteLen;
			StartCoroutine(ref corPatrol, DoPatrol());
		}
	}

	private IEnumerator DoPatrol()
	{
		if (doNotResume)
		{
			yield return null;
		}
		TSVector2 targetPos = nextPoint;
		while (true)
		{
			FP fP = _actor.actorInfo.runSpeed * _actor.LogicDeltaTime;
			if (!(TSVector2.Distance(targetPos, _actor.tsTransform.Position) > fP))
			{
				break;
			}
			_actor.MoveTo(targetPos, fP, enableNavigation: false, AdventureActor.MovementMode.Run, null, randomMove: false, forceMove: false, default, null, stayWhenReachTarget: true, stopDisIgnoreRadius: true);
			yield return null;
		}
		if (HasLocalAction(curGridId) || HasGlobalAction(curActionIndex))
		{
			_actor.StandBy();
			if (!isInAction)
			{
				StartCoroutine(ref corStartAction, StartAction());
			}
		}
		else
		{
			EndPoint();
		}
	}

	protected void PauseMove()
	{
		isPause = true;
		StopCoroutine(ref corPatrol);
		_actor.StandBy();
	}

	protected void ResumeMove()
	{
		if (!doNotResume)
		{
			isPause = false;
			if (!isInAction)
			{
				StartCoroutine(ref corPatrol, DoPatrol());
			}
		}
	}

	public virtual bool HasLocalAction(int gridId)
	{
		return false;
	}

	public bool HasGlobalAction(int actionIndex)
	{
		if (actionIndex == 1)
		{
			return true;
		}
		return false;
	}

	private IEnumerator StartAction()
	{
		isInAction = true;
		StartCoroutine(ref corAction, DoAction(curGridId));
		yield return corAction;
		StartCoroutine(ref corRouteAction, DoRouteAction(curActionIndex, curActionParam));
		yield return corRouteAction;
		isInAction = false;
		EndPoint();
	}

	protected virtual IEnumerator DoAction(int gridIndex)
	{
		yield break;
	}

	protected IEnumerator DoRouteAction(int actionIndex, string actionParam)
	{
		if (actionIndex == 1)
		{
			_actor.StandBy();
			FP seconds = CommonUtils.ParseStringParamToFP(actionParam);
			yield return _actor.WaitTime(seconds);
		}
	}

	private void EndPoint()
	{
		TowerDefenseMonsterActionCallbackEvent towerDefenseMonsterActionCallbackEvent = TowerDefenseMonsterActionCallbackEvent.Generate();
		towerDefenseMonsterActionCallbackEvent.monsterID = _actor.Id;
		towerDefenseMonsterActionCallbackEvent.sender = _actor;
		towerDefenseMonsterActionCallbackEvent.gridIndex = curGridId;
		towerDefenseMonsterActionCallbackEvent.routeID = routeId;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(towerDefenseMonsterActionCallbackEvent);
	}
}
