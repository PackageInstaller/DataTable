#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;
using UnityEngine.Pool;

namespace Ase;

public class RoleService : IRoleService
{
	private IMessenger messenger;

	private RoleViewModel roleViewModel;

	private long[] recoverVitCost;

	private ISubscription<UserInfohNotify> sub_UserInfoNotify;

	private ISubscription<GoldenFingerNotify> sub_GoldenFingerNotify;

	private Action goldenFingerAction;

	private List<int> manualRewardStates = new List<int>();

	private List<int> manualOpenStates = new List<int>();

	private bool _manualDataInitialized;

	public long Uid => roleViewModel?.Uid ?? 0;

	public bool NeedCreateRole => Uid == 0;

	public bool GuideLevelComplete => (roleViewModel?.PlayerInfo?.MaxStoryLevel).GetValueOrDefault() >= 10;

	public RoleService()
	{
		messenger = Context.GetApplicationContext().GetService<IMessenger>();
		sub_UserInfoNotify = Singleton<NetworkSystem>.Instance.Subscribe<UserInfohNotify>(OnUserInfoNotify);
	}

	public void CreateRoleData(long uid, UserBaseInfo userBaseInfo, long serverOpneTime)
	{
		roleViewModel = new RoleViewModel(uid, userBaseInfo, serverOpneTime);
		if (userBaseInfo != null)
		{
			TDAHandler.Instance.Login($"{uid}");
		}
	}

