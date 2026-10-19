using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Config;
using ACT.Core;
using ACT.UI;
using ACT.Utility;
using Bamboo.Chronos;
using Bamboo.Precache;
using Fundamental;
using UnityEngine;

namespace ACT.Model.ChatBubbleModel;

public class ChatBubbleModel : Model<ChatBubbleModel>
{
	private Dictionary<IBubbleObject, RuntimeChatBubbleGroupData> _playingBubbleGroupDataDic;

	private Dictionary<IBubbleObject, RuntimeChatBubbleGroupData> _waitCycleBubbleDic;

	private Looper _mainLooper;

	private Looper _cycleLooper;

	private const int deltaTimeMs = 500;

	private const float cycleDeltaTimeS = 5f;

	private const float deltaTimeSec = 0.5f;

	private static ObjectPool<RuntimeChatBubbleGroupData> _objectPool = new ObjectPool<RuntimeChatBubbleGroupData>(null, ResetRuntimeChatBubbleGroupData);

	public IReadOnlyDictionary<IBubbleObject, RuntimeChatBubbleGroupData> PlayingBubbleGroupDataDic => _playingBubbleGroupDataDic;

	public IReadOnlyDictionary<IBubbleObject, RuntimeChatBubbleGroupData> CyclingBubbleGroupDataDic => _waitCycleBubbleDic;

	private YooAssetReference _bubblePrefabRef => GameLoader.meta?.npcDialogueBubble;

	protected override void Init()
	{
		_playingBubbleGroupDataDic = DictionaryPool<IBubbleObject, RuntimeChatBubbleGroupData>.Get();
		_waitCycleBubbleDic = DictionaryPool<IBubbleObject, RuntimeChatBubbleGroupData>.Get();
	}

	protected override void UnInit()
	{
		if (_mainLooper.IsValid())
		{
			_mainLooper.Cancel();
		}
		List<IBubbleObject> list = _playingBubbleGroupDataDic.Keys.ToList();
		list.AddRange(_waitCycleBubbleDic.Keys);
		foreach (IBubbleObject item in list)
		{
			StopBubbleGroup(item);
		}
		DictionaryPool<IBubbleObject, RuntimeChatBubbleGroupData>.Release(_playingBubbleGroupDataDic);
		DictionaryPool<IBubbleObject, RuntimeChatBubbleGroupData>.Release(_waitCycleBubbleDic);
	}

	public RuntimeChatBubbleGroupData GetPlayingBubbleGroupData(IBubbleObject bubbleObject)
	{
		if (_playingBubbleGroupDataDic.TryGetValue(bubbleObject, out var value))
		{
			return value;
		}
		if (_waitCycleBubbleDic.TryGetValue(bubbleObject, out value))
		{
			return value;
		}
		return null;
	}

	public void RebindPlayingBubbleObject(IBubbleObject bubbleObject)
	{
		if (bubbleObject != null)
		{
			RuntimeChatBubbleGroupData playingBubbleGroupData = GetPlayingBubbleGroupData(bubbleObject);
			if (playingBubbleGroupData != null && (bool)playingBubbleGroupData.bubbleGameObject)
			{
				playingBubbleGroupData.bubbleGameObject.GetComponent<MonoChatBubble>()?.BindBubbleObject(bubbleObject);
			}
		}
	}

