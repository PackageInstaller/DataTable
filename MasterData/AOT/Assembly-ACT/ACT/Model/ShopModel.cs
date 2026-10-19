using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model.Jump;
using ACT.UI;
using Fundamental;
using UnityEngine;

namespace ACT.Model;

public class ShopModel : Model<ShopModel>, IJumpable
{
	private readonly HashSet<int> _bundlePreconditionMissionGroupIds = new HashSet<int>();

	private readonly HashSet<int> _bundlePreconditionTaskIds = new HashSet<int>();

	public DiamondData DiamondData { get; } = new DiamondData();

	public BundleData BundleData { get; } = new BundleData();

	public bool HasBundleDataSync { get; private set; }

	public bool HasGoodsDataSync { get; private set; }

	public Dictionary<int, MonthlyPassEntry> MonthlyPassData { get; } = new Dictionary<int, MonthlyPassEntry>();

	public Dictionary<int, PayGoods> GoodsData { get; } = new Dictionary<int, PayGoods>();

	public List<SkinInfo> SkinData { get; } = new List<SkinInfo>();

	public Action OnCommodityDataUpdate { get; set; }

	public Action OnShopDataUpdate { get; set; }

	public LuminModelType JumpSourceType => LuminModelType.Shops;

	public void MarkGoodsDataSynced()
	{
		HasGoodsDataSync = true;
	}

	protected override void Init()
	{
		BuildBundlePreconditionCache();
		RegisterRedDots();
		OnShopDataUpdate = (Action)Delegate.Combine(OnShopDataUpdate, new Action(RegisterRedDots));
		if (!Singleton<PreconditionInfoManager>.HasInstance())
		{
			Singleton<PreconditionInfoManager>.CreateInstance();
		}
		Singleton<PreconditionInfoManager>.instance.TaskProgressChangeAction += OnTaskProgressChanged;
	}

	protected override void UnInit()
	{
		DiamondData.DiamondInfo.Clear();
		BundleData.BundleInfo.Clear();
		HasBundleDataSync = false;
		HasGoodsDataSync = false;
		MonthlyPassData.Clear();
		GoodsData.Clear();
		SkinData.Clear();
		_bundlePreconditionMissionGroupIds.Clear();
		_bundlePreconditionTaskIds.Clear();
		OnShopDataUpdate = (Action)Delegate.Remove(OnShopDataUpdate, new Action(RegisterRedDots));
		if (Singleton<PreconditionInfoManager>.HasInstance())
		{
			Singleton<PreconditionInfoManager>.instance.TaskProgressChangeAction -= OnTaskProgressChanged;
		}
	}

	public void UpdateBundleData(BundleData bundleData)
	{
		BundleData.BundleInfo.Clear();
		HasBundleDataSync = true;
		if (bundleData != null)
		{
			BundleData.BundleInfo.Add(bundleData.BundleInfo);
		}
	}

	public void UpdateDiamondData(DiamondData diamondData)
	{
		DiamondData.DiamondInfo.Clear();
		if (diamondData != null)
		{
			DiamondData.DiamondInfo.Add(diamondData.DiamondInfo);
		}
	}

	private void OnTaskProgressChanged(int taskId, ACT.Battle.TaskInfo taskInfo, bool isNew)
	{
		if (IsTaskComplete(taskInfo) && _bundlePreconditionTaskIds.Contains(taskId))
		{
			RegisterRedDots();
		}
	}

	private void BuildBundlePreconditionCache()
	{
		_bundlePreconditionMissionGroupIds.Clear();
		_bundlePreconditionTaskIds.Clear();
		foreach (KeyValuePair<int, Bundle> bundle in RuntimeConfigs.data.bundles)
		{
			int missionGroupId = bundle.Value.missionGroupId;
			if (missionGroupId == 0 || !_bundlePreconditionMissionGroupIds.Add(missionGroupId))
			{
				continue;
			}
			MissionGroup data = CoreUtils.GetData(missionGroupId, RuntimeConfigs.data.missionGroups);
			if (data?.missionId == null)
			{
				continue;
			}
			int[] missionId = data.missionId;
			foreach (int num in missionId)
			{
				if (num != 0)
				{
					_bundlePreconditionTaskIds.Add(num);
				}
			}
		}
	}

