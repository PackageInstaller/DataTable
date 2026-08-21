#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using GameFramework;
using GameFramework.Runtime;
using Newtonsoft.Json;
using UnityEngine;
using UnityEngine.Pool;

namespace Ase;

public class BannerService : IBannerService
{
	private IMessenger messenger;

	private ISubscription<RoleExpOrLevelUpNotifyMessager> subscription_UpdateLevel;

	private ISubscription<SOOpenNotifyMessager> subscription_SONotify;

	private ISubscription<OpActivityMessage> subscription_opActNotify;

	private ISubscription<ShopMessage> subscription_shopMsg;

	private ISubscription<DrawCardMessage> subscription_DrawCard;

	private ISubscription<UserInfoMessage> subscription_UserInfo;

	private ISubscription<TaskChangeNotifyMessager> subscription_taskChange;

	private ISubscription<RefetchDataNotify> subscription_RefetchData;

	private ISubscription<PassportMessage> subscription_Passport;

	private Dictionary<int, DateTime> _spBannerCds = new Dictionary<int, DateTime>();

	private BannerInfo _bannerWaitShow;

	private bool _bannerDataInited;

	private const string PrefName = "BannerPopupCd";

	public IMessenger GetMessager()
	{
		return messenger;
	}

	public BannerService()
	{
		messenger = Context.GetApplicationContext().GetService<IMessenger>();
		subscription_UpdateLevel = messenger.Subscribe<RoleExpOrLevelUpNotifyMessager>(OnLevelChangeNotify);
		subscription_SONotify = messenger.Subscribe<SOOpenNotifyMessager>(OnSystemOpen);
		subscription_opActNotify = Singleton<ServiceSystem>.Instance.GetService<IOpActivityService>().GetMessager().Subscribe<OpActivityMessage>(OnOpActNotify);
		subscription_shopMsg = messenger.Subscribe<ShopMessage>(OnShopMsg);
		subscription_DrawCard = messenger.Subscribe<DrawCardMessage>(OnDrawCardNotify);
		subscription_Passport = messenger.Subscribe<PassportMessage>(OnPassportInfoNotify);
		subscription_UserInfo = messenger.Subscribe<UserInfoMessage>(OnUserInfoNotify);
		subscription_taskChange = messenger.Subscribe<TaskChangeNotifyMessager>(OnTaskChangeNotify);
		subscription_RefetchData = Singleton<NetworkSystem>.Instance.Subscribe<RefetchDataNotify>(OnRefetchDataNotify);
	}

	public static bool GetBannerOpenState(DRBanner drBanner)
	{
		if (drBanner == null)
		{
			return false;
		}
		if (GameEntry.BuiltinData.OpenTestFlight && Constant.DisabledBanner.Contains(drBanner.Id))
		{
			return false;
		}
		if (GetOpenStateByTime(drBanner.StartTime, drBanner.EndTime, out var result))
		{
			return result;
		}
		bool flag = false;
		bool num = drBanner.OnCondition == 0 || CheckConditionMet(drBanner.OnCondition, drBanner.OnConfig);
		flag = drBanner.OffCondition != 0 && CheckConditionMet(drBanner.OffCondition, drBanner.OffConfig);
		if (num)
		{
			return !flag;
		}
		return false;
	}

	public static List<DRBanner> GetOpenBannerConfigs()
	{
		List<DRBanner> list = new List<DRBanner>();
		DRBanner[] allDataRow = GameEntry.DataTable.GetAllDataRow<DRBanner>();
		if (allDataRow != null)
		{
			DRBanner[] array = allDataRow;
			foreach (DRBanner dRBanner in array)
			{
				if (!string.IsNullOrEmpty(dRBanner.Img) && GetBannerOpenState(dRBanner))
				{
					list.Add(dRBanner);
				}
			}
		}
		return list;
	}

