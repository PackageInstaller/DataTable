using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.Net;
using ACT.RichText;
using ACT.UI;
using ACT.Utility;
using Cysharp.Threading.Tasks;
using Cysharp.Threading.Tasks.Linq;
using Fundamental;
using Google.Protobuf;
using Google.Protobuf.Collections;
using Pb;
using Runtime.WaitSort;
using UnityEngine;

namespace ACT;

public class SystemUnlockManager : Singleton<SystemUnlockManager>
{
	public static long operationTs;

	private Dictionary<int, bool> m_SystemClientStatus;

	private PreconditionInfoManager m_PreconditionInfoManager;

	public List<int> missionLevels;

	private HashSet<int> _readSystemIds;

	private IDisposable _update;

	private bool _isInitialized;

	private float _countingTime;

	public Queue<UiViewDataContent> SystemUnlockUiEvt = new Queue<UiViewDataContent>();

	public override ContextType ContextType => ContextType.GLOBAL;

	public static int playerLevel
	{
		get
		{
			if (G.detailUserInfo != null && G.detailUserInfo.Attributes.TryGetValue(90, out var value))
			{
				return (int)value;
			}
			return 1;
		}
	}

	public static int worldLevel => 1;

	public override void Init()
	{
		if (_isInitialized)
		{
			return;
		}
		m_PreconditionInfoManager = Singleton<PreconditionInfoManager>.instance;
		m_SystemClientStatus = DictionaryPool<int, bool>.Get();
		missionLevels = ListPool<int>.Get();
		_readSystemIds = HashSetPool<int>.Get();
		foreach (KeyValuePair<int, SystemOpen> systemOpen in RuntimeConfigs.data.systemOpens)
		{
			m_SystemClientStatus[systemOpen.Key] = true;
		}
		EventManager eventManager = Singleton<EventManager>.instance;
		eventManager.AddEventListener(ClientEvent.Mission_Finish, CheckSystem);
		eventManager.AddEventListener(ClientEvent.SubMission_Pass, CheckSystem);
		eventManager.AddEventListener(ClientEvent.SubMission_Finish, CheckSystem);
		eventManager.AddEventListener(ClientEvent.PlayLevel_Change, CheckSystem);
		eventManager.AddEventListener(ClientEvent.Scene_Change_Complete, CheckSystem);
		eventManager.AddEventListener(ClientEvent.PlayerWorldLevel_Change, CheckSystem);
		eventManager.AddEventListener(ClientEvent.PlayLevel_Change, GenAdventureRewardInfos);
		eventManager.AddEventListener(ClientEvent.BagItemChange, CheckSystem);
		eventManager.AddEventListener(ClientEvent.Game_Over, OnClearData);
		GenAdventureRewardInfos(null);
		_update = UniTaskAsyncEnumerable.EveryUpdate().Subscribe((Action<AsyncUnit>)OnUpdate);
		_isInitialized = true;
	}

