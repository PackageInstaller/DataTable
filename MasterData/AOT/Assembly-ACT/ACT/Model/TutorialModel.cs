using System.Collections.Generic;
using System.Linq;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.UI;
using ACT.Utility;
using Fundamental;
using UnityEngine;
using UnityEngine.Localization.Settings;

namespace ACT.Model;

public class TutorialModel : Model<TutorialModel>
{
	public class TutorialData
	{
		public int id;

		public TutorialType type;

		public string table;

		public int localizeId;

		public List<ItemKv> rewards;

		public int firstTriggerTs;

		private int firstReadTs;

		public bool defaultDisplay;

		public int FirstReadTs
		{
			get
			{
				return firstReadTs;
			}
			set
			{
				firstReadTs = value;
			}
		}

		public bool UnRead()
		{
			return firstReadTs == 0;
		}
	}

	public enum TutorialType
	{
		Battle = 1,
		Enemy,
		System,
		Explore
	}

	private const int latestTutorialNum = 5;

	private List<TutorialData> allTutorial;

	private Dictionary<TutorialType, List<TutorialData>> eachTypeTutorial;

	private int splitLineCellIndex;

	private readonly List<TutorialType> _tutorialTypes = new List<TutorialType>
	{
		TutorialType.Battle,
		TutorialType.Enemy,
		TutorialType.System,
		TutorialType.Explore
	};

	private List<int> readTutorialIds = new List<int>();

	public override ContextType ContextType => ContextType.NET;

	public int allTutorialCount
	{
		get
		{
			if (allTutorial == null)
			{
				return 0;
			}
			return allTutorial.Count;
		}
	}

	public int SplitLineCellIndex => splitLineCellIndex;

	public List<TutorialData> GetAllTutorial()
	{
		return allTutorial.ToList();
	}

	public List<TutorialData> GetOneTypeTutorial(TutorialType tutorialType)
	{
		if (eachTypeTutorial.TryGetValue(tutorialType, out var value))
		{
			return value.ToList();
		}
		return null;
	}