	public void StartBubbleGroup(IBubbleObject bubbleObject, int bubbleGroupId, RuntimeChatBubbleGroupData providedData = null)
	{
		if (bubbleObject == null)
		{
			return;
		}
		if (_playingBubbleGroupDataDic.ContainsKey(bubbleObject) || _waitCycleBubbleDic.ContainsKey(bubbleObject))
		{
			StopBubbleGroup(bubbleObject);
		}
		RuntimeChatBubbleGroupData runtimeData = providedData ?? _objectPool.Get();
		YooAssetReference bubblePrefabRef = _bubblePrefabRef;
		if (bubblePrefabRef == null)
		{
			if (providedData == null)
			{
				_objectPool.Release(runtimeData);
			}
			return;
		}
		InstanceHandle instanceHandle = PrecacheManager.Instance.GetInstanceHandle(bubblePrefabRef.GUID);
		if (instanceHandle == null)
		{
			if (providedData == null)
			{
				_objectPool.Release(runtimeData);
			}
			return;
		}
		_playingBubbleGroupDataDic[bubbleObject] = runtimeData;
		runtimeData.bubbleInstanceHandle = instanceHandle;
		instanceHandle.Completed += (InstanceHandle l) =>
		{
			try
			{
				if (!IsCurrentBubbleLoad(bubbleObject, runtimeData, l) || l.Result == null)
				{
					ReleaseBubbleInstanceHandle(l);
				}
				else
				{
					l.Result.transform.SetParent(GameUtility.npcInfoRoot);
					MonoChatBubble component = l.Result.GetComponent<MonoChatBubble>();
					l.Result.gameObject.SetActive(value: false);
					DialogueBubbleGroup data = CoreUtils.GetData(bubbleGroupId, RuntimeConfigs.data.dialogueBubbleGroups);
					if (data == null || data.bubbleID == null || data.bubbleID.Length == 0)
					{
						CleanupFailedBubbleLoad(bubbleObject, runtimeData, l, $"气泡组配置缺失: bubbleGroupId: {bubbleGroupId}");
					}
					else
					{
						DialogueBubbleContent data2 = CoreUtils.GetData(data.bubbleID[0], RuntimeConfigs.data.dialogueBubbleContents);
						if (data2 == null)
						{
							CleanupFailedBubbleLoad(bubbleObject, runtimeData, l, $"气泡内容配置缺失: bubbleContentId: {data.bubbleID[0]}");
						}
						else if (component == null)
						{
							CleanupFailedBubbleLoad(bubbleObject, runtimeData, l, "气泡预制体缺少 MonoChatBubble 组件");
						}
						else
						{
							float num = 0f;
							int[] bubbleID = data.bubbleID;
							for (int i = 0; i < bubbleID.Length; i++)
							{
								DialogueBubbleContent data3 = CoreUtils.GetData(bubbleID[i], RuntimeConfigs.data.dialogueBubbleContents);
								if (data3 != null)
								{
									num += (float)(data3.BubbleGapTime + data3.BubbleShowTime);
								}
							}
							runtimeData.bubbleIndex = 0;
							runtimeData.currentProcessingBubbleRemainTime = data2.BubbleShowTime + data2.BubbleGapTime;
							runtimeData.totalTime = num;
							runtimeData.currentTime = 0f;
							runtimeData.bubbleGameObject = l.Result;
							runtimeData.dialogueBubbleGroupData = data;
							runtimeData.dialogueBubbleContentData = data2;
							component.BindBubbleObject(bubbleObject);
							component.BindChatBubbleGroupData(runtimeData);
							runtimeData.onSingleBubbleShow?.Invoke();
							if (!_mainLooper.IsValid())
							{
								_mainLooper = UpdateTimer.Default.LoopMs(500, UpdateBubbleGroupsInfo);
							}
						}
					}
				}
			}
			catch (Exception exception)
			{
				Debug.LogException(exception);
				CleanupFailedBubbleLoad(bubbleObject, runtimeData, l, null);
			}
		};
	}

	public void StopBubbleGroup(IBubbleObject bubbleObject, bool forceStopCycleBubble = true)
	{
		if (!_playingBubbleGroupDataDic.TryGetValue(bubbleObject, out var value) && !_waitCycleBubbleDic.TryGetValue(bubbleObject, out value))
		{
			return;
		}
		InstanceHandle bubbleInstanceHandle = value.bubbleInstanceHandle;
		value.bubbleInstanceHandle = null;
		if ((bool)value.bubbleGameObject)
		{
			value.bubbleGameObject.GetComponent<MonoChatBubble>()?.Reset();
			value.bubbleGameObject = null;
		}
		ReleaseBubbleInstanceHandle(bubbleInstanceHandle);
		try
		{
			value.onBubbleGroupComplete?.Invoke();
		}
		catch (Exception exception)
		{
			Debug.LogException(exception);
		}
		if (forceStopCycleBubble || value.dialogueBubbleGroupData == null || !value.dialogueBubbleGroupData.bubbleLoop)
		{
			_waitCycleBubbleDic.Remove(bubbleObject);
			_objectPool.Release(value);
		}
		else
		{
			_waitCycleBubbleDic[bubbleObject] = value;
			value.bubbleIndex = 1;
			value.totalTime = Mathf.Max(0f, 5f + (float)value.dialogueBubbleGroupData.bubbleLoopGap);
			value.currentTime = 0f;
			value.currentProcessingBubbleRemainTime = value.totalTime;
			value.bubbleGameObject = null;
			value.bubbleInstanceHandle = null;
			if (!_cycleLooper.IsValid())
			{
				_cycleLooper = UpdateTimer.Default.LoopMs(500, UpdateInCycleBubbleGroups);
			}
		}
		_playingBubbleGroupDataDic.Remove(bubbleObject);
		if (_playingBubbleGroupDataDic.Count == 0 && _mainLooper.IsValid())
		{
			_mainLooper.Cancel();
			_mainLooper = default;
		}
	}