	private bool IsTaskComplete(ACT.Battle.TaskInfo taskInfo)
	{
		if (taskInfo != null)
		{
			int status = taskInfo.status;
			if ((uint)(status - 1) <= 1u)
			{
				return true;
			}
		}
		return false;
	}

	private void RegisterRedDots()
	{
		RegisterShopFrameRedDots();
		RegisterBundleRedDots();
	}

	private void RegisterShopFrameRedDots()
	{
		RegisterShopRedDotPath(RedDotPathDefine.Shop);
		foreach (KeyValuePair<int, ShopData> shopData in RuntimeConfigs.data.shopDatas)
		{
			ShopData value = shopData.Value;
			if (value?.subshopIds != null)
			{
				RegisterShopRedDotPath(GetShopRedDotPath(value.id));
				int[] subshopIds = value.subshopIds;
				foreach (int subShopId in subshopIds)
				{
					RegisterShopRedDotPath(GetShopSubShopRedDotPath(value.id, subShopId));
				}
			}
		}
	}

	private void RegisterBundleRedDots()
	{
		foreach (KeyValuePair<int, ShopData> shopData in RuntimeConfigs.data.shopDatas)
		{
			RegisterShopGiftCenterBundleRedDots(shopData.Value);
		}
	}

	private void RegisterShopGiftCenterBundleRedDots(ShopData shopData)
	{
		if (shopData?.subshopIds != null && TimeManager.IsInTimeRange(shopData.shopStartTs, shopData.shopEndTs))
		{
			int[] subshopIds = shopData.subshopIds;
			foreach (int subShopId in subshopIds)
			{
				RegisterSubShopBundleRedDots(shopData.id, subShopId);
			}
		}
	}

	private void RegisterShopRedDotPath(string redDotPath)
	{
		if (!Singleton<RedDotManager>.instance.IsPathRegistered(redDotPath))
		{
			Singleton<RedDotManager>.instance.StaticRegisterInitTrieNode(redDotPath, active: false, 1027);
		}
	}

	private void RegisterSubShopBundleRedDots(int shopId, int subShopId)
	{
		SubshopData data = CoreUtils.GetData(subShopId, RuntimeConfigs.data.subshopDatas);
		if (data?.commodityIds == null)
		{
			return;
		}
		int[] commodityIds = data.commodityIds;
		for (int i = 0; i < commodityIds.Length; i++)
		{
			Bundle data2 = CoreUtils.GetData(commodityIds[i], RuntimeConfigs.data.bundles);
			if (data2 != null)
			{
				string shopBundleRedDotPath = GetShopBundleRedDotPath(shopId, subShopId, data2.id);
				RegisterShopRedDotPath(shopBundleRedDotPath);
				Singleton<RedDotManager>.instance.SetLeafNodeActive(shopBundleRedDotPath, CanBuyFreeBundle(data2.id));
			}
		}
	}

	private string GetShopRedDotPath(int shopId)
	{
		return $"{RedDotPathDefine.Shop}|{shopId}";
	}

	private string GetShopSubShopRedDotPath(int shopId, int subShopId)
	{
		return $"{GetShopRedDotPath(shopId)}|{subShopId}";
	}

	private string GetShopBundleRedDotPath(int shopId, int subShopId, int bundleId)
	{
		return $"{GetShopSubShopRedDotPath(shopId, subShopId)}|{bundleId}";
	}

	public bool IsBundleRedDotActive(int shopId, int subShopId, int bundleId)
	{
		if (shopId == 0 || subShopId == 0 || bundleId == 0)
		{
			return false;
		}
		string shopBundleRedDotPath = GetShopBundleRedDotPath(shopId, subShopId, bundleId);
		if (!Singleton<RedDotManager>.instance.IsPathRegistered(shopBundleRedDotPath))
		{
			return false;
		}
		return Singleton<RedDotManager>.instance.IsLeafNodeActive(shopBundleRedDotPath);
	}

