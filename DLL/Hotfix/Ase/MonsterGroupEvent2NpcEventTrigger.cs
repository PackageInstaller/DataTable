using System.Collections.Generic;
using UnityEngine;

namespace Ase;

[Trigger("怪物组2Npc触发器")]
public class MonsterGroupEvent2NpcEventTrigger : MonsterGroupEventTrigger
{
	public List<NPCNode> NpcNodeList;

	[SerializeField]
	private bool IsChangeSaveData;

	[SerializeField]
	private bool IsSaveLevelData;

	public string messageKey;

	public MapDataNodeParadoxParameter mapDataNodeParadoxParameter;

	public override string TriggerName => "怪物组-Npc触发器";

	protected override void DoExecute()
	{
		base.DoExecute();
		int levelId = sceneSystem.GetSystem<SceneSystem>().GetLevelId();
		if (NpcNodeList == null || NpcNodeList.Count <= 0)
		{
			return;
		}
		foreach (NPCNode npcNode in NpcNodeList)
		{
			if ((Object)(object)npcNode != null)
			{
				npcNode.SendParadoxMessage(messageKey, mapDataNodeParadoxParameter);
			}
			if (IsChangeSaveData)
			{
				Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().UpdateNpcParadoxData(levelId, npcNode.Uid, messageKey, mapDataNodeParadoxParameter);
			}
		}
		if (IsSaveLevelData && IsChangeSaveData)
		{
			Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().SaveLevelData(levelId);
		}
	}
}