	private static bool CheckConditionMet(int conditionType, int configArg)
	{
		switch (conditionType)
		{
		case 1:
			return (Singleton<ServiceSystem>.Instance.GetService<IRoleService>()?.GetRoleData()?.GetPlayerData()?.Level).GetValueOrDefault() >= configArg;
		case 2:
			return Singleton<ServiceSystem>.Instance.GetService<ISOService>()?.GetState(configArg) ?? false;
		case 3:
			return (Singleton<ServiceSystem>.Instance.GetService<IOpActivityService>()?.GetActivityVm()?.GetActivityViewModel(configArg)).IsUnderWay();
		case 4:
			return Singleton<ServiceSystem>.Instance.GetService<IRoleService>()?.GetRoleData()?.MonthPayTotal >= configArg;
		case 5:
		{
			ShopExcData obj3 = Singleton<ServiceSystem>.Instance.GetService<IShopService>()?.GetData()?.GetGoods(configArg);
			return obj3?.LeftExc < obj3?.QuotaNum;
		}
		case 6:
		{
			ShopExcData obj2 = Singleton<ServiceSystem>.Instance.GetService<IShopService>()?.GetData()?.GetGoods(configArg);
			return obj2?.LeftExc == obj2?.QuotaNum;
		}
		case 7:
			return (Singleton<ServiceSystem>.Instance.GetService<IShopService>()?.GetMonthlyCardLeftDay() ?? (-1)) >= 0;
		case 8:
		{
			PassportInfo obj = Singleton<ServiceSystem>.Instance.GetService<IPassportService>()?.GetPassportInfo();
			if (obj == null)
			{
				return false;
			}
			return obj.Grade >= 2;
		}
		default:
			return false;
		}
	}

	private static bool GetOpenStateByTime(string startTime, string endTime, out bool result)
	{
		result = false;
		if (!string.IsNullOrEmpty(startTime) && !string.IsNullOrEmpty(endTime) && TimeService.StringToDateTime(startTime, out var dateTime) && TimeService.StringToDateTime(endTime, out var dateTime2))
		{
			if (DateTime.Compare(dateTime, dateTime2) >= 0)
			{
				return false;
			}
			DateTime localDateTime = TimeHelper.GetLocalDateTime(Singleton<ServiceSystem>.Instance.GetService<ITimeService>().GetCurServerTime());
			result = DateTime.Compare(dateTime, localDateTime) < 0 && DateTime.Compare(localDateTime, dateTime2) < 0;
			return true;
		}
		return false;
	}

	private void OnSystemOpen(SOOpenNotifyMessager msg)
	{
		OnBannerStateChanged();
		messenger.Publish(new BannerMessage(this, BannerMessageEnum.BannerUpdate, null));
	}

	private void OnLevelChangeNotify(RoleExpOrLevelUpNotifyMessager msg)
	{
		if (msg.MessageEnum == RoleExpOrLevelUpNotifyMessager.RoleExpLevelMsgEnum.LevelUp)
		{
			OnBannerStateChanged();
			messenger.Publish(new BannerMessage(this, BannerMessageEnum.BannerUpdate, null));
		}
	}

	private void OnOpActNotify(OpActivityMessage msg)
	{
		if (msg.Type == OpActivityMessageEnum.ActivityOpen || msg.Type == OpActivityMessageEnum.ActivityClose || msg.Type == OpActivityMessageEnum.ActivityOn || msg.Type == OpActivityMessageEnum.ActivityOff)
		{
			OnBannerStateChanged();
			messenger.Publish(new BannerMessage(this, BannerMessageEnum.BannerUpdate, null));
		}
	}

	private void OnShopMsg(ShopMessage msg)
	{
		if (msg != null && (msg.Type == ShopMessageEnum.GoodsInitialized || msg.Type == ShopMessageEnum.GoodsBuy || msg.Type == ShopMessageEnum.MonthlyCardInfoChanged))
		{
			OnBannerStateChanged();
			messenger.Publish(new BannerMessage(this, BannerMessageEnum.BannerUpdate, null));
		}
	}

	public void RequestBannerDataAfterLogin()
	{
		_bannerDataInited = true;
		LoadSpBannerCds();
		GetNormalBanner();
	}

	public BannerInfo GetBannerWaitShow()
	{
		return _bannerWaitShow;
	}

	public void SetBannerNull()
	{
		_bannerWaitShow = null;
	}

	public void SetBannerShowed(int id, bool useCd)
	{
		DRBanner dRBanner = null;
		if (_bannerWaitShow != null && _bannerWaitShow.Id == id)
		{
			dRBanner = _bannerWaitShow.Config;
			_bannerWaitShow = null;
		}
		else
		{
			dRBanner = GameEntry.DataTable.GetDataRow<DRBanner>(id);
		}
		if (dRBanner != null && dRBanner.SpCd != 0 && useCd)
		{
			long num = Singleton<ServiceSystem>.Instance.GetService<ITimeService>()?.GetCurServerTime() ?? 0;
			if (num > 0)
			{
				DateTime localDateTime = TimeHelper.GetLocalDateTime(num);
				_spBannerCds.Remove(id);
				_spBannerCds.Add(id, localDateTime);
				SaveSpBannerCds();
			}
		}
	}

