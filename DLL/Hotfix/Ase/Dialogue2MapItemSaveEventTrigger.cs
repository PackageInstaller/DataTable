using System.Collections.Generic;
using UnityEngine;

namespace Ase;

[Trigger("对话链2交互物存档事件触发器")]
public class Dialogue2MapItemSaveEventTrigger : DialogueChainEventTrigger
{
	public List<MapItemNode> mapItemList;

	public bool changeActiveState;

	public bool activeState;

	public bool changeArgs;

	public int args;

	public bool changeIconType;

	public int iconType;

	public override string TriggerName => "NPC-交互物存档事件触发器";

	protected override void DoExecute()
	{
		base.DoExecute();
		for (int i = 0; i < mapItemList.Count; i++)
		{
			MapItemNode mapItemNode = mapItemList[i];
			if (!((Object)(object)mapItemNode == null))
			{
				int levelId = sceneSystem.GetSystem<SceneSystem>().GetLevelId();
				if (changeActiveState)
				{
					Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().UpdateMapItemActiveState(levelId, mapItemNode.Uid, (!activeState) ? 1 : 0);
				}
				if (changeIconType)
				{
					Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().UpdateMapItemDataIconType(levelId, mapItemNode.Uid, iconType);
				}
				if (changeArgs)
				{
					Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().UpdateMapItemDataParadoxData(levelId, mapItemNode.Uid, "saveArgsKey", MapDataNodeParadoxParameter.CreateIntParameter(args));
				}
				if (changeActiveState || changeIconType || changeArgs)
				{
					Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().ExcuteMapItemUpdateAction(levelId, mapItemNode.Uid);
				}
			}
		}
	}
}
