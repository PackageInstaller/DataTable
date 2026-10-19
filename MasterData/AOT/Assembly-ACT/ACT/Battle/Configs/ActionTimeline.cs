using System;
using System.Collections.Generic;
using ACT.Timeline;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[Obsolete("Use ActionPlayTimeline")]
[AbilityTypeMetadata("执行Timeline", "Action", new string[] { "timeline", "motion" })]
public class ActionTimeline : ConfigAction
{
	public DynamicTimeline dynamicTimeline = new DynamicTimeline();

	public bool faceLeftUseExtra;

	public DynamicTimeline dynamicTimelineLeft = new DynamicTimeline();

	private Quaternion quaternion;

	protected override AbilityAuth defaultAuth => AbilityAuth.ClientOwner;

	public override void Precache(List<YooAssetReference> addlist)
	{
		addlist.Add(dynamicTimeline.AssetReferenceAssetID);
		addlist.Add(dynamicTimelineLeft.AssetReferenceAssetID);
	}

	public override async void Do(ActionMemory memory)
	{
		CompEffect compEffect = memory.target.entity.GetCompEffect();
		if (faceLeftUseExtra && memory.target.entity.IsFaceLeft())
		{
			compEffect.myTimeLines.Add(dynamicTimelineLeft.directorId, dynamicTimelineLeft);
			dynamicTimelineLeft.Init(memory.target.entity, null, memory);
			await dynamicTimelineLeft.DoTimeline();
			if (compEffect.myTimeLines.TryGetValue(dynamicTimelineLeft.directorId, out var value))
			{
				value.StopTimeline();
				compEffect.myTimeLines.Remove(dynamicTimelineLeft.directorId);
			}
		}
		else
		{
			compEffect.myTimeLines.Add(dynamicTimeline.directorId, dynamicTimeline);
			dynamicTimeline.Init(memory.target.entity);
			await dynamicTimeline.DoTimeline();
			if (compEffect.myTimeLines.TryGetValue(dynamicTimeline.directorId, out var value2))
			{
				value2.StopTimeline();
				compEffect.myTimeLines.Remove(dynamicTimeline.directorId);
			}
		}
	}
}
