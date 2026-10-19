using System;
using System.Collections.Generic;
using ACT;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using Fundamental;
using Pb;

namespace Runtime.Model.PowerModel;

public class PowerModel : Model<PowerModel>
{
	public Action OnPowerChanged;

	private bool m_NeedRecover;

	private long m_NextTime;

	private long m_Interval;

	public const int PowerToCoinId = 111;

	public const int PowerToSkillExp = 113;

	public const int PowerToEquipExp = 114;

	public const int PowerToBattleExp = 115;

	public const int PowerExchangeStep = 10;

	public const int PowerConvertPercentBase = 100;

	public static readonly IReadOnlyDictionary<int, int> PowerExchangeAttributeIds = new Dictionary<int, int>
	{
		{ 1, 111 },
		{ 2, 115 },
		{ 3, 113 },
		{ 4, 114 }
	};

	public readonly Dictionary<int, int> ItemIdToExchangeTableId = new Dictionary<int, int>();

	public int PowerCount { get; private set; }

	public long NextRecoverTime => m_NextTime;

	public long recoverToMaxTime => CalRecoverPowerToMaxTime();

	public bool IsItemPowerExchangeUnlocked(int itemId)
	{
		if (itemId <= 0 || !ItemIdToExchangeTableId.TryGetValue(itemId, out var value))
		{
			return false;
		}
		return Model<HandBookModel>.Interface.IsPowerExchangeTabUnlock(value);
	}

