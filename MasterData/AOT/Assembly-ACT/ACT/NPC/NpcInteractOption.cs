using System;
using System.Collections.Generic;
using ACT.DialogueSystem;
using ACT.NPC.Actions;
using Sirenix.Serialization;

namespace ACT.NPC;

[Serializable]
public class NpcInteractOption
{
	public long dialogueID;

	public int iconID;

	public NpcCondition showCondition = new NpcCondition();

	[OdinSerialize]
	public List<NpcInteractActionWrap> interactActionWraps = new List<NpcInteractActionWrap>();

	public IEnumerable<NpcInteractAction> GetAllInteractActions()
	{
		if (interactActionWraps == null)
		{
			yield break;
		}
		foreach (NpcInteractActionWrap interactActionWrap in interactActionWraps)
		{
			foreach (NpcInteractAction action in interactActionWrap.GetActions())
			{
				if (action != null)
				{
					yield return action;
				}
			}
		}
	}

	public bool ShouldShow()
	{
		return showCondition.IsPassWithoutCache();
	}

	public DialogueNode ConvertToDialogueNode(DialogueNode origin = null)
	{
		ChatOptionNode chatOptionNode = origin as ChatOptionNode;
		if (chatOptionNode == null)
		{
			chatOptionNode = new ChatOptionNode();
		}
		chatOptionNode.key = dialogueID;
		chatOptionNode.iconId = iconID;
		chatOptionNode.OnSelectCallback = null;
		return chatOptionNode;
	}
}
