#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Numerics;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;
using Newtonsoft.Json;
using UnityEngine;

namespace Ase;

public class MultiRoomService : IMultiRoomService
{
	private CopyEnterInfoData copyEnterInfoData;

	private CopyEnterInfoData roomInfoData;

	private string sceneLoadPath;

	private long roomId;

	private bool canAcceptInvite;

	private bool canReturnRoom;

	private bool isMatch;

	private float matchTime;

	private bool isSingleBattle;

	private MultiRoomViewModel multiRoomViewModel;

	private Action openMultiRoomAction;

	private ISubscription<MultiFightInviteFriendNotify> subscription_beInvite;

	private Action<MultiFightInviteFriendNotify> beInvitedAction;

	private ISubscription<S2C_Global_StartLoad> subscription_StartLoad;

	private ISubscription<GetBattleFieldUserFightInfoResponse> subscription_GetBattleFieldUserFightInfo;

	private ISubscription<MultiFightSinglePlayerStartLoadNotify> subscription_MultiFightSinglePlayerStartLoadNotify;

	private Action<int, int> teammateLoadingRateAction;

	private ISubscription<MultiFightLoadRateNotify> subscription_TeammateLoadingRateNotify;

	private ISubscription<S2C_MultiFightSettleNotify> syncBattleSubscription;

	private BattleResultViewModel battleResultViewModel;

	private List<KnapsackItemViewModel> rewardList;

	private BattleReward battleReward;

	private Dictionary<int, Dictionary<int, BSData>> accounts;

	private Dictionary<int, BattleRecordPointInfo> recordPointInfo;

	private AutoFightStatistics autoFightStatistics;

	private int battleReason;

	private int killedMonsterId;

	private ISubscription<MultiFightReconnectIntoBattleFieldNotify> subscription_ReturnMulti;

	private bool returnMulti;

	private Action<LoadingMultiBattleViewModel> getBattleFieldUserFightInfoAction;

	private ISubscription<MultiFightUserLeaveHalfwayNotify> subscription_UserLeaveHalfway;

	private long roomKey;

	private string ip;

	private int port;

	private uint kcpId;

	private bool getBFInfo;

	private IMultiRoomService _multiRoomServiceImplementation;

	private CampaignTeamRoomContext campaignTeamRoomContext;

	public MultiRoomService()
	{
		ReSetReward();
		canAcceptInvite = true;
		subscription_beInvite = Singleton<NetworkSystem>.Instance.Subscribe<MultiFightInviteFriendNotify>(BeInvited);
		subscription_ReturnMulti = Singleton<NetworkSystem>.Instance.Subscribe<MultiFightReconnectIntoBattleFieldNotify>(ReturnMulti);
		canReturnRoom = true;
	}