	protected override void Init()
	{
		PowerCount = (int)G.detailUserInfo.Attributes[96];
		m_Interval = RuntimeConfigs.data.game.recoveryRule.id * 1000;
		m_NextTime = G.localPlayer.Profile.PowerRecoverTs + m_Interval;
		m_NeedRecover = PowerCount < RuntimeConfigs.data.game.powerLimit;
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_PlayerAttribute_Refresh, OnRefresh);
		foreach (KeyValuePair<int, ExchangeItem> exchangeItem in RuntimeConfigs.data.ExchangeItems)
		{
			ItemIdToExchangeTableId[exchangeItem.Value.itemId] = exchangeItem.Key;
		}
	}

	protected override void UnInit()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_PlayerAttribute_Refresh, OnRefresh);
		PowerCount = 0;
		m_Interval = 0L;
		m_NextTime = 0L;
		m_NeedRecover = false;
		ItemIdToExchangeTableId.Clear();
	}

	public void Tick()
	{
		if (m_NeedRecover)
		{
			long num = m_NextTime - TimeManager.ServerTime.NowTimestamp;
			if (num <= 0)
			{
				Recover(-num);
			}
		}
	}

	public long GetPowerConvertRate(int powerConvertItemId)
	{
		return 100 + G.TryGetAttribute(powerConvertItemId);
	}

	public long GetRequirePowerCount(int itemId, int needCount)
	{
		if (!ItemIdToExchangeTableId.TryGetValue(itemId, out var value))
		{
			return -1L;
		}
		if (needCount <= 0)
		{
			return 0L;
		}
		if (!RuntimeConfigs.data.ExchangeItems.TryGetValue(value, out var value2) || value2.ExchangeCount <= 0 || !PowerExchangeAttributeIds.TryGetValue(value, out var value3))
		{
			return -1L;
		}
		long powerConvertRate = GetPowerConvertRate(value3);
		long num = value2.ExchangeCount * powerConvertRate;
		if (num <= 0)
		{
			return -1L;
		}
		return (((long)needCount * 100L + num - 1) / num + 10 - 1) / 10 * 10;
	}

	public long GetPowerExchangeItemCount(int itemId, long powerCount)
	{
		if (powerCount <= 0 || !ItemIdToExchangeTableId.TryGetValue(itemId, out var value) || !RuntimeConfigs.data.ExchangeItems.TryGetValue(value, out var value2) || value2.ExchangeCount <= 0 || !PowerExchangeAttributeIds.TryGetValue(value, out var value3))
		{
			return 0L;
		}
		return powerCount * value2.ExchangeCount * GetPowerConvertRate(value3) / 100;
	}

	public bool TryGetPowerExchangePreview(int itemId, int needCount, out int powerConvertItemId, out long requiredPowerCost, out long exchangePowerCost, out long exchangeCount)
	{
		powerConvertItemId = 0;
		requiredPowerCost = 0L;
		exchangePowerCost = 0L;
		exchangeCount = 0L;
		if (itemId <= 0 || needCount <= 0 || !RuntimeConfigs.data.itemDatas.ContainsKey(itemId))
		{
			return false;
		}
		if (!ItemIdToExchangeTableId.TryGetValue(itemId, out var value) || !RuntimeConfigs.data.ExchangeItems.TryGetValue(value, out var value2) || value2.ExchangeCount <= 0 || !PowerExchangeAttributeIds.TryGetValue(value, out powerConvertItemId))
		{
			return false;
		}
		requiredPowerCost = GetRequirePowerCount(itemId, needCount);
		if (requiredPowerCost <= 0)
		{
			return false;
		}
		exchangePowerCost = ((requiredPowerCost <= PowerCount) ? requiredPowerCost : Math.Max(10, PowerCount / 10 * 10));
		exchangeCount = GetPowerExchangeItemCount(itemId, exchangePowerCost);
		return exchangeCount > 0;
	}

	public bool IsPowerEnough(long needCount)
	{
		if (needCount <= PowerCount)
		{
			return true;
		}
		long num = PowerCount;
		foreach (Item item in G.localPlayer.Inventory.Items)
		{
			if (item.itemType != 23 || item.IsDisuse() || !RuntimeConfigs.data.itemDatas.TryGetValue(item.Id, out var value) || !RuntimeConfigs.data.collections.TryGetValue(value.Use, out var value2))
			{
				continue;
			}
			List<ItemKv> certain = value2.certain;
			if (certain != null && certain.Count > 0)
			{
				num += (long)item.Count * (long)value2.certain[0].count;
				if (num >= needCount)
				{
					return true;
				}
			}
		}
		Game game = RuntimeConfigs.data.game;
		long num2 = G.detailUserInfo.Attributes[97];
		int i = Math.Max(0, G.localPlayer.Profile.PowerDailyBuyNum);
		for (int num3 = Math.Min(game.freeDiamondExchangePowerNum, game.freeDiamondExchangePowerCost.Count); i < num3; i++)
		{
			int count = game.freeDiamondExchangePowerCost[i].count;
			if (num2 < count)
			{
				break;
			}
			num2 -= count;
			num += game.freeDiamondExchangePowerObtain;
			if (num >= needCount)
			{
				return true;
			}
		}
		return false;
	}

	private void Recover(long left)
	{
		G.service.RequestPowerCount((PowerInfoQueryAck ack) =>
		{
			m_NextTime = TimeManager.ServerTime.NowTimestamp + m_Interval - left % m_Interval;
			if (ack == null)
			{
				long num = (left / m_Interval + 1) * RuntimeConfigs.data.game.recoveryRule.count;
				PowerCount = (int)Math.Clamp(PowerCount + num, 0L, RuntimeConfigs.data.game.powerLimit);
				G.detailUserInfo.Attributes[96] = PowerCount;
				G.localPlayer.Profile.PowerRecoverTs = TimeManager.ServerTime.NowTimestamp;
				m_NeedRecover = PowerCount < RuntimeConfigs.data.game.powerLimit;
				OnPowerChanged?.Invoke();
			}
			else
			{
				PowerCount = ack.Power;
				G.detailUserInfo.Attributes[96] = PowerCount;
				G.localPlayer.Profile.PowerRecoverTs = ack.PowerRecoverTs;
				m_NeedRecover = PowerCount < RuntimeConfigs.data.game.powerLimit;
				OnPowerChanged?.Invoke();
			}
		});
	}

	private void OnRefresh(BaseEventContent obj)
	{
		if (!(obj is PlayerAttributeChangeEvt { id: 96 }))
		{
			return;
		}
		PowerCount = (int)G.detailUserInfo.Attributes[96];
		m_NeedRecover = PowerCount < RuntimeConfigs.data.game.powerLimit;
		if (m_NeedRecover)
		{
			if (G.localPlayer.Profile.PowerRecoverTs == 0L)
			{
				m_NextTime = TimeManager.ServerTime.NowTimestamp + m_Interval;
			}
			else
			{
				m_NextTime = G.localPlayer.Profile.PowerRecoverTs + m_Interval;
			}
		}
		OnPowerChanged?.Invoke();
	}

	private long CalRecoverPowerToMaxTime()
	{
		if (!m_NeedRecover)
		{
			return 0L;
		}
		int num = RuntimeConfigs.data.game.powerLimit - PowerCount;
		int count = RuntimeConfigs.data.game.recoveryRule.count;
		return ((num + count - 1) / count - 1) * m_Interval + m_NextTime;
	}
}
