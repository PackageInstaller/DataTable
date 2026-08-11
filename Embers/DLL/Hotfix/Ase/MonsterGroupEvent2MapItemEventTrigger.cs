using System.Collections.Generic;
using UnityEngine;

namespace Ase;

[Trigger("怪物组2交互物触发器")]
public class MonsterGroupEvent2MapItemEventTrigger : MonsterGroupEventTrigger
{
	public List<MapItemNode> mapItemList;

	[SerializeField]
	private bool IsSaveData;

	[SerializeField]
	private bool IsSaveLevelData;

	public string messageKey;

	public MapDataNodeParadoxParameter mapDataNodeParadoxParameter;

	public override string TriggerName => "怪物组-交互物触发器";

	protected override void DoExecute()
	{
		base.DoExecute();
		int levelId = sceneSystem.GetSystem<SceneSystem>().GetLevelId();
		if (mapItemList == null || mapItemList.Count <= 0)
		{
			return;
		}
		foreach (MapItemNode mapItem in mapItemList)
		{
			if ((Object)(object)mapItem != null)
			{
				mapItem.SendParadoxMessage(messageKey, mapDataNodeParadoxParameter);
			}
			if (IsSaveData)
			{
				Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().UpdateMapItemDataParadoxData(levelId, mapItem.Uid, messageKey, mapDataNodeParadoxParameter);
			}
		}
		if (IsSaveLevelData && IsSaveData)
		{
			Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().SaveLevelData(levelId);
		}
	}
}
