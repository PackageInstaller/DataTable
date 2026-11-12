using System;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster.TowerDefense;

public class TowerMonsterSkillBase : SkillSimpleBase
{
	private Action<MonsterRecGridInfo> recGridInfoCallback;

	private Action<MonsterRecGridInfo> recNextNGridInfoCallback;

	private Action<List<GridInfoData>> recGridInfosCallback;

	private Action<GridInfoData> recGridInfoByPosCallback;

	private Action<List<GridInfoData>> recItemGridInfosCallback;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("TOWERDEFENSE_DIS_GET_NEXT_GRID_INFO", Rec_GetNextGridInfo);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("TOWERDEFENSE_DIS_GET_NEXT_N_GRID_INFO", Rec_GetNextNGridInfo);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("TOWERDEFENSE_DIS_GET_GRID_INFO_IN_CIRCLE", Rec_GetGridInfoInCircle);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("TOWERDEFENSE_DIS_GET_GRID_INFO_BY_POS", Rec_GetGridInfoByPos);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("TOWERDEFENSE_DIS_GET_ITEM_GRID_INFO", Rec_GetItemGridInfo);
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("TOWERDEFENSE_DIS_GET_NEXT_GRID_INFO", Rec_GetNextGridInfo);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("TOWERDEFENSE_DIS_GET_NEXT_N_GRID_INFO", Rec_GetNextNGridInfo);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("TOWERDEFENSE_DIS_GET_GRID_INFO_IN_CIRCLE", Rec_GetGridInfoInCircle);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("TOWERDEFENSE_DIS_GET_GRID_INFO_BY_POS", Rec_GetGridInfoByPos);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("TOWERDEFENSE_DIS_GET_ITEM_GRID_INFO", Rec_GetItemGridInfo);
	}

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

	protected void Dispatch_DarkenLighthouse(int lighthouseGridIndex)
	{
		ModuleController<AdventureModuleController>.Instance.DispatchEventWithData("TOWERDEFENSE_REC_DARKEN_LIGHTHOUSE", _actor, lighthouseGridIndex.ToString());
	}

	protected void Dispatch_DarkenLightSourcesInRange(TSVector2 center, FP range)
	{
		ModuleController<AdventureModuleController>.Instance.DispatchEventWithData("TOWERDEFENSE_REC_DARKEN_LIGHT_SOURCES", _actor, new GridQueryParam(center, range, preferNonFlame: false));
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
}
