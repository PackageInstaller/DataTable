using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Battle.Configs;
using ACT.Core;
using ACT.Model;
using Bamboo.AssetField;
using Bamboo.ECS;
using Runtime.Model;
using UnityEngine;
using UnityEngine.Playables;
using UnityEngine.Timeline;

namespace ACT.Timeline;

public class DynamicTimeline : TimelineBase
{
	public enum PositionMode
	{
		Player,
		World
	}

	private struct DynamicTimelineData
	{
		public Entity target;

		public GameObject timeline;

		public ActionMemory actionMemory;
	}

	public int directorId;

	public string guid;

	public bool syncPosition;

	public ConfigFunction<Vector3> configWorldPosition;

	public PositionMode mode;

	public new bool dontSyncRotation;

	private YooAssetReference m_AssetReferenceAssetID;

	private DynamicTimelineData m_Data;

	public string Path => RuntimeConfigs.data.dramaTimelineDatas[directorId].content;

	public override YooAssetReference AssetReferenceAssetID => m_AssetReferenceAssetID ?? (m_AssetReferenceAssetID = new YooAssetReference(guid));

	public override int Id => directorId;

	public async void AssetChange()
	{
		AssetLoadHandle handle = AssetStationManager.BattleStation.LoadAsync<GameObject>(Path);
		await handle;
		GameObject gameObject = handle.As<GameObject>();
		if (gameObject == null)
		{
			return;
		}
		m_director = gameObject.GetComponent<PlayableDirector>();
		asset = (TimelineAsset)m_director.playableAsset;
		useNewAssetsBindings = true;
		if (newAssetsBindings == null)
		{
			newAssetsBindings = new Dictionary<string, TrackData>();
		}
		List<string> list = new List<string>();
		foreach (PlayableBinding output in asset.outputs)
		{
			list.Remove(output.streamName);
			if (!newAssetsBindings.ContainsKey(output.streamName))
			{
				newAssetsBindings.Add(output.streamName, new TrackData
				{
					trackType = TrackType.None,
					trackData = "0"
				});
				if (LuminApplication.LogEnabled)
				{
					Debug.Log(output.outputTargetType);
				}
			}
		}
		foreach (string item in list)
		{
			newAssetsBindings.Remove(item);
		}
		AssetStationManager.BattleStation.Release(handle);
	}

	public void Init(Entity target, GameObject instanceGo = null, ActionMemory memory = default(ActionMemory))
	{
		m_Data = new DynamicTimelineData
		{
			target = target,
			timeline = instanceGo,
			actionMemory = memory
		};
		Vector3 worldPosition;
		Quaternion rotation;
		switch (mode)
		{
		case PositionMode.Player:
			worldPosition = MonoECS.instance.mainEntity.GetRootTransform().position;
			rotation = (dontSyncRotation ? Quaternion.identity : MonoECS.instance.mainEntity.GetCompTransform().XFaceRotation);
			break;
		case PositionMode.World:
			worldPosition = configWorldPosition.Return(memory);
			rotation = Quaternion.identity;
			break;
		default:
			throw new ArgumentOutOfRangeException();
		}
		base.Init(worldPosition, rotation);
	}

	public override PlayableDirector GetTimelineObject()
	{
		if (m_Data.timeline == null)
		{
			return Model<RuntimeTimelineModel>.Interface.GetTimelineImmediately(AssetReferenceAssetID);
		}
		timeline = m_Data.timeline;
		return timeline.GetComponent<PlayableDirector>();
	}

	public override void ReleaseTimelineObject()
	{
		if (m_Data.timeline == null)
		{
			Model<RuntimeTimelineModel>.Interface.ReleaseTimeline(AssetReferenceAssetID);
		}
		else
		{
			m_Data.timeline.SetActive(value: false);
		}
	}

	protected override void OnUpdate()
	{
		if (syncPosition)
		{
			timeline.transform.position = MonoECS.instance.mainEntity.GetRootTransform().position;
		}
	}
}