	private bool CanBuyFreeBundle(int bundleId)
	{
		Bundle data = CoreUtils.GetData(bundleId, RuntimeConfigs.data.bundles);
		if (data == null || data.paytype != 3)
		{
			return false;
		}
		if (!IsCommodityAvailable(bundleId))
		{
			return false;
		}
		if (!IsBundleMissionGroupComplete(data.missionGroupId))
		{
			return false;
		}
		return BundleLeftCount(bundleId) != 0;
	}

	private bool IsBundleMissionGroupComplete(int missionGroupId)
	{
		if (missionGroupId != 0)
		{
			return Singleton<PreconditionInfoManager>.instance.GetTaskGroupIsComplete(missionGroupId);
		}
		return true;
	}

	private bool IsCommodityAvailable(int commodityId)
	{
		if (!GoodsData.TryGetValue(commodityId, out var value))
		{
			return true;
		}
		if (value.EndTime > 0)
		{
			return value.EndTime >= TimeManager.ServerTime.NowTimestampSecond;
		}
		return true;
	}

	public JumpResult CanJump(RuntimeJumpData jumpData)
	{
		JumpResult result = default;
		_ = jumpData.Params[0];
		int jumpShopId = GetJumpShopId(jumpData);
		int jumpSubShopId = GetJumpSubShopId(jumpData);
		int jumpCommodityId = GetJumpCommodityId(jumpData);
		ShopData data = CoreUtils.GetData(jumpShopId, RuntimeConfigs.data.shopDatas);
		if (!Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.Shop))
		{
			result.ShowType = JumpResult.JumpShowType.Forbidden;
			result.Message = Singleton<SystemUnlockManager>.instance.GetSystemLockTips(SystemType.Shop);
			return result;
		}
		if (data != null)
		{
			if (!TimeManager.IsInTimeRange(data.shopStartTs, data.shopEndTs))
			{
				result.ShowType = JumpResult.JumpShowType.Hide;
				return result;
			}
			if (jumpSubShopId != 0 && (data.subshopIds == null || !data.subshopIds.Contains(jumpSubShopId)))
			{
				result.ShowType = JumpResult.JumpShowType.Hide;
				Debug.LogError($"subShopId {jumpSubShopId} not found in shopDataId {data.id}");
				return result;
			}
			if (jumpCommodityId != 0)
			{
				SubshopData data2 = CoreUtils.GetData(jumpSubShopId, RuntimeConfigs.data.subshopDatas);
				if (!IsSubShopCommodityListed(data2, jumpCommodityId))
				{
					result.ShowType = JumpResult.JumpShowType.Hide;
					Debug.LogError($"commodityId {jumpCommodityId} not found in subShopId {jumpSubShopId}");
					return result;
				}
				if (IsPermanentLimitSoldOut(jumpShopId, jumpSubShopId, jumpCommodityId))
				{
					result.ShowType = JumpResult.JumpShowType.Hide;
					return result;
				}
			}
			result.ShowType = JumpResult.JumpShowType.CanJump;
			return result;
		}
		result.ShowType = JumpResult.JumpShowType.Hide;
		return result;
	}

	public void Jump(RuntimeJumpData jumpData)
	{
		ShopViewData uiData = new ShopViewData
		{
			FirstTabID = GetJumpShopId(jumpData),
			SecondTabID = GetJumpSubShopId(jumpData)
		};
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_SHOP, uiData);
	}

	private int GetJumpShopId(RuntimeJumpData jumpData)
	{
		List<int> list = jumpData.Params;
		if (list == null || list.Count <= 1)
		{
			return 0;
		}
		if (jumpData.Params.Count > 2)
		{
			return jumpData.Params[1];
		}
		int num = GetJumpShopData(jumpData.Params[1])?.id ?? 0;
		if (num == 0 && CoreUtils.GetData(jumpData.Params[1], RuntimeConfigs.data.shopDatas) != null)
		{
			return jumpData.Params[1];
		}
		return num;
	}

	private ShopData GetJumpShopData(int subShopId)
	{
		ShopData result = null;
		foreach (KeyValuePair<int, ShopData> shopData in RuntimeConfigs.data.shopDatas)
		{
			if (shopData.Value?.subshopIds != null && shopData.Value.subshopIds.Contains(subShopId))
			{
				result = shopData.Value;
				break;
			}
		}
		return result;
	}

	private int GetJumpSubShopId(RuntimeJumpData jumpData)
	{
		List<int> list = jumpData.Params;
		if (list != null && list.Count > 2)
		{
			return jumpData.Params[2];
		}
		return 0;
	}

	private int GetJumpCommodityId(RuntimeJumpData jumpData)
	{
		List<int> list = jumpData.Params;
		if (list != null && list.Count > 3)
		{
			return jumpData.Params[3];
		}
		return 0;
	}

	private bool IsSubShopCommodityListed(SubshopData subShopData, int commodityId)
	{
		if (subShopData?.commodityIds != null)
		{
			return subShopData.commodityIds.Contains(commodityId);
		}
		return false;
	}

	private bool IsPermanentLimitSoldOut(int shopId, int subShopId, int commodityId)
	{
		Bundle data = CoreUtils.GetData(commodityId, RuntimeConfigs.data.bundles);
		if (data != null)
		{
			if (data.limitCount > 0 && data.limitRefreshType == 0)
			{
				return BundleLeftCount(commodityId) <= 0;
			}
			return false;
		}
		SkinShop data2 = CoreUtils.GetData(commodityId, RuntimeConfigs.data.skinShops);
		if (data2 != null)
		{
			if (data2.limitCount > 0 && data2.limitRefreshType == 0)
			{
				return SkinItemLeftCount(commodityId) <= 0;
			}
			return false;
		}
		ACT.Config.ExchangeShop data3 = CoreUtils.GetData(commodityId, RuntimeConfigs.data.exchangeShops);
		if (data3 != null)
		{
			if (data3.limitCount > 0 && data3.limitRefreshType == 0)
			{
				return ExchangeItemLeftCount(shopId, subShopId, commodityId) <= 0;
			}
			return false;
		}
		return false;
	}

	public bool IsDiamondCommodityDouble(int commodityId)
	{
		if (DiamondData.DiamondInfo.TryGetValue(commodityId, out var value))
		{
			return value.FirstBuyTime == 0;
		}
		return true;
	}

	public bool IsDiamondCommodityLimitDouble(int commodityId)
	{
		if (RuntimeConfigs.data.gemRecharges.TryGetValue(commodityId, out var value))
		{
			int doubleid = value.doubleid;
			if (doubleid != 0 && RuntimeConfigs.data.doubleGems.TryGetValue(doubleid, out var value2))
			{
				if (DiamondData.DiamondInfo.TryGetValue(commodityId, out var value3) && value3.LimitDouble.TryGetValue(doubleid, out var value4) && value4 != 0L)
				{
					return false;
				}
				return TimeManager.IsInTimeRange(value2.startTimeStamp, value2.endTimeStamp);
			}
		}
		return false;
	}

	public int ExchangeItemLeftCount(int shopId, int subShopId, int commodityId)
	{
		ACT.Config.ExchangeShop data = CoreUtils.GetData(commodityId, RuntimeConfigs.data.exchangeShops);
		if (data == null)
		{
			return -1;
		}
		if (data.limitCount == 0)
		{
			return -1;
		}
		G.localPlayer.ShopInfos.TryGetValue(shopId, out var value);
		if (value == null)
		{
			return data.limitCount;
		}
		value.SubShops.TryGetValue(subShopId, out var value2);
		if (value2 == null)
		{
			return data.limitCount;
		}
		value2.Commodities.TryGetValue(commodityId, out var value3);
		if (value3 == null)
		{
			return data.limitCount;
		}
		return data.limitCount - value3.BoughtNum;
	}

	public int SkinItemLeftCount(int skinCommodityId)
	{
		SkinShop skinShop = CoreUtils.GetData(skinCommodityId, RuntimeConfigs.data.skinShops);
		if (skinShop == null || skinShop.limitCount == 0)
		{
			return -1;
		}
		if (SkinData?.FirstOrDefault((SkinInfo x) => x.SkinId == skinShop.skinid) == null)
		{
			return -1;
		}
		int num = Enumerable.Count(SkinData, (SkinInfo x) => x.SkinId == skinShop.skinid);
		return Math.Max(0, skinShop.limitCount - num);
	}

	public int BundleLeftCount(int bundleId)
	{
		Bundle data = CoreUtils.GetData(bundleId, RuntimeConfigs.data.bundles);
		if (data == null || data.limitCount == 0)
		{
			return -1;
		}
		int num = 0;
		BundleData.BundleInfo.TryGetValue(bundleId, out var value);
		if (value != null)
		{
			num = value.BuyCount;
		}
		return data.limitCount - num;
	}

	public bool MonthlyPassValid(int monthlyPassId)
	{
		if (CoreUtils.GetData(monthlyPassId, RuntimeConfigs.data.monthlyPasss) == null)
		{
			return false;
		}
		if (!MonthlyPassData.TryGetValue(monthlyPassId, out var value))
		{
			return false;
		}
		return value.ExpireTimeUnix > TimeManager.ServerTime.NowTimestampSecond;
	}

	public bool IsNeedPopPassDailyReward(int monthlyPassId)
	{
		if (CoreUtils.GetData(monthlyPassId, RuntimeConfigs.data.monthlyPasss) == null)
		{
			return false;
		}
		if (!MonthlyPassData.TryGetValue(monthlyPassId, out var value))
		{
			return false;
		}
		System.DateTime date = TimeManager.ServerTime.Now.AddHours(-4.0).Date;
		System.DateTime date2 = TimeManager.TimeStampToDateTime(value.LastPopTimeUnix).AddHours(-4.0).Date;
		return date > date2;
	}

	public long CommodityLeftTime(int commodityId)
	{
		if (!GoodsData.TryGetValue(commodityId, out var value) || value.EndTime == 0L)
		{
			return -1L;
		}
		return Math.Max(0L, value.EndTime - TimeManager.ServerTime.NowTimestampSecond);
	}

	public long MonthlyPassLeftTime(int monthlyPassId)
	{
		if (!MonthlyPassData.TryGetValue(monthlyPassId, out var value))
		{
			return 0L;
		}
		if (value.ExpireTimeUnix == 0L || value.ExpireTimeUnix < TimeManager.ServerTime.NowTimestampSecond)
		{
			return 0L;
		}
		return Math.Max(0L, value.ExpireTimeUnix - TimeManager.ServerTime.NowTimestampSecond);
	}

	public int MonthlyPassLeftCount(int monthlyPassId)
	{
		return (int)TimeSpan.FromSeconds(MonthlyPassLeftTime(monthlyPassId)).TotalDays;
	}

	public void SendMonthlyPassRecordPopReq(int passId, long PopTimeUnix)
	{
		G.service.SendMonthlyPassRecordPopReq(passId, PopTimeUnix, (MonthlyPassRecordPopAck ack) =>
		{
			if (MonthlyPassData.TryGetValue(passId, out var value))
			{
				value.LastPopTimeUnix = PopTimeUnix;
			}
		});
	}

	public bool IsHaveMonthlyPassValid(out MonthlyPassEntry monthlyPass)
	{
		Dictionary<int, MonthlyPassEntry> monthlyPassData = MonthlyPassData;
		if (monthlyPassData == null || monthlyPassData.Count <= 0)
		{
			monthlyPass = null;
			return false;
		}
		foreach (KeyValuePair<int, MonthlyPassEntry> monthlyPassDatum in MonthlyPassData)
		{
			if (MonthlyPassValid(monthlyPassDatum.Value.PassId) && IsNeedPopPassDailyReward(monthlyPassDatum.Value.PassId))
			{
				monthlyPass = monthlyPassDatum.Value;
				return true;
			}
		}
		monthlyPass = null;
		return false;
	}

	public void TestMonthyRest()
	{
		foreach (KeyValuePair<int, MonthlyPassEntry> monthlyPassDatum in MonthlyPassData)
		{
			monthlyPassDatum.Value.LastPopTimeUnix = 0L;
		}
	}
}
