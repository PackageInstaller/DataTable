using System;
using System.Collections.Generic;
using UnityEngine;

[CreateAssetMenu(fileName = "DormTimelineSequenceConfig", menuName = "游戏/后宅/动画序列配置")]
public class DormTimelineSequenceConfigData : ScriptableObject
{
	[Serializable]
	public class TimelineEntry
	{
		public GameObject timelinePrefab;

		[Min(0f)]
		public int weight = 100;

		public bool isSkip;
	}

	[Serializable]
	public class AnimationSegment
	{
		public List<TimelineEntry> timelineEntries = new List<TimelineEntry>();

		[Min(1f)]
		public int loopCountMin = 1;

		[Min(1f)]
		public int loopCountMax = 1;

		public TimelineEntry PickRandomEntry()
		{
			if (timelineEntries == null || timelineEntries.Count == 0)
			{
				return null;
			}
			if (timelineEntries.Count == 1)
			{
				return timelineEntries.get_Item(0);
			}
			int num = 0;
			for (int i = 0; i < timelineEntries.Count; i++)
			{
				int weight = timelineEntries.get_Item(i).weight;
				if (weight > 0)
				{
					num += weight;
				}
			}
			if (num <= 0)
			{
				return null;
			}
			int num2 = UnityEngine.Random.Range(0, num);
			int num3 = 0;
			for (int j = 0; j < timelineEntries.Count; j++)
			{
				int weight2 = timelineEntries.get_Item(j).weight;
				if (weight2 > 0)
				{
					num3 += weight2;
					if (num2 < num3)
					{
						return timelineEntries.get_Item(j);
					}
				}
			}
			return null;
		}

		public int RollLoopCount()
		{
			int num = Mathf.Max(1, loopCountMin);
			int num2 = Mathf.Max(num, loopCountMax);
			return UnityEngine.Random.Range(num, num2 + 1);
		}
	}

	public class TimelinePlaybackSegment
	{
		public GameObject timelinePrefab;

		public int loopCount;
	}

	public class PlaybackData
	{
		public List<TimelinePlaybackSegment> sequence;
	}

	public List<AnimationSegment> segments = new List<AnimationSegment>();

	public PlaybackData Resolve()
	{
		PlaybackData playbackData = new PlaybackData
		{
			sequence = new List<TimelinePlaybackSegment>()
		};
		for (int i = 0; i < segments.Count; i++)
		{
			AnimationSegment animationSegment = segments.get_Item(i);
			TimelineEntry timelineEntry = animationSegment.PickRandomEntry();
			if (timelineEntry != null && !timelineEntry.isSkip)
			{
				playbackData.sequence.Add(new TimelinePlaybackSegment
				{
					timelinePrefab = timelineEntry.timelinePrefab,
					loopCount = animationSegment.RollLoopCount()
				});
			}
		}
		return playbackData;
	}
}