	private void OnBannerStateChanged()
	{
		if (_bannerWaitShow == null || !_bannerWaitShow.Special)
		{
			GetNormalBanner();
		}
	}

	private void GetNormalBanner()
	{
		if (!_bannerDataInited)
		{
			return;
		}
		List<DRBanner> list = GameEntry.DataTable.GetDataRows((DRBanner p) => p.Weight > 0 && GetBannerOpenState(p)).ToList();
		if (list == null)
		{
			return;
		}
		int totalWeight = 0;
		list.ForEach(delegate(DRBanner p)
		{
			totalWeight += p.Weight;
		});
		int num = new System.Random().Next(0, totalWeight);
		foreach (DRBanner item in list)
		{
			num -= item.Weight;
			if (num <= 0)
			{
				TrySetBannerWaitShow(item, special: false, useCd: false, "自然弹出");
				break;
			}
		}
	}

	private void TrySetBannerWaitShow(DRBanner drBanner, bool special, bool useCd, string source)
	{
		if (drBanner != null)
		{
			if (_bannerWaitShow == null)
			{
				DoSet();
			}
			else if ((!_bannerWaitShow.Special & special) || _bannerWaitShow.Config.Sort >= drBanner.Sort)
			{
				DoSet();
			}
		}
		void DoSet()
		{
			_bannerWaitShow = new BannerInfo
			{
				Id = drBanner.Id,
				Config = drBanner,
				Special = special,
				UseCd = useCd,
				Source = source
			};
		}
	}

	private void OnSpConditionUpdated(int triggerType)
	{
		long num = Singleton<ServiceSystem>.Instance.GetService<ITimeService>()?.GetCurServerTime() ?? 0;
		DateTime dateTime = DateTime.MinValue;
		if (num > 0)
		{
			dateTime = TimeHelper.GetLocalDateTime(num);
		}
		foreach (DRBanner item in GameEntry.DataTable.GetDataRows<DRBanner>(GetBannerOpenState).ToList())
		{
			KeyValuePair<bool, string> keyValuePair = CheckSpCondition(item.SpCondition, item.SpConfig, triggerType);
			if (!keyValuePair.Key)
			{
				continue;
			}
			DateTime value;
			if (item.SpCd == 0)
			{
				TrySetBannerWaitShow(item, special: true, useCd: true, keyValuePair.Value);
			}
			else if (item.SpCd < 0)
			{
				if (!_spBannerCds.ContainsKey(item.Id))
				{
					TrySetBannerWaitShow(item, special: true, useCd: true, keyValuePair.Value);
				}
			}
			else if (_spBannerCds.TryGetValue(item.Id, out value))
			{
				if (!(dateTime == DateTime.MinValue) && (dateTime - value).Days >= item.SpCd)
				{
					TrySetBannerWaitShow(item, special: true, useCd: true, keyValuePair.Value);
				}
			}
			else
			{
				TrySetBannerWaitShow(item, special: true, useCd: true, keyValuePair.Value);
			}
		}
	}

	private void ReceiveInstruction(int bannerId)
	{
		if (bannerId == 98 || bannerId == 99)
		{
			_bannerWaitShow = new BannerInfo
			{
				Id = bannerId,
				Config = null,
				Special = true,
				UseCd = false,
				Source = "收到GM指令弹出"
			};
		}
		DRBanner dataRow = GameEntry.DataTable.GetDataRow<DRBanner>(bannerId);
		if (dataRow != null)
		{
			TrySetBannerWaitShow(dataRow, special: true, useCd: false, "收到GM指令弹出");
		}
	}

	private static KeyValuePair<bool, string> CheckSpCondition(List<int> conditionType, List<int> configArg, int triggerType)
	{
		if (conditionType == null)
		{
			return new KeyValuePair<bool, string>(key: false, "");
		}
		bool flag = false;
		string value = "";
		for (int i = 0; i < conditionType.Count; i++)
		{
			int num = conditionType[i];
			int num2 = ((configArg.Count > i) ? configArg[i] : 0);
			switch (num)
			{
			case 1:
				flag = flag || triggerType == 1;
				value = "抽卡完成后弹出";
				break;
			case 2:
			{
				IAccountService service = Singleton<ServiceSystem>.Instance.GetService<IAccountService>();
				long num4 = ((service != null) ? (service.GetLoginSeconds() / 60) : 0);
				flag = flag || num4 >= num2;
				value = $"单次登录累计在线达到{num2}分钟后弹出";
				break;
			}
			case 3:
			{
				int num3 = Singleton<ServiceSystem>.Instance.GetService<ITaskServices>()?.GetCurrentCopyOpen() ?? 0;
				flag = flag || num3 > num2;
				value = $"首次达到剧情进度CopyOpen:{num2}后弹出";
				break;
			}
			}
		}
		return new KeyValuePair<bool, string>(flag, value);
	}