	public void GetContainsSearchTextTutorialTypeList(string searchText, out List<int> containsTutorialTypeList)
	{
		containsTutorialTypeList = new List<int> { 0 };
		if (string.IsNullOrEmpty(searchText))
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("搜索词为空，进到这就不合法了");
			}
			return;
		}
		foreach (KeyValuePair<TutorialType, List<TutorialData>> item in eachTypeTutorial)
		{
			foreach (TutorialData item2 in item.Value)
			{
				if (LocalizationSettings.StringDatabase.GetLocalizedString(item2.table, item2.localizeId, LocalizationSettings.ProjectLocale, FallbackBehavior.DontUseFallback, null).Contains(searchText))
				{
					containsTutorialTypeList.Add((int)item.Key);
				}
			}
		}
	}

	protected override void Init()
	{
		if (allTutorial == null)
		{
			allTutorial = new List<TutorialData>();
		}
		if (eachTypeTutorial == null)
		{
			eachTypeTutorial = new Dictionary<TutorialType, List<TutorialData>>();
			foreach (TutorialType tutorialType in _tutorialTypes)
			{
				if (tutorialType != TutorialType.Enemy)
				{
					eachTypeTutorial.Add(tutorialType, null);
				}
			}
		}
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.System_Open, OnTutorialSystemOpen);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.ReadTutorial, OnOneTutorialReaded);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.ReqRewardTutorial, OnReqRewardTutorial);
	}

	protected override void UnInit()
	{
		allTutorial.Clear();
		eachTypeTutorial.Clear();
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.System_Open, OnTutorialSystemOpen);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.ReadTutorial, OnOneTutorialReaded);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.ReqRewardTutorial, OnReqRewardTutorial);
	}

	public void MergeDataOnGuideLogsNtf(GuideLogs guideLogs)
	{
		foreach (var (id, guideItem2) in guideLogs.GuideItems)
		{
			GuideTutorial data = CoreUtils.GetData(id, RuntimeConfigs.data.guideTutorials);
			if (data != null)
			{
				allTutorial.Add(new TutorialData
				{
					id = id,
					type = (TutorialType)data.tutorialType,
					table = LocalizationUtility.localizeTableName_shortcommon,
					localizeId = data.tutorialTitle,
					firstTriggerTs = guideItem2.FirstTriggerTs,
					FirstReadTs = guideItem2.FirstReadTs,
					rewards = data.reward,
					defaultDisplay = (data.defaultDisplay == 1)
				});
			}
		}
		AddDefaultTutorial();
		ResortAllTutorial();
		RegisterTutorialRedDot();
	}

	public void RefreshOnGuideLogsNtf(GuideLogs guideLogs)
	{
		allTutorial.Clear();
		MergeDataOnGuideLogsNtf(guideLogs);
	}

	public void AddDefaultTutorial()
	{
		foreach (KeyValuePair<int, GuideTutorial> guideTutorial3 in RuntimeConfigs.data.guideTutorials)
		{
			var (id, guideTutorial2) = guideTutorial3;
			if (guideTutorial2.defaultDisplay == 1 && allTutorial.All((TutorialData data) => data.id != id))
			{
				allTutorial.Add(new TutorialData
				{
					id = id,
					type = (TutorialType)guideTutorial2.tutorialType,
					table = LocalizationUtility.localizeTableName_shortcommon,
					localizeId = guideTutorial2.tutorialTitle,
					firstTriggerTs = 0,
					FirstReadTs = 0,
					rewards = guideTutorial2.reward,
					defaultDisplay = (guideTutorial2.defaultDisplay == 1)
				});
			}
		}
	}

	public void ResortAllTutorial()
	{
		allTutorial.Sort((TutorialData x, TutorialData y) =>
		{
			GuideTutorial data = CoreUtils.GetData(x.id, RuntimeConfigs.data.guideTutorials);
			GuideTutorial data2 = CoreUtils.GetData(y.id, RuntimeConfigs.data.guideTutorials);
			int sort = data.sort;
			return sort.CompareTo(data2.sort);
		});
		List<TutorialData> list = (from data in allTutorial
			where data.UnRead()
			orderby data.id descending
			select data).ToList();
		List<TutorialData> collection = allTutorial.Except(list).ToList();
		allTutorial.Clear();
		allTutorial.AddRange(list);
		allTutorial.AddRange(collection);
		foreach (TutorialType type in _tutorialTypes)
		{
			if (type != TutorialType.Enemy)
			{
				eachTypeTutorial[type] = allTutorial.Where((TutorialData data) => data.type == type).ToList();
			}
		}
	}

	public bool CanTriggerTutorial(int tutorialId)
	{
		if (allTutorial == null)
		{
			return false;
		}
		return allTutorial.All((TutorialData data) => data.id != tutorialId);
	}

	public void TriggerTutorial(int guideTutorialId)
	{
		GuideTutorial data = CoreUtils.GetData(guideTutorialId, RuntimeConfigs.data.guideTutorials);
		if (data != null && allTutorial.All((TutorialData tutorialData) => tutorialData.id != guideTutorialId))
		{
			allTutorial.Add(new TutorialData
			{
				id = guideTutorialId,
				type = (TutorialType)data.tutorialType,
				table = LocalizationUtility.localizeTableName_shortcommon,
				localizeId = data.tutorialTitle,
				firstTriggerTs = TimeManager.ServerTime.NowTimestampSecond,
				FirstReadTs = 0,
				rewards = data.reward,
				defaultDisplay = (data.defaultDisplay == 1)
			});
			SendTutorialUnLockEvent(guideTutorialId);
			ResortAllTutorial();
			SetTutorialRedDot(guideTutorialId, active: false);
		}
	}

	private void SendTutorialUnLockEvent(int tutorialId)
	{
		TutorialUnLockEvent evt = Singleton<EventManager>.instance.GetEvt<TutorialUnLockEvent>();
		evt.TutorialId = tutorialId;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.TutorialUnlock, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	public void ReadTutorialLocal(int tutorialId)
	{
		TutorialData tutorialData = allTutorial.FirstOrDefault((TutorialData data) => data.id == tutorialId);
		if (tutorialData == null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("教程没有正确添加进alltutorial里，不能读教程");
			}
		}
		else if (tutorialData.UnRead())
		{
			tutorialData.FirstReadTs = TimeManager.ServerTime.NowTimestampSecond;
			readTutorialIds.TryAdd(tutorialId);
			SetTutorialRedDot(tutorialId, active: false);
		}
	}

	public void ReadTutorialReq()
	{
		List<int> list = readTutorialIds;
		if (list != null && list.Count > 0)
		{
			G.service.ReadTutorial(readTutorialIds, null);
			readTutorialIds.Clear();
		}
	}

	public bool HasUnReadTutorial()
	{
		if (allTutorial == null)
		{
			return false;
		}
		return allTutorial.Any((TutorialData data) => data.UnRead());
	}

	public bool TutorialIsUnRead(int tutorialId)
	{
		return allTutorial.Any((TutorialData data) => data.id == tutorialId && data.UnRead());
	}

	public bool RewardListContainsTutorial(int tutorialId)
	{
		return readTutorialIds.Any((int id) => id == tutorialId);
	}

	private void RegisterTutorialRedDot()
	{
		if (!Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.Tutorial))
		{
			return;
		}
		foreach (TutorialData item in allTutorial)
		{
			string nodeFullPath = RedDotPathDefine.TutorialUnRead + $"|{item.id}";
			if (!Singleton<RedDotManager>.instance.IsPathRegistered(nodeFullPath))
			{
				Singleton<RedDotManager>.instance.StaticRegisterInitTrieNode(nodeFullPath, item.UnRead(), 1019);
			}
			Singleton<RedDotManager>.instance.SetLeafNodeActive(nodeFullPath, item.UnRead());
		}
		RefreshRedDotOnCheck();
	}

	private void SetTutorialRedDot(int tutorialId, bool active)
	{
		if (Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.Tutorial))
		{
			string nodeFullPath = RedDotPathDefine.TutorialUnRead + $"|{tutorialId}";
			Singleton<RedDotManager>.instance.SetLeafNodeActive(nodeFullPath, active);
			RefreshRedDotOnCheck();
		}
	}

	private void OnTutorialSystemOpen(BaseEventContent obj)
	{
		if (obj is SystemOpenEvt { systemId: 1019 })
		{
			RegisterTutorialRedDot();
		}
	}

	private void OnOneTutorialReaded(BaseEventContent obj)
	{
		if (obj is ReadGuideTutorial readGuideTutorial)
		{
			ReadTutorialLocal(readGuideTutorial.ReadTutorialId);
		}
	}

	private void OnReqRewardTutorial(BaseEventContent obj)
	{
		if (obj is GuideTutorialAward guideTutorialAward && RewardListContainsTutorial(guideTutorialAward.RewardTutorialId))
		{
			ReadTutorialReq();
		}
	}

	public void RefreshRedDotOnCheck()
	{
		Dictionary<TutorialType, List<TutorialData>> dictionary = new Dictionary<TutorialType, List<TutorialData>>();
		foreach (TutorialData item in allTutorial)
		{
			if (dictionary.ContainsKey(item.type))
			{
				dictionary[item.type].Add(item);
				continue;
			}
			dictionary.Add(item.type, new List<TutorialData> { item });
		}
		foreach (List<TutorialData> value in dictionary.Values)
		{
			bool isShow = false;
			int id = 0;
			foreach (TutorialData item2 in value)
			{
				id = (int)item2.type;
				if (item2.UnRead())
				{
					isShow = true;
				}
			}
			SetToggleRedDot(id, isShow);
		}
	}

	public void SetToggleRedDot(int id, bool isShow)
	{
		switch (id)
		{
		case 0:
			if (Singleton<RedDotManager>.instance.IsPathRegistered(RedDotPathDefine.TutorialUnReadAll))
			{
				Singleton<RedDotManager>.instance.SetLeafNodeActive(RedDotPathDefine.TutorialUnReadAll, HasUnReadTutorial());
			}
			else
			{
				Singleton<RedDotManager>.instance.DynamicRegisterInitTrieNode(RedDotPathDefine.TutorialUnReadAll, HasUnReadTutorial());
			}
			break;
		case 1:
			if (Singleton<RedDotManager>.instance.IsPathRegistered(RedDotPathDefine.TutorialUnReadBattle))
			{
				Singleton<RedDotManager>.instance.SetLeafNodeActive(RedDotPathDefine.TutorialUnReadBattle, isShow);
			}
			else
			{
				Singleton<RedDotManager>.instance.DynamicRegisterInitTrieNode(RedDotPathDefine.TutorialUnReadBattle, isShow);
			}
			break;
		case 2:
			if (Singleton<RedDotManager>.instance.IsPathRegistered(RedDotPathDefine.TutorialUnReadMonster))
			{
				Singleton<RedDotManager>.instance.SetLeafNodeActive(RedDotPathDefine.TutorialUnReadMonster, isShow);
			}
			else
			{
				Singleton<RedDotManager>.instance.DynamicRegisterInitTrieNode(RedDotPathDefine.TutorialUnReadMonster, isShow);
			}
			break;
		case 3:
			if (Singleton<RedDotManager>.instance.IsPathRegistered(RedDotPathDefine.TutorialUnReadSystem))
			{
				Singleton<RedDotManager>.instance.SetLeafNodeActive(RedDotPathDefine.TutorialUnReadSystem, isShow);
			}
			else
			{
				Singleton<RedDotManager>.instance.DynamicRegisterInitTrieNode(RedDotPathDefine.TutorialUnReadSystem, isShow);
			}
			break;
		case 4:
			if (Singleton<RedDotManager>.instance.IsPathRegistered(RedDotPathDefine.TutorialUnReadExplore))
			{
				Singleton<RedDotManager>.instance.SetLeafNodeActive(RedDotPathDefine.TutorialUnReadExplore, isShow);
			}
			else
			{
				Singleton<RedDotManager>.instance.DynamicRegisterInitTrieNode(RedDotPathDefine.TutorialUnReadExplore, isShow);
			}
			break;
		}
	}
}
