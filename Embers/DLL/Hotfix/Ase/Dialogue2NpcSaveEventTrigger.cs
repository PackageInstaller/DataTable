using System.Collections.Generic;
using UnityEngine;

namespace Ase;

[Trigger("对话链2Npc存档事件触发器")]
public class Dialogue2NpcSaveEventTrigger : DialogueChainEventTrigger
{
	public List<NPCNode> npcNodes;

	public bool changeActive;

	public bool changeDialogPrologue;

	public bool changeDialogButtonGroup;

	public bool active;

	public List<int> dialogPrologue;

	public List<DialogueChainConfig.DialogueButtonConfig> dialogButtonGroup;

	public override string TriggerName => "NPC-Npc存档触发器";

	protected override void DoExecute()
	{
		base.DoExecute();
		for (int i = 0; i < npcNodes.Count; i++)
		{
			NPCNode nPCNode = npcNodes[i];
			if (!((Object)(object)nPCNode == null))
			{
				int levelId = sceneSystem.GetSystem<SceneSystem>().GetLevelId();
				if (changeActive)
				{
					Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().UpdateNpcActiveState(levelId, nPCNode.Uid, active);
				}
				if (changeDialogPrologue)
				{
					Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().UpdateNpcDialogPrologue(levelId, nPCNode.Uid, dialogPrologue);
				}
				if (changeDialogButtonGroup)
				{
					Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().UpdateNpcData(levelId, nPCNode.Uid, dialogButtonGroup);
				}
				if (changeActive || changeDialogPrologue || changeDialogButtonGroup)
				{
					Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().ExcuteNpcUpdateAction(levelId, nPCNode.Uid);
				}
			}
		}
	}
}
