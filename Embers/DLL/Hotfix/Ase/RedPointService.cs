#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;
using Newtonsoft.Json;
using UnityEngine;

namespace Ase;

public class RedPointService : IRedPointService
{
	private const string SaveKey = "RedPoint_";

	private readonly IMessenger messenger;

	private Dictionary<string, List<RedPointSave>> localRedPointDatas = new Dictionary<string, List<RedPointSave>>();

	private ISubscription<RoleExpOrLevelUpNotifyMessager> subscription_UpdateLevel;

	private ISubscription<TaskChangeNotifyMessager> subscription_TaskNotify;

	private ISubscription<SOOpenNotifyMessager> subscription_SONotify;

	private ISubscription<PropChangeMessage> sub_knapsackChanged;

	private ISubscription<HeroMessage> sub_heroMessage;

	private ISubscription<SocialMessage> sub_socialMessage;

	private ISubscription<OpActivityMessage> sub_opActivityMessage;

	private ISubscription<AnnouncementMsg> sub_announcementMsg;

	private ISubscription<ShopMessage> sub_shopMsg;

	private ISubscription<GuildMessage> sub_guildMsg;

	private ISubscription<TeachingManualGetRewardMsg> subscription_manualReward;

	private ISubscription<ClimbTowerActivityMessager> subscription_towerActivity;

	private ISubscription<TeachingManualOpenMsg> subscription_manualOpen;

	private ISubscription<HomelandMsg> subscription_homeland;

	private ISubscription<UserReadCodeNotify> sub_UserReadNotify;

	private ISubscription<RedPointNotify> sub_serverRedNotify;

	private bool newProp;

	private List<int> _heroTalent = new List<int>();

	private Action talentTree;

	private List<DRHeroSeat> _heroSeats = new List<DRHeroSeat>();

	private bool _haveHeroUpgradeProp;

	private List<int> _heroIdCanBreak = new List<int>();

	private List<long> _friendsUnreadChat = new List<long>();

	private bool _friendApplyUnReply;

	private List<int> mainShopReds = new List<int>();

	private List<int> subShopReds = new List<int>();

	private bool guildApplicationUnRead;

	private bool guildActivityUnread;

	private bool guildCanBuild;

	private bool guildTaskCanComplete;

	private bool guildActiveRewardCanGet;

	private Dictionary<ServerReadEnum, bool> serverReadState = new Dictionary<ServerReadEnum, bool>();

	private Dictionary<ServerRedType, bool> _serverRedData = new Dictionary<ServerRedType, bool>();

	private bool canUpTalent;

	private bool towerAreaUnLock;

	public bool NewProp => newProp;

	public List<int> HeroTalent => _heroTalent;

	public List<DRHeroSeat> HeroSeats => _heroSeats;

	public bool HaveHeroUpgradeProp => _haveHeroUpgradeProp;

	public List<int> HeroIdCanBreak => _heroIdCanBreak;

	public List<long> FriendsUnreadChat => _friendsUnreadChat;

	public bool FriendApplyUnReply => _friendApplyUnReply;

	public List<int> MainShopReds => mainShopReds;

	public List<int> SubShopReds => subShopReds;

	public bool GuildApplicationUnRead
	{
		get
		{
			return guildApplicationUnRead;
		}
		private set
		{
			bool num = guildApplicationUnRead;
			guildApplicationUnRead = value;
			if (num != value)
			{
				messenger.Publish(new RedPointMessage(this, RedPointMessageEnum.GuildApplicationUnread, GuildApplicationUnRead));
			}
		}
	}

	public bool GuildActivityUnread
	{
		get
		{
			return guildActivityUnread;
		}
		private set
		{
			bool num = guildActivityUnread;
			guildActivityUnread = value;
			if (num != value)
			{
				messenger.Publish(new RedPointMessage(this, RedPointMessageEnum.GuildActivityUnread, GuildActivityUnread));
			}
		}
	}

	public bool GuildCanBuild
	{
		get
		{
			return guildCanBuild;
		}
		private set
		{
			bool num = guildCanBuild;
			guildCanBuild = value;
			if (num != value)
			{
				messenger.Publish(new RedPointMessage(this, RedPointMessageEnum.GuildBuild, GuildCanBuild));
			}
		}
	}

