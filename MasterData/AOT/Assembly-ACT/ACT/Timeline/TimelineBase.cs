using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Battle.Configs;
using Cysharp.Threading.Tasks;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace ACT.Timeline;

public abstract class TimelineBase
{
	public bool useNewAssetsBindings;

	public Dictionary<string, string> assets = new Dictionary<string, string>();

	public Dictionary<string, TrackData> newAssetsBindings = new Dictionary<string, TrackData>();

	public bool canOperateRobot;

	public bool dontSyncPosition;

	public ConfigFunction<Vector3> configPosition;

	public bool dontSyncRotation;

	public ConfigFunction<Vector3> configRotation;

	[NonSerialized]
	public GameObject timeline;

	protected TimelineAsset asset;

	protected PlayableDirector m_director;

	protected bool m_Stopped = true;

	protected ActionMemory m_CachedMemory;

	public abstract YooAssetReference AssetReferenceAssetID { get; }

	public abstract int Id { get; }

	public abstract PlayableDirector GetTimelineObject();

	public abstract void ReleaseTimelineObject();

	public virtual void Init(Vector3 worldPosition, Quaternion rotation)
	{
		m_director = GetTimelineObject();
		m_director.Resume();
		timeline = m_director.gameObject;
		timeline.transform.SetPositionAndRotation(worldPosition, rotation);
		timeline.SetActive(value: true);
		if (useNewAssetsBindings)
		{
			TimelineTrackBinding.SetTrackBinding(m_director, newAssetsBindings);
		}
		else
		{
			OldTimelineTrackBinding.SetTrackBinding(m_director, assets);
		}
	}

	public virtual void Init(ActionMemory memory)
	{
		m_CachedMemory = memory;
		Init(configPosition.Return(memory), Quaternion.Euler(configRotation.Return(memory)));
	}

	public virtual async UniTask DoTimeline()
	{
		m_Stopped = false;
		m_director.Play();
		m_director.stopped += OnDirectorStopped;
		if (canOperateRobot)
		{
			MonoECS.instance.RobotActive(value: true, effect: false);
		}
		await UniTask.WaitUntil(() =>
		{
			OnUpdate();
			return m_Stopped;
		});
		if (canOperateRobot)
		{
			MonoECS.instance.RobotActive(value: false, effect: false);
		}
		ReleaseTimelineObject();
		m_director = null;
		timeline = null;
	}

	protected virtual void OnUpdate()
	{
		if (!dontSyncPosition)
		{
			timeline.transform.position = configPosition.Return(m_CachedMemory);
		}
		if (!dontSyncRotation)
		{
			timeline.transform.rotation = Quaternion.Euler(configRotation.Return(m_CachedMemory));
		}
	}

	protected virtual void OnDirectorStopped(PlayableDirector director)
	{
		m_Stopped = true;
		m_director.stopped -= OnDirectorStopped;
	}

	public virtual void StopTimeline()
	{
		if ((bool)timeline)
		{
			m_director.time = m_director.duration;
			m_director.Stop();
		}
	}
}
