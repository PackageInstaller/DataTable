using System.Collections.Generic;
using UnityEngine;

namespace Ase;

[Trigger("交互物传参触发器")]
public class SendParadoxParameterToMapItemTrigger : BaseTrigger
{
	public List<MapItemNode> mapItemList;

	[SerializeField]
	private bool IsSaveData;

	[SerializeField]
	private bool IsSaveLevelData;

	public Dictionary<string, MapDataNodeParadoxParameter> mapDataNodeParadoxParameters = new Dictionary<string, MapDataNodeParadoxParameter>();

	public override string TriggerName => "交互物传参触发器";

	protected override void DoExecute()
	{
		base.DoExecute();
		if (mapItemList == null)
		{
			return;
		}
		int levelId = sceneSystem.GetSystem<SceneSystem>().GetLevelId();
		foreach (MapItemNode mapItem in mapItemList)
		{
			if (!((Object)(object)mapItem == null))
			{
				mapItem.SendParadoxMessage(mapDataNodeParadoxParameters);
				if (IsSaveData)
				{
					Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().UpdateMapItemDataParadoxDatas(levelId, mapItem.Uid, mapDataNodeParadoxParameters);
				}
			}
		}
		if (IsSaveData && IsSaveLevelData)
		{
			Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().SaveLevelData(levelId);
		}
	}
}