	public async UniTask RequestUserBaseInfo()
	{
		GetUserBaseInfoRequest rst = GetUserBaseInfoRequest.Create();
		GetUserBaseInfoResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetUserBaseInfoResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "请求玩家基础数据") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "请求玩家基础数据失败"))
			{
				roleViewModel?.UpdateUserBaseInfo(response.UserBaseInfo);
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
	}

	private void OnGoldenFingerNotify(GoldenFingerNotify message)
	{
		roleViewModel.UpdateServerOpenTime(message.ServerOpenTime);
		goldenFingerAction?.Invoke();
	}

	private void OnUserInfoNotify(UserInfohNotify notify)
	{
		if (notify?.UserBaseInfo != null)
		{
			roleViewModel?.UpdateUserBaseInfo(notify.UserBaseInfo);
			messenger.Publish(new UserInfoMessage(this, UserInfoMessage.MsgTypeEnum.UserBaseInfoChanged));
		}
	}

	public void RegisterGoldfingerNotify(Action action)
	{
		goldenFingerAction = (Action)Delegate.Combine(goldenFingerAction, action);
	}

	public async UniTask<bool> UpdateCurrencyData()
	{
		C2H_GetCurrencyDataRequest rst = C2H_GetCurrencyDataRequest.Create();
		H2C_GetCurrencyDataResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<H2C_GetCurrencyDataResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "获取货币") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "获取货币失败"))
			{
				roleViewModel.UpdateMoneyData((int)response.Gold, (int)response.Diamond);
				return true;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return false;
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return false;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public async UniTask UpdateAccountLimit()
	{
		GetTimedRefreshInfoRequest rst = GetTimedRefreshInfoRequest.Create();
		GetTimedRefreshInfoResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetTimedRefreshInfoResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "获取账号限制") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "获取账号限制"))
			{
				roleViewModel.UpdateAccountLimit(response.Infos);
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
	}

	public RoleViewModel GetRoleData()
	{
		return roleViewModel;
	}

	public async UniTask<List<RoleDecorateData>> GetIconOrTitleList(RoleDecorateEnum type)
	{
		List<RoleDecorateData> result = new List<RoleDecorateData>();
		GetIconOrTitleListRequest rst = GetIconOrTitleListRequest.Create();
		rst.Type = (int)type;
		GetIconOrTitleListResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetIconOrTitleListResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "获取头像/框/称号数据") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "获取头像/框/称号数据"))
			{
				for (int i = 0; i < response.ExtraItemInfos.Count; i++)
				{
					result.Add(new RoleDecorateData
					{
						id = response.ExtraItemInfos[i].Id,
						expireTime = response.ExtraItemInfos[i].ExpireTime,
						DecorateType = type
					});
				}
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return result;
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return result;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return result;
	}

	public async UniTask<List<BackgroundData>> RequestBackgroundData()
	{
		List<BackgroundData> result = new List<BackgroundData>();
		GetIconOrTitleListRequest rst = GetIconOrTitleListRequest.Create();
		rst.Type = 3;
		GetIconOrTitleListResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetIconOrTitleListResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "获取背景数据") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "获取背景数据失败"))
			{
				if (response.ExtraItemInfos != null)
				{
					foreach (PbExtraItemInfo extraItemInfo in response.ExtraItemInfos)
					{
						result.Add(new BackgroundData
						{
							Id = extraItemInfo.Id,
							ExpireTime = extraItemInfo.ExpireTime
						});
					}
				}
				return result;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return result;
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return result;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return result;
	}

	public async UniTask<bool> ChangeIconOrTitle(RoleDecorateEnum type, int id)
	{
		ChangeIconOrTitleRequest rst = ChangeIconOrTitleRequest.Create();
		rst.Type = (int)type;
		rst.Id = id;
		S2C_DefaultActorResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<S2C_DefaultActorResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, $"请求更换头像/框/称号数据 type = {type}") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, $"请求更换头像/框/称号数据 type = {type}"))
			{
				roleViewModel.ChangeRoleDecorate(type, id);
				return true;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return false;
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return false;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public async UniTask<bool> ChangeShowHero(List<int> heroIds)
	{
		List<int> list = new List<int>();
		for (int i = 0; i < heroIds.Count; i++)
		{
			list.Add(heroIds[i]);
		}
		ChangeShowHeroRequest rst = ChangeShowHeroRequest.Create();
		rst.HeroIds = list;
		S2C_DefaultActorResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<S2C_DefaultActorResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "更换烬天使展示") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "更换烬天使展示"))
			{
				return true;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return false;
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return false;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public void UpdateRoleLevelAndExp(int level, long exp)
	{
		bool num = level != roleViewModel.PlayerInfo.Level;
		bool flag = exp != roleViewModel.PlayerInfo.Exp;
		roleViewModel.PlayerInfo.SetLevelAndExp(level, exp);
		if (num)
		{
			messenger.Publish(new RoleExpOrLevelUpNotifyMessager(this)
			{
				MessageEnum = RoleExpOrLevelUpNotifyMessager.RoleExpLevelMsgEnum.LevelUp,
				Level = level,
				Exp = exp
			});
			MyGuildData myGuildData = Singleton<ServiceSystem>.Instance.GetService<IGuildService>().GetMyGuildData();
			ExtraGameData extraGameData = new ExtraGameData();
			extraGameData.dataType = 3;
			extraGameData.roleID = roleViewModel.PlayerInfo.Uid.ToString();
			extraGameData.roleName = roleViewModel.PlayerInfo.Name;
			extraGameData.serverID = 0;
			extraGameData.serverName = "";
			extraGameData.vipLevel = roleViewModel.PlayerInfo.Vip;
			extraGameData.roleLevel = roleViewModel.PlayerInfo.Level.ToString();
			extraGameData.gangName = myGuildData?.Name;
			extraGameData.createRoleTime = 0.ToString();
			extraGameData.monyNum_1 = MoneyDefinition.GetMoneyCount(RoleMoneyEnum.Voucher);
			extraGameData.monyNum_2 = MoneyDefinition.GetMoneyCount(RoleMoneyEnum.Diamond);
			extraGameData.accumulateNum = 0;
			Singleton<ServiceSystem>.Instance.GetService<ISDKService>().ReportPlayerData(extraGameData);
		}
		else if (flag)
		{
			messenger.Publish(new RoleExpOrLevelUpNotifyMessager(this)
			{
				MessageEnum = RoleExpOrLevelUpNotifyMessager.RoleExpLevelMsgEnum.OnlyExpUp,
				Level = level,
				Exp = exp
			});
		}
	}

	public async UniTask<bool> ChangeBoardHeroData(int id)
	{
		BoardHeroData boardHeroData = roleViewModel.BoardHeroData;
		if (id == boardHeroData.BoardHeroId)
		{
			return false;
		}
		C2H_ChangBackgroundRequest rst = C2H_ChangBackgroundRequest.Create();
		rst.Type = 1;
		rst.Id = id;
		S2C_DefaultActorResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<S2C_DefaultActorResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "修改看板烬天使数据") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "修改看板烬天使数据"))
			{
				roleViewModel.BoardHeroData.ChangeHero(id);
				return true;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return false;
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return false;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public async UniTask<bool> ChangeBoardBackgroundData(int bgId)
	{
		BoardHeroData boardHeroData = roleViewModel.BoardHeroData;
		if (bgId == boardHeroData.BackgroundId)
		{
			return false;
		}
		C2H_ChangBackgroundRequest rst = C2H_ChangBackgroundRequest.Create();
		rst.Type = 2;
		rst.Id = bgId;
		S2C_DefaultActorResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<S2C_DefaultActorResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "修改看板背景数据") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "修改看板背景数据"))
			{
				roleViewModel.BoardHeroData.ChangeBg(bgId);
				return true;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return false;
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return false;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public async UniTask<bool> SendPlayerInfoUseMedals(List<PbMedalInfo> medals)
	{
		SetAchievementMedalWearRequest request = SetAchievementMedalWearRequest.Create();
		request.WearMedal = medals;
		SetAchievementMedalWearResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<SetAchievementMedalWearResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "设置玩家展示成就勋章") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "设置玩家展示成就勋章失败"))
			{
				return true;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error("获取成就组奖励失败，发生异常！" + ex2.Message + " / " + ex2.StackTrace);
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public async UniTask<bool> SendRecoverUserVit(int type, int id)
	{
		RecoverUserVitRequest rst = RecoverUserVitRequest.Create();
		rst.Typ = type;
		rst.Id = id;
		rst.UseCount = ((type != 1) ? 1 : 0);
		RecoverUserVitResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<RecoverUserVitResponse>(rst);
			if (!Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "可燃魂兑换"))
			{
				Toast.ShowInfo("可燃魂兑换失败");
				return false;
			}
			if (Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "可燃魂兑换失败"))
			{
				MoneyDefinition.SetMoney(RoleMoneyEnum.Energy, (int)response.Vit);
				if (type == 1)
				{
					MoneyDefinition.AddMoney(RoleMoneyEnum.Diamond, (int)response.ItemChange.ItemDelta);
					await UpdateAccountLimit();
					GetRoleData().GetMoneyData().SetAutoAddEnergyLastTime(response.LastVitRecoverTime);
					GetRoleData().GetMoneyData().OpenAutoAddEnergy();
					recoverVitCost = new long[2]
					{
						response.ItemChange.ItemId,
						response.ItemChange.ItemDelta
					};
				}
				else
				{
					KnapsackPropData propData = KnapsackPropData.Create(id, (int)response.ItemChange.ItemDelta);
					Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>().AddProp(propData);
				}
				return true;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return false;
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return false;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return true;
	}

	public async UniTask<bool> SendPlayerInfoUseCopyInfoShowOrSetBackGround(int type, int id)
	{
		C2H_ChangBackgroundRequest rst = C2H_ChangBackgroundRequest.Create();
		rst.Type = type;
		rst.Id = id;
		S2C_DefaultActorResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<S2C_DefaultActorResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "设置玩家是否展示副本信息或者更换背景娘") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "设置玩家是否展示副本信息或者更换背景娘失败"))
			{
				return true;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return false;
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return false;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public long[] GetRecoverVitCost()
	{
		return recoverVitCost;
	}

	public async UniTask<bool> InitManualServerInfo()
	{
		if (_manualDataInitialized)
		{
			return true;
		}
		bool num = await RequestManualRewardInfo();
		if (num)
		{
			_manualDataInitialized = true;
		}
		return num;
	}

	public async UniTask<bool> RequestManualRewardInfo()
	{
		GetManualRewardInfoRequest rst = GetManualRewardInfoRequest.Create();
		GetManualRewardInfoResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetManualRewardInfoResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "获取教学手册领奖状态") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "获取教学手册领奖状态 失败"))
			{
				manualRewardStates = response.RewardStates;
				manualOpenStates = response.OpenStates;
				return true;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return false;
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return false;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public async UniTask<bool> RequestUseExchangeCode(string code)
	{
		RedeemCodeRequest rst = RedeemCodeRequest.Create();
		rst.Code = code;
		RedeemCodeResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<RedeemCodeResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "使用兑换码") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "使用兑换码 失败"))
			{
				if (!string.IsNullOrEmpty(response.Message))
				{
					Toast.ShowInfo(response.Message);
				}
				return true;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return false;
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return false;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public async UniTask<KeyValuePair<bool, RewardGetData>> RequestGetManualReward(int index)
	{
		GetManualRewardRequest rst = GetManualRewardRequest.Create();
		rst.Index = index;
		KeyValuePair<bool, RewardGetData> result = new KeyValuePair<bool, RewardGetData>(key: false, null);
		GetManualRewardResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetManualRewardResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "教学手册领奖") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "教学手册领奖 失败"))
			{
				result = new KeyValuePair<bool, RewardGetData>(key: true, PropHelper.AnalyzeRewardFromServer(new List<PbItemChange> { response.Reward }));
				bool manualTypeRedState = TeachingDefinition.GetManualTypeRedState(TeachingDefinition.TeachingType.All);
				ChangeManualRewardState(index, got: true);
				bool manualTypeRedState2 = TeachingDefinition.GetManualTypeRedState(TeachingDefinition.TeachingType.All);
				if (manualTypeRedState && !manualTypeRedState2)
				{
					Singleton<ServiceSystem>.Instance.GetService<IRedPointService>()?.SetServerRed(ServerRedType.Manual, red: false);
				}
				messenger.Publish(new TeachingManualGetRewardMsg(this));
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return result;
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return result;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return result;
	}

	public void SetManualOpenState(int drManualId)
	{
		UpdateManualOpenStateClientMessage updateManualOpenStateClientMessage = UpdateManualOpenStateClientMessage.Create();
		updateManualOpenStateClientMessage.Idxs = new List<int>(drManualId);
		updateManualOpenStateClientMessage.UserId = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().Uid;
		Singleton<NetworkSystem>.Instance.Call(updateManualOpenStateClientMessage);
		DRManual dataRow = GameEntry.DataTable.GetDataRow<DRManual>(drManualId);
		if (dataRow != null)
		{
			ChangeManualOpenState(dataRow.Index, isOpen: true);
			messenger.Publish(new TeachingManualOpenMsg(this));
		}
	}

	public void SetManualOpenState(int manualReleaseType, int drTeachingId)
	{
		DRManual[] dataRows = GameEntry.DataTable.GetDataRows((DRManual p) => p.Release == manualReleaseType && p.ReleaseConfig == drTeachingId);
		if (dataRows != null)
		{
			List<int> list = new List<int>();
			List<int> list2 = new List<int>();
			DRManual[] array = dataRows;
			foreach (DRManual dRManual in array)
			{
				list.Add(dRManual.Id);
				list2.Add(dRManual.Index);
			}
			UpdateManualOpenStateClientMessage updateManualOpenStateClientMessage = UpdateManualOpenStateClientMessage.Create();
			updateManualOpenStateClientMessage.Idxs = list;
			updateManualOpenStateClientMessage.UserId = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().Uid;
			Singleton<NetworkSystem>.Instance.Call(updateManualOpenStateClientMessage);
			ChangeManualOpenState(list2, isOpen: true);
			messenger.Publish(new TeachingManualOpenMsg(this));
		}
	}

	public List<int> GetManualRewardStates()
	{
		return manualRewardStates;
	}

	public bool GetManualRewardState(int index)
	{
		bool result = false;
		int num = (index - 1) / 32;
		int num2 = (index - 1) % 32;
		int count = manualRewardStates.Count;
		if (count <= num)
		{
			for (int i = count; i < num + 1; i++)
			{
				manualRewardStates.Add(0);
			}
		}
		if (int.TryParse(Convert.ToString(manualRewardStates[num], 2).PadLeft(32, '0')[31 - num2].ToString(), out var result2))
		{
			result = result2 == 1;
		}
		return result;
	}

	public bool GetManualOpenState(int index)
	{
		bool result = false;
		int num = (index - 1) / 32;
		int num2 = (index - 1) % 32;
		int count = manualOpenStates.Count;
		if (count <= num)
		{
			for (int i = count; i < num + 1; i++)
			{
				manualOpenStates.Add(0);
			}
		}
		if (int.TryParse(Convert.ToString(manualOpenStates[num], 2).PadLeft(32, '0')[31 - num2].ToString(), out var result2))
		{
			result = result2 == 1;
		}
		return result;
	}

	public void SavePay(long firstCharge, long totalCharge)
	{
		roleViewModel.SavePay(firstCharge, totalCharge);
		messenger.Publish(new UserInfoMessage(this, UserInfoMessage.MsgTypeEnum.ChargeDataChanged));
	}

	private void ChangeManualRewardState(int index, bool got)
	{
		int num = (index - 1) / 32;
		int num2 = (index - 1) % 32;
		int count = manualRewardStates.Count;
		if (count <= num)
		{
			for (int i = count; i < num + 1; i++)
			{
				manualRewardStates.Add(0);
			}
		}
		string text = Convert.ToString(manualRewardStates[num], 2).PadLeft(32, '0');
		text = text.Remove(31 - num2, 1);
		text = text.Insert(31 - num2, got ? "1" : "0");
		manualRewardStates[num] = Convert.ToInt32(text, 2);
	}

	private void ChangeManualOpenState(int index, bool isOpen)
	{
		int num = (index - 1) / 32;
		int num2 = (index - 1) % 32;
		int count = manualOpenStates.Count;
		if (count <= num)
		{
			for (int i = count; i < num + 1; i++)
			{
				manualOpenStates.Add(0);
			}
		}
		string text = Convert.ToString(manualOpenStates[num], 2).PadLeft(32, '0');
		text = text.Remove(31 - num2, 1);
		text = text.Insert(31 - num2, isOpen ? "1" : "0");
		manualOpenStates[num] = Convert.ToInt32(text, 2);
	}

	private void ChangeManualOpenState(List<int> indexs, bool isOpen)
	{
		if (indexs == null)
		{
			return;
		}
		foreach (int index in indexs)
		{
			ChangeManualOpenState(index, isOpen);
		}
	}

	public static void AddPlayerInfoChangeTDA()
	{
		PlayerData playerInfo = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().PlayerInfo;
		Dictionary<string, object> dictionary = CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Get();
		dictionary.Clear();
		List<Dictionary<string, object>> list = CollectionPool<List<Dictionary<string, object>>, Dictionary<string, object>>.Get();
		list.Clear();
		dictionary.Add("edit_detail", list);
		Dictionary<string, object> dictionary2 = CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Get();
		dictionary2.Clear();
		dictionary2.Add("type", "name");
		dictionary2.Add("id", "");
		dictionary2.Add("name", playerInfo.Name);
		list.Add(dictionary2);
		Dictionary<string, object> dictionary3 = CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Get();
		dictionary3.Clear();
		dictionary3.Add("type", "title");
		dictionary3.Add("id", $"{playerInfo.Title}");
		DRTitle dataRow = GameEntry.DataTable.GetDataRow<DRTitle>(playerInfo.Title);
		dictionary3.Add("name", (dataRow == null) ? "" : dataRow.Name);
		list.Add(dictionary3);
		Dictionary<string, object> dictionary4 = CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Get();
		dictionary4.Clear();
		dictionary4.Add("type", "iconFrame");
		dictionary4.Add("id", $"{playerInfo.IconFrame}");
		DRHeadDecorate dataRow2 = GameEntry.DataTable.GetDataRow<DRHeadDecorate>(playerInfo.IconFrame);
		dictionary4.Add("name", (dataRow2 == null) ? "" : dataRow2.Name);
		list.Add(dictionary4);
		Dictionary<string, object> dictionary5 = CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Get();
		dictionary5.Clear();
		dictionary5.Add("type", "icon");
		dictionary5.Add("id", $"{playerInfo.IconId}");
		dictionary5.Add("name", $"{playerInfo.IconId}");
		list.Add(dictionary5);
		RoleViewModel roleData = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData();
		if (roleData.HeroIds != null && roleData.HeroIds.Count > 0)
		{
			for (int i = 0; i < roleData.HeroIds.Count; i++)
			{
				DRHeroInfo dataRow3 = GameEntry.DataTable.GetDataRow<DRHeroInfo>(roleData.HeroIds[i]);
				Dictionary<string, object> dictionary6 = CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Get();
				dictionary6.Clear();
				dictionary6.Add("type", "hero");
				dictionary6.Add("id", $"{roleData.HeroIds[i]}");
				dictionary6.Add("name", (dataRow3 == null) ? "" : dataRow3.Name);
				list.Add(dictionary6);
			}
		}
		IBFBEService service = Singleton<ServiceSystem>.Instance.GetService<IBFBEService>();
		int chatBubbleId = service.GetChatBubble();
		string text = GameEntry.DataTable.GetDataRow((DRChatBox p) => p.Id == chatBubbleId)?.Name ?? "";
		Dictionary<string, object> dictionary7 = CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Get();
		dictionary7.Clear();
		dictionary7.Add("type", "chat_bubble");
		dictionary7.Add("id", $"{chatBubbleId}");
		dictionary7.Add("name", text ?? "");
		list.Add(dictionary7);
		List<int> cardFrameSet = service.GetCardFrameSet();
		for (int num = 0; num < 3; num++)
		{
			int num2 = ((cardFrameSet != null && cardFrameSet.Count > num) ? cardFrameSet[num] : 0);
			DRHeroCardFrame dataRow4 = GameEntry.DataTable.GetDataRow<DRHeroCardFrame>(num2);
			Dictionary<string, object> dictionary8 = CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Get();
			dictionary8.Clear();
			dictionary8.Add("type", "role_display");
			dictionary8.Add("id", $"{num2}");
			dictionary8.Add("name", dataRow4?.Name ?? "");
			dictionary8.Add("index", num + 1);
			list.Add(dictionary8);
		}
		new List<int>();
		List<int> list2 = new List<int>();
		list2 = service.GetBattleSetEmojiSetting().Item2;
		for (int num3 = 0; num3 < 3; num3++)
		{
			int num4 = ((list2 != null && list2.Count > num3) ? list2[num3] : 0);
			DRBattleEmote dataRow5 = GameEntry.DataTable.GetDataRow<DRBattleEmote>(num4);
			Dictionary<string, object> dictionary9 = CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Get();
			dictionary9.Clear();
			dictionary9.Add("type", "battle_expression");
			dictionary9.Add("id", $"{num4}");
			dictionary9.Add("name", dataRow5?.ResPath ?? "");
			dictionary9.Add("index", num3 + 1);
			list.Add(dictionary9);
		}
		int indicatorId = service.GetIndicatorSetting();
		string text2 = GameEntry.DataTable.GetDataRow((DRIndicatorRing p) => p.Id == indicatorId)?.Name ?? "";
		Dictionary<string, object> dictionary10 = CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Get();
		dictionary10.Clear();
		dictionary10.Add("type", "indicator");
		dictionary10.Add("id", $"{indicatorId}");
		dictionary10.Add("name", text2 ?? "");
		list.Add(dictionary10);
		List<PbMedalInfo> useMedals = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().PlayerInfo.WearMedals;
		int i2;
		for (i2 = 0; i2 < 4; i2++)
		{
			if (i2 < useMedals.Count)
			{
				DRAchievementMedal[] dataRows = GameEntry.DataTable.GetDataRows((DRAchievementMedal p) => p.MedalId == useMedals[i2].MedalId);
				for (int num5 = 0; num5 < dataRows.Length; num5++)
				{
					if (dataRows[num5].Rank == useMedals[i2].Rank)
					{
						Dictionary<string, object> dictionary11 = CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Get();
						dictionary11.Clear();
						dictionary11.Add("type", "glorious_feat");
						dictionary11.Add("id", dataRows[num5].Id);
						dictionary11.Add("name", dataRows[num5].Name);
						dictionary11.Add("index", i2 + 1);
						list.Add(dictionary11);
					}
				}
			}
			else
			{
				Dictionary<string, object> dictionary12 = CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Get();
				dictionary12.Clear();
				dictionary12.Add("type", "glorious_feat");
				dictionary12.Add("id", 0);
				dictionary12.Add("name", "");
				dictionary12.Add("index", i2 + 1);
				list.Add(dictionary12);
			}
		}
		TDAHandler.Instance.SendUserEvent("profile_edit", dictionary);
	}

	public void Dispose()
	{
		sub_UserInfoNotify?.Dispose();
		sub_GoldenFingerNotify?.Dispose();
	}
}
