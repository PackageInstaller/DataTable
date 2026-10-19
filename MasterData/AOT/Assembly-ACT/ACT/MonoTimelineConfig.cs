using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Drama;
using Cysharp.Threading.Tasks;
using Fundamental;
using Sirenix.Serialization;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace ACT;

[AddComponentMenu("TimelineConfig")]
public class MonoTimelineConfig : LuminSerializedMonoBehaviour
{
	[NonSerialized]
	[OdinSerialize]
	public TimelineConfig timelineConfig = new TimelineConfig();

	private void LoadTrackAssets()
	{
		PlayableDirector component = GetComponent<PlayableDirector>();
		if (component == null || !(component.playableAsset is TimelineAsset timelineAsset))
		{
			Debug.LogWarning(name + " 没有配置有效的 TimelineAsset，无法加载轨道。", this);
			return;
		}
		if (timelineConfig == null)
		{
			timelineConfig = new TimelineConfig();
		}
		timelineConfig.useNewAssetsBindings = true;
		if (timelineConfig.newAssetsBindings == null)
		{
			timelineConfig.newAssetsBindings = new Dictionary<string, TrackData>();
		}
		HashSet<string> outputNames = new HashSet<string>();
		foreach (PlayableBinding output in timelineAsset.outputs)
		{
			if (!string.IsNullOrEmpty(output.streamName))
			{
				outputNames.Add(output.streamName);
				if (!timelineConfig.newAssetsBindings.ContainsKey(output.streamName))
				{
					timelineConfig.newAssetsBindings.Add(output.streamName, new TrackData
					{
						trackType = TrackType.None,
						trackData = "0"
					});
				}
			}
		}
		foreach (string item in timelineConfig.newAssetsBindings.Keys.Where((string trackName) => !outputNames.Contains(trackName)).ToList())
		{
			timelineConfig.newAssetsBindings.Remove(item);
		}
	}

	public void Play()
	{
		Singleton<TimelineConversationManager>.instance.PlayTimeline(gameObject).Forget();
	}

	public void Stop()
	{
		Singleton<TimelineConversationManager>.instance.StopConversation();
	}

	public void Restart()
	{
		Stop();
		Play();
	}

	public void Skip()
	{
		Singleton<TimelineConversationManager>.instance.SkipConversation();
	}

	public void ForceSkip()
	{
		Skip();
	}
}
