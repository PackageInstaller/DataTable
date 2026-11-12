using System;
using System.Collections;
using System.Collections.Generic;
using AIScript.Monster.Template;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Monster.TowerDefense;

public class TowerMonsterParalletBase : Parallel
{
	private enum FogState
	{
		Fog,
		Light,
		Leaving
	}

	private static int buff_AddWegith = 809001120;

	private static int buff_DelWegith = 809001110;

	private FogState _fogState;

	private FP _leaveStartTime;

	private CoroutineNode _corFogState;

	private bool _isDarkLevel;

	private Action<GridInfoData> _recGridInfoByPosCallback;

	private Action<List<GridInfoData>> _recItemGridInfosCallback;

	private bool _recIsDarkLevelResult;

	public override void OnStart()
	{
		base.OnStart();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_WEIGHT_CHANGED", OnWeightUpdate);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("TOWERDEFENSE_DIS_GET_GRID_INFO_BY_POS", Rec_GetGridInfoByPos);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("TOWERDEFENSE_DIS_IS_DARK_LEVEL", Rec_IsDarkLevel);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("TOWERDEFENSE_DIS_GET_ITEM_GRID_INFO", Rec_GetItemGridInfo);
		_isDarkLevel = QueryIsDarkLevel();
		if (_isDarkLevel)
		{
			_fogState = FogState.Fog;
			_actor.buffComponent.AddBuff(TowerDefenseConfig.buffId_BlackFog, _actor);
			StartCoroutine(ref _corFogState, FogStateLoop());
		}
	}

	public override void OnDisable()
	{
		base.OnDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_WEIGHT_CHANGED", OnWeightUpdate);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("TOWERDEFENSE_DIS_GET_GRID_INFO_BY_POS", Rec_GetGridInfoByPos);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("TOWERDEFENSE_DIS_IS_DARK_LEVEL", Rec_IsDarkLevel);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("TOWERDEFENSE_DIS_GET_ITEM_GRID_INFO", Rec_GetItemGridInfo);
		_recGridInfoByPosCallback = null;
		_recItemGridInfosCallback = null;
		StopCoroutine(ref _corFogState);
	}

	private void OnWeightUpdate(IEvent evt)
	{
		if (evt is AdventureActorWeightChangedEvent evt2)
		{
			OnWeightUpdate(evt2);
		}
	}

	public virtual void OnWeightUpdate(AdventureActorWeightChangedEvent evt)
	{
		if (evt.actorId != _actor.Id)
		{
			return;
		}
		if (evt.finalWeight > evt.originWeight)
		{
			if (!_actor.buffComponent.CheckBuffByBuffID(buff_AddWegith))
			{
				_actor.buffComponent.AddBuff(buff_AddWegith, _actor);
			}
			if (_actor.buffComponent.CheckBuffByBuffID(buff_DelWegith))
			{
				_actor.buffComponent.RemoveBuffByBuffId(buff_DelWegith);
			}
		}
		else if (evt.finalWeight < evt.originWeight)
		{
			if (!_actor.buffComponent.CheckBuffByBuffID(buff_DelWegith))
			{
				_actor.buffComponent.AddBuff(buff_DelWegith, _actor);
			}
			if (_actor.buffComponent.CheckBuffByBuffID(buff_AddWegith))
			{
				_actor.buffComponent.RemoveBuffByBuffId(buff_AddWegith);
			}
		}
		else
		{
			if (_actor.buffComponent.CheckBuffByBuffID(buff_AddWegith))
			{
				_actor.buffComponent.RemoveBuffByBuffId(buff_AddWegith);
			}
			if (_actor.buffComponent.CheckBuffByBuffID(buff_DelWegith))
			{
				_actor.buffComponent.RemoveBuffByBuffId(buff_DelWegith);
			}
		}
	}

