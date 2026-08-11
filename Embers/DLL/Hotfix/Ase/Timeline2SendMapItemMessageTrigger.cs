using System.Collections.Generic;
using UnityEngine;

namespace Ase;

[Trigger("Timeline2交互物传参触发器")]
public class Timeline2SendMapItemMessageTrigger : TimelineEventTrigger
{
	public MapItemNode MapItemNode;

	[SerializeField]
	private bool IsSaveData;

	[SerializeField]
	private bool IsSaveLevelData;

	[SerializeField]
	public Dictionary<string, MapDataNodeParadoxParameter> eventNodeParadoxMsg = new Dictionary<string, MapDataNodeParadoxParameter>();

	public override string TriggerName => "Timeline-交互物传参触发器";

	protected override void DoExecute()
	{
		base.DoExecute();
		if (sceneSystem == null)
		{
			return;
		}
		int levelId = sceneSystem.GetLevelId();
		if (!((Object)(object)MapItemNode != null))
		{
			return;
		}
		MapItemNode.SendParadoxMessage(eventNodeParadoxMsg);
		if (IsSaveData)
		{
			Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().UpdateMapItemDataParadoxDatas(levelId, MapItemNode.Uid, eventNodeParadoxMsg);
			if (IsSaveLevelData)
			{
				Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().SaveLevelData(levelId);
			}
		}
	}
}