	public async UniTask<bool> RequestData()
	{
		C2S_GameInstanceSettleRequest request = C2S_GameInstanceSettleRequest.Create();
		S2C_GameInstanceSettleResponse singleBattleResponse = null;
		try
		{
			long uid = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().Uid;
			string value = PlayerPrefs.GetString($"{Constant.ConstantConfig.CopyResultSave}_{uid}", "");
			if (string.IsNullOrEmpty(value))
			{
				return true;
			}
			CopySettleInfo copySettleInfo = JsonConvert.DeserializeObject<CopySettleInfo>(value);
			PbCopySettleInfo pbCopySettleInfo = new PbCopySettleInfo();
			pbCopySettleInfo.Deaths = copySettleInfo.deaths;
			pbCopySettleInfo.PassTime = copySettleInfo.passTime;
			pbCopySettleInfo.SettleMode = copySettleInfo.settleMode;
			pbCopySettleInfo.BossHPLeft = copySettleInfo.bossHpLeft;
			if (copySettleInfo.userInfos != null)
			{
				pbCopySettleInfo.UserInfos = new List<PbCopySettleUserInfo>();
				foreach (CopySettleUserInfoCache userInfo in copySettleInfo.userInfos)
				{
					pbCopySettleInfo.UserInfos.Add(new PbCopySettleUserInfo
					{
						UserId = userInfo.userId,
						damage = userInfo.damage
					});
				}
			}
			request.CopySettleInfo = pbCopySettleInfo;
			request.CheckCode = copySettleInfo.checkCode;
			singleBattleResponse = await Singleton<NetworkSystem>.Instance.Call<S2C_GameInstanceSettleResponse>(request);
			PlayerPrefs.SetString($"{Constant.ConstantConfig.CopyResultSave}_{uid}", "");
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(singleBattleResponse, "单人战斗结算请求失败") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(singleBattleResponse.Error, "单人战斗结算请求错误"))
			{
				Singleton<ServiceSystem>.Instance.GetService<IRoleService>().UpdateRoleLevelAndExp(singleBattleResponse.AccountLevel, singleBattleResponse.AccountExp);
				Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().GetMoneyData()
					.SetMoney(MoneyEnum.Energy, singleBattleResponse.AccountEnergy);
				if (singleBattleResponse.CostGoods != null && singleBattleResponse.CostGoods.ItemId == 9400300)
				{
					MoneyDefinition.SetMoney(RoleMoneyEnum.SoulTicket, (int)singleBattleResponse.CostGoods.ItemTotal);
				}
			}
			Log.Error("请求副本掉线补偿失败！");
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error("检查副本战斗记录发生异常！" + ex2.Message + " / " + ex2.StackTrace);
		}
		finally
		{
			request.Dispose();
			singleBattleResponse?.Dispose();
		}
		return true;
	}

	public async UniTask<bool> ChangeModel(int copyId, int model, int dropRate)
	{
		MultiFightChangeModelRequest request = MultiFightChangeModelRequest.Create();
		request.CopyId = copyId;
		request.SelectModel = model;
		request.RewardTimes = dropRate;
		Debug.Log($"MultiFightChangeModelRequest RewardTimes = {dropRate}");
		MultiFightChangeModelResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<MultiFightChangeModelResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "发送协议 MultiFightChangeModelResponse") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "切换模式失败"))
			{
				Singleton<ServiceSystem>.Instance.GetService<ITeamService>()?.SetCopyMode(copyId, (BattleMode)model);
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
			Log.Error("发送协议 MultiFightChangeModelResponse，发生异常！" + ex2.Message + " / " + ex2.StackTrace);
			return false;
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public int GetModel(int copyId)
	{
		return (int)(Singleton<ServiceSystem>.Instance.GetService<ITeamService>()?.GetCopyMode(copyId) ?? BattleMode.CopyNormal);
	}

	public void SavaCopyEnterInfo(CopyEnterInfoData copyEnterInfoData)
	{
		this.copyEnterInfoData = copyEnterInfoData;
		if (sceneLoadPath == null)
		{
			sceneLoadPath = "Copy/" + copyEnterInfoData?.CopyData.SceneName;
		}
		roomInfoData = copyEnterInfoData;
	}

	public void ClearCopyEnterInfo()
	{
		copyEnterInfoData = null;
	}

	public string GetSceneLoadPath()
	{
		return sceneLoadPath;
	}

	public void SetSceneLoadPath(string path)
	{
		sceneLoadPath = path;
	}

	public CopyData GetCopyData()
	{
		return copyEnterInfoData?.CopyData;
	}

	public CopyEnterInfoData GetCopyEnterInfoData()
	{
		return copyEnterInfoData;
	}

	public void SaveRoomId(long roomId)
	{
		this.roomId = roomId;
	}

	public long GetRoomId()
	{
		return roomId;
	}

	public long GetCheckCode()
	{
		return copyEnterInfoData?.CheckCode ?? 0;
	}

	public int GetSelfHeroId()
	{
		if (copyEnterInfoData != null && copyEnterInfoData.TeamMembers != null)
		{
			foreach (TeamMember teamMember in copyEnterInfoData.TeamMembers)
			{
				if (teamMember.IsSelf)
				{
					return teamMember.HeroModel.Id;
				}
			}
		}
		return 0;
	}

	public void SaveCanAcceptInvite(bool value)
	{
		canAcceptInvite = value;
	}

	public async UniTask<bool> SendSingleBattleResult(int deaths, int passTime, int settleMode, float bossHpLeft, int monsterKill, float actorDamage, int actorKillCount, long score)
	{
		ClearData();
		ReSetReward();
		C2S_GameInstanceSettleRequest c2S_GameInstanceSettleRequest = C2S_GameInstanceSettleRequest.Create();
		PbCopySettleInfo pbCopySettleInfo = new PbCopySettleInfo();
		pbCopySettleInfo.Deaths = deaths;
		pbCopySettleInfo.PassTime = passTime;
		pbCopySettleInfo.SettleMode = settleMode;
		pbCopySettleInfo.BossHPLeft = bossHpLeft;
		pbCopySettleInfo.MonsterKillCount = monsterKill;
		pbCopySettleInfo.UserInfos = new List<PbCopySettleUserInfo>();
		PbCopyBattleInfo pbCopyBattleInfo = new PbCopyBattleInfo();
		pbCopyBattleInfo.OwnTotalDamage = (long)actorDamage;
		pbCopyBattleInfo.OwnKillCount = actorKillCount;
		long num = 0L;
		if (accounts != null)
		{
			foreach (Dictionary<int, BSData> value in accounts.Values)
			{
				if (value != null && value.ContainsKey(-1))
				{
					num += value[-1].Damage;
				}
			}
		}
		pbCopySettleInfo.UserInfos.Add(new PbCopySettleUserInfo
		{
			UserId = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().Uid,
			damage = num
		});
		c2S_GameInstanceSettleRequest.CopySettleInfo = pbCopySettleInfo;
		c2S_GameInstanceSettleRequest.CheckCode = copyEnterInfoData?.CheckCode ?? 0;
		c2S_GameInstanceSettleRequest.CopyBattleInfo = pbCopyBattleInfo;
		c2S_GameInstanceSettleRequest.Score = score;
		battleReward.PassTime = passTime;
		battleReward.AccountOldExp = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().PlayerInfo.Exp;
		try
		{
			S2C_GameInstanceSettleResponse singleBattleResponse = await Singleton<NetworkSystem>.Instance.Call<S2C_GameInstanceSettleResponse>(c2S_GameInstanceSettleRequest);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(singleBattleResponse, "单人战斗结算请求失败") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(singleBattleResponse.Error, "单人战斗结算请求错误"))
			{
				int level = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().PlayerInfo.Level;
				battleReward.IsUpgrade = singleBattleResponse.AccountLevel > level;
				Singleton<ServiceSystem>.Instance.GetService<IRoleService>().UpdateRoleLevelAndExp(singleBattleResponse.AccountLevel, singleBattleResponse.AccountExp);
				MoneyData moneyData = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().GetMoneyData();
				battleReward.CostEnergy = moneyData.GetMoney(MoneyEnum.Energy).Count - singleBattleResponse.AccountEnergy;
				if (singleBattleResponse.CostGoods != null && singleBattleResponse.CostGoods.ItemId == 9400300)
				{
					MoneyDefinition.SetMoney(RoleMoneyEnum.SoulTicket, (int)singleBattleResponse.CostGoods.ItemTotal);
				}
				moneyData.SetMoney(MoneyEnum.Energy, singleBattleResponse.AccountEnergy);
				Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().GetMoneyData()
					.SetAutoAddEnergyLastTime(singleBattleResponse.LastVitRecoverTime);
				Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().GetMoneyData()
					.OpenAutoAddEnergy();
				battleReward.AccountExpDelta = singleBattleResponse.AccountExpDelta;
				await SetRewardList(singleBattleResponse.FirstStarRewards, singleBattleResponse.RewardInPackage, 2);
				await SetRewardList(singleBattleResponse.PassRewards, singleBattleResponse.RewardInPackage);
				battleReward.Star = singleBattleResponse.Star;
				battleReward.IsWin = singleBattleResponse.IsWin;
				battleReward.IsMulti = false;
				battleReward.IsInit = true;
				battleReward.RaceCopyScore = singleBattleResponse.RaceCopyScore;
				long num2 = ((copyEnterInfoData.CopyData.CopyMainId == 3) ? singleBattleResponse.LastMaxScore : Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().GetCopyById(copyEnterInfoData.CopyData.Id)
					.CurScore);
				battleReward.IsNewRecord = singleBattleResponse.RaceCopyScore > num2;
				if (battleReward.IsWin)
				{
					if (copyEnterInfoData.CopyData.CopyMainId == 3 && singleBattleResponse.PassRewards != null)
					{
						Singleton<ServiceSystem>.Instance.GetService<ICopyService>().CopyType3RefreshCount();
					}
					Singleton<ServiceSystem>.Instance.GetService<ICopyService>().CopyComplete(copyEnterInfoData.CopyData.Id, battleReward.Star, battleReward.RaceCopyScore, isSingle: true);
				}
				foreach (PbNormalRoleInfo role in singleBattleResponse.Roles)
				{
					Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetHeroById(role.RoleId).SetFeelingData(role.TrustLevel, role.Feeling);
				}
				ClearMultiReconnect();
				int skilledMonsterId = (battleReward.IsWin ? 1 : killedMonsterId);
				Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().AddExitCopyTDA(copyEnterInfoData, battleReward.PassTime, skilledMonsterId, battleReward.RaceCopyScore, recordPointInfo, GetStar(singleBattleResponse.Star), autoFightStatistics, score, 0L);
				return true;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			SaveBattleLocal(deaths, passTime, settleMode, bossHpLeft, copyEnterInfoData.CheckCode);
			return false;
		}
		catch (Exception ex2)
		{
			Log.Error("发送单人战斗结算请求，发生异常！" + ex2.Message + " / " + ex2.StackTrace);
			return false;
		}
		SaveBattleLocal(deaths, passTime, settleMode, bossHpLeft, copyEnterInfoData.CheckCode);
		return false;
	}

	public bool GetCanReturnRoom()
	{
		return canReturnRoom;
	}

	public void SetCanReturnRoom(bool value)
	{
		canReturnRoom = value;
	}

	public async UniTask<bool> SendMultiBattleResult(int deaths, int passTime, int settleMode, float bossHpLeft, int monsterKill, float actorDamage, int actorKillCount)
	{
		try
		{
			Dictionary<long, long> playerDamages = GetPlayerDamages();
			BattleFieldSettleRequest battleFieldSettleRequest = BattleFieldSettleRequest.Create();
			PbCopySettleInfo pbCopySettleInfo = new PbCopySettleInfo();
			pbCopySettleInfo.Deaths = deaths;
			pbCopySettleInfo.PassTime = passTime;
			pbCopySettleInfo.SettleMode = settleMode;
			pbCopySettleInfo.BossHPLeft = bossHpLeft;
			pbCopySettleInfo.MonsterKillCount = monsterKill;
			pbCopySettleInfo.UserInfos = new List<PbCopySettleUserInfo>();
			PbCopyBattleInfo pbCopyBattleInfo = new PbCopyBattleInfo();
			pbCopyBattleInfo.OwnTotalDamage = (long)actorDamage;
			pbCopyBattleInfo.OwnKillCount = actorKillCount;
			if (playerDamages != null)
			{
				foreach (KeyValuePair<long, long> item in playerDamages)
				{
					pbCopySettleInfo.UserInfos.Add(new PbCopySettleUserInfo
					{
						damage = item.Value,
						UserId = item.Key
					});
				}
			}
			SetCanReturnRoom(settleMode == 1);
			battleFieldSettleRequest.CheckCode = copyEnterInfoData.CheckCode;
			battleFieldSettleRequest.CopySettleInfo = pbCopySettleInfo;
			battleFieldSettleRequest.UserId = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().Uid;
			battleFieldSettleRequest.LeaveHalfway = settleMode == 2;
			battleFieldSettleRequest.CopyBattleInfo = pbCopyBattleInfo;
			Singleton<NetworkSystem>.Instance.Call(battleFieldSettleRequest);
			battleReason = ((settleMode == 1 && bossHpLeft == -1f) ? 1 : killedMonsterId);
			return true;
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return false;
		}
		catch (Exception)
		{
			Toast.ShowInfo("游戏结束失败!");
			return false;
		}
	}

	private Dictionary<long, long> GetPlayerDamages()
	{
		Dictionary<long, long> dictionary = new Dictionary<long, long>();
		List<TeamMember> list = copyEnterInfoData?.TeamMembers ?? null;
		if (list != null)
		{
			foreach (KeyValuePair<int, Dictionary<int, BSData>> account in accounts)
			{
				for (int i = 0; i < list.Count; i++)
				{
					if (list[i].MemberId == account.Key && account.Value.ContainsKey(-1))
					{
						dictionary.Add(list[i].uid, account.Value[-1].Damage);
					}
				}
			}
		}
		return dictionary;
	}

	private void SaveBattleLocal(int deaths, int passTime, int settleMode, float bossHpLeft, long checkCode)
	{
		long uid = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().Uid;
		if (settleMode == 2 || bossHpLeft > 0f)
		{
			PlayerPrefs.SetString($"{Constant.ConstantConfig.CopyResultSave}_{uid}", "");
			return;
		}
		CopySettleInfo copySettleInfo = new CopySettleInfo();
		copySettleInfo.deaths = deaths;
		copySettleInfo.passTime = passTime;
		copySettleInfo.settleMode = settleMode;
		copySettleInfo.bossHpLeft = bossHpLeft;
		copySettleInfo.checkCode = checkCode;
		copySettleInfo.userInfos = new List<CopySettleUserInfoCache>();
		long num = 0L;
		if (accounts != null)
		{
			foreach (Dictionary<int, BSData> value2 in accounts.Values)
			{
				if (value2 != null && value2.ContainsKey(-1))
				{
					num += value2[-1].Damage;
				}
			}
		}
		copySettleInfo.userInfos.Add(new CopySettleUserInfoCache
		{
			userId = uid,
			damage = num
		});
		string value = copySettleInfo.ToJson();
		PlayerPrefs.SetString($"{Constant.ConstantConfig.CopyResultSave}_{uid}", value);
	}

	public void SaveBattleData(BattleWorldMode worldMode, Dictionary<int, Dictionary<int, BSData>> accounts, Dictionary<int, BattleRecordPointInfo> recordPointInfo, int killedMonsterId, AutoFightStatistics autoFightStatistics)
	{
		this.accounts = accounts;
		this.recordPointInfo = recordPointInfo;
		this.killedMonsterId = killedMonsterId;
		this.autoFightStatistics = autoFightStatistics;
	}

	public BattleResultViewModel GetBattleResultViewModel()
	{
		RoleViewModel roleData = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData();
		battleResultViewModel = new BattleResultViewModel(copyEnterInfoData.CopyData, copyEnterInfoData.TeamMembers, roleData, isSingleBattle, accounts, battleReward, rewardList);
		return battleResultViewModel;
	}

	private void ReSetReward()
	{
		rewardList = new List<KnapsackItemViewModel>();
		battleReward = default(BattleReward);
		battleReward.IsInit = false;
		battleReward.IsFirst = false;
		battleResultViewModel = null;
	}

	private async UniTask SetRewardList(PbDropThing pbDropThing, bool rewardInPack, int exValue = 0)
	{
		if (pbDropThing == null)
		{
			return;
		}
		if ((pbDropThing.Items != null || pbDropThing.Equips != null) && exValue == 2)
		{
			battleReward.IsFirst = true;
		}
		RewardGetData rewardGetData = await PropHelper.AnalyzeRewardFromServer(pbDropThing, rewardInPack);
		if (rewardGetData == null)
		{
			return;
		}
		foreach (PropDataBase item in PropHelper.MergeProp(rewardGetData.PropList))
		{
			if (item.PropTypeEnum == PropTypeEnum.Equipment || item.PropTypeEnum == PropTypeEnum.SuitBox)
			{
				if (item is ArmourData data)
				{
					ArmourItemData armourItemData = new ArmourItemData(null, data);
					armourItemData.ExValue = exValue;
					rewardList.Add(armourItemData);
				}
				continue;
			}
			if (item.PropTypeEnum == PropTypeEnum.Weapon)
			{
				if (item is WeaponData weaponData)
				{
					weaponData.SetWeaponIcon(2);
					WeaponItemData weaponItemData = new WeaponItemData(null, weaponData);
					weaponItemData.ExValue = exValue;
					rewardList.Add(weaponItemData);
				}
				continue;
			}
			KnapsackItemViewModel knapsackItemViewModel = new KnapsackItemViewModel(null, item);
			knapsackItemViewModel.ExValue = exValue;
			if (knapsackItemViewModel.PropDataBase.PropTypeEnum == PropTypeEnum.BattlePropDrawing)
			{
				if (rewardInPack)
				{
					rewardList.Add(knapsackItemViewModel);
				}
			}
			else
			{
				rewardList.Add(knapsackItemViewModel);
			}
		}
	}

	public BattleReward GetBattleReward()
	{
		return battleReward;
	}

	private async void SaveMultiBattleResult(S2C_MultiFightSettleNotify message)
	{
		ClearData();
		ReSetReward();
		battleReward.AccountOldExp = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().PlayerInfo.Exp;
		try
		{
			ClearMultiReconnect();
			int level = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().PlayerInfo.Level;
			battleReward.IsUpgrade = message.AccountLevel > level;
			Singleton<ServiceSystem>.Instance.GetService<IRoleService>().UpdateRoleLevelAndExp(message.AccountLevel, message.AccountExp);
			MoneyData moneyData = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().GetMoneyData();
			battleReward.CostEnergy = moneyData.GetMoney(MoneyEnum.Energy).Count - message.AccountEnergy;
			moneyData.SetMoney(MoneyEnum.Energy, message.AccountEnergy);
			Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().GetMoneyData()
				.SetAutoAddEnergyLastTime(message.LastVitRecoverTime);
			Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().GetMoneyData()
				.OpenAutoAddEnergy();
			PbItemChange costGoods = message.CostGoods;
			if (costGoods != null && costGoods.ItemId == 9400300)
			{
				MoneyDefinition.SetMoney(RoleMoneyEnum.SoulTicket, (int)message.CostGoods.ItemTotal);
			}
			battleReward.AccountExpDelta = message.AccountExpDelta;
			await SetRewardList(message.StarRewards, message.RewardInPackage, 2);
			await SetRewardList(message.ExtraRewards, message.RewardInPackage, 1);
			await SetRewardList(message.PassRewards, message.RewardInPackage);
			battleReward.Star = message.Star;
			battleReward.IsWin = message.IsWin;
			battleReward.PassTime = message.PassTime;
			battleReward.IsMulti = true;
			battleReward.IsInit = true;
			battleReward.RaceCopyScore = message.Score;
			long num = ((copyEnterInfoData.CopyData.CopyMainId == 3) ? message.LastMaxScore : Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().GetCopyById(copyEnterInfoData.CopyData.Id)
				.CurScore);
			battleReward.IsNewRecord = message.Score > num;
			battleReward.TeamInfos = new List<TeamInfo>();
			if (battleReward.IsWin)
			{
				if (copyEnterInfoData.CopyData.CopyMainId == 3 && message.PassRewards != null)
				{
					Singleton<ServiceSystem>.Instance.GetService<ICopyService>().CopyType3RefreshCount();
				}
				Singleton<ServiceSystem>.Instance.GetService<ICopyService>().CopyComplete(copyEnterInfoData.CopyData.Id, battleReward.Star, battleReward.RaceCopyScore, isSingle: false);
			}
			int skilledMonsterId = (message.IsWin ? 1 : battleReason);
			long num2 = 0L;
			if (accounts != null)
			{
				foreach (Dictionary<int, BSData> value in accounts.Values)
				{
					if (value != null && value.ContainsKey(-1))
					{
						num2 += value[-1].Damage;
					}
				}
			}
			Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().AddExitCopyTDA(copyEnterInfoData, message.PassTime, skilledMonsterId, message.Score, recordPointInfo, GetStar(message.Star), autoFightStatistics, 0L, num2);
			long uid = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().Uid;
			foreach (PbCopyTeamInfo teamInfo in message.TeamInfos)
			{
				if (teamInfo.UserId != uid)
				{
					TeamInfo item = new TeamInfo
					{
						Icon = teamInfo.Icon,
						Level = teamInfo.Level,
						Title = teamInfo.Title,
						IconFrame = teamInfo.IconFrame,
						RoleId = teamInfo.RoleId,
						UserId = teamInfo.UserId,
						UserName = teamInfo.UserName
					};
					battleReward.TeamInfos.Add(item);
				}
			}
			if (message.Role != null)
			{
				Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetHeroById(message.Role.RoleId).SetFeelingData(message.Role.TrustLevel, message.Role.Feeling);
			}
			if (subscription_UserLeaveHalfway != null)
			{
				subscription_UserLeaveHalfway.Dispose();
				subscription_UserLeaveHalfway = null;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception)
		{
		}
	}

	private int GetStar(int star)
	{
		return BitOperations.PopCount((uint)star);
	}

	private void ClearData()
	{
		battleResultViewModel = null;
		if (syncBattleSubscription != null)
		{
			syncBattleSubscription.Dispose();
			syncBattleSubscription = null;
		}
	}

	public void ClearBattleResult()
	{
		campaignTeamRoomContext = null;
		battleResultViewModel = null;
		battleReward.IsInit = false;
		battleReason = 0;
		canAcceptInvite = true;
	}

	public void ReleaseRoom()
	{
		if (multiRoomViewModel != null)
		{
			multiRoomViewModel.Close();
			multiRoomViewModel = null;
		}
	}

	public void SetRoom(MultiRoomViewModel viewModel)
	{
		multiRoomViewModel = viewModel;
	}

	public void AddSyncBattleSubscription()
	{
		ClearData();
		syncBattleSubscription = Singleton<NetworkSystem>.Instance.Subscribe<S2C_MultiFightSettleNotify>(SaveMultiBattleResult);
	}

	public void SendLeaveCopyRequest()
	{
		MultiFightLeaveCopyRequest multiFightLeaveCopyRequest = MultiFightLeaveCopyRequest.Create();
		multiFightLeaveCopyRequest.UserId = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().Uid;
		Singleton<NetworkSystem>.Instance.Call(multiFightLeaveCopyRequest);
		SaveRoomId(0L);
	}

	public MultiRoomViewModel GetMultiRoomViewModel()
	{
		return multiRoomViewModel;
	}

	public async UniTask<ProtocolRequestResult> CreateMultiRoom(CopyData copyData, bool loadCacheDropRate = false, int campaignPlayId = 0)
	{
		CreateRoomRequest createRoomRequest = CreateRoomRequest.Create();
		createRoomRequest.Difficulty = copyData.CopyRank;
		createRoomRequest.SelectModel = GetModel(copyData.Id);
		createRoomRequest.CopyId = copyData.Id;
		createRoomRequest.RewardTimes = copyData.DropRate;
		createRoomRequest.PlayId = campaignPlayId;
		Debug.Log($"CreateRoomRequest RewardTimes = {copyData.DropRate}");
		createRoomRequest.ClientVersion = GameEntry.Setting.GetString("版本信息");
		try
		{
			CreateRoomResponse createRoomResponse = await Singleton<NetworkSystem>.Instance.Call<CreateRoomResponse>(createRoomRequest);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(createRoomResponse, "创建房间"))
			{
				if (Singleton<NetResponseHandler>.Instance.ValidateErrorCode(createRoomResponse.Error, "创建房间失败"))
				{
					SaveRoomId(createRoomResponse.RoomInfo.RoomId);
					List<MatchRoomUserInfo> list = new List<MatchRoomUserInfo>();
					for (int i = 0; i < createRoomResponse.RoomInfo.Gamers.Count; i++)
					{
						list.Add(new MatchRoomUserInfo(createRoomResponse.RoomInfo.Gamers[i].CapFlag, createRoomResponse.RoomInfo.Gamers[i].UserId, createRoomResponse.RoomInfo.Gamers[i].SeatId, createRoomResponse.RoomInfo.Gamers[i].State, createRoomResponse.RoomInfo.Gamers[i].SelectModel, createRoomResponse.RoomInfo.Gamers[i].UserBaseInfo.Icon, createRoomResponse.RoomInfo.Gamers[i].UserBaseInfo.Name, createRoomResponse.RoomInfo.Gamers[i].RoleInfo.RoleId, createRoomResponse.RoomInfo.Gamers[i].RoleInfo.Star, createRoomResponse.RoomInfo.Gamers[i].RoleInfo.Level, createRoomResponse.RoomInfo.Gamers[i].RoleInfo.SkinId, createRoomResponse.RoomInfo.Gamers[i].HeroCardFrame, createRoomResponse.RoomInfo.Gamers[i].RoleInfo.SeatLevel, Singleton<ServiceSystem>.Instance.GetService<IHomeLandService>().GetBPCarryings(createRoomResponse.RoomInfo.Gamers[i].BattleProp)));
					}
					multiRoomViewModel = new MultiRoomViewModel(null, copyData, list, loadCacheDropRate);
					openMultiRoomAction();
					return ProtocolRequestResult.Success;
				}
				return ProtocolRequestResult.ServerErrorCode;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return ProtocolRequestResult.Exception;
		}
		catch (Exception ex2)
		{
			Log.Error("创建房间请求，发生异常！" + ex2.Message + " / " + ex2.StackTrace);
			return ProtocolRequestResult.Exception;
		}
		return ProtocolRequestResult.Exception;
	}

	public void AddOpenMultiRoomAction(Action action)
	{
		openMultiRoomAction = action;
	}

	public async void InviteOperate(int ope, long inviteUserId, long roomId, int model, CopyData copyData = null)
	{
		MultiFightHandleInviteOpeRequest request = MultiFightHandleInviteOpeRequest.Create();
		request.Ope = ope;
		request.InviteUserId = inviteUserId;
		request.RoomId = roomId;
		request.SelectModel = model;
		MultiFightHandleInviteOpeResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<MultiFightHandleInviteOpeResponse>(request);
			if (ope == 1 && Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "战斗确认请求") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "战斗确认请求失败"))
			{
				SaveRoomId(response.RoomInfo.RoomId);
				List<MatchRoomUserInfo> list = new List<MatchRoomUserInfo>();
				for (int i = 0; i < response.RoomInfo.Gamers.Count; i++)
				{
					list.Add(new MatchRoomUserInfo(response.RoomInfo.Gamers[i].CapFlag, response.RoomInfo.Gamers[i].UserId, response.RoomInfo.Gamers[i].SeatId, response.RoomInfo.Gamers[i].State, response.RoomInfo.Gamers[i].SelectModel, response.RoomInfo.Gamers[i].UserBaseInfo.Icon, response.RoomInfo.Gamers[i].UserBaseInfo.Name, response.RoomInfo.Gamers[i].RoleInfo.RoleId, response.RoomInfo.Gamers[i].RoleInfo.Star, response.RoomInfo.Gamers[i].RoleInfo.Level, response.RoomInfo.Gamers[i].RoleInfo.SkinId, response.RoomInfo.Gamers[i].HeroCardFrame, response.RoomInfo.Gamers[i].RoleInfo.SeatLevel, Singleton<ServiceSystem>.Instance.GetService<IHomeLandService>().GetBPCarryings(response.RoomInfo.Gamers[i].BattleProp)));
				}
				multiRoomViewModel = new MultiRoomViewModel(null, copyData, list);
				openMultiRoomAction();
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Toast.ShowInfo("当前无法接受战斗邀请");
			Log.Error("战斗确认请求，发生异常！" + ex2.Message + " / " + ex2.StackTrace);
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
	}

	private void BeInvited(MultiFightInviteFriendNotify message)
	{
		if (canAcceptInvite && !GameEntry.Setting.GetBool("自动拒绝玩家邀请"))
		{
			beInvitedAction?.Invoke(message);
		}
	}

	public void BindInviteMessage(Action<MultiFightInviteFriendNotify> action, bool bind)
	{
		if (bind)
		{
			beInvitedAction = (Action<MultiFightInviteFriendNotify>)Delegate.Combine(beInvitedAction, action);
		}
		else
		{
			beInvitedAction = (Action<MultiFightInviteFriendNotify>)Delegate.Remove(beInvitedAction, action);
		}
	}

	public async UniTask<MultiRoomData> TryJoinFriendTeam(long friendUid, long roomId)
	{
		if (!canAcceptInvite)
		{
			Toast.ShowInfo("当前状态无法加入其他玩家队伍");
			return default(MultiRoomData);
		}
		MultiFightEnterMatchRoomRequest request = MultiFightEnterMatchRoomRequest.Create();
		request.RoomId = roomId;
		request.FriendUserId = friendUid;
		request.ClientVersion = GameEntry.Setting.GetString("版本信息");
		MultiFightEnterMatchRoomResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<MultiFightEnterMatchRoomResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "组队") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "组队失败"))
			{
				CopyData copyData = Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().GetCopyById(response.MatchRoomInfo.CopyId);
				if (copyData == null)
				{
					Log.Error($"找不到副本数据{response.MatchRoomInfo.CopyId}");
					copyData = CopyData.CreateTemp(GameEntry.DataTable.GetDataRow<DRCopy>(response.MatchRoomInfo.CopyId));
				}
				return new MultiRoomData(response, copyData);
			}
			return default(MultiRoomData);
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return default(MultiRoomData);
		}
		catch (Exception ex2)
		{
			Log.Error("申请加入多人队伍，发生异常！" + ex2.Message + " / " + ex2.StackTrace);
			return default(MultiRoomData);
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
	}

	public async UniTask<bool> TrySendTeamInvite(long playerUid)
	{
		try
		{
			MultiFightInviteFriendRequest multiFightInviteFriendRequest = MultiFightInviteFriendRequest.Create();
			multiFightInviteFriendRequest.FriendIds = new List<long> { playerUid };
			MultiFightInviteFriendResponse multiFightInviteFriendResponse = await Singleton<NetworkSystem>.Instance.Call<MultiFightInviteFriendResponse>(multiFightInviteFriendRequest);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(multiFightInviteFriendResponse, "发送队伍邀请") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(multiFightInviteFriendResponse.Error, "发送队伍邀请失败"))
			{
				Toast.ShowInfo("邀请已发送");
				return true;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return false;
		}
		catch (Exception value)
		{
			Console.WriteLine(value);
			return false;
		}
		return false;
	}

	private void ServiceSendLoginBattleGate(S2C_Global_StartLoad message)
	{
		roomKey = message.Key;
		string[] array = message.Address.Split(":");
		ip = array[0];
		port = int.Parse(array[1]);
		kcpId = (uint)message.KcpConnectId;
		GetBattleFieldUserFightInfoRequest getBattleFieldUserFightInfoRequest = new GetBattleFieldUserFightInfoRequest();
		getBattleFieldUserFightInfoRequest.UserId = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().Uid;
		Singleton<NetworkSystem>.Instance.Call(getBattleFieldUserFightInfoRequest);
	}

	public void SendGetBattleFieldRequest()
	{
		GetBattleFieldUserFightInfoRequest getBattleFieldUserFightInfoRequest = new GetBattleFieldUserFightInfoRequest();
		getBattleFieldUserFightInfoRequest.UserId = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().Uid;
		Singleton<NetworkSystem>.Instance.Call(getBattleFieldUserFightInfoRequest);
	}

	private void ReturnMulti(MultiFightReconnectIntoBattleFieldNotify notify)
	{
		returnMulti = true;
		roomKey = notify.LoginKey;
		string[] array = notify.Address.Split(":");
		ip = array[0];
		port = int.Parse(array[1]);
		kcpId = (uint)notify.KcpConnectId;
	}

	public async UniTask<bool> AddMultiBackListener(Action<LoadingMultiBattleViewModel> action)
	{
		if (!returnMulti)
		{
			return false;
		}
		getBattleFieldUserFightInfoAction = null;
		getBattleFieldUserFightInfoAction = (Action<LoadingMultiBattleViewModel>)Delegate.Combine(getBattleFieldUserFightInfoAction, action);
		subscription_GetBattleFieldUserFightInfo = Singleton<NetworkSystem>.Instance.Subscribe<GetBattleFieldUserFightInfoResponse>(GetBattleFieldUserFightInfo);
		subscription_UserLeaveHalfway = Singleton<NetworkSystem>.Instance.Subscribe<MultiFightUserLeaveHalfwayNotify>(UserLeaveHalfWay);
		GetBattleFieldUserFightInfoRequest getBattleFieldUserFightInfoRequest = GetBattleFieldUserFightInfoRequest.Create();
		getBattleFieldUserFightInfoRequest.UserId = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().Uid;
		Singleton<NetworkSystem>.Instance.Call(getBattleFieldUserFightInfoRequest);
		return true;
	}

	public async UniTask<bool> AddMultiListener(Action<LoadingMultiBattleViewModel> action)
	{
		getBattleFieldUserFightInfoAction = null;
		getBattleFieldUserFightInfoAction = (Action<LoadingMultiBattleViewModel>)Delegate.Combine(getBattleFieldUserFightInfoAction, action);
		return true;
	}

	public void RegisterMultiMessage()
	{
		subscription_GetBattleFieldUserFightInfo = Singleton<NetworkSystem>.Instance.Subscribe<GetBattleFieldUserFightInfoResponse>(GetBattleFieldUserFightInfo);
		subscription_MultiFightSinglePlayerStartLoadNotify = Singleton<NetworkSystem>.Instance.Subscribe<MultiFightSinglePlayerStartLoadNotify>(GetMultiBattleSingleUserFightInfo);
		subscription_StartLoad = Singleton<NetworkSystem>.Instance.Subscribe<S2C_Global_StartLoad>(ServiceSendLoginBattleGate);
	}

	public void UnregisterMultiMessage()
	{
		if (subscription_StartLoad != null)
		{
			subscription_StartLoad.Dispose();
			subscription_StartLoad = null;
		}
		if (subscription_GetBattleFieldUserFightInfo != null)
		{
			subscription_GetBattleFieldUserFightInfo.Dispose();
			subscription_GetBattleFieldUserFightInfo = null;
			getBattleFieldUserFightInfoAction = null;
		}
		if (subscription_MultiFightSinglePlayerStartLoadNotify != null)
		{
			subscription_MultiFightSinglePlayerStartLoadNotify.Dispose();
			subscription_MultiFightSinglePlayerStartLoadNotify = null;
			getBattleFieldUserFightInfoAction = null;
		}
	}

	private void UserLeaveHalfWay(MultiFightUserLeaveHalfwayNotify notify)
	{
		Toast.ShowInfo(notify.Name + "已退出战斗");
	}

	private void GetBattleFieldUserFightInfo(GetBattleFieldUserFightInfoResponse message)
	{
		canAcceptInvite = false;
		SetIsSingleBattle(value: false);
		if (getBFInfo)
		{
			return;
		}
		getBFInfo = true;
		if (roomKey == 0L)
		{
			Log.Error("RoomKey 为 0 ！");
		}
		try
		{
			CopyData copyById = Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().GetCopyById(message.CopyId);
			if (copyById == null)
			{
				Log.Error($"客户端找不到副本Id为【{message.CopyId}】的副本！");
				return;
			}
			List<TeamMember> list = new List<TeamMember>();
			int selfIndex = 0;
			long uid = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().Uid;
			for (int i = 0; i < message.Users.Count; i++)
			{
				WeaponData heldWeapon = WeaponData.CreateEmpty();
				PbRoomRoleInfo role = message.Users[i].Role;
				if (role.Weapon != null)
				{
					heldWeapon = Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().CreateWeapon(role.Weapon);
				}
				Dictionary<int, ArmourData> dictionary = new Dictionary<int, ArmourData>();
				if (role.Armours != null)
				{
					foreach (PbEquipBase armour in role.Armours)
					{
						ArmourData armourData = Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().CreateArmour(armour);
						if (armourData != null)
						{
							dictionary.Add((int)armourData.ArmourEnum, armourData);
						}
					}
				}
				if (role.Suitbox != null)
				{
					ArmourData armourData2 = Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().CreateArmour(role.Suitbox);
					if (armourData2 != null)
					{
						dictionary.Add((int)armourData2.ArmourEnum, armourData2);
					}
				}
				Dictionary<int, HCTalentData> dictionary2 = new Dictionary<int, HCTalentData>();
				foreach (PbRoleTalent talent in role.Talents)
				{
					dictionary2.Add(talent.SkillId, HCTalentData.Create(talent.SkillId, talent.SkillLevel, talent.MaxOrderId));
				}
				Dictionary<int, int> dictionary3 = new Dictionary<int, int>();
				for (int j = 0; j < role.SkillSkinIds.Count; j++)
				{
					dictionary3.Add(role.SkillSkinIds[j].Id, role.SkillSkinIds[j].Value);
				}
				HeroModel heroModel = HeroModel.CreateMulti(role.RoleId, role.SkinId, role.Star, role.Level, 0L, dictionary3, heldWeapon, dictionary, dictionary2, role.SeatLevel);
				heroModel.SeatId = message.Users[i].SeatId;
				heroModel.AddBPData(Singleton<ServiceSystem>.Instance.GetService<IHomeLandService>().GetBPCarryings(message.Users[i].BattleProp));
				if (message.Users[i].UserId == uid)
				{
					selfIndex = i;
				}
				TeamMember teamMember = TeamMember.CreateMulti(message.Users[i].SeatId, message.Users[i].UserBaseInfo.Name, message.Users[i].UserBaseInfo.Icon, message.Users[i].SeatId == 1, heroModel, message.Users[i].UserId, message.Users[i].UnionId, message.Users[i].UserBaseInfo.IsFirst, message.Difficult, message.Users[i].UserId == uid);
				teamMember.heroCardFrame = message.Users[i].HeroCardFrame;
				list.Add(teamMember);
			}
			for (int k = 0; k < list.Count; k++)
			{
				list[k].HeroModel.ResetOuterBuff();
			}
			for (int l = 0; l < list.Count; l++)
			{
				if (list[l].guildId == 0L)
				{
					continue;
				}
				for (int m = 0; m < list.Count; m++)
				{
					if (l != m && list[m].guildId != 0L && list[l].guildId == list[m].guildId && list[l].guildId != 0L)
					{
						list[l].HeroModel.AddGuildTeammateBuff();
						list[m].HeroModel.AddGuildTeammateBuff();
					}
				}
			}
			List<PeripheryHeroData> list2 = new List<PeripheryHeroData>();
			for (int n = 0; n < list.Count; n++)
			{
				if (list[n].HeroModel.GetOuterBuff(OuterBuffEnum.GuildBuff) == 0 && list[n].guildId != 0L)
				{
					list[n].HeroModel.AddGuildBaseBuff();
				}
				if ((copyById.IsNeedFirst && !list[n].isFirst) || !copyById.IsNeedFirst)
				{
					list[n].HeroModel.AddOuterBuff(OuterBuffEnum.CopyFirstAccessBuff, copyById.CopyEnvironId);
				}
				PeripheryHeroData peripheryHeroData = list[n].GetPeripheryHeroData();
				bool isSelf = message.Users[n].UserId == uid;
				ApplySelectBattleEmojiToHeroData(peripheryHeroData, message.Users[n].SelectBattleEmoji, isSelf);
				list2.Add(peripheryHeroData);
			}
			List<AchievementMedal> battleAchievementMedals = Singleton<ServiceSystem>.Instance.GetService<IAchievementService>().GetBattleAchievementMedals();
			WorldData worldData = null;
			if (copyById.CopyMainId == 6 || copyById.CopyMainId == 8 || copyById.CopyMainId == Constant.ConstantConfig.GuildCopyType)
			{
				worldData = ActivityBattleWorldData.Create(copyById.Id, 0u, list2, null, message.Seed, message.RoomId, roomKey, 0, Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().Uid, selfIndex, ip, port, kcpId, battleAchievementMedals, 0, BattleWorldMode.SyncBattle, returnMulti ? LockStepWorldType.Reconnect : LockStepWorldType.Normal);
			}
			else if (copyById.CopyMainId == 91)
			{
				worldData = CampaignBattleWorldData.Create(copyById.Id, 0u, list2, list, message.Seed, message.RoomId, roomKey, uid, selfIndex, ip, port, kcpId, battleAchievementMedals, returnMulti ? LockStepWorldType.Reconnect : LockStepWorldType.Normal);
				SetSceneLoadPath(worldData.SceneLoadPath);
			}
			else
			{
				worldData = LockstepBattleWorldData.CreateSyncWorldData(0u, copyById.SceneName, copyById.Id, copyById.GetBossId(0), copyById.MapData, null, copyById.NavMeshId, list2, list, null, message.Seed, message.RoomId, roomKey, returnMulti ? LockStepWorldType.Reconnect : LockStepWorldType.Normal, uid, selfIndex, ip, port, kcpId, battleAchievementMedals);
			}
			LoadingMultiBattleViewModel loadingMultiBattleViewModel = null;
			AddSyncBattleSubscription();
			loadingMultiBattleViewModel = ((!returnMulti) ? new LoadingMultiBattleViewModel("Outer/Outer", autoUnload: true, worldData, list) : new LoadingMultiBattleBackViewModel("Outer/Outer", autoUnload: true, worldData, list));
			CopyEnterInfoData copyEnterInfoData = new CopyEnterInfoData
			{
				CopyData = copyById,
				TeamMembers = list,
				MaterialId = 0,
				CheckCode = message.CheckCode,
				RoomId = message.RoomId,
				SeedID = message.Seed,
				IsSingle = false,
				IsMatch = isMatch,
				MatchTime = matchTime,
				IsBattleSend = 0,
				IsCampaignBattle = (copyById.CopyMainId == 91)
			};
			SavaCopyEnterInfo(copyEnterInfoData);
			if (copyById.CopyMainId == 6 || copyById.CopyMainId == 8 || copyById.CopyMainId == Constant.ConstantConfig.GuildCopyType)
			{
				sceneLoadPath = worldData.SceneLoadPath;
			}
			getBattleFieldUserFightInfoAction?.Invoke(loadingMultiBattleViewModel);
			getBattleFieldUserFightInfoAction = null;
			subscription_UserLeaveHalfway = Singleton<NetworkSystem>.Instance.Subscribe<MultiFightUserLeaveHalfwayNotify>(UserLeaveHalfWay);
		}
		catch (Exception ex)
		{
			canAcceptInvite = true;
			Log.Error("创建多人Loading发生异常！ " + ex.Message + " / " + ex.StackTrace);
		}
		getBFInfo = false;
	}

	private static void ApplySelectBattleEmojiToHeroData(PeripheryHeroData heroData, List<int> selectBattleEmoji, bool isSelf)
	{
		if (heroData == null)
		{
			return;
		}
		heroData.RoundEmojis.Clear();
		if (selectBattleEmoji != null)
		{
			for (int i = 0; i < selectBattleEmoji.Count; i++)
			{
				heroData.RoundEmojis.Add(selectBattleEmoji[i]);
			}
		}
		if (!isSelf)
		{
			return;
		}
		heroData.RoundEmojis.Clear();
		heroData.FightEventEmojisDic.Clear();
		List<int> list = new List<int>();
		List<int> list2 = new List<int>();
		(List<int>, List<int>) battleSetEmojiSetting = Singleton<ServiceSystem>.Instance.GetService<IBFBEService>().GetBattleSetEmojiSetting();
		list = battleSetEmojiSetting.Item1;
		list2 = battleSetEmojiSetting.Item2;
		for (int j = 0; j < 8; j++)
		{
			if (j < list.Count)
			{
				heroData.RoundEmojis.Add(list[j]);
			}
			else
			{
				heroData.RoundEmojis.Add(0);
			}
		}
		heroData.FightEventEmojisDic[BattleObserverEventEnum.BattleStart] = 0;
		heroData.FightEventEmojisDic[BattleObserverEventEnum.MonsterFuzzy] = 0;
		heroData.FightEventEmojisDic[BattleObserverEventEnum.EntityDead] = 0;
		List<BattleObserverEventEnum> list3 = heroData.FightEventEmojisDic.Keys.ToList();
		for (int k = 0; k < list3.Count; k++)
		{
			if (k < list2.Count)
			{
				heroData.FightEventEmojisDic[list3[k]] = list2[k];
			}
		}
	}

	private async void GetMultiBattleSingleUserFightInfo(MultiFightSinglePlayerStartLoadNotify message)
	{
		canAcceptInvite = false;
		SetIsSingleBattle(value: false);
		if (getBFInfo)
		{
			return;
		}
		getBFInfo = true;
		try
		{
			CopyData copyById = Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().GetCopyById(message.CopyId);
			if (copyById == null)
			{
				Log.Error($"客户端找不到副本Id为【{message.CopyId}】的副本！");
				return;
			}
			List<TeamMember> list = new List<TeamMember>();
			int selfIndex = 0;
			long uid = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().Uid;
			WeaponData heldWeapon = WeaponData.CreateEmpty();
			PbRoomRoleInfo role = message.User.Role;
			if (role.Weapon != null)
			{
				heldWeapon = Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().CreateWeapon(role.Weapon);
			}
			Dictionary<int, ArmourData> dictionary = new Dictionary<int, ArmourData>();
			if (role.Armours != null)
			{
				foreach (PbEquipBase armour in role.Armours)
				{
					ArmourData armourData = Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().CreateArmour(armour);
					if (armourData != null)
					{
						dictionary.Add((int)armourData.ArmourEnum, armourData);
					}
				}
			}
			if (role.Suitbox != null)
			{
				ArmourData armourData2 = Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().CreateArmour(role.Suitbox);
				if (armourData2 != null)
				{
					dictionary.Add((int)armourData2.ArmourEnum, armourData2);
				}
			}
			Dictionary<int, HCTalentData> dictionary2 = new Dictionary<int, HCTalentData>();
			foreach (PbRoleTalent talent in role.Talents)
			{
				dictionary2.Add(talent.SkillId, HCTalentData.Create(talent.SkillId, talent.SkillLevel, talent.MaxOrderId));
			}
			Dictionary<int, int> dictionary3 = new Dictionary<int, int>();
			for (int i = 0; i < role.SkillSkinIds.Count; i++)
			{
				dictionary3.Add(role.SkillSkinIds[i].Id, role.SkillSkinIds[i].Value);
			}
			HeroModel heroModel = HeroModel.CreateMulti(role.RoleId, role.SkinId, role.Star, role.Level, 0L, dictionary3, heldWeapon, dictionary, dictionary2, role.SeatLevel);
			heroModel.SeatId = message.User.SeatId;
			heroModel.AddBPData(Singleton<ServiceSystem>.Instance.GetService<IHomeLandService>().GetBPCarryings(message.User.BattleProp));
			TeamMember teamMember = TeamMember.CreateMulti(message.User.SeatId, message.User.UserBaseInfo.Name, message.User.UserBaseInfo.Icon, message.User.SeatId == 1, heroModel, message.User.UserId, message.User.UnionId, message.User.UserBaseInfo.IsFirst, message.Difficult, message.User.UserId == uid);
			teamMember.heroCardFrame = message.User.HeroCardFrame;
			list.Add(teamMember);
			for (int j = 0; j < list.Count; j++)
			{
				list[j].HeroModel.ResetOuterBuff();
			}
			for (int k = 0; k < list.Count; k++)
			{
				if (list[k].guildId == 0L)
				{
					continue;
				}
				for (int l = 0; l < list.Count; l++)
				{
					if (k != l && list[l].guildId != 0L && list[k].guildId == list[l].guildId && list[k].guildId != 0L)
					{
						list[k].HeroModel.AddGuildTeammateBuff();
						list[l].HeroModel.AddGuildTeammateBuff();
					}
				}
			}
			List<PeripheryHeroData> list2 = new List<PeripheryHeroData>();
			for (int m = 0; m < list.Count; m++)
			{
				if (list[m].HeroModel.GetOuterBuff(OuterBuffEnum.GuildBuff) == 0 && list[m].guildId != 0L)
				{
					list[m].HeroModel.AddGuildBaseBuff();
				}
				if ((copyById.IsNeedFirst && !list[m].isFirst) || !copyById.IsNeedFirst)
				{
					list[m].HeroModel.AddOuterBuff(OuterBuffEnum.CopyFirstAccessBuff, copyById.CopyEnvironId);
				}
				PeripheryHeroData peripheryHeroData = list[m].GetPeripheryHeroData();
				bool isSelf = message.User.UserId == uid;
				ApplySelectBattleEmojiToHeroData(peripheryHeroData, message.User.SelectBattleEmoji, isSelf);
				list2.Add(peripheryHeroData);
			}
			List<AchievementMedal> battleAchievementMedals = Singleton<ServiceSystem>.Instance.GetService<IAchievementService>().GetBattleAchievementMedals();
			BattleMode battleMode = Singleton<ServiceSystem>.Instance.GetService<ITeamService>()?.GetCopyMode(copyById.Id) ?? BattleMode.CopyNormal;
			CopyEnterInfoData copyEnterInfoData = new CopyEnterInfoData
			{
				CopyData = copyById,
				TeamMembers = list,
				MaterialId = 0,
				CheckCode = message.CheckCode,
				RoomId = message.RoomId,
				SeedID = message.Seed,
				IsSingle = false,
				IsMatch = isMatch,
				MatchTime = matchTime,
				IsBattleSend = ((battleMode != BattleMode.CopyPractice) ? 1 : 2),
				IsCampaignBattle = (copyById.CopyMainId == 91)
			};
			SavaCopyEnterInfo(copyEnterInfoData);
			WorldData worldData;
			if (copyById.CopyMainId == 6 || copyById.CopyMainId == 8 || copyById.CopyMainId == Constant.ConstantConfig.GuildCopyType)
			{
				worldData = ActivityBattleWorldData.Create(copyById.Id, 0u, list2, null, message.Seed, message.RoomId, 0L, 0, Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().Uid, 0, "", 0, 0u, battleAchievementMedals, 0);
				SetSceneLoadPath(worldData.SceneLoadPath);
			}
			else if (copyById.CopyMainId == 91)
			{
				worldData = CampaignBattleWorldData.Create(copyById.Id, 0u, list2, list, message.Seed, message.RoomId, roomKey, uid, selfIndex, ip, port, kcpId, battleAchievementMedals, returnMulti ? LockStepWorldType.Reconnect : LockStepWorldType.Normal);
				SetSceneLoadPath(worldData.SceneLoadPath);
			}
			else
			{
				worldData = BattleWorldData.CreateBattleWorldData(0u, copyById.SceneName, copyById.Id, copyById.GetBossId(0), copyById.MapData, copyById.NavMeshId, list2, list, null, battleAchievementMedals);
			}
			worldData.RoomId = message.RoomId;
			worldData.RandomSeed = message.Seed;
			AddSyncBattleSubscription();
			subscription_UserLeaveHalfway = Singleton<NetworkSystem>.Instance.Subscribe<MultiFightUserLeaveHalfwayNotify>(UserLeaveHalfWay);
			worldData.IsBattleSend = copyEnterInfoData.IsBattleSend;
			LoadingSingleViewModel loadingSingleViewModel = new LoadingSingleViewModel("Outer/Outer", autoUnload: true, worldData);
			DRLoadingTips randomLoadingTap = await Singleton<ServiceSystem>.Instance.GetService<ILoadingService>().PrepareLoading(GameProcessType.Battle);
			loadingSingleViewModel.SetRandomLoadingTap(randomLoadingTap);
			await GameEntry.UI.OpenWindow<LoadingWindow>("Loading/LoadingWindow", "LOADING", loadingSingleViewModel);
			await UniTask.WaitUntil(() => loadingSingleViewModel.IsLoadingFinish);
			if (loadingSingleViewModel.LoadingSuccess)
			{
				UIWindowHelper.WindowRelease();
				await loadingSingleViewModel.CloseLoading();
				Singleton<ServiceSystem>.Instance.GetService<ILoadingService>().LoadingEnd(loadingSingleViewModel.LoadingSuccess);
				Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyVM().AddEnterCopyTDA(copyEnterInfoData);
			}
			else
			{
				await loadingSingleViewModel.CloseLoading();
				Toast.ShowInfo("进入战斗发生异常");
			}
		}
		catch (Exception ex)
		{
			canAcceptInvite = true;
			Log.Error("创建多人Loading发生异常！ " + ex.Message + " / " + ex.StackTrace);
		}
		getBFInfo = false;
	}

	public void ClearMultiReconnect()
	{
		returnMulti = false;
		getBattleFieldUserFightInfoAction = null;
		if (subscription_GetBattleFieldUserFightInfo != null)
		{
			subscription_GetBattleFieldUserFightInfo.Dispose();
			subscription_GetBattleFieldUserFightInfo = null;
		}
		if (subscription_MultiFightSinglePlayerStartLoadNotify != null)
		{
			subscription_MultiFightSinglePlayerStartLoadNotify.Dispose();
			subscription_MultiFightSinglePlayerStartLoadNotify = null;
		}
		if (subscription_UserLeaveHalfway != null)
		{
			subscription_UserLeaveHalfway.Dispose();
			subscription_UserLeaveHalfway = null;
		}
	}

	public void SendLoadingRate(int rate)
	{
		try
		{
			C2S_MultiFightLoadRate c2S_MultiFightLoadRate = C2S_MultiFightLoadRate.Create();
			c2S_MultiFightLoadRate.UserId = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().Uid;
			c2S_MultiFightLoadRate.Rate = rate;
			Singleton<NetworkSystem>.Instance.Call(c2S_MultiFightLoadRate);
		}
		catch (Exception value)
		{
			Console.WriteLine(value);
		}
	}

	public void RegisterTmProgress(Action<int, int> updateTmProgress)
	{
		teammateLoadingRateAction = (Action<int, int>)Delegate.Combine(teammateLoadingRateAction, updateTmProgress);
		if (subscription_TeammateLoadingRateNotify == null)
		{
			subscription_TeammateLoadingRateNotify = Singleton<NetworkSystem>.Instance.Subscribe<MultiFightLoadRateNotify>(TeammateLoadingRateNotify);
		}
	}

	public void RemoveTmProgress(Action<int, int> updateTmProgress)
	{
		teammateLoadingRateAction = null;
		if (subscription_TeammateLoadingRateNotify != null)
		{
			subscription_TeammateLoadingRateNotify.Dispose();
			subscription_TeammateLoadingRateNotify = null;
		}
	}

	private void TeammateLoadingRateNotify(MultiFightLoadRateNotify message)
	{
		teammateLoadingRateAction(message.SeatId, message.Rate);
	}

	public async UniTask<bool> TeamRoomChangeSelectRole(int heroId)
	{
		TeamRoomChangeSelectRoleRequest teamRoomChangeSelectRoleRequest = TeamRoomChangeSelectRoleRequest.Create();
		teamRoomChangeSelectRoleRequest.SelectRoleId = heroId;
		try
		{
			TeamRoomChangeSelectRoleResponse teamRoomChangeSelectRoleResponse = await Singleton<NetworkSystem>.Instance.Call<TeamRoomChangeSelectRoleResponse>(teamRoomChangeSelectRoleRequest);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(teamRoomChangeSelectRoleResponse, "当前状态无法更换烬天使") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(teamRoomChangeSelectRoleResponse.Error, "当前状态无法更换烬天使", showToast: false))
			{
				return true;
			}
			Toast.ShowInfo("当前状态无法更换烬天使");
			return false;
		}
		catch (Exception value)
		{
			Console.WriteLine(value);
			return false;
		}
	}

	public async UniTask<bool> TeamRoomChangeSelectBattleProp(List<int> propIds)
	{
		BattleChangeBattlePropRequest battleChangeBattlePropRequest = BattleChangeBattlePropRequest.Create();
		battleChangeBattlePropRequest.PropId = propIds;
		try
		{
			BattleChangeBattlePropResponse battleChangeBattlePropResponse = await Singleton<NetworkSystem>.Instance.Call<BattleChangeBattlePropResponse>(battleChangeBattlePropRequest);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(battleChangeBattlePropResponse, "当前状态无法更换战斗道具") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(battleChangeBattlePropResponse.Error, "当前状态无法更换战斗道具"))
			{
				return true;
			}
			Toast.ShowInfo("当前状态无法更换战斗道具");
			return false;
		}
		catch (Exception value)
		{
			Console.WriteLine(value);
			return false;
		}
	}

	public async void BackToMultiRoom()
	{
		_ = 1;
		try
		{
			int model = GetModel(roomInfoData.CopyData.Id);
			long roomId = GetRoomId();
			Loading loading = await Loading.Show();
			MultiFightEnterMatchRoomRequest multiFightEnterMatchRoomRequest = MultiFightEnterMatchRoomRequest.Create();
			multiFightEnterMatchRoomRequest.RoomId = roomId;
			multiFightEnterMatchRoomRequest.SelectModel = model;
			multiFightEnterMatchRoomRequest.ClientVersion = GameEntry.Setting.GetString("版本信息");
			MultiFightEnterMatchRoomResponse multiFightEnterMatchRoomResponse = await Singleton<NetworkSystem>.Instance.Call<MultiFightEnterMatchRoomResponse>(multiFightEnterMatchRoomRequest);
			loading.Dispose();
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(multiFightEnterMatchRoomResponse, "无法回到队伍 ") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(multiFightEnterMatchRoomResponse.Error, "无法回到队伍"))
			{
				List<MatchRoomUserInfo> list = new List<MatchRoomUserInfo>();
				for (int i = 0; i < multiFightEnterMatchRoomResponse.MatchRoomInfo.Gamers.Count; i++)
				{
					list.Add(new MatchRoomUserInfo(multiFightEnterMatchRoomResponse.MatchRoomInfo.Gamers[i].CapFlag, multiFightEnterMatchRoomResponse.MatchRoomInfo.Gamers[i].UserId, multiFightEnterMatchRoomResponse.MatchRoomInfo.Gamers[i].SeatId, multiFightEnterMatchRoomResponse.MatchRoomInfo.Gamers[i].State, multiFightEnterMatchRoomResponse.MatchRoomInfo.Gamers[i].SelectModel, multiFightEnterMatchRoomResponse.MatchRoomInfo.Gamers[i].UserBaseInfo.Icon, multiFightEnterMatchRoomResponse.MatchRoomInfo.Gamers[i].UserBaseInfo.Name, multiFightEnterMatchRoomResponse.MatchRoomInfo.Gamers[i].RoleInfo.RoleId, multiFightEnterMatchRoomResponse.MatchRoomInfo.Gamers[i].RoleInfo.Star, multiFightEnterMatchRoomResponse.MatchRoomInfo.Gamers[i].RoleInfo.Level, multiFightEnterMatchRoomResponse.MatchRoomInfo.Gamers[i].RoleInfo.SkinId, multiFightEnterMatchRoomResponse.MatchRoomInfo.Gamers[i].HeroCardFrame, multiFightEnterMatchRoomResponse.MatchRoomInfo.Gamers[i].RoleInfo.SeatLevel, Singleton<ServiceSystem>.Instance.GetService<IHomeLandService>().GetBPCarryings(multiFightEnterMatchRoomResponse.MatchRoomInfo.Gamers[i].BattleProp)));
				}
				multiRoomViewModel = new MultiRoomViewModel(null, roomInfoData.CopyData, list, loadCacheDropRate: true);
				openMultiRoomAction();
			}
		}
		catch (Exception ex)
		{
			Log.Error("无法回到队伍！" + ex.Message + " / " + ex.StackTrace);
		}
	}

	public Dictionary<int, string> heroNames()
	{
		Dictionary<int, string> dictionary = new Dictionary<int, string>();
		if (copyEnterInfoData != null)
		{
			foreach (TeamMember teamMember in copyEnterInfoData.TeamMembers)
			{
				dictionary.Add(teamMember.MemberId, teamMember.Name);
			}
		}
		return dictionary;
	}

	public void SetIsMatch(bool value)
	{
		isMatch = value;
	}

	public void SetMatchTime(int value)
	{
		matchTime = value;
	}

	public async UniTask<bool> SendGetMultiFriendsInfoView(int copyMainId)
	{
		MultiFightGetUserListRequest request = MultiFightGetUserListRequest.Create();
		MultiFightGetUserListResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<MultiFightGetUserListResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "获取好友列表") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "获取好友列表失败"))
			{
				MultiRoomInviteViewModel multiRoomInviteViewModel = new MultiRoomInviteViewModel(null, response.UserStates, response.RecentPlayers, response.UnionUserStates, copyMainId);
				multiRoomViewModel?.OpenFriendInfoWindow(multiRoomInviteViewModel);
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
			Log.Error("获取好友列表失败，发生异常！" + ex2.Message + " / " + ex2.StackTrace);
			return false;
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public async UniTask<bool> SendGameOver(int teamKilled, int passTime, float bossHpLeft, int mode, int monsterKill, float actorDamage, int actorKillCount, long score)
	{
		actorDamage /= 10000f;
		return (!isSingleBattle) ? (await SendMultiBattleResult(teamKilled, passTime, mode, bossHpLeft, monsterKill, actorDamage, actorKillCount)) : (await SendSingleBattleResult(teamKilled, passTime, mode, bossHpLeft, monsterKill, actorDamage, actorKillCount, score));
	}

	public void SetIsSingleBattle(bool value)
	{
		isSingleBattle = value;
	}

	public async UniTask<bool> InviteFriendsAsync(List<long> friendIds)
	{
		if (friendIds.Count == 0 || friendIds == null)
		{
			return false;
		}
		MultiFightInviteFriendRequest multiFightInviteFriendRequest = MultiFightInviteFriendRequest.Create();
		multiFightInviteFriendRequest.FriendIds = friendIds;
		try
		{
			MultiFightInviteFriendResponse multiFightInviteFriendResponse = await Singleton<NetworkSystem>.Instance.Call<MultiFightInviteFriendResponse>(multiFightInviteFriendRequest);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(multiFightInviteFriendResponse, "邀请好友") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(multiFightInviteFriendResponse.Error, "邀请好友失败"))
			{
				if (friendIds.Count > 0)
				{
					Toast.ShowInfo("邀请已发送");
				}
				return true;
			}
		}
		catch (Exception ex)
		{
			Log.Error("邀请好友，发生异常！" + ex.Message + "/" + ex.StackTrace);
		}
		return false;
	}

	public async UniTask<bool> LevelRoomAsync()
	{
		MultiFightLeaveRoomRequest request = MultiFightLeaveRoomRequest.Create();
		try
		{
			MultiFightLeaveRoomResponse multiFightLeaveRoomResponse = await Singleton<NetworkSystem>.Instance.Call<MultiFightLeaveRoomResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(multiFightLeaveRoomResponse, "离开房间") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(multiFightLeaveRoomResponse.Error, "离开房间失败"))
			{
				SaveRoomId(0L);
				return true;
			}
		}
		catch (Exception ex)
		{
			Log.Error("离开房间失败" + ex.Message + "/" + ex.StackTrace);
		}
		return false;
	}

	public async UniTask<bool> KickGamerAsync(long targetUserId, long userId)
	{
		MultiFightKickUserRequest multiFightKickUserRequest = MultiFightKickUserRequest.Create();
		multiFightKickUserRequest.TargetUserId = targetUserId;
		multiFightKickUserRequest.UserId = userId;
		try
		{
			MultiFightKickUserResponse multiFightKickUserResponse = await Singleton<NetworkSystem>.Instance.Call<MultiFightKickUserResponse>(multiFightKickUserRequest);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(multiFightKickUserResponse, "驱逐玩家") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(multiFightKickUserResponse.Error, "驱逐玩家失败"))
			{
				return true;
			}
		}
		catch (Exception ex)
		{
			Log.Error("驱逐玩家,发生异常！" + ex.Message + "/" + ex.StackTrace);
		}
		return false;
	}

	public async UniTask<bool> StartGameAsync()
	{
		MultiFightStartFightRequest multiFightStartFightRequest = MultiFightStartFightRequest.Create();
		multiFightStartFightRequest.ClientVersion = GameEntry.Setting.GetString("版本信息");
		try
		{
			MultiFightStartFightResponse multiFightStartFightResponse = await Singleton<NetworkSystem>.Instance.Call<MultiFightStartFightResponse>(multiFightStartFightRequest);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(multiFightStartFightResponse, "开始游戏") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(multiFightStartFightResponse.Error, "开始游戏失败"))
			{
				return true;
			}
		}
		catch (Exception ex)
		{
			Log.Error("开始游戏,发生异常！" + ex.Message + "/" + ex.StackTrace);
			return false;
		}
		return false;
	}

	public async UniTask<bool> StopMatchAsync()
	{
		MultiFightStopMatchRequest request = new MultiFightStopMatchRequest();
		try
		{
			MultiFightStopMatchResponse multiFightStopMatchResponse = await Singleton<NetworkSystem>.Instance.Call<MultiFightStopMatchResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(multiFightStopMatchResponse, "取消匹配") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(multiFightStopMatchResponse.Error, "取消匹配失败"))
			{
				return true;
			}
		}
		catch (Exception ex)
		{
			Log.Error("取消匹配，发生异常！" + ex.Message + " / " + ex.StackTrace);
		}
		return false;
	}

	public async UniTask<bool> StartMatchAsync()
	{
		MultiFightStartMatchRequest multiFightStartMatchRequest = new MultiFightStartMatchRequest();
		multiFightStartMatchRequest.ClientVersion = GameEntry.Setting.GetString("版本信息");
		try
		{
			MultiFightStartMatchResponse multiFightStartMatchResponse = await Singleton<NetworkSystem>.Instance.Call<MultiFightStartMatchResponse>(multiFightStartMatchRequest);
			if (!Singleton<NetResponseHandler>.Instance.ValidateResponse(multiFightStartMatchResponse, "开始匹配"))
			{
				return false;
			}
			if (Singleton<NetResponseHandler>.Instance.ValidateErrorCode(multiFightStartMatchResponse.Error, "开始匹配失败"))
			{
				return true;
			}
		}
		catch (Exception ex)
		{
			Log.Error("开始匹配，发生异常！" + ex.Message + " / " + ex.StackTrace);
			return false;
		}
		return false;
	}

	public async UniTask<bool> FightConfirmSetting(int ope)
	{
		MultiFightConfirmSettingRequset multiFightConfirmSettingRequset = new MultiFightConfirmSettingRequset();
		multiFightConfirmSettingRequset.Ope = ope;
		string str1 = "";
		string str2 = "";
		string str3 = "";
		switch (ope)
		{
		case 1:
		case 2:
			str1 = "战斗确认";
			str2 = "战斗确认失败";
			str3 = "战斗确认设置，发生异常！";
			break;
		case 3:
			str1 = "打开更换烬天使界面";
			str2 = "打开更换烬天使界面失败";
			str3 = "打开更换烬天使界面，发生异常！";
			break;
		default:
			str1 = "未知操作";
			str2 = "操作失败";
			str3 = "未知操作，发生异常！";
			break;
		case 0:
			break;
		}
		try
		{
			MultiFightConfirmSettingResponse multiFightConfirmSettingResponse = await Singleton<NetworkSystem>.Instance.Call<MultiFightConfirmSettingResponse>(multiFightConfirmSettingRequset);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(multiFightConfirmSettingResponse, str1) && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(multiFightConfirmSettingResponse.Error, str2))
			{
				return true;
			}
		}
		catch (Exception ex)
		{
			Log.Error(str3 + ex.Message + " / " + ex.StackTrace);
		}
		return false;
	}

	public CampaignTeamRoomContext GetCampaignTeamRoomContext()
	{
		return campaignTeamRoomContext;
	}

	public void ClearCampaignTeamRoomContext()
	{
		campaignTeamRoomContext = null;
	}

	public async UniTask<ProtocolRequestResult> CreateCampaignMultiRoom(CampaignTeamRoomContext context)
	{
		if (context == null || context.CopyData == null)
		{
			return ProtocolRequestResult.Exception;
		}
		campaignTeamRoomContext = context;
		ProtocolRequestResult num = await CreateMultiRoom(context.CopyData, loadCacheDropRate: false, context.PlayId);
		if (num != ProtocolRequestResult.Success)
		{
			campaignTeamRoomContext = null;
		}
		return num;
	}
}