	private void OnPassportInfoNotify(PassportMessage msg)
	{
		if (msg != null && msg.MsgEnum == PassportMsgEnum.BuyPassportGrade)
		{
			OnBannerStateChanged();
			messenger.Publish(new BannerMessage(this, BannerMessageEnum.BannerUpdate, null));
		}
	}

	private void OnDrawCardNotify(DrawCardMessage msg)
	{
		if (msg != null && msg.MsgEnum == DrawCardMsgEnum.DrawCard)
		{
			OnSpConditionUpdated(1);
		}
	}

	private void OnUserInfoNotify(UserInfoMessage msg)
	{
		if (msg != null)
		{
			if (msg.MessageType == UserInfoMessage.MsgTypeEnum.SingleLoginMinutesChanged)
			{
				OnSpConditionUpdated(2);
			}
			else if (msg.MessageType == UserInfoMessage.MsgTypeEnum.ChargeDataChanged)
			{
				OnBannerStateChanged();
				messenger.Publish(new BannerMessage(this, BannerMessageEnum.BannerUpdate, null));
			}
		}
	}

	private void OnTaskChangeNotify(TaskChangeNotifyMessager msg)
	{
		if (msg != null)
		{
			if (msg.changeNotifyType == TaskSystem.TaskChangeNotifyType.CopyOpenUpdate)
			{
				OnSpConditionUpdated(3);
			}
			if (msg.changeNotifyType == TaskSystem.TaskChangeNotifyType.Finished || msg.changeNotifyType == TaskSystem.TaskChangeNotifyType.Received || msg.changeNotifyType == TaskSystem.TaskChangeNotifyType.CopyOpenUpdate)
			{
				OnBannerStateChanged();
			}
		}
	}

	private void OnRefetchDataNotify(RefetchDataNotify notify)
	{
		if (notify != null && notify.Type == 27)
		{
			ReceiveInstruction(notify.Para);
		}
	}

	private void SaveSpBannerCds()
	{
		string value = JsonConvert.SerializeObject(new SpBannerCdsJsonData(_spBannerCds));
		PlayerPrefs.SetString(GetPrefName(), value);
	}

	private void LoadSpBannerCds()
	{
		try
		{
			SpBannerCdsJsonData spBannerCdsJsonData = JsonConvert.DeserializeObject<SpBannerCdsJsonData>(PlayerPrefs.GetString(GetPrefName()));
			if (spBannerCdsJsonData == null)
			{
				_spBannerCds = new Dictionary<int, DateTime>();
			}
			else
			{
				_spBannerCds = spBannerCdsJsonData.ToDictionary();
			}
		}
		catch (Exception ex)
		{
			Log.Error(ex?.ToString() + ex.StackTrace);
			throw;
		}
	}

	private string GetPrefName()
	{
		return string.Format("{0}_{1}", "BannerPopupCd", (Singleton<ServiceSystem>.Instance.GetService<IRoleService>()?.GetRoleData()?.PlayerInfo?.Uid).GetValueOrDefault());
	}

	public static void SendTDAEventPopup(int bannerId, string source)
	{
		Dictionary<string, object> dictionary = CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Get();
		dictionary.Add("bannerid", $"{bannerId}");
		dictionary.Add("source", source);
		TDAHandler.Instance.SendUserEvent("banner_activity_popup", dictionary);
		dictionary.Clear();
		CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Release(dictionary);
	}

	public static void SendTDAEventClose(int bannerId, string type, int duration)
	{
		Dictionary<string, object> dictionary = CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Get();
		dictionary.Add("bannerid", $"{bannerId}");
		dictionary.Add("close_type", type);
		dictionary.Add("duration", $"{duration}");
		TDAHandler.Instance.SendUserEvent("banner_activity_close", dictionary);
		dictionary.Clear();
		CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Release(dictionary);
	}

	public static void SendTDAEventClick(int bannerId, string jumpTarget, int duration)
	{
		Dictionary<string, object> dictionary = CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Get();
		dictionary.Add("bannerid", $"{bannerId}");
		dictionary.Add("jump_entrance", jumpTarget);
		dictionary.Add("duration", $"{duration}");
		TDAHandler.Instance.SendUserEvent("banner_activity_click_redirect", dictionary);
		dictionary.Clear();
		CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Release(dictionary);
	}
}
