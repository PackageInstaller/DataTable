using System.Collections.Generic;
using UnityEngine;

namespace Ase;

[Trigger("NPC2交互物_NPC触发器")]
public class NpcEvent2Npc_MapItemEventTrigger : NpcNodeEventTrigger
{
	public List<MapItemNode> mapItemList;

	public List<NPCNode> npcList;

	public bool MapItemIsSaveData;

	public string messageKey;

	public MapDataNodeParadoxParameter mapDataNodeParadoxParameter;

	public bool NpcIsSaveData;

	public string npcMessageKey;

	public MapDataNodeParadoxParameter npcMapDataNodeParadoxParameter;

	public override string TriggerName => "NPC-交互物_NPC触发器";

	protected override void DoExecute()
	{
		base.DoExecute();
		int levelId = sceneSystem.GetSystem<SceneSystem>().GetLevelId();
		if (mapItemList != null && mapItemList.Count > 0)
		{
			foreach (MapItemNode mapItem in mapItemList)
			{
				if ((Object)(object)mapItem != null)
				{
					mapItem.SendParadoxMessage(messageKey, mapDataNodeParadoxParameter);
					if (MapItemIsSaveData)
					{
						Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().UpdateMapItemDataParadoxData(levelId, mapItem.Uid, messageKey, mapDataNodeParadoxParameter);
					}
				}
			}
		}
		if (npcList == null || npcList.Count <= 0)
		{
			return;
		}
		foreach (NPCNode npc in npcList)
		{
			if ((Object)(object)npc != null)
			{
				npc.SendParadoxMessage(npcMessageKey, npcMapDataNodeParadoxParameter);
				if (NpcIsSaveData)
				{
					Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().UpdateNpcParadoxData(levelId, npc.Uid, npcMessageKey, npcMapDataNodeParadoxParameter);
				}
			}
		}
	}

	public override void OnDisposed()
	{
	}
}