	public bool GuildTaskCanComplete
	{
		get
		{
			return guildTaskCanComplete;
		}
		private set
		{
			bool num = guildTaskCanComplete;
			guildTaskCanComplete = value;
			if (num != value)
			{
				messenger.Publish(new RedPointMessage(this, RedPointMessageEnum.GuildTaskComplete, GuildTaskCanComplete));
			}
		}
	}

	public bool GuildActiveRewardCanGet
	{
		get
		{
			return guildActiveRewardCanGet;
		}
		private set
		{
			bool num = guildActiveRewardCanGet;
			guildActiveRewardCanGet = value;
			if (num != value)
			{
				messenger.Publish(new RedPointMessage(this, RedPointMessageEnum.GuildActiveReward, GuildActiveRewardCanGet));
			}
		}
	}

	public bool CanUpTalent => canUpTalent;

	public bool TowerAreaUnLock => towerAreaUnLock;

	public IMessenger GetMessager()
	{
		return messenger;
	}

	public RedPointService()
	{
		messenger = Context.GetApplicationContext().GetService<IMessenger>();
		subscription_UpdateLevel = messenger.Subscribe<RoleExpOrLevelUpNotifyMessager>(GetLevelNotify);
		subscription_TaskNotify = messenger.Subscribe<TaskChangeNotifyMessager>(GetTaskNotify);
		subscription_SONotify = messenger.Subscribe<SOOpenNotifyMessager>(OnSystemOpen);
		sub_knapsackChanged = Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>().GetMessager().Subscribe<PropChangeMessage>(OnKnapsackChanged);
		sub_heroMessage = Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetMessager().Subscribe<HeroMessage>(OnHeroChanged);
		sub_socialMessage = Singleton<ServiceSystem>.Instance.GetService<ISocialService>().GetMessager().Subscribe<SocialMessage>(OnSocialChanged);
		sub_opActivityMessage = Singleton<ServiceSystem>.Instance.GetService<IOpActivityService>().GetMessager().Subscribe<OpActivityMessage>(OnOpActivityChanged);
		sub_announcementMsg = Singleton<ServiceSystem>.Instance.GetService<IAnnouncementService>().GetMessager().Subscribe<AnnouncementMsg>(OnAnnouncementChanged);
		sub_shopMsg = Singleton<ServiceSystem>.Instance.GetService<IShopService>().GetMessager().Subscribe<ShopMessage>(OnShopMessage);
		sub_guildMsg = messenger.Subscribe<GuildMessage>(OnGuildMessageReceived);
		subscription_manualReward = messenger.Subscribe<TeachingManualGetRewardMsg>(OnManualRewardGot);
		subscription_towerActivity = messenger.Subscribe<ClimbTowerActivityMessager>(OnClimbTowerActivity);
		subscription_manualOpen = messenger.Subscribe<TeachingManualOpenMsg>(OnManualOpen);
		subscription_homeland = messenger.Subscribe<HomelandMsg>(OnHomelandMsg);
		sub_UserReadNotify = Singleton<NetworkSystem>.Instance.Subscribe<UserReadCodeNotify>(OnUserReadNotify);
		sub_serverRedNotify = Singleton<NetworkSystem>.Instance.Subscribe<RedPointNotify>(OnRedPointNotify);
	}

	public void InitRedPointDatas()
	{
		LoadLocalSaveRedDatas();
		RefreshHeroDestinyData();
		RefreshPropForHeroUpgrade();
		RefreshHeroBreakoutData();
		RefreshFriendApplyUnread();
		RefreshFriendChatUnreadData();
		RefreshGuildApplicationRed();
		RefreshGuildBuild();
		RefreshGuildTask();
		RefreshGuildActiveRewardState();
		RefreshGuildActivityRewardState();
	}

