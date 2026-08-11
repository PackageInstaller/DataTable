#define ENABLE_ERROR_AND_ABOVE_LOG
using Ase.ECS;
using GameFramework;
using UnityEngine;

namespace Ase;

public class BattleMapItemNode : BaseMapDataNode
{
	public int mapItemId;

	public int syncMapItemId;

	public string InteractiveName;

	public override bool DisplayNode => false;

	public override bool UsedOcTree => false;

	public async void CallEntity()
	{
		DRMapItem drMapItem = GameEntry.DataTable.GetDataRow<DRMapItem>(mapItemId);
		if (drMapItem == null)
		{
			Log.Error($"没有找到编号 = {mapItemId}的交互物配置..");
			return;
		}
		GameObject entityObject = await LoadEntityView(drMapItem.Id, drMapItem.AssetPath);
		sceneSystem.GetSystem<EntitySystem>().CreateEntity<BattleInteractiveEntity>(drMapItem.Id, new EntityData
		{
			pointData = new EntityPositionData
			{
				position = ((Component)(object)this).transform.position,
				scale = ((Component)(object)this).transform.localScale,
				rotation = ((Component)(object)this).transform.eulerAngles
			},
			entityObject = entityObject,
			userData = drMapItem,
			updateType = EntityUpdateType.Local,
			logicType = EntityLogicType.None
		}).SetData(Constant.InteractiveConstant.INTERACTIVE_NAME, InteractiveName);
	}

	public async void CallSyncEntity()
	{
		DRMapItem drMapItem = GameEntry.DataTable.GetDataRow<DRMapItem>(syncMapItemId);
		if (drMapItem == null)
		{
			Log.Error($"没有找到编号 = {mapItemId}的交互物配置..");
			return;
		}
		GameObject entityObject = await LoadEntityView(drMapItem.Id, drMapItem.AssetPath);
		sceneSystem.GetSystem<EntitySystem>().CreateEntity<SyncBattleInteractiveEntity>(drMapItem.Id, new EntityData
		{
			pointData = new EntityPositionData
			{
				position = ((Component)(object)this).transform.position,
				scale = ((Component)(object)this).transform.localScale,
				rotation = ((Component)(object)this).transform.eulerAngles
			},
			entityObject = entityObject,
			userData = drMapItem,
			updateType = EntityUpdateType.Authority,
			logicType = EntityLogicType.None
		}).SetData(Constant.InteractiveConstant.INTERACTIVE_NAME, InteractiveName);
	}

	public override void OnDisposed()
	{
	}
}
