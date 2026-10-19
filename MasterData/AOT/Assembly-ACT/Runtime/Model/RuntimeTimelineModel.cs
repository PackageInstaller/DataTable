using System;
using System.Collections.Generic;
using ACT;
using ACT.Battle;
using ACT.Core;
using ACT.Model;
using ACT.Sound.Management;
using ACT.Utility;
using Bamboo.AssetField;
using Bamboo.Precache;
using Fundamental;
using UnityEngine;
using UnityEngine.Playables;

namespace Runtime.Model;

public class RuntimeTimelineModel : Model<RuntimeTimelineModel>
{
	private Dictionary<YooAssetReference, RuntimeTimelineData> _runningTimelinesByReference;

	private Dictionary<string, RuntimeTimelineData> _runningTimelinesByPath;

	private Dictionary<PlayableDirector, List<Animator>> _changeAnimationDatas = new Dictionary<PlayableDirector, List<Animator>>();

	protected override void Init()
	{
		_runningTimelinesByReference = DictionaryPool<YooAssetReference, RuntimeTimelineData>.Get();
		_runningTimelinesByPath = DictionaryPool<string, RuntimeTimelineData>.Get();
	}

	protected override void UnInit()
	{
		Dictionary<YooAssetReference, RuntimeTimelineData> runningTimelinesByReference = _runningTimelinesByReference;
		if (runningTimelinesByReference != null && runningTimelinesByReference.Count > 0)
		{
			foreach (KeyValuePair<YooAssetReference, RuntimeTimelineData> item in _runningTimelinesByReference)
			{
				PrecacheManager.Instance.ReleaseInstanceHandle(item.Value.instanceHandle);
			}
			_runningTimelinesByReference.Clear();
			DictionaryPool<YooAssetReference, RuntimeTimelineData>.Release(_runningTimelinesByReference);
			_runningTimelinesByReference = null;
		}
		Dictionary<string, RuntimeTimelineData> runningTimelinesByPath = _runningTimelinesByPath;
		if (runningTimelinesByPath != null && runningTimelinesByPath.Count > 0)
		{
			foreach (KeyValuePair<string, RuntimeTimelineData> item2 in _runningTimelinesByPath)
			{
				AssetStationManager.BattleStation.ReleaseInstance(item2.Value.pd.gameObject);
			}
			_runningTimelinesByPath.Clear();
			DictionaryPool<string, RuntimeTimelineData>.Release(_runningTimelinesByPath);
			_runningTimelinesByPath = null;
		}
		_changeAnimationDatas.Clear();
	}

	public PlayableDirector GetTimelineImmediately(YooAssetReference assetReferenceAssetID)
	{
		if (_runningTimelinesByReference.TryGetValue(assetReferenceAssetID, out var value))
		{
			return value.pd;
		}
		GameObject parentTransform = MonoECS.instance.GetRoot(SceneRootType.Timeline);
		InstanceHandle instanceHandle = PrecacheManager.Instance.GetInstanceHandle(assetReferenceAssetID.GUID);
		instanceHandle.CompleteSync();
		instanceHandle.Completed += (InstanceHandle handle) =>
		{
			handle.Result.transform.SetParent(parentTransform.transform);
		};
		RuntimeTimelineData value2 = new RuntimeTimelineData
		{
			instanceHandle = instanceHandle,
			pd = instanceHandle.Result.GetComponent<PlayableDirector>()
		};
		_runningTimelinesByReference.Add(assetReferenceAssetID, value2);
		return value2.pd;
	}

	public void ReleaseTimeline(YooAssetReference assetReferenceAssetID)
	{
		if (_runningTimelinesByReference.Remove(assetReferenceAssetID, out var value))
		{
			PrecacheManager.Instance.ReleaseInstanceHandle(value.instanceHandle);
		}
	}

	public PlayableDirector GetTimelineImmediately(string timelineId)
	{
		if (_runningTimelinesByPath.TryGetValue(timelineId, out var value))
		{
			return value.pd;
		}
		GameObject root = MonoECS.instance.GetRoot(SceneRootType.Timeline);
		AssetLoadHandle assetLoadHandle = AssetStationManager.BattleStation.Instantiate(timelineId, root.transform);
		RuntimeTimelineData value2 = new RuntimeTimelineData
		{
			pd = assetLoadHandle.AsGameObject().GetComponent<PlayableDirector>()
		};
		_runningTimelinesByPath.Add(timelineId, value2);
		return value2.pd;
	}

	public void ReleaseTimeline(string timelineId)
	{
		if (_runningTimelinesByPath.Remove(timelineId, out var value))
		{
			AssetStationManager.BattleStation.ReleaseInstance(value.pd.gameObject);
		}
	}

	public AssetLoadHandle GetTimelineByDramaId(int id, Vector3 position = default(Vector3), Quaternion rotation = default(Quaternion))
	{
		AssetLoadHandle result = default;
		if (!RuntimeConfigs.data.dramaTimelineDatas.ContainsKey(id) && LuminApplication.LogEnabled)
		{
			Debug.LogError($"错误的DramaTimelineId {id}");
		}
		string content = RuntimeConfigs.data.dramaTimelineDatas[id].content;
		if (string.IsNullOrEmpty(content) && LuminApplication.LogEnabled)
		{
			Debug.LogError($"空的dramaConversationData！ id {id}");
		}
		try
		{
			if (string.IsNullOrEmpty(RuntimeConfigs.data.dramaTimelineDatas[id].eventAddress))
			{
				Singleton<DramaVoiceManager>.instance.Release();
			}
			else
			{
				Singleton<DramaVoiceManager>.instance.SetVoice(RuntimeConfigs.data.dramaTimelineDatas[id].eventAddress, Camera.main.transform);
			}
			try
			{
				result = AssetStationManager.BattleStation.InstantiateAsync(content, position, rotation);
				return result;
			}
			catch (Exception)
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError("找不到 " + content + " 对话Timeline");
				}
				throw;
			}
		}
		catch (Exception exception)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogException(exception);
			}
		}
		return result;
	}

	public void AddAnimationChangeInfo(PlayableDirector playableDirector, Animator animator)
	{
		if (_changeAnimationDatas != null && !_changeAnimationDatas.ContainsKey(playableDirector))
		{
			_changeAnimationDatas[playableDirector] = ListPool<Animator>.Get();
		}
		if (_changeAnimationDatas != null)
		{
			_changeAnimationDatas[playableDirector].Add(animator);
		}
	}

	public void ClearAnimationTrack(PlayableDirector playableDirector)
	{
		if (!_changeAnimationDatas.TryGetValue(playableDirector, out var value))
		{
			return;
		}
		foreach (Animator item in value)
		{
			item.applyRootMotion = false;
		}
		value.Clear();
		ListPool<Animator>.Release(value);
	}
}