	private IEnumerator FogStateLoop()
	{
		while (true)
		{
			bool flag = IsCurrentGridLit();
			switch (_fogState)
			{
			case FogState.Fog:
				if (flag)
				{
					EnterLight();
				}
				break;
			case FogState.Light:
				if (!flag)
				{
					EnterLeaving();
				}
				break;
			case FogState.Leaving:
				if (flag)
				{
					EnterLight();
				}
				else if (_actor.LogicTime - _leaveStartTime >= TowerDefenseConfig.reFogDelay)
				{
					EnterFog();
				}
				break;
			}
			yield return _actor.WaitTime(TowerDefenseConfig.fogStatePollInterval);
		}
	}

	private void EnterLight()
	{
		if (_actor.buffComponent.CheckBuffByBuffID(TowerDefenseConfig.buffId_BlackFog))
		{
			_actor.buffComponent.RemoveBuffByBuffId(TowerDefenseConfig.buffId_BlackFog);
		}
		_fogState = FogState.Light;
	}

	private void EnterLeaving()
	{
		_leaveStartTime = _actor.LogicTime;
		_fogState = FogState.Leaving;
	}

	private void EnterFog()
	{
		if (!_actor.buffComponent.CheckBuffByBuffID(TowerDefenseConfig.buffId_BlackFog))
		{
			_actor.buffComponent.AddBuff(TowerDefenseConfig.buffId_BlackFog, _actor);
		}
		_fogState = FogState.Fog;
	}

	private bool IsCurrentGridLit()
	{
		bool lit = false;
		Dispatch_GetGridInfoByPosition(_actor.tsTransform.Position, (GridInfoData grid) =>
		{
			lit = grid?.isLit ?? false;
		});
		return lit;
	}

	protected void Dispatch_GetGridInfoByPosition(TSVector2 position, Action<GridInfoData> callback)
	{
		_recGridInfoByPosCallback = callback;
		ModuleController<AdventureModuleController>.Instance.DispatchEventWithData("TOWERDEFENSE_REC_GET_GRID_INFO_BY_POS", _actor, position);
	}

	private void Rec_GetGridInfoByPos(IEvent iEvent)
	{
		GeneralEvent generalEvent = (GeneralEvent)iEvent;
		if (generalEvent.sender == _actor)
		{
			GridInfoData obj = generalEvent.data as GridInfoData;
			_recGridInfoByPosCallback?.Invoke(obj);
			_recGridInfoByPosCallback = null;
		}
	}

	private bool QueryIsDarkLevel()
	{
		_recIsDarkLevelResult = false;
		ModuleController<AdventureModuleController>.Instance.DispatchEventWithData("TOWERDEFENSE_REC_IS_DARK_LEVEL", _actor, null);
		return _recIsDarkLevelResult;
	}

	private void Rec_IsDarkLevel(IEvent iEvent)
	{
		GeneralEvent generalEvent = (GeneralEvent)iEvent;
		if (generalEvent.sender == _actor && generalEvent.data is bool recIsDarkLevelResult)
		{
			_recIsDarkLevelResult = recIsDarkLevelResult;
		}
	}

	public void Dispatch_GetItemGridInfo(Action<List<GridInfoData>> callback)
	{
		_recItemGridInfosCallback = callback;
		ModuleController<AdventureModuleController>.Instance.DispatchEventWithData("TOWERDEFENSE_REC_GET_ITEM_GRID_INFO", _actor, _actor.Id.ToString());
	}

	public void Rec_GetItemGridInfo(IEvent iEvent)
	{
		if (((GeneralEvent)iEvent).data is List<GridInfoData> obj)
		{
			_recItemGridInfosCallback?.Invoke(obj);
			_recItemGridInfosCallback = null;
		}
	}

	public void Dispatch_DarkenItemGrid(int itemGridIndex)
	{
		ModuleController<AdventureModuleController>.Instance.DispatchEventWithData("TOWERDEFENSE_REC_DARKEN_ITEM_GRID", _actor, itemGridIndex.ToString());
	}

	public void Dispatch_DarkenRoleGrid(int roleDataID)
	{
		ModuleController<AdventureModuleController>.Instance.DispatchEventWithData("TOWERDEFENSE_REC_DARKEN_ROLE_GRID", _actor, roleDataID.ToString());
	}
}
