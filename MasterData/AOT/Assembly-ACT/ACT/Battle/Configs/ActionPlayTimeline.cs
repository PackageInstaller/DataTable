using System.Collections.Generic;
using ACT.Timeline;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("播放Timeline", "Action", new string[] { "play", "timeline", "motion" })]
public class ActionPlayTimeline : ConfigAction
{
	public TimelineBase timeline;

	public bool faceLeftUseExtra;

	public TimelineBase timelineLeft;

	private Quaternion quaternion;

	protected override AbilityAuth defaultAuth => AbilityAuth.ClientOwner;

	public override void Precache(List<YooAssetReference> addlist)
	{
		addlist.Add(timeline.AssetReferenceAssetID);
		if (faceLeftUseExtra)
		{
			addlist.Add(timelineLeft.AssetReferenceAssetID);
		}
	}

	public override async void Do(ActionMemory memory)
	{
		CompEffect compEffect = memory.target.entity.GetCompEffect();
		if (faceLeftUseExtra && memory.target.entity.IsFaceLeft())
		{
			compEffect.myTimeLines.Add(timelineLeft.Id, timelineLeft);
			timelineLeft.Init(memory);
			await timelineLeft.DoTimeline();
			if (compEffect.myTimeLines.TryGetValue(timelineLeft.Id, out var value))
			{
				value.StopTimeline();
				compEffect.myTimeLines.Remove(timelineLeft.Id);
			}
			return;
		}
		compEffect.myTimeLines.Add(timeline.Id, timeline);
		timeline.Init(memory);
		MonoECS.instance.IsPlayingVibration = true;
		await timeline.DoTimeline();
		if (compEffect.myTimeLines.TryGetValue(timeline.Id, out var value2))
		{
			value2.StopTimeline();
			compEffect.myTimeLines.Remove(timeline.Id);
		}
		MonoECS.instance.IsPlayingVibration = false;
	}
}