	private void UpdateBubbleGroupsInfo()
	{
		List<IBubbleObject> list = ListPool<IBubbleObject>.Get();
		foreach (KeyValuePair<IBubbleObject, RuntimeChatBubbleGroupData> item in _playingBubbleGroupDataDic)
		{
			IBubbleObject key = item.Key;
			RuntimeChatBubbleGroupData value = item.Value;
			if (!value.IsValide)
			{
				continue;
			}
			value.currentProcessingBubbleRemainTime -= 0.5f;
			if (value.currentProcessingBubbleRemainTime <= (float)value.dialogueBubbleContentData.BubbleGapTime)
			{
				try
				{
					value.onSingleBubbleHide?.Invoke();
				}
				catch (Exception exception)
				{
					Debug.LogException(exception);
				}
			}
			value.currentTime += 0.5f;
			if (!(value.currentProcessingBubbleRemainTime <= 0f))
			{
				continue;
			}
			value.onSingleBubbleComplete?.Invoke(value.CurrentProcessingBubbleId);
			value.bubbleIndex++;
			if (value.bubbleIndex < value.dialogueBubbleGroupData.bubbleID.Length)
			{
				try
				{
					int id = value.dialogueBubbleGroupData.bubbleID[value.bubbleIndex];
					value.dialogueBubbleContentData = CoreUtils.GetData(id, RuntimeConfigs.data.dialogueBubbleContents);
					value.currentProcessingBubbleRemainTime = value.dialogueBubbleContentData.BubbleGapTime + value.dialogueBubbleContentData.BubbleShowTime;
					value.onSingleBubbleShow?.Invoke();
				}
				catch (Exception exception2)
				{
					Debug.LogException(exception2);
				}
			}
			else
			{
				list.Add(key);
				try
				{
					value.onBubbleGroupComplete?.Invoke();
				}
				catch (Exception exception3)
				{
					Debug.LogException(exception3);
				}
			}
		}
		foreach (IBubbleObject item2 in list)
		{
			StopBubbleGroup(item2, forceStopCycleBubble: false);
		}
		ListPool<IBubbleObject>.Release(list);
	}

	private void UpdateInCycleBubbleGroups()
	{
		List<IBubbleObject> list = ListPool<IBubbleObject>.Get();
		foreach (KeyValuePair<IBubbleObject, RuntimeChatBubbleGroupData> item in _waitCycleBubbleDic)
		{
			IBubbleObject key = item.Key;
			RuntimeChatBubbleGroupData value = item.Value;
			value.currentProcessingBubbleRemainTime -= 0.5f;
			value.currentTime += 0.5f;
			if (value.currentProcessingBubbleRemainTime <= 0f)
			{
				list.Add(key);
			}
		}
		foreach (IBubbleObject item2 in list)
		{
			if (_waitCycleBubbleDic.Remove(item2, out var value2))
			{
				try
				{
					StartBubbleGroup(item2, value2.dialogueBubbleGroupData.id, value2);
				}
				catch (Exception exception)
				{
					Debug.LogException(exception);
					_objectPool.Release(value2);
				}
			}
		}
		if (_waitCycleBubbleDic.Count == 0 && _cycleLooper.IsValid())
		{
			_cycleLooper.Cancel();
			_cycleLooper = default;
		}
		ListPool<IBubbleObject>.Release(list);
	}

	private bool IsCurrentBubbleLoad(IBubbleObject bubbleObject, RuntimeChatBubbleGroupData runtimeData, InstanceHandle handle)
	{
		if (handle != null && handle.IsValid && runtimeData != null && runtimeData.bubbleInstanceHandle == handle && _playingBubbleGroupDataDic.TryGetValue(bubbleObject, out var value))
		{
			return value == runtimeData;
		}
		return false;
	}

	private static void ReleaseBubbleInstanceHandle(InstanceHandle handle)
	{
		if (handle != null && handle.IsValid)
		{
			PrecacheManager.Instance.ReleaseInstanceHandle(handle);
		}
	}

	private void CleanupFailedBubbleLoad(IBubbleObject bubbleObject, RuntimeChatBubbleGroupData runtimeData, InstanceHandle handle, string warningMessage)
	{
		if (!string.IsNullOrEmpty(warningMessage))
		{
			Debug.LogWarning("[ChatBubbleModel] " + warningMessage);
		}
		bool num = _playingBubbleGroupDataDic.TryGetValue(bubbleObject, out var value) && value == runtimeData;
		ReleaseBubbleInstanceHandle(handle);
		if (num)
		{
			runtimeData.bubbleInstanceHandle = null;
			runtimeData.bubbleGameObject = null;
			_playingBubbleGroupDataDic.Remove(bubbleObject);
			_objectPool.Release(runtimeData);
		}
	}

	private static void ResetRuntimeChatBubbleGroupData(RuntimeChatBubbleGroupData toReset)
	{
		toReset.bubbleIndex = 0;
		toReset.totalTime = 0f;
		toReset.currentTime = 0f;
		toReset.currentProcessingBubbleRemainTime = 0f;
		toReset.onSingleBubbleShow = null;
		toReset.onSingleBubbleHide = null;
		toReset.onSingleBubbleComplete = null;
		toReset.onBubbleGroupComplete = null;
		toReset.bubbleGameObject = null;
		toReset.dialogueBubbleGroupData = null;
		toReset.dialogueBubbleContentData = null;
		toReset.bubbleInstanceHandle = null;
	}
}
