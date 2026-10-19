using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.UI;
using Fundamental;
using Pb;
using UnityEngine;
using UnityEngine.Localization.Settings;

namespace ACT.Model;

public class TextLibraryModel : Model<TextLibraryModel>
{
	public Dictionary<int, List<TextLibraryData>> textlibraryDatas;

	public Dictionary<int, bool> groupState;

	public List<ACT.Config.TextLibraryContent> unlockTextLibraryInOneAvg;

	public List<int> readTextLibraryIdList;

	public int lastUnLockTextLibraryId { get; set; }

	protected override void Init()
	{
		unlockTextLibraryInOneAvg = ListPool<ACT.Config.TextLibraryContent>.Get();
		textlibraryDatas = DictionaryPool<int, List<TextLibraryData>>.Get();
		readTextLibraryIdList = ListPool<int>.Get();
		groupState = DictionaryPool<int, bool>.Get();
		Singleton<TextLibraryManager>.CreateInstance();
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UnLockTextLibrary, OnUnLockTextLibrary);
	}

	public void UpdateTextLibrariesByNtf(VocabularyNtf ntf)
	{
		textlibraryDatas.Clear();
		groupState.Clear();
		foreach (KeyValuePair<int, bool> item2 in ntf.GroupState)
		{
			int key = item2.Key;
			groupState[key] = item2.Value;
		}
		foreach (KeyValuePair<int, ACT.Game.Data.TextLibraryContent> item3 in ntf.ContentInfo)
		{
			int contentId = item3.Key;
			int textLibraryType = GetTextLibraryType(item3.Key);
			TextLibrary textLibrary = RuntimeConfigs.data.textLibrarys.Values.FirstOrDefault((TextLibrary i) => i.content.Contains(contentId));
			if (textLibrary != null)
			{
				TextLibraryData item = new TextLibraryData(contentId, textLibrary.id, textLibraryType, item3.Value.IsRead, item3.Value.UnlockTime);
				if (!textlibraryDatas.ContainsKey(textLibrary.id))
				{
					textlibraryDatas[textLibrary.id] = new List<TextLibraryData>();
				}
				textlibraryDatas[textLibrary.id].Add(item);
			}
		}
		RegisterOrRefreshTextLibraryDot();
	}

	public void RegisterOrRefreshTextLibraryDot()
	{
		if (!Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.TextLibrary))
		{
			return;
		}
		foreach (KeyValuePair<int, List<TextLibraryData>> textlibraryData in textlibraryDatas)
		{
			string nodeFullPath = ((CoreUtils.GetData(textlibraryData.Key, RuntimeConfigs.data.textLibrarys).tabId == 1) ? RedDotPathDefine.TextLibrary : RedDotPathDefine.ViewPort) + $"|{textlibraryData.Key}";
			if (!Singleton<RedDotManager>.instance.IsPathRegistered(nodeFullPath))
			{
				Singleton<RedDotManager>.instance.StaticRegisterInitTrieNode(nodeFullPath, GroupHasUnReadTextLibrary(textlibraryData.Key), 1046);
			}
			else
			{
				Singleton<RedDotManager>.instance.SetLeafNodeActive(nodeFullPath, GroupHasUnReadTextLibrary(textlibraryData.Key));
			}
		}
	}

	protected override void UnInit()
	{
		DictionaryPool<int, bool>.Release(groupState);
		ListPool<ACT.Config.TextLibraryContent>.Release(unlockTextLibraryInOneAvg);
		ListPool<int>.Release(readTextLibraryIdList);
		DictionaryPool<int, List<TextLibraryData>>.Release(textlibraryDatas);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UnLockTextLibrary, OnUnLockTextLibrary);
		lastUnLockTextLibraryId = 0;
		Singleton<TextLibraryManager>.instance.UnInit();
	}

	private void OnUnLockTextLibrary(BaseEventContent obj)
	{
		if (obj is UnLockTextLibraries { unlockTextLibraries: { Count: >0 } } unLockTextLibraries)
		{
			UnlockTextLibraries(unLockTextLibraries.unlockTextLibraries, unLockTextLibraries.isFromAVG, unLockTextLibraries.isFromAVGSkip);
		}
	}

	public TextLibrary GetTextLibraryGroupData(int textLibraryId)
	{
		foreach (TextLibrary value in RuntimeConfigs.data.textLibrarys.Values)
		{
			if (value.content.Contains(textLibraryId))
			{
				return value;
			}
		}
		return null;
	}

	public int GetTextLibraryType(int textLibraryId)
	{
		return GetTextLibraryGroupData(textLibraryId)?.tabId ?? 0;
	}

	public List<TextLibrary> GetTextLibraryGroupsByType(int textLibraryType)
	{
		List<TextLibrary> list = new List<TextLibrary>();
		foreach (int key in textlibraryDatas.Keys)
		{
			TextLibrary data = CoreUtils.GetData(key, RuntimeConfigs.data.textLibrarys);
			if (data.tabId == textLibraryType)
			{
				list.Add(data);
			}
		}
		return list;
	}

	public List<TextLibraryData> GetTextLibraryDataListByGroupId(int textLibraryGroupId)
	{
		if (textlibraryDatas.TryGetValue(textLibraryGroupId, out var value))
		{
			return value;
		}
		return null;
	}

	public bool GroupContainsSearchTraget(int groupDataId, string searchText)
	{
		if (textlibraryDatas.TryGetValue(groupDataId, out var value))
		{
			foreach (TextLibraryData item in value)
			{
				if (TextLibraryDatasContainsSearchTraget(item, searchText))
				{
					return true;
				}
			}
		}
		return false;
	}

	public bool TextLibraryDatasContainsSearchTraget(TextLibraryData targetTextLibrary, string searchText)
	{
		if (targetTextLibrary == null)
		{
			return false;
		}
		ACT.Config.TextLibraryContent data = CoreUtils.GetData(targetTextLibrary.contentId, RuntimeConfigs.data.textLibraryContents);
		if (data == null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"id:{targetTextLibrary.contentId}的词条，文本库词条组里配了，词条表里没有，检查配表");
			}
			return false;
		}
		string localizedString = LocalizationSettings.StringDatabase.GetLocalizedString("shortcommon", data.titleName, LocalizationSettings.ProjectLocale, FallbackBehavior.DontUseFallback, null);
		if (!string.IsNullOrEmpty(localizedString))
		{
			return localizedString.Contains(searchText);
		}
		return false;
	}

	public void UnlockTextLibraries(List<int> ids, bool unLockFromAvg, bool isSkipAvgTextLibraryData, Action callBack = null)
	{
		for (int num = ids.Count - 1; num >= 0; num--)
		{
			if (TextLibraryIsUnLock(ids[num]))
			{
				ids.Remove(ids[num]);
			}
			else if (!TextLibraryCanInclude(ids[num]))
			{
				ids.Remove(ids[num]);
			}
		}
		if (ids == null || ids.Count <= 0)
		{
			return;
		}
		G.service.SendUnlockTextLibraryReq(ids, (VocabularyUnlockContentAck ack, bool b) =>
		{
			if (b && ack != null)
			{
				foreach (KeyValuePair<int, bool> item2 in ack.GroupState)
				{
					groupState[item2.Key] = item2.Value;
					CoreUtils.GetData(item2.Key, RuntimeConfigs.data.textLibrarys);
					if (!textlibraryDatas.ContainsKey(item2.Key))
					{
						textlibraryDatas[item2.Key] = new List<TextLibraryData>();
					}
				}
				foreach (KeyValuePair<int, ACT.Game.Data.TextLibraryContent> item3 in ack.ContentInfo)
				{
					int contentId = item3.Key;
					TextLibrary textLibraryGroupData = GetTextLibraryGroupData(contentId);
					if (textLibraryGroupData != null)
					{
						if (textlibraryDatas[textLibraryGroupData.id].FirstOrDefault((TextLibraryData i) => i.contentId == contentId) == null)
						{
							int textLibraryType = GetTextLibraryType(contentId);
							TextLibraryData item = new TextLibraryData(contentId, textLibraryGroupData.id, textLibraryType, isRead: false, item3.Value.UnlockTime);
							textlibraryDatas[textLibraryGroupData.id].Add(item);
							if (unLockFromAvg)
							{
								unlockTextLibraryInOneAvg.Add(CoreUtils.GetData(contentId, RuntimeConfigs.data.textLibraryContents));
							}
						}
					}
					else if (LuminApplication.LogEnabled)
					{
						Debug.LogError($"id为{contentId} 所属的词条组找不到");
					}
				}
				RegisterOrRefreshTextLibraryDot();
				TextLibraryModel textLibraryModel = this;
				List<int> list = ids;
				textLibraryModel.lastUnLockTextLibraryId = list[list.Count - 1];
				if (unLockFromAvg)
				{
					PopUpTextLibraryTip evt = Singleton<EventManager>.instance.GetEvt<PopUpTextLibraryTip>();
					Singleton<EventManager>.instance.EventDispatch(ClientEvent.UnlockOnAvgPopTip, evt);
					Singleton<EventManager>.instance.ReleaseEvt(evt);
				}
				callBack?.Invoke();
			}
		});
	}

	public void SetTextLibraryIsRead()
	{
		if (readTextLibraryIdList.Count == 0)
		{
			return;
		}
		G.service.SendTextLibraryReadReq(readTextLibraryIdList, (bool b) =>
		{
			if (b)
			{
				foreach (int id in readTextLibraryIdList)
				{
					TextLibrary textLibraryGroupData = GetTextLibraryGroupData(id);
					if (textLibraryGroupData != null && textlibraryDatas.TryGetValue(textLibraryGroupData.id, out var value))
					{
						TextLibraryData textLibraryData = value.FirstOrDefault((TextLibraryData i) => i.contentId == id);
						if (textLibraryData == null)
						{
							if (LuminApplication.LogEnabled)
							{
								Debug.LogError($"阅读了一个没解锁的词条，是非法的，检查 id:{textLibraryData.contentId}的词条为什么没解锁");
							}
						}
						else if (!textLibraryData.isRead)
						{
							textLibraryData.isRead = true;
						}
					}
				}
				readTextLibraryIdList.Clear();
			}
		});
	}

	public void SyncTextLibrariesGroupState()
	{
		G.service.SendTextLibraryGroupState(groupState, (bool b) =>
		{
			if (!b && LuminApplication.LogEnabled)
			{
				Debug.LogError("词条组展开状态协议同步失败");
			}
		});
	}

	public void GetMatchSearchTextLibraryTypeIds(string search, out List<int> result)
	{
		result = new List<int>();
		foreach (List<TextLibraryData> value in textlibraryDatas.Values)
		{
			foreach (TextLibraryData item in value)
			{
				if (TextLibraryDatasContainsSearchTraget(item, search))
				{
					result.Add(item.belongParentId);
				}
			}
		}
		result.Sort((int x, int y) => x.CompareTo(y));
	}

	public bool TextLibraryIsUnLock(int textLibraryId)
	{
		TextLibrary textLibraryGroupData = GetTextLibraryGroupData(textLibraryId);
		if (textLibraryGroupData == null)
		{
			return false;
		}
		if (textlibraryDatas.TryGetValue(textLibraryGroupData.id, out var value))
		{
			return value.Any((TextLibraryData i) => i.contentId == textLibraryId);
		}
		return false;
	}

	public bool TextLibraryIsRead(int textLibraryId)
	{
		TextLibrary textLibraryGroupData = GetTextLibraryGroupData(textLibraryId);
		if (textLibraryGroupData == null)
		{
			return false;
		}
		if (textlibraryDatas.TryGetValue(textLibraryGroupData.id, out var value))
		{
			foreach (TextLibraryData item in value)
			{
				if (item.contentId == textLibraryId)
				{
					return item.isRead;
				}
			}
		}
		return false;
	}

	public bool GroupHasUnReadTextLibrary(int groupId)
	{
		if (textlibraryDatas.TryGetValue(groupId, out var value))
		{
			return value.Any((TextLibraryData i) => !i.isRead);
		}
		return false;
	}

	public bool TypeHasUnReadTextLibrary(int typeId)
	{
		foreach (int key in textlibraryDatas.Keys)
		{
			if (GroupHasUnReadTextLibrary(key))
			{
				return true;
			}
		}
		return false;
	}

	public bool GetTextLibraryGroupState(int textGroupId)
	{
		if (groupState.TryGetValue(textGroupId, out var value))
		{
			return value;
		}
		return false;
	}

	private bool TextLibraryCanInclude(int textLibraryId)
	{
		return RuntimeConfigs.data.textLibrarys.Values.Any((TextLibrary i) => i.content.Contains(textLibraryId));
	}
}
