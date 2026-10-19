using System;
using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model.Jump;
using ACT.UI;
using ACT.UI.DataProxy;
using ACT.Utility;
using Fundamental;
using Pb;
using UnityEngine.Localization;

namespace ACT.Model;

public class CardDrawModel : Model<CardDrawModel>, IJumpable
{
	public const int ShopId = 4;

	public GachaPoolDataNtf GachaPoolInfo;

	private NewbieConfig config;

	private int _NextOpenViewTabPoolSelectId;

	private bool _targetGachaReminderDisabled;

	public bool InCommunication;

	private Dictionary<int, GachaPoolEffectiveInfo> _gachaPoolEffectiveInfos = new Dictionary<int, GachaPoolEffectiveInfo>();

	private Gacha pooldata;

	public LuminModelType JumpSourceType => LuminModelType.Gacha;

	protected override void Init()
	{
		InitData();
		_gachaPoolEffectiveInfos.Clear();
		_targetGachaReminderDisabled = false;
		InCommunication = false;
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.ItemAdd, OnGachaItemChange);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.ItemMinus, OnMinusGachaItem);
	}

	private void OnMinusGachaItem(BaseEventContent obj)
	{
		if (obj is ItemUnifierProxyEvt itemUnifierProxyEvt && itemUnifierProxyEvt.data.ItemData != null && itemUnifierProxyEvt.data.ItemData.id == pooldata.token[0].id)
		{
			SetNewbiePoolRed();
		}
	}

	private void OnGachaItemChange(BaseEventContent obj)
	{
		if (obj is ItemUnifierProxyEvt itemUnifierProxyEvt && pooldata != null)
		{
			ItemUnifierProxy data = itemUnifierProxyEvt.data;
			if (pooldata != null && data.As<Item>().Id == pooldata.token[0].id)
			{
				SetNewbiePoolRed();
			}
		}
	}

	private void SetNewbiePoolRed()
	{
		string nodeFullPath = RedDotPathDefine.GaCha + $"|{pooldata.id}" + "|" + RedDotPathDefine.GaChaNewbiePool;
		Singleton<RedDotManager>.instance.SetLeafNodeActive(nodeFullPath, NewbiePoolAbundantProps(pooldata));
	}

	private Gacha GetNewbiePoolId()
	{
		Dictionary<int, Gacha> gachas = RuntimeConfigs.data.gachas;
		for (int i = 0; i < gachas.Count; i++)
		{
			if (gachas[i].gachaType == 5)
			{
				return gachas[i];
			}
		}
		return null;
	}

	protected override void UnInit()
	{
		_gachaPoolEffectiveInfos.Clear();
		_targetGachaReminderDisabled = false;
		InCommunication = false;
		pooldata = null;
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.ItemAdd, OnGachaItemChange);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.ItemMinus, OnMinusGachaItem);
	}

	public bool IsTargetGachaReminderDisabled()
	{
		return _targetGachaReminderDisabled;
	}

	public void SetTargetGachaReminderDisabled(bool disabled)
	{
		_targetGachaReminderDisabled = disabled;
	}

	public void SetNextSelectPoolId(int id)
	{
		_NextOpenViewTabPoolSelectId = id;
	}

	public int GetNextOpenViewTabPoolSelectId()
	{
		return _NextOpenViewTabPoolSelectId;
	}

	private void InitData()
	{
		InitNewbieConfig();
	}

	private void InitNewbieConfig()
	{
		Dictionary<int, Gacha> gachas = RuntimeConfigs.data.gachas;
		Gacha gacha = null;
		foreach (KeyValuePair<int, Gacha> item in gachas)
		{
			if (item.Value.gachaType == 1)
			{
				gacha = item.Value;
			}
			if (item.Value.gachaType == 5)
			{
				pooldata = item.Value;
			}
		}
		if (gacha != null)
		{
			config = JsonParser.ParseNewbieConfig(gacha.typeProperty);
		}
	}

	public bool CheckGachaPoolInTimeRange(int poolId)
	{
		if (_gachaPoolEffectiveInfos.TryGetValue(poolId, out var value))
		{
			Gacha data = CoreUtils.GetData(poolId, RuntimeConfigs.data.gachas);
			if (data != null && data.gachaType == 5)
			{
				bool flag = GetNewbiePool().TotalCount >= data.discountEligiblePulls;
				if (TimeManager.IsInTimeRange(value.BeginTimestamp, value.EndTimestamp, isMilliseconds: false) && value.State == GachaPoolState.Effective)
				{
					return !flag;
				}
				return false;
			}
			if (TimeManager.IsInTimeRange(value.BeginTimestamp, value.EndTimestamp, isMilliseconds: false))
			{
				return value.State == GachaPoolState.Effective;
			}
			return false;
		}
		return false;
	}

	public GachaResidentPool GetGachaResidentPool()
	{
		return Model<CardDrawModel>.Interface.GachaPoolInfo.PoolShareData.ResidentPool;
	}

	public GachaTestRoundTwoPool GetGachaTestRoundTwoPool()
	{
		return Model<CardDrawModel>.Interface.GachaPoolInfo.PoolShareData.TestRoundTwoPool;
	}

	public GachaLimitedUpPool GetLimitedUpPool()
	{
		return Model<CardDrawModel>.Interface.GachaPoolInfo.PoolShareData.LimitedUpPool;
	}

	public GachaLimitedGuaranteedPool GetLimitedGuaranteedPool()
	{
		return Model<CardDrawModel>.Interface.GachaPoolInfo.PoolShareData.LimitedGuaranteedPool;
	}

	public GachaNewbiePool GetNewbiePool()
	{
		return Model<CardDrawModel>.Interface.GachaPoolInfo.PoolShareData.NewbiePool;
	}

	public void InitGachaInfo(GachaPoolDataNtf info)
	{
		GachaPoolInfo = info;
		SetNewbiePathDefine();
		RegisterEffectivePoolRedDots();
	}

	private void RegisterEffectivePoolRedDots()
	{
		if (GachaPoolInfo == null)
		{
			return;
		}
		foreach (KeyValuePair<int, Gacha> gacha in RuntimeConfigs.data.gachas)
		{
			if (CheckGachaPoolInTimeRange(gacha.Value.id))
			{
				SetRedDotPathDefine(gacha.Value.id);
			}
		}
	}

	private void SetNewbiePathDefine()
	{
		if (!(GachaPoolInfo.PoolShareData.NewbiePool?.TotalCount >= pooldata.discountEligiblePulls))
		{
			string nodeFullPath = RedDotPathDefine.GaCha + $"|{pooldata.id}" + "|" + RedDotPathDefine.GaChaNewbiePool;
			Singleton<RedDotManager>.instance.StaticRegisterInitTrieNode(nodeFullPath, NewbiePoolAbundantProps(pooldata));
		}
	}

	private void SetRedDotPathDefine(int poolId)
	{
		string nodeFullPath = RedDotPathDefine.GaCha + $"|{poolId}";
		if (!Singleton<RedDotManager>.instance.IsPathRegistered(nodeFullPath))
		{
			Singleton<RedDotManager>.instance.StaticRegisterInitTrieNode(nodeFullPath);
		}
		string nodeFullPath2 = RedDotPathDefine.GaCha + $"|{poolId}" + "|" + RedDotPathDefine.GaChaReward;
		Gacha data = CoreUtils.GetData(poolId, RuntimeConfigs.data.gachas);
		if (data == null)
		{
			return;
		}
		if (data.finalGuarantNum != 0 && !Singleton<RedDotManager>.instance.IsPathRegistered(nodeFullPath2))
		{
			Singleton<RedDotManager>.instance.StaticRegisterInitTrieNode(nodeFullPath2, GetCurrentPoolCountForNotExchangeFinalGuaranteed(data.gachaType) >= data.finalGuarantNum);
		}
		if (data.milestonePull != 0)
		{
			string nodeFullPath3 = RedDotPathDefine.GaCha + $"|{poolId}" + "|" + RedDotPathDefine.GoMilestoneCanReward;
			GachaPoolUniqueData gachaPoolUniqueData = GetGachaPoolUniqueData(poolId);
			bool active = gachaPoolUniqueData != null && gachaPoolUniqueData.TotalCount >= data.milestonePull && !gachaPoolUniqueData.HasTakenMilestoneReward;
			if (!Singleton<RedDotManager>.instance.IsPathRegistered(nodeFullPath3))
			{
				Singleton<RedDotManager>.instance.StaticRegisterInitTrieNode(nodeFullPath3, active);
			}
		}
	}

	private void SetRedDotState(string Path, bool isactive)
	{
		Singleton<RedDotManager>.instance.SetLeafNodeActive(Path, isactive);
	}

	public bool NewbiePoolAbundantProps(Gacha gacaha)
	{
		bool flag = GachaPoolInfo.PoolShareData.NewbiePool?.TotalCount >= gacaha.discountEligiblePulls;
		if (G.localPlayer.Inventory.GetItemCount(gacaha.token[0].id) > 0)
		{
			return !flag;
		}
		return false;
	}

	public int GetCurrentPoolCountForNotExchangeFinalGuaranteed(int gachaType)
	{
		int result = 0;
		switch (gachaType)
		{
		case 1:
			result = GachaPoolInfo.PoolShareData.ResidentPool.CountForNotExchangeFinalGuaranteed;
			break;
		case 2:
			result = GachaPoolInfo.PoolShareData.LimitedGuaranteedPool.CountForNotExchangeFinalGuaranteed;
			break;
		case 3:
			result = GachaPoolInfo.PoolShareData.LimitedUpPool.CountForNotExchangeFinalGuaranteed;
			break;
		case 4:
			result = GachaPoolInfo.PoolShareData.TestRoundTwoPool.CountForNotExchangeFinalGuaranteed;
			break;
		}
		return result;
	}

	public bool GetCurrentFinalGuaranteed(int gachaType)
	{
		bool result = false;
		switch (gachaType)
		{
		case 1:
			result = GachaPoolInfo.PoolShareData.ResidentPool.ExchangedFinalGuaranteed;
			break;
		case 2:
			result = GachaPoolInfo.PoolShareData.LimitedGuaranteedPool.ExchangedFinalGuaranteed;
			break;
		case 3:
			result = GachaPoolInfo.PoolShareData.LimitedUpPool.ExchangedFinalGuaranteed;
			break;
		case 4:
			result = GachaPoolInfo.PoolShareData.TestRoundTwoPool.ExchangedFinalGuaranteed;
			break;
		}
		return result;
	}

	public void UpdateGachaTimeInfo(GachaPoolEffectiveInfoNtf info)
	{
		for (int i = 0; i < info.Info.Count; i++)
		{
			if (_gachaPoolEffectiveInfos.ContainsKey(info.Info[i].Id))
			{
				_gachaPoolEffectiveInfos[info.Info[i].Id] = info.Info[i];
			}
			else
			{
				_gachaPoolEffectiveInfos.Add(info.Info[i].Id, info.Info[i]);
			}
		}
		RegisterEffectivePoolRedDots();
	}

	public GachaPoolEffectiveInfo GetGachaEffectiveInfo(int poolId)
	{
		if (_gachaPoolEffectiveInfos.TryGetValue(poolId, out var value))
		{
			return value;
		}
		return null;
	}

	public void UpdateGachaInfo(GachaPoolShareDataChangeNtf info)
	{
		GaChaPoolType gaChaPoolType = GaChaPoolType.None;
		if (info.ChangeData.ResidentPool != null)
		{
			UpdateResidentPool(info.ChangeData.ResidentPool);
			gaChaPoolType = GaChaPoolType.Resident;
		}
		if (info.ChangeData.LimitedGuaranteedPool != null)
		{
			UpdateLimitedGuaranteedPool(info.ChangeData.LimitedGuaranteedPool);
			gaChaPoolType = GaChaPoolType.LimitGuranteed;
		}
		if (info.ChangeData.LimitedUpPool != null)
		{
			UpdateLimitedUpPool(info.ChangeData.LimitedUpPool);
			gaChaPoolType = GaChaPoolType.Limitup;
		}
		if (info.ChangeData.TestRoundTwoPool != null)
		{
			UpdateTestRoundTwoPool(info.ChangeData.TestRoundTwoPool);
			gaChaPoolType = GaChaPoolType.Test;
		}
		if (info.ChangeData.NewbiePool != null)
		{
			UpdateGachaNewbiePool(info.ChangeData.NewbiePool);
			gaChaPoolType = GaChaPoolType.Beginner;
		}
		if (info.PoolUnique != null)
		{
			UpdatePoolUnique(info.PoolUnique);
			string path = RedDotPathDefine.GaCha + $"|{info.PoolUnique.PoolId}" + "|" + RedDotPathDefine.GaChaReward;
			Gacha data = CoreUtils.GetData(info.PoolUnique.PoolId, RuntimeConfigs.data.gachas);
			if (data == null || data.finalGuarantNum != 0)
			{
				bool isactive = GetCurrentPoolCountForNotExchangeFinalGuaranteed(data.gachaType) >= data.finalGuarantNum;
				SetRedDotState(path, isactive);
			}
			if (data == null || data.milestonePull != 0)
			{
				string text = RedDotPathDefine.GaCha + $"|{info.PoolUnique.PoolId}" + "|" + RedDotPathDefine.GoMilestoneCanReward;
				bool flag = info.PoolUnique.TotalCount >= data.milestonePull && !info.PoolUnique.HasTakenMilestoneReward;
				if (Singleton<RedDotManager>.instance.IsPathRegistered(text))
				{
					SetRedDotState(text, flag);
				}
				else
				{
					Singleton<RedDotManager>.instance.StaticRegisterInitTrieNode(text, flag);
				}
			}
		}
		if (gaChaPoolType != GaChaPoolType.None)
		{
			GachaUpdateEvent evt = Singleton<EventManager>.instance.GetEvt<GachaUpdateEvent>();
			evt.GaChaPoolType = gaChaPoolType;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_GaChaPoolDataUpdate, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
		}
	}

	private void UpdatePoolUnique(GachaPoolUniqueData data)
	{
		if (GachaPoolInfo.PoolUniqueData.ContainsKey(data.PoolId))
		{
			GachaPoolInfo.PoolUniqueData[data.PoolId] = data;
		}
		else
		{
			GachaPoolInfo.PoolUniqueData.Add(data.PoolId, data);
		}
	}

	private void DispatchGachaTargetStateChanged(GachaPoolUniqueData data)
	{
		if (data != null)
		{
			GachaTargetStateChangedEvent evt = Singleton<EventManager>.instance.GetEvt<GachaTargetStateChangedEvent>();
			evt.GachaId = data.PoolId;
			evt.TargetGachaItemId = data.TargetGachaItemId;
			evt.TargetPoint = data.TargetPoint;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_GachaTargetStateChanged, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
		}
	}

	public GachaPoolUniqueData GetGachaPoolUniqueData(int poolId)
	{
		if (GachaPoolInfo?.PoolUniqueData == null)
		{
			return null;
		}
		if (GachaPoolInfo.PoolUniqueData.TryGetValue(poolId, out var value))
		{
			return value;
		}
		return null;
	}

	private void UpdateResidentPool(GachaResidentPool residentPool)
	{
		GachaPoolInfo.PoolShareData.ResidentPool = residentPool;
	}

	private void UpdateLimitedGuaranteedPool(GachaLimitedGuaranteedPool gachaLimitedGuaranteedPool)
	{
		GachaPoolInfo.PoolShareData.LimitedGuaranteedPool = gachaLimitedGuaranteedPool;
	}

	private void UpdateLimitedUpPool(GachaLimitedUpPool limitedUpPool)
	{
		GachaPoolInfo.PoolShareData.LimitedUpPool = limitedUpPool;
	}

	private void UpdateTestRoundTwoPool(GachaTestRoundTwoPool testRoundTwoPool)
	{
		GachaPoolInfo.PoolShareData.TestRoundTwoPool = testRoundTwoPool;
	}

	private void UpdateGachaNewbiePool(GachaNewbiePool newbiePool)
	{
		GachaPoolInfo.PoolShareData.NewbiePool = newbiePool;
	}

	public void SendGachaCardDraw(int gachaid, int count, Action<GachaCardDrawAck> callback = null, bool Beginner = false)
	{
		G.service.SendGachaCardDraw(gachaid, count, callback);
	}

	public void SendGachaExchangeTicket(int gachaid, int count, Action<GachaExchangeTicketAck> callback)
	{
		G.service.SendGachaExchangeTicket(gachaid, count, callback);
	}

	public void SendGachaQueryHistory(int type, int Page, Action<GachaQueryHistoryAck> callback)
	{
		G.service.SendGachaQueryHistory((GachaPoolType)type, Page, callback);
	}

	public void SendGachaExchangeFinalGuaranteed(int poolid, int gachaitemid, Action<GachaExchangeFinalGuaranteedAck> callback)
	{
		G.service.SendGachaExchangeFinalGuaranteed(poolid, gachaitemid, callback);
	}

	public void SendGachaTargetSelect(int gachaId, int targetGachaItemId, Action<GachaTargetSelectAck> callback)
	{
		G.service.SendGachaTargetSelect(gachaId, targetGachaItemId, (GachaTargetSelectAck ack) =>
		{
			if (ack?.PoolUnique != null)
			{
				UpdatePoolUnique(ack.PoolUnique);
				DispatchGachaTargetStateChanged(ack.PoolUnique);
			}
			callback?.Invoke(ack);
		});
	}

	public void SendGachaTargetCancel(int gachaId, Action<GachaTargetCancelAck> callback)
	{
		G.service.SendGachaTargetCancel(gachaId, (GachaTargetCancelAck ack) =>
		{
			if (ack?.PoolUnique != null)
			{
				UpdatePoolUnique(ack.PoolUnique);
				DispatchGachaTargetStateChanged(ack.PoolUnique);
			}
			callback?.Invoke(ack);
		});
	}

	public void SendGaChaExchangeMilestoneReward(int poolId, Action<GachaExchangeMilestoneRewardAck> callback)
	{
		G.service.SendGaChaExchangeMilestoneReward(poolId, callback);
	}

	public JumpResult CanJump(RuntimeJumpData jumpData)
	{
		if (Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.DrawCard) && CheckGachaPoolInTimeRange(jumpData.Params[1]))
		{
			return new JumpResult
			{
				ShowType = JumpResult.JumpShowType.CanJump
			};
		}
		return new JumpResult
		{
			ShowType = JumpResult.JumpShowType.Hide,
			Message = LocalizationUtility.GetLocalizeString(LocalizationCommonData.CommonString.CanNotGoTo)
		};
	}

	public void Jump(RuntimeJumpData jumpData)
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_CARDDRAW, new CardDrawViewData
		{
			PoolId = jumpData.Params[1]
		});
	}
}
