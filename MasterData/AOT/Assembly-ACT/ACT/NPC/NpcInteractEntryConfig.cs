using System;
using System.Collections.Generic;
using ACT.NPC.Actions;
using ACT.NPC.Animation;
using ACT.NPC.ChatBubble;
using ACT.World.StateObject;
using Sirenix.Serialization;
using UnityEngine;

namespace ACT.NPC;

[Serializable]
public class NpcInteractEntryConfig
{
	[OdinSerialize]
	public NpcCondition interactEntryCondition = new NpcCondition();

	[OdinSerialize]
	public InteractEntry interactEntry;

	[SerializeReference]
	public List<NpcInteractAction> interactActions = new List<NpcInteractAction>();

	[OdinSerialize]
	public List<NpcInteractActionWrap> interactActionWraps = new List<NpcInteractActionWrap>();

	[SerializeReference]
	public List<NpcChatBubbleCollection> chatBubbleCollections = new List<NpcChatBubbleCollection>();

	[SerializeReference]
	public List<NpcInteractOption> interactOptions = new List<NpcInteractOption>();

	[SerializeReference]
	public List<NpcAnimationCollection> animationCollections = new List<NpcAnimationCollection>();

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

	public bool ShouldUseAnimationSnap()
	{
		if (animationCollections == null)
		{
			return true;
		}
		foreach (NpcAnimationCollection animationCollection in animationCollections)
		{
			if (animationCollection != null && animationCollection.dontUseAnimationSnap)
			{
				return false;
			}
		}
		return true;
	}
}
