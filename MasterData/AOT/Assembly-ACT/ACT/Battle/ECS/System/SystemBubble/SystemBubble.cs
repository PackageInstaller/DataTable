using System.Collections.Generic;
using ACT.Battle.ECS.System.SystemNPC;
using ACT.Model.ChatBubbleModel;
using ACT.NPC.ChatBubble;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.Battle.ECS.System.SystemBubble;

public class SystemBubble : EntitySystem
{
	private Filter _filter;

	private Vector3 _mainEntityPosition;

	public override Filter MajorFilter => _filter;

	protected override void OnCreate()
	{
		_filter = World.NewFilter().All<CompBubble>().Build();
	}

	public override void Update()
	{
		base.Update();
		if (!MonoECS.instance.mainEntity.IsValid)
		{
			return;
		}
		CompTransform compTransform = MonoECS.instance.mainEntity.GetCompTransform();
		if (compTransform == null)
		{
			return;
		}
		_mainEntityPosition = compTransform.physicsPosition;
		foreach (KeyValuePair<int, Entity> item in Singleton<RuntimeNpcManager>.instance.InstantiatedNpcDictionary)
		{
			Entity value = item.Value;
			if (value.IsValid && value.IsLogicAvailable())
			{
				UpdateBubble(value, value.GetComponent<CompBubble>());
			}
		}
	}

	private void UpdateBubble(Entity entity, CompBubble compBubble)
	{
		if (compBubble == null || !compBubble.Parent)
		{
			return;
		}
		IReadOnlyList<NpcChatBubbleRuntime> bubbleRuntimes = compBubble.BubbleRuntimes;
		if (bubbleRuntimes.Count == 0)
		{
			return;
		}
		float num = Vector3.Distance(_mainEntityPosition, compBubble.GetBubbleRootPosition());
		for (int i = 0; i < bubbleRuntimes.Count; i++)
		{
			NpcChatBubbleRuntime npcChatBubbleRuntime = bubbleRuntimes[i];
			if (npcChatBubbleRuntime.Config != null)
			{
				if (num > npcChatBubbleRuntime.DistanceToHide && npcChatBubbleRuntime.IsInArea)
				{
					npcChatBubbleRuntime.Clear();
					compBubble.StopBubbleGroup();
				}
				else if (num <= npcChatBubbleRuntime.DistanceToShow && !npcChatBubbleRuntime.IsInArea)
				{
					npcChatBubbleRuntime.Bind(compBubble);
				}
			}
		}
	}
}