	private void OnUpdate(AsyncUnit _)
	{
		NewUIManager newUIManager = Singleton<NewUIManager>.instance;
		if (newUIManager == null)
		{
			_countingTime = 0f;
			return;
		}
		GameState gameState = Singleton<GameState>.instance;
		if (SystemUnlockUiEvt.Count <= 0)
		{
			if (gameState.InSystemUnlock)
			{
				gameState.SetInSystemUnLock(inUnlock: false);
			}
			return;
		}
		UIState firstUIState = newUIManager.GetFirstUIState(UI_TYPE.UI_POPUPSYSTEMUNLOCK);
		if (gameState.InSystemUnlock && (firstUIState == UIState.Closing || firstUIState == UIState.Closed || firstUIState == UIState.None))
		{
			if (SystemUnlockUiEvt.Count <= 0)
			{
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.SystemUnLockHudOver, null);
			}
			gameState.SetInSystemUnLock(inUnlock: false);
		}
		UIState firstUIState2 = newUIManager.GetFirstUIState(UI_TYPE.UI_BATTLEMAIN);
		UIState firstUIState3 = newUIManager.GetFirstUIState(UI_TYPE.UI_GUIDEIMAGEVIDEO);
		BattleMainModel battleMainModel = Model<BattleMainModel>.Interface;
		if (battleMainModel == null)
		{
			return;
		}
		HudType hudType = battleMainModel.hudType;
		if (!SystemUnlockQueueIsEmpty() && firstUIState2 == UIState.Opened && !gameState.InGuiding && MonoECS.instance.playState == PlayState.UnBattle && (firstUIState == UIState.None || firstUIState == UIState.Closed) && (firstUIState3 == UIState.None || firstUIState3 == UIState.Closed) && !newUIManager.IsActivePanelBusy() && hudType == HudType.MainWorldType)
		{
			if (_countingTime > 0.1f)
			{
				OpenPopupSystemUnlockView();
			}
			_countingTime += Time.deltaTime;
		}
		else
		{
			_countingTime = 0f;
		}
	}

	public override void UnInit()
	{
		if (_isInitialized)
		{
			_isInitialized = false;
			_update?.Dispose();
			_update = null;
			if (m_SystemClientStatus != null)
			{
				DictionaryPool<int, bool>.Release(m_SystemClientStatus);
			}
			if (missionLevels != null)
			{
				ListPool<int>.Release(missionLevels);
			}
			if (_readSystemIds != null)
			{
				HashSetPool<int>.Release(_readSystemIds);
			}
			m_SystemClientStatus = null;
			missionLevels = null;
			_readSystemIds = null;
			m_PreconditionInfoManager = null;
			_countingTime = 0f;
			SystemUnlockUiEvt.Clear();
			EventManager eventManager = Singleton<EventManager>.instance;
			eventManager.RemoveEventListener(ClientEvent.Mission_Finish, CheckSystem);
			eventManager.RemoveEventListener(ClientEvent.SubMission_Pass, CheckSystem);
			eventManager.RemoveEventListener(ClientEvent.SubMission_Finish, CheckSystem);
			eventManager.RemoveEventListener(ClientEvent.PlayLevel_Change, CheckSystem);
			eventManager.RemoveEventListener(ClientEvent.Scene_Change_Complete, CheckSystem);
			eventManager.RemoveEventListener(ClientEvent.PlayerWorldLevel_Change, CheckSystem);
			eventManager.RemoveEventListener(ClientEvent.PlayLevel_Change, GenAdventureRewardInfos);
			eventManager.RemoveEventListener(ClientEvent.BagItemChange, CheckSystem);
			eventManager.RemoveEventListener(ClientEvent.Game_Over, OnClearData);
		}
	}

	public bool IsCheckMission(int missionId)
	{
		RepeatedField<MissionState> repeatedField = G.localPlayer?.Missions;
		if (repeatedField == null)
		{
			return false;
		}
		for (int i = 0; i < repeatedField.Count; i++)
		{
			MissionState missionState = repeatedField[i];
			if (missionState.Id == missionId)
			{
				return missionState.Finished;
			}
		}
		return false;
	}

	public bool IsHasItem(int itemId)
	{
		Item item = G.localPlayer?.Inventory?.GetItemInfo(itemId);
		if (item != null)
		{
			return item.Count > 0;
		}
		return false;
	}

	public bool IsUnlock(int nSystemUnLockId)
	{
		if (Singleton<SystemBlockManager>.instance.IsBlocked(nSystemUnLockId))
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.Log($"GM block this system: {nSystemUnLockId}");
			}
			return false;
		}
		if (CoreUtils.GetData(nSystemUnLockId, RuntimeConfigs.data.systemOpens) == null)
		{
			_ = LuminApplication.LogEnabled;
			return true;
		}
		if (G.localPlayer != null)
		{
			Player localPlayer = G.localPlayer;
			bool value = default;
			return (localPlayer != null && localPlayer.OpenSystems?.Contains(nSystemUnLockId) == true && m_SystemClientStatus != null && m_SystemClientStatus.TryGetValue(nSystemUnLockId, out value)) & value;
		}
		return true;
	}

	public bool IsSystemUnlock(SystemType systemType)
	{
		return IsUnlock((int)systemType);
	}

	public bool IsSystemUnlock(int systemTypeId)
	{
		return IsUnlock(systemTypeId);
	}

	public void ShowUnlockTip(int nFunctionUnlockID)
	{
		if (!RuntimeConfigs.data.systemOpens.TryGetValue(nFunctionUnlockID, out var value) || value == null)
		{
			_ = LuminApplication.LogEnabled;
		}
		else
		{
			GameUtility.OpenToolTip(value.descriptionBefore);
		}
	}

	public bool IsUnlock(List<ItemKv> itemKvs, bool withUI = false)
	{
		if (itemKvs == null || itemKvs.Count == 0)
		{
			return true;
		}
		foreach (ItemKv itemKv in itemKvs)
		{
			if (!IsUnlock(itemKv, withUI))
			{
				return false;
			}
		}
		return true;
	}

	public bool IsUnlock(ItemKv itemKv, bool withUI = false)
	{
		if (itemKv == null)
		{
			return true;
		}
		int count = itemKv.count;
		Dictionary<int, PreconditionInfo> dictionary = m_PreconditionInfoManager?.preconditionInfos;
		if (dictionary == null || !dictionary.ContainsKey(itemKv.id))
		{
			string text;
			if (!RuntimeConfigs.data.preconditions.TryGetValue(itemKv.id, out var value) || value == null)
			{
				int id = itemKv.id;
				text = id.ToString();
			}
			else
			{
				text = value.intro;
			}
			string text2 = text;
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("无法解析的功能解锁类型=>" + text2);
			}
			return true;
		}
		bool flag = m_PreconditionInfoManager.IsComplete(itemKv.id, itemKv.count);
		if (flag || !withUI)
		{
			return flag;
		}
		string item;
		if (itemKv.id == 1)
		{
			MissionBase data = CoreUtils.GetData(count, RuntimeConfigs.data.missionBases);
			item = ((data != null) ? LocalizationUtility.GetLocalizeString("shortcommon", data.name) : count.ToString());
		}
		else
		{
			item = count.ToString();
		}
		if (!RuntimeConfigs.data.preconditions.TryGetValue(itemKv.id, out var value2) || value2 == null)
		{
			return false;
		}
		GameUtility.OpenToolTip(value2.desId, "longcommon", new List<string> { item });
		return false;
	}

	public bool SystemUnlockUiEvtHasContent()
	{
		return SystemUnlockUiEvt.Count > 0;
	}

	private void CheckSystem(BaseEventContent e)
	{
		GameUtility.CheckRefreshLegendMissionRedDot();
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.PreconditionFinsh, null);
	}

	public void OnSystemOpenAdd(int systemId)
	{
		SystemOpenEvt evt = Singleton<EventManager>.instance.GetEvt<SystemOpenEvt>();
		evt.systemId = systemId;
		evt.unLock = true;
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.System_Open, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
		SystemOpen data = CoreUtils.GetData(systemId, RuntimeConfigs.data.systemOpens);
		if (data != null && data.isNeedAnimal && GameUtility.gameLoader.IsNetMode)
		{
			GameUtility.CheckRefreshLegendMissionRedDot();
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.PreconditionFinsh, null);
			CheckIsShowPopupSystemUnlockView(systemId, data);
		}
	}

	public void ClientLockSystem(int lockId)
	{
		if (m_SystemClientStatus.ContainsKey(lockId))
		{
			m_SystemClientStatus[lockId] = false;
			CheckSystem(null);
		}
		else if (LuminApplication.LogEnabled)
		{
			Debug.LogWarning($"客户端没有这个系统{lockId}");
		}
	}

	public void ClientUnLockSystem(int openId)
	{
		if (m_SystemClientStatus.ContainsKey(openId))
		{
			m_SystemClientStatus[openId] = true;
			CheckSystem(null);
		}
		else if (LuminApplication.LogEnabled)
		{
			Debug.LogWarning($"客户端没有这个系统{openId}");
		}
	}

	private void GenAdventureRewardInfos(BaseEventContent obj)
	{
		missionLevels.Clear();
		int playerMaxLevel = RuntimeConfigs.data.game.playerMaxLevel;
		for (int i = 2; i <= playerMaxLevel; i++)
		{
			PlayerLevelData playerLevelData = RuntimeConfigs.data.playerLevelDatas[i];
			missionLevels.Add(i);
			if (!IsUnlock(playerLevelData.preconditionParam))
			{
				missionLevels.Add(-i);
			}
		}
	}

	public void CheckIsShowPopupSystemUnlockView(int systemId, SystemOpen tableData)
	{
		if (tableData.isNeedAnimal)
		{
			UiViewDataContent evt = Singleton<EventManager>.instance.GetEvt<UiViewDataContent>();
			evt.uiViewData = new PopupSystemUnlockViewData
			{
				systemId = systemId,
				openTime = tableData.openTime,
				missionId = tableData.missionId
			};
			if (!SystemUnlockUiEvt.Contains(evt))
			{
				SystemUnlockUiEvt.Enqueue(evt);
			}
		}
	}

	private void OpenPopupSystemUnlockView()
	{
		if (SystemUnlockUiEvt.Count > 1)
		{
			SortBySystemId(SystemUnlockUiEvt);
		}
		if (SystemUnlockUiEvt.Peek().uiViewData is PopupSystemUnlockViewData popupSystemUnlockViewData)
		{
			if (SystemHudIsOpened(popupSystemUnlockViewData.systemId))
			{
				SystemUnlockUiEvt.Dequeue();
			}
			else if (!Singleton<GameState>.instance.InSystemUnlock)
			{
				Singleton<GameState>.instance.SetInSystemUnLock(inUnlock: true);
				Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPSYSTEMUNLOCK, popupSystemUnlockViewData);
			}
		}
	}

	public void SortBySystemId(Queue<UiViewDataContent> queue)
	{
		if (queue == null || queue.Count <= 1)
		{
			return;
		}
		List<UiViewDataContent> list = ListPool<UiViewDataContent>.Get();
		try
		{
			foreach (UiViewDataContent item in queue)
			{
				list.Add(item);
			}
			for (int i = 1; i < list.Count; i++)
			{
				UiViewDataContent uiViewDataContent = list[i];
				int systemUnlockOpenTime = GetSystemUnlockOpenTime(uiViewDataContent);
				int num = i - 1;
				while (num >= 0 && GetSystemUnlockOpenTime(list[num]) > systemUnlockOpenTime)
				{
					list[num + 1] = list[num];
					num--;
				}
				list[num + 1] = uiViewDataContent;
			}
			queue.Clear();
			for (int j = 0; j < list.Count; j++)
			{
				queue.Enqueue(list[j]);
			}
		}
		finally
		{
			ListPool<UiViewDataContent>.Release(list);
		}
	}

	private static int GetSystemUnlockOpenTime(UiViewDataContent evt)
	{
		if (!(evt?.uiViewData is PopupSystemUnlockViewData popupSystemUnlockViewData))
		{
			return int.MaxValue;
		}
		return popupSystemUnlockViewData.openTime;
	}

	public bool SystemUnlockQueueIsEmpty()
	{
		return SystemUnlockUiEvt.Count <= 0;
	}

	private void OnClearData(BaseEventContent obj)
	{
		Singleton<GameState>.instance.SetInSystemUnLock(inUnlock: false);
		SystemUnlockUiEvt.Clear();
		_readSystemIds?.Clear();
	}

	public bool SystemHudIsOpened(int systemId)
	{
		return _readSystemIds?.Contains(systemId) ?? false;
	}

	public void OnSystemReadAdd(int systemId)
	{
		_readSystemIds?.Add(systemId);
	}

	public void SendReadSystemUnLockReq(int systemId)
	{
		SystemReadDoneReq data = new SystemReadDoneReq
		{
			Id = systemId
		};
		Singleton<NetManager>.instance.Request(data, (IMessage msg) =>
		{
			if (msg is SystemReadDoneAck systemReadDoneAck)
			{
				OnSystemReadAdd(systemReadDoneAck.Id);
			}
		});
	}

	public string GetSystemLockTips(SystemType systemType)
	{
		if (!RuntimeConfigs.data.systemOpens.TryGetValue((int)systemType, out var value))
		{
			return string.Empty;
		}
		if (!RuntimeConfigs.data.missionGroups.TryGetValue(value.missionId, out var value2) || value2.missionId == null || value2.missionId.Length == 0)
		{
			return string.Empty;
		}
		if (!RuntimeConfigs.data.missions.TryGetValue(value2.missionId[0], out var value3))
		{
			return string.Empty;
		}
		return CustomTagParser.ReplacePreconditionText(value3, value3.number, value3.param);
	}
}