	public async UniTask<bool> RequestServerRedPoints()
	{
		GetRedPointRequest request = GetRedPointRequest.Create();
		GetRedPointResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetRedPointResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "获取红点") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "获取红点失败"))
			{
				_serverRedData.Clear();
				if (response.RedPoints != null)
				{
					foreach (int redPoint in response.RedPoints)
					{
						if (Enum.IsDefined(typeof(ServerRedType), redPoint))
						{
							_serverRedData[(ServerRedType)redPoint] = true;
						}
					}
				}
				return true;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error("获取红点，发生异常！" + ex2.Message + " / " + ex2.StackTrace);
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return false;
	}

	private void LoadLocalSaveRedDatas()
	{
		localRedPointDatas.Clear();
		foreach (RedPointLocalSaveKeys value in Enum.GetValues(typeof(RedPointLocalSaveKeys)))
		{
			GetRedPoint(value, forceLoading: true);
		}
	}

	public void Publish(RedPointMessageEnum msgType, bool redState)
	{
		messenger?.Publish(new RedPointMessage(this, msgType, redState));
	}

	private void OnSystemOpen(SOOpenNotifyMessager messager)
	{
		OnManualRewardGot();
	}

	private void GetLevelNotify(RoleExpOrLevelUpNotifyMessager messager)
	{
		if (messager.MessageEnum.Equals(RoleExpOrLevelUpNotifyMessager.RoleExpLevelMsgEnum.LevelUp))
		{
			OnManualRewardGot();
			CheckHomelandUpgrade();
		}
	}

	private void GetTaskNotify(TaskChangeNotifyMessager messager)
	{
		OnManualRewardGot();
	}

	private void OnKnapsackChanged(PropChangeMessage message)
	{
		RefreshHeroDestinyData();
		RefreshPropForHeroUpgrade();
		RefreshHeroBreakoutData();
		RefreshGuildTask();
		if (message.Type == PropChangeMessageEnum.Add)
		{
			RefreshNewAddedPropDatas();
		}
		CheckHomelandUpgrade();
		CheckTowerTalentData();
	}

	private void RefreshNewAddedPropDatas()
	{
		bool valueOrDefault = Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>()?.GetKnapsackViewModel()?.GetDisplayProps()?.Exists((KnapsackPropData p) => p.IsNew) == true;
		if (newProp != valueOrDefault)
		{
			newProp = valueOrDefault;
			messenger.Publish(new RedPointMessage(this, RedPointMessageEnum.NewAddedPropItem, newProp));
		}
	}

	private void OnHeroChanged(HeroMessage message)
	{
		if (message.Type == HeroMessageEnum.DestinyLevelChanged)
		{
			RefreshHeroDestinyData();
		}
		else if (message.Type == HeroMessageEnum.StarLevelChanged)
		{
			RefreshHeroTalentData((HeroModel)message.Arg);
		}
	}

	public void AddTalentTree(Action action)
	{
		talentTree = (Action)Delegate.Combine(talentTree, action);
	}

	public void RemoveTalentTree()
	{
		talentTree = null;
	}

	private void RefreshHeroTalentData(HeroModel heroModel)
	{
		talentTree?.Invoke();
		messenger.Publish(new RedPointMessage(this, RedPointMessageEnum.HeroTalentNewLayer));
	}

	private void RefreshHeroDestinyData()
	{
		_heroSeats.Clear();
		foreach (HeroModel heroModel in Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetAllHeroData().Values)
		{
			DRHeroSeat dataRow = GameEntry.DataTable.GetDataRow((DRHeroSeat p) => p.HeroId == heroModel.Id && p.TargetSeat == heroModel.DestinyLevel + 1);
			if (dataRow == null)
			{
				continue;
			}
			int num = 0;
			if (heroModel.DestinyData != null)
			{
				for (int num2 = 0; num2 < heroModel.DestinyData.Count; num2++)
				{
					if (heroModel.DestinyData[num2] == 1)
					{
						num = num2 + 1;
					}
				}
			}
			int needItem = dataRow.NeedItem;
			int count = 0;
			if (num > 3)
			{
				count = dataRow.UpItemNum;
			}
			else if (dataRow.ItemNum.Count > num)
			{
				count = dataRow.ItemNum[num];
			}
			if (Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>().CheckEnough(new List<PropDataBase> { PropDataBase.CreateByType(PropTypeEnum.Prop, needItem, count) }))
			{
				_heroSeats.Add(dataRow);
			}
		}
		messenger.Publish(new RedPointMessage(this, RedPointMessageEnum.HeroDestinyEnabled));
	}

	private void RefreshPropForHeroUpgrade()
	{
		bool flag = false;
		foreach (KnapsackPropData displayProp in Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>().GetKnapsackViewModel().GetDisplayProps())
		{
			if (displayProp.UseType.Contains(1) && displayProp.Amount > 0)
			{
				flag = true;
				break;
			}
		}
		if (_haveHeroUpgradeProp != flag)
		{
			_haveHeroUpgradeProp = flag;
			messenger.Publish(new RedPointMessage(this, RedPointMessageEnum.HaveHeroUpgradeProp, _haveHeroUpgradeProp));
		}
	}

	private void RefreshHeroBreakoutData()
	{
		_heroIdCanBreak?.Clear();
		int num = Singleton<OuterSystem>.Instance?.GetConstantConfigInt(Constant.ConstantConfig.MaxStarHero) ?? 0;
		Dictionary<int, HeroModel> dictionary = Singleton<ServiceSystem>.Instance?.GetService<IHeroService>()?.GetAllHeroData();
		if (dictionary == null)
		{
			return;
		}
		foreach (HeroModel hero in dictionary.Values)
		{
			if (hero.IsNullOrEmpty() || hero.StarLevel >= num)
			{
				continue;
			}
			DRHeroStar dataRow = GameEntry.DataTable.GetDataRow((DRHeroStar p) => p.HeroId == hero.Id && p.TargetStar == hero.StarLevel + 1);
			if (dataRow == null || hero.Level < dataRow.NeedLv)
			{
				continue;
			}
			bool flag = true;
			if (dataRow.NeedItem != null)
			{
				for (int num2 = 0; num2 < dataRow.NeedItem.Count; num2++)
				{
					int needCount = ((dataRow.ItemNum.Count > num2) ? dataRow.ItemNum[num2] : 0);
					if (!PropHelper.CheckPropEnough(dataRow.NeedItem[num2], needCount))
					{
						flag = false;
						break;
					}
				}
			}
			if (MoneyDefinition.GetMoneyCount(RoleMoneyEnum.Coin) < dataRow.NeedGold)
			{
				flag = false;
			}
			if (flag)
			{
				_heroIdCanBreak?.Add(hero.Id);
			}
		}
		messenger?.Publish(new RedPointMessage(this, RedPointMessageEnum.HeroIdsCanBreak));
	}

	private void OnSocialChanged(SocialMessage message)
	{
		if (message.Type == SocialMessageEnum.DelFriend)
		{
			RefreshFriendChatUnreadData();
			RefreshFriendApplyUnread();
		}
		else if (message.Type == SocialMessageEnum.ReceiveFriendChat)
		{
			RefreshFriendChatUnreadData();
		}
		else if (message.Type == SocialMessageEnum.ReadFriendChat)
		{
			RefreshFriendChatUnreadData();
		}
		else if (message.Type == SocialMessageEnum.AddFriendApplication)
		{
			RefreshFriendApplyUnread();
		}
		else if (message.Type == SocialMessageEnum.DelFriendApplication)
		{
			RefreshFriendApplyUnread();
		}
	}

	private void RefreshFriendChatUnreadData()
	{
		_friendsUnreadChat.Clear();
		foreach (KeyValuePair<long, List<PlayerChatData>> allFriendChatDatum in Singleton<ServiceSystem>.Instance.GetService<ISocialService>().GetFriendViewModel().GetAllFriendChatData())
		{
			if (allFriendChatDatum.Value.Count <= 0)
			{
				continue;
			}
			foreach (PlayerChatData item in allFriendChatDatum.Value)
			{
				if (item.UnRead)
				{
					_friendsUnreadChat.Add(allFriendChatDatum.Key);
					break;
				}
			}
		}
		messenger.Publish(new RedPointMessage(this, RedPointMessageEnum.FriendChatUnread));
	}

	private void RefreshFriendApplyUnread()
	{
		List<PlayerData> allFriendApplyData = Singleton<ServiceSystem>.Instance.GetService<ISocialService>().GetFriendViewModel().GetAllFriendApplyData();
		bool flag = allFriendApplyData != null && allFriendApplyData.Count > 0;
		if (_friendApplyUnReply != flag)
		{
			_friendApplyUnReply = flag;
			messenger.Publish(new RedPointMessage(this, RedPointMessageEnum.FriendApplicationUnReply, _friendApplyUnReply));
		}
	}

	private void OnAnnouncementChanged(AnnouncementMsg message)
	{
		messenger.Publish(new RedPointMessage(this, RedPointMessageEnum.AnnouncementUnRead, message.unReadList != null && message.unReadList.Count > 0));
	}

	private void OnOpActivityChanged(OpActivityMessage message)
	{
		if (message != null && message.Type == OpActivityMessageEnum.RedChange)
		{
			messenger.Publish(new RedPointMessage(this, RedPointMessageEnum.OpActivityRed));
		}
	}

	public bool GetActivityOpenRed(int activityId)
	{
		throw new NotImplementedException();
	}

	public bool SetActivityOpenRed(int activityId)
	{
		throw new NotImplementedException();
	}

	private void OnShopMessage(ShopMessage message)
	{
		if (message.Type != ShopMessageEnum.UpdateRed)
		{
			return;
		}
		mainShopReds.Clear();
		subShopReds.Clear();
		foreach (KeyValuePair<int, Dictionary<int, ShopInfoData>> allShopData in Singleton<ServiceSystem>.Instance.GetService<IShopService>().GetData().GetAllShopDatas())
		{
			foreach (KeyValuePair<int, ShopInfoData> item in allShopData.Value)
			{
				ShopInfoData value = item.Value;
				if (value.New)
				{
					if (!mainShopReds.Contains(value.MainShopId))
					{
						mainShopReds.Add(value.MainShopId);
					}
					if (!subShopReds.Contains(value.ShopId))
					{
						subShopReds.Add(value.ShopId);
					}
				}
			}
		}
		messenger.Publish(new RedPointMessage(this, RedPointMessageEnum.ShopRed));
	}

	public bool GetShopRedByShopPosition(ShopGoodItemData.ShopPosition shopPosition)
	{
		if (mainShopReds == null || mainShopReds.Count <= 0)
		{
			return false;
		}
		foreach (int mainShopRed in mainShopReds)
		{
			DRMainShopList dataRow = GameEntry.DataTable.GetDataRow<DRMainShopList>(mainShopRed);
			if (dataRow != null && dataRow.ShopPosition == (int)shopPosition)
			{
				return true;
			}
		}
		return false;
	}

	private void OnGuildMessageReceived(GuildMessage message)
	{
		if (message != null)
		{
			if (message.Type == GuildMessageEnum.GuildAssetChange || message.Type == GuildMessageEnum.GuildInfoChanged)
			{
				RefreshGuildBuild();
				RefreshGuildActiveRewardState();
			}
			else if (message.Type == GuildMessageEnum.GuildLevelChange)
			{
				RefreshGuildBuild();
			}
			else if (message.Type == GuildMessageEnum.TaskProcessChange)
			{
				RefreshGuildTask();
			}
			else if (message.Type == GuildMessageEnum.ActiveRewardStateChange)
			{
				RefreshGuildActiveRewardState();
			}
			else if (message.Type == GuildMessageEnum.GuildPermissionChange)
			{
				RefreshGuildApplicationRed();
				RefreshGuildBuild();
			}
			else if (message.Type == GuildMessageEnum.NewApplication || message.Type == GuildMessageEnum.ApplicationRead)
			{
				RefreshGuildApplicationRed();
			}
			else if (message.Type == GuildMessageEnum.CreateGuild || message.Type == GuildMessageEnum.GuildDataRefresh || message.Type == GuildMessageEnum.JoinInGuild || message.Type == GuildMessageEnum.ExitGuild || message.Type == GuildMessageEnum.Kicked || message.Type == GuildMessageEnum.GuildDismissed)
			{
				RefreshGuildApplicationRed();
				RefreshGuildBuild();
				RefreshGuildTask();
				RefreshGuildActiveRewardState();
			}
			else if (message.Type == GuildMessageEnum.GuildActivityChange)
			{
				RefreshGuildActivityRewardState();
			}
		}
	}

	private void RefreshGuildApplicationRed()
	{
		MyGuildData myGuildData = Singleton<ServiceSystem>.Instance.GetService<IGuildService>()?.GetMyGuildData();
		if (myGuildData == null || !GuildDefinition.CheckGuildMemberPermission(myGuildData.Position, GuildDefinition.GuildPermissions.ReplyApplication))
		{
			GuildApplicationUnRead = false;
			return;
		}
		List<PlayerDataBase> applyDatas = myGuildData.ApplyDatas;
		if (applyDatas == null || applyDatas.Count <= 0)
		{
			GuildApplicationUnRead = false;
			return;
		}
		List<RedPointSave> redPoint = GetRedPoint(RedPointLocalSaveKeys.NewGuildApplication);
		foreach (PlayerDataBase application in applyDatas)
		{
			if (!redPoint.Exists((RedPointSave p) => p.keyId == application.Uid && !p.isNew))
			{
				GuildApplicationUnRead = true;
				return;
			}
		}
		GuildApplicationUnRead = false;
	}

	private void RefreshGuildBuild()
	{
		IGuildService service = Singleton<ServiceSystem>.Instance.GetService<IGuildService>();
		if (service == null)
		{
			GuildCanBuild = false;
			return;
		}
		MyGuildData myGuildData = service.GetMyGuildData();
		if (myGuildData == null)
		{
			GuildCanBuild = false;
			return;
		}
		if (!GuildDefinition.CheckGuildMemberPermission(myGuildData.Position, GuildDefinition.GuildPermissions.GuildBuild))
		{
			GuildCanBuild = false;
			return;
		}
		int level = myGuildData.Level;
		int guildMaxLevel = GuildDefinition.GetGuildMaxLevel();
		if (level >= guildMaxLevel)
		{
			GuildCanBuild = false;
			return;
		}
		DRGuildLev dataRow = GameEntry.DataTable.GetDataRow<DRGuildLev>(level + 1);
		if (dataRow == null)
		{
			GuildCanBuild = false;
			return;
		}
		int funds = myGuildData.Funds;
		int guildFund = dataRow.GuildFund;
		GuildCanBuild = funds >= guildFund;
	}

	private void RefreshGuildTask()
	{
		IGuildService service = Singleton<ServiceSystem>.Instance.GetService<IGuildService>();
		if (service == null)
		{
			GuildTaskCanComplete = false;
			return;
		}
		MyGuildData myGuildData = service.GetMyGuildData();
		if (myGuildData == null)
		{
			GuildTaskCanComplete = false;
			return;
		}
		int myDailyActivePoint = myGuildData.MyDailyActivePoint;
		int dailyMaxActivePoint = myGuildData.GetDailyMaxActivePoint();
		if (myDailyActivePoint >= dailyMaxActivePoint)
		{
			GuildTaskCanComplete = false;
			return;
		}
		Dictionary<int, GuildTaskData> dailyTasks = myGuildData.DailyTasks;
		if (dailyTasks == null || dailyTasks.Count <= 0)
		{
			GuildTaskCanComplete = false;
			return;
		}
		foreach (GuildTaskData value in dailyTasks.Values)
		{
			if (value.State == GuildTaskState.CanFinish)
			{
				GuildTaskCanComplete = true;
				return;
			}
		}
		GuildTaskCanComplete = false;
	}

	private void RefreshGuildActiveRewardState()
	{
		DRGuildActiveReward[] allDataRow = GameEntry.DataTable.GetAllDataRow<DRGuildActiveReward>();
		if (allDataRow == null || allDataRow.Length == 0)
		{
			GuildActiveRewardCanGet = false;
			return;
		}
		MyGuildData myGuildData = Singleton<ServiceSystem>.Instance.GetService<IGuildService>().GetMyGuildData();
		if (myGuildData == null)
		{
			GuildActiveRewardCanGet = false;
			return;
		}
		DRGuildActiveReward[] array = allDataRow;
		foreach (DRGuildActiveReward dRGuildActiveReward in array)
		{
			if ((myGuildData.DailyActiveRewardState.Length < dRGuildActiveReward.Id || !int.TryParse(myGuildData.DailyActiveRewardState[dRGuildActiveReward.Id - 1].ToString(), out var result) || result != 1) && myGuildData.MyDailyActivePoint >= dRGuildActiveReward.ActiveLev)
			{
				GuildActiveRewardCanGet = true;
				return;
			}
		}
		GuildActiveRewardCanGet = false;
	}

	private void RefreshGuildActivityRewardState()
	{
		GuildActivityExpeditionData guildActivityData = Singleton<ServiceSystem>.Instance.GetService<IGuildService>().GetGuildActivityData();
		if (guildActivityData == null)
		{
			GuildActivityUnread = false;
		}
		else
		{
			GuildActivityUnread = guildActivityData.HasGuildCopyReward();
		}
	}

	private void OnManualRewardGot(TeachingManualGetRewardMsg messager = null)
	{
		messenger.Publish(new RedPointMessage(this, RedPointMessageEnum.TeachingManualUpdate));
	}

	private void OnManualOpen(TeachingManualOpenMsg messager = null)
	{
		messenger.Publish(new RedPointMessage(this, RedPointMessageEnum.TeachingManualUpdate));
	}

	private void OnHomelandMsg(HomelandMsg msg)
	{
		if (msg != null)
		{
			if (msg.Type == HomelandMsgType.ShopRefreshRed)
			{
				messenger.Publish(new RedPointMessage(this, RedPointMessageEnum.HomelandShopRefreshRed));
			}
			else if (msg.Type == HomelandMsgType.FriendShopRefreshRed)
			{
				messenger.Publish(new RedPointMessage(this, RedPointMessageEnum.HomelandFriendShopRefreshRed));
			}
			else if (msg.Type == HomelandMsgType.HomelandLevelUpgradeRed)
			{
				CheckHomelandUpgrade();
			}
			else if (msg.Type == HomelandMsgType.HomelandFarmRed)
			{
				messenger.Publish(new RedPointMessage(this, RedPointMessageEnum.HomelandFarmRed));
			}
			else if (msg.Type == HomelandMsgType.HomelandSailRed)
			{
				messenger.Publish(new RedPointMessage(this, RedPointMessageEnum.HomelandSailRed));
			}
		}
	}

	private void CheckHomelandUpgrade()
	{
		messenger.Publish(new RedPointMessage(this, RedPointMessageEnum.HomelandLevelUpgradeRed));
	}

	private void OnUserReadNotify(UserReadCodeNotify notify)
	{
		try
		{
			if (notify == null)
			{
				return;
			}
			string text = IntToBinaryStringManual(notify.ReadCode);
			for (int i = 0; i < text.Length; i++)
			{
				if ('1'.Equals(text[i]))
				{
					ServerReadEnum key = (ServerReadEnum)(text.Length - i);
					if (serverReadState.ContainsKey(ServerReadEnum.HeroHeadIcon))
					{
						serverReadState[key] = true;
					}
					else
					{
						serverReadState.Add(key, value: true);
					}
					messenger.Publish(new RedPointMessage(this, RedPointMessageEnum.HeroHeadIcon));
				}
			}
		}
		catch (Exception)
		{
			Log.Error("接收红点发生异常");
		}
	}

	public void CancelUserRead(ServerReadEnum serverRead)
	{
		if (serverReadState.ContainsKey(serverRead))
		{
			serverReadState.Remove(serverRead);
			messenger.Publish(new RedPointMessage(this, RedPointMessageEnum.HeroHeadIcon));
		}
	}

	public bool GetUserRead(ServerReadEnum serverRead)
	{
		if (serverReadState.ContainsKey(serverRead))
		{
			return true;
		}
		return false;
	}

	public string IntToBinaryStringManual(long number)
	{
		int num = 64;
		if (number <= 0)
		{
			return "0";
		}
		char[] array = new char[num];
		int num2 = num - 1;
		while (number != 0L)
		{
			array[num2--] = (((number & 1) == 1) ? '1' : '0');
			number >>= 1;
		}
		return new string(array, num2 + 1, num - 1 - num2);
	}

	private void OnRedPointNotify(RedPointNotify notify)
	{
		try
		{
			if (notify == null)
			{
				return;
			}
			List<int> redPoint = notify.RedPoint;
			if (redPoint == null || redPoint.Count <= 0)
			{
				return;
			}
			foreach (int item in redPoint)
			{
				if (Enum.IsDefined(typeof(ServerRedType), item))
				{
					ServerRedType key = (ServerRedType)item;
					if (_serverRedData.ContainsKey(key))
					{
						_serverRedData[key] = true;
					}
					else
					{
						_serverRedData.Add(key, value: true);
					}
				}
			}
			messenger.Publish(new RedPointMessage(this, RedPointMessageEnum.ServerRed));
		}
		catch (Exception arg)
		{
			Log.Error($"接收红点发生异常:{arg}");
		}
	}

	public bool GetServerRed(ServerRedType serverRedType)
	{
		if (_serverRedData.TryGetValue(serverRedType, out var value))
		{
			return value;
		}
		return false;
	}

	public bool GetServerRed(List<ServerRedType> serverRedTypes)
	{
		if (serverRedTypes != null)
		{
			foreach (ServerRedType serverRedType in serverRedTypes)
			{
				if (GetServerRed(serverRedType))
				{
					return true;
				}
			}
		}
		return false;
	}

	public void SetServerRed(ServerRedType serverRedType, bool red)
	{
		if (_serverRedData.ContainsKey(serverRedType))
		{
			if (_serverRedData[serverRedType] != red)
			{
				_serverRedData[serverRedType] = red;
				messenger.Publish(new RedPointMessage(this, RedPointMessageEnum.ServerRed));
			}
		}
		else if (red)
		{
			_serverRedData.Add(serverRedType, red);
			messenger.Publish(new RedPointMessage(this, RedPointMessageEnum.ServerRed));
		}
	}

	private List<RedPointSave> GetRedPoint(string systemName)
	{
		try
		{
			long uid = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().PlayerInfo.Uid;
			List<RedPointSave> list = JsonConvert.DeserializeObject<List<RedPointSave>>(PlayerPrefs.GetString("RedPoint_" + $"{uid}_{systemName}", ""));
			if (list == null)
			{
				return new List<RedPointSave>();
			}
			if (localRedPointDatas.ContainsKey(systemName))
			{
				localRedPointDatas[systemName] = list;
			}
			else
			{
				localRedPointDatas.Add(systemName, list);
			}
			return list;
		}
		catch (Exception)
		{
			Log.Error("获取红点保存数据失败！" + systemName);
		}
		return new List<RedPointSave>();
	}

	public List<RedPointSave> GetRedPoint(string systemName, bool forceLoading)
	{
		if (!forceLoading && localRedPointDatas.TryGetValue(systemName, out var value))
		{
			return value;
		}
		return GetRedPoint(systemName);
	}

	public List<RedPointSave> GetRedPoint(RedPointLocalSaveKeys key, bool forceLoading = false)
	{
		return GetRedPoint(key.ToString(), forceLoading);
	}

	public string SaveRedPoint(List<RedPointSave> obj, string systemName)
	{
		string text = null;
		try
		{
			long uid = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().PlayerInfo.Uid;
			text = JsonConvert.SerializeObject(obj);
			PlayerPrefs.SetString("RedPoint_" + $"{uid}_{systemName}", text);
		}
		catch (Exception)
		{
			Log.Error("保存红点数据失败！" + systemName);
		}
		if (text == null)
		{
			return "";
		}
		return text;
	}

	public string SaveRedPoint(List<RedPointSave> obj, RedPointLocalSaveKeys key)
	{
		return SaveRedPoint(obj, key.ToString());
	}

	public bool GetRedPointDaily(string systemName)
	{
		long curServerTime = Singleton<ServiceSystem>.Instance.GetService<ITimeService>().GetCurServerTime();
		try
		{
			long uid = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().PlayerInfo.Uid;
			if (!long.TryParse(PlayerPrefs.GetString("RedPoint_" + $"{uid}_{systemName}", ""), out var result))
			{
				result = 0L;
			}
			if (result == 0L)
			{
				return true;
			}
			return !Utility.DateTime.IsSameDayWithSplit(curServerTime, result);
		}
		catch (Exception)
		{
			Log.Error("获取红点数据失败！" + systemName);
		}
		return false;
	}

	public void SaveRedPointDaily(string systemName)
	{
		long curServerTime = Singleton<ServiceSystem>.Instance.GetService<ITimeService>().GetCurServerTime();
		try
		{
			long uid = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().PlayerInfo.Uid;
			PlayerPrefs.SetString("RedPoint_" + $"{uid}_{systemName}", $"{curServerTime}");
		}
		catch (Exception)
		{
			Log.Error("保存红点数据失败！" + systemName);
		}
	}

	private void OnClimbTowerActivity(ClimbTowerActivityMessager messager = null)
	{
		if (messager != null)
		{
			bool flag = false;
			if (messager.CanUpTalent.HasValue && canUpTalent != messager.CanUpTalent.Value)
			{
				canUpTalent = messager.CanUpTalent.Value;
				messenger.Publish(new RedPointMessage(this, RedPointMessageEnum.TowerUpTalent));
				flag = true;
			}
			if (messager.AreaRedPoint.HasValue && towerAreaUnLock != messager.AreaRedPoint.Value)
			{
				towerAreaUnLock = messager.AreaRedPoint.Value;
				messenger.Publish(new RedPointMessage(this, RedPointMessageEnum.TowerAreaUnLock));
				flag = true;
			}
			if (flag)
			{
				messenger.Publish(new ClimbTowerRedPointMeaasger(this, canUpTalent, towerAreaUnLock));
			}
		}
	}

	private void CheckTowerTalentData()
	{
		Singleton<ServiceSystem>.Instance.GetService<ICopyService>().UpdateTowerTalentUpLevel();
	}

	public bool GetTowerAreaRedPoint(int tagId)
	{
		return Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetTowerOneAreaRedPoint(tagId) == 0;
	}
}
