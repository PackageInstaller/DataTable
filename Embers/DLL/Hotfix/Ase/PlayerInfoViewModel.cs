#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using System.Threading.Tasks;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class PlayerInfoViewModel : OptionBase
{
	[CompilerGenerated]
	private sealed class _003C_003Ec__DisplayClass96_0
	{
		public int chatBubbleId;

		internal bool _003CAddPlayerInfoChangeTDA_003Eb__0(DRChatBox p)
		{
			return p.Id == chatBubbleId;
		}
	}

	private AddHeroItemViewModel addHeroVM;

	private Dictionary<string, OptionBase> childVMs = new Dictionary<string, OptionBase>();

	private int copyRankColor;

	private bool everHadCard;

	private string copyRankName;

	private string oriImage;

	private List<int> heroIdList;

	private List<HeroItemViewModel> heroItemList;

	private bool isSelf;

	private PlayerNameChangeViewModel nameSetVM;

	private SimpleCommand<string> optCommand;

	private PlayerData playerInfo;

	private int starCount;

	private InteractionRequest updateHeroInfoRequest;

	private InteractionRequest updateHeroListRequest;

	private GameObject heroSpine;

	private BoardHeroViewModel boardHeroViewModel;

	private List<int> achiIdList;

	private AddAchiItemViewModel addAchiVM;

	private List<AchiItemData> achiInfoList;

	private List<PlayerInfoCopyInfoItemViewModel> playerInfoCopyInfoItems;

	private PlayerInfoFunctionViewModel playerInfoFunctionViewModel;

	private List<TabItemNormalData> functionList;

	private InteractionRequest updateAchiListRequest;

	private InteractionRequest refreshSpineRst;

	private bool copyInfoImgShowOrHide;

	private PlayerInfoBoardHeroChangeViewModel boardChangeVM;

	public GameObject HeroSpine
	{
		get
		{
			return heroSpine;
		}
		set
		{
			heroSpine = value;
		}
	}

	public bool IsSelf
	{
		get
		{
			return isSelf;
		}
		private set
		{
			Set(ref isSelf, value, "IsSelf");
		}
	}

	public PlayerData PlayerInfo
	{
		get
		{
			return playerInfo;
		}
		private set
		{
			Set(ref playerInfo, value, "PlayerInfo");
		}
	}

	public string CopyRankName
	{
		get
		{
			return copyRankName;
		}
		private set
		{
			Set(ref copyRankName, value, "CopyRankName");
		}
	}

	public bool EverHadCard
	{
		get
		{
			return everHadCard;
		}
		private set
		{
			Set(ref everHadCard, value, "EverHadCard");
		}
	}

	public List<TabItemNormalData> FunctionList
	{
		get
		{
			return functionList;
		}
		private set
		{
			Set(ref functionList, value, "FunctionList");
		}
	}

	public bool CopyInfoImgShowOrHide
	{
		get
		{
			return copyInfoImgShowOrHide;
		}
		set
		{
			Set(ref copyInfoImgShowOrHide, value, "CopyInfoImgShowOrHide");
		}
	}

	public string OriImage => oriImage;

	public ICommand OptCommand => optCommand;

	public List<HeroItemViewModel> HeroItemList => heroItemList;

	public IInteractionRequest UpdateHeroListRequest => updateHeroListRequest;

	public IInteractionRequest UpdateHeroInfoRequest => updateHeroInfoRequest;

	public IInteractionRequest UpdateAchiListRequest => updateAchiListRequest;

	public List<AchiItemData> AchiInfoList => achiInfoList;

	public List<PlayerInfoCopyInfoItemViewModel> PlayerInfoCopyInfoItems => playerInfoCopyInfoItems;

	public PlayerInfoFunctionViewModel PlayerInfoFunctionViewModel
	{
		get
		{
			return playerInfoFunctionViewModel;
		}
		private set
		{
			Set(ref playerInfoFunctionViewModel, value, "PlayerInfoFunctionViewModel");
		}
	}

	public BoardHeroViewModel BoardHeroViewModel => boardHeroViewModel;

	public InteractionRequest RefreshSpineRst => refreshSpineRst;

	public PlayerInfoBoardHeroChangeViewModel BoardChangeVM
	{
		get
		{
			return boardChangeVM;
		}
		set
		{
			boardChangeVM = value;
		}
	}

	public PlayerInfoViewModel()
	{
	}

	public PlayerInfoViewModel(OptionBase parent, PlayerData playerInfo, bool isSelf)
	{
		base.parent = parent;
		this.isSelf = isSelf;
		this.playerInfo = playerInfo;
		updateHeroListRequest = new InteractionRequest();
		updateHeroInfoRequest = new InteractionRequest();
		updateAchiListRequest = new InteractionRequest();
		refreshSpineRst = new InteractionRequest();
		boardHeroViewModel = AddChild(new BoardHeroViewModel(this));
		heroItemList = new List<HeroItemViewModel>();
		addHeroVM = new AddHeroItemViewModel(this, this.isSelf);
		optCommand = new SimpleCommand<string>(OnOptClick);
		GetIconOri();
		if (!isSelf)
		{
			AddOtherShowAchi();
			AddOtherShowHeros();
			EverHadCard = false;
		}
		else
		{
			List<RoleDecorateEnum> types = new List<RoleDecorateEnum>
			{
				RoleDecorateEnum.Title,
				RoleDecorateEnum.HeadFrame,
				RoleDecorateEnum.HeadIcon
			};
			Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().ClearItemList(types);
			EverHadCard = true;
		}
		InitRequestData();
		addAchiVM = new AddAchiItemViewModel(this, isSelf);
		playerInfoCopyInfoItems = new List<PlayerInfoCopyInfoItemViewModel>();
		playerInfoFunctionViewModel = new PlayerInfoFunctionViewModel(this);
		functionList = new List<TabItemNormalData>();
		InitPlayerInfoCopyInfoItem();
		RefreshFunctionList();
		SetCopyInfoBool();
		playerInfoFunctionViewModel.SetFunctionList(this);
	}

	private async void InitRequestData()
	{
		await Singleton<ServiceSystem>.Instance.GetService<IAchievementService>().RequestAchievementData();
	}

	private void SetCopyInfoBool()
	{
		CopyInfoImgShowOrHide = playerInfo.ShowCopyInfo;
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is OptionArg optionArg)
		{
			if (optionArg.OptionName.Equals("ChangeName"))
			{
				ChangeName((string)optionArg.Obj);
			}
			else if (optionArg.OptionName.Equals("ChangeTitle"))
			{
				ChangeInfo(GetVM<ChangePlayerInfoViewModel>().CurTitleId, RoleDecorateEnum.Title);
			}
			else if (optionArg.OptionName.Equals("ChangeIcon"))
			{
				ChangeInfo(GetVM<ChangePlayerInfoViewModel>().CurIconId, RoleDecorateEnum.HeadIcon);
			}
			else if (optionArg.OptionName.Equals("ChangeIconFrame"))
			{
				ChangeInfo(GetVM<ChangePlayerInfoViewModel>().CurIconFrame, RoleDecorateEnum.HeadFrame);
			}
			else if (optionArg.OptionName.Equals("OnShowHeroes"))
			{
				OnShowHeroes((PlayerInfoHeroSelectViewModel)optionArg.Obj);
			}
			else if (optionArg.OptionName.Equals("OnShowAchis"))
			{
				OnShowAchis((PlayerInfoAchiSelectViewModel)optionArg.Obj);
			}
			else if (optionArg.OptionName.Equals("OnSetBackGround"))
			{
				OnSetBackGround();
			}
			else if (optionArg.OptionName.Equals("OnSetInitialBackGround"))
			{
				SetSpineItemSelected();
			}
		}
		else if (obj is ChangePlayerInfoViewModel)
		{
			optCommand.Enabled = true;
		}
		else if (isSelf && obj is HeroItemViewModel heroItemViewModel)
		{
			SelectHeroShow(heroItemViewModel.HeroModel.Id);
		}
		else if (!isSelf && obj is HeroItemViewModel heroItemViewModel2)
		{
			HeroCultivateViewModel userData = new HeroCultivateViewModel(this, heroItemViewModel2.HeroModel, 1, changeHeroEnable: false, null, isSelf: false);
			openWindowRequest.Raise(new OpenViewArg(typeof(HeroCultivateWindow), userData));
		}
		else if (isSelf && obj is AddHeroItemViewModel)
		{
			SelectHeroShow(0);
		}
		else if (isSelf && (obj is AddAchiItemViewModel || obj is AchiItemData))
		{
			SelectAchiShow(0);
		}
		else if (obj is TabItemNormalData tabItemNormalData)
		{
			switch (tabItemNormalData.ID)
			{
			case 1:
				AddFriendOrRemoveFriend();
				break;
			case 2:
				PrivateChat();
				break;
			case 3:
				Report();
				break;
			case 4:
				AddToBlackListOrRemoveFromBlackList();
				break;
			}
		}
		else if (obj is BoardChangeItemData)
		{
			SetSpineItemSelected();
		}
		else if (obj is BoardHeroItemData)
		{
			SetSpineItemSelected();
		}
	}

	private async void OnSetBackGround()
	{
		if (await Singleton<ServiceSystem>.Instance.GetService<IRoleService>().SendPlayerInfoUseCopyInfoShowOrSetBackGround(3, BoardChangeVM.CurSelectSpineItemData.Id))
		{
			playerInfo.SetShowPosterGirl(BoardChangeVM.CurSelectSpineItemData.Id);
			BoardChangeVM.CurrentBoardData.ChangeHero(BoardChangeVM.CurSelectSpineItemData.Id);
			Toast.ShowInfo("修改成功");
		}
	}

	private void SetSpineItemSelected()
	{
		refreshSpineRst.Raise();
	}

	public async Task OnShow()
	{
		if (isSelf)
		{
			(await Loading.Show()).Dispose();
		}
		DRCopy dataRow = GameEntry.DataTable.GetDataRow((DRCopy p) => p.CopyRank == ((PlayerInfo.WeeklyRank < 1) ? 1 : PlayerInfo.WeeklyRank));
		if (dataRow == null)
		{
			CopyRankName = "未开放";
		}
		else
		{
			CopyRankName = dataRow.CopyRankName;
		}
	}

	public async UniTask AddSelfShowAchi(List<PbMedalInfo> pbMedalInfos)
	{
		achiIdList = new List<int>();
		for (int i = 0; i < pbMedalInfos.Count; i++)
		{
			achiIdList.Add(pbMedalInfos[i].MedalId);
		}
		achiInfoList = new List<AchiItemData>();
		for (int j = 0; j < pbMedalInfos.Count; j++)
		{
			achiInfoList.Add(new AchiItemData(this, pbMedalInfos[j].MedalId, pbMedalInfos[j].Rank, pbMedalInfos[j].Tag));
		}
	}

	public void AddOtherShowAchi()
	{
		achiInfoList = new List<AchiItemData>();
		if (playerInfo?.WearMedals != null)
		{
			for (int i = 0; i < playerInfo.WearMedals.Count; i++)
			{
				achiInfoList.Add(new AchiItemData(this, playerInfo.WearMedals[i].MedalId, playerInfo.WearMedals[i].Rank, playerInfo.WearMedals[i].Tag));
			}
		}
	}

	public async Task AddSelfShowHeros(List<int> heroModels)
	{
		heroIdList = heroModels;
		heroItemList = new List<HeroItemViewModel>();
		for (int i = 0; i < heroModels.Count; i++)
		{
			heroItemList.Add(new HeroItemViewModel(this, Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetHeroById(heroModels[i])));
		}
	}

	public void AddOtherShowHeros()
	{
		heroItemList = new List<HeroItemViewModel>();
		if (playerInfo?.HeroList != null)
		{
			for (int i = 0; i < playerInfo.HeroList.Count; i++)
			{
				HeroModel heroModel = new HeroModel(playerInfo.HeroList[i]);
				heroItemList.Add(new HeroItemViewModel(this, heroModel));
			}
		}
	}

	public async Task<ChangePlayerInfoViewModel> GetChangePlayerInfo()
	{
		if (childVMs.ContainsKey(typeof(ChangePlayerInfoViewModel).FullName))
		{
			ChangePlayerInfoViewModel vM = GetVM<ChangePlayerInfoViewModel>();
			showViewRequest.Raise(new ShowViewArg(vM, isShow: true));
			return vM;
		}
		IRoleService roleService = Singleton<ServiceSystem>.Instance.GetService<IRoleService>();
		RoleViewModel roleData = roleService.GetRoleData();
		List<RoleDecorateEnum> decorateEnums = new List<RoleDecorateEnum>
		{
			RoleDecorateEnum.Title,
			RoleDecorateEnum.HeadFrame,
			RoleDecorateEnum.HeadIcon
		};
		for (int i = 0; i < decorateEnums.Count; i++)
		{
			if (!roleService.GetRoleData().ItemList.ContainsKey(decorateEnums[i]))
			{
				List<RoleDecorateData> list = await roleService.GetIconOrTitleList(decorateEnums[i]);
				roleData.SetItemList(decorateEnums[i], list);
			}
		}
		Singleton<ServiceSystem>.Instance.GetService<IRedPointService>().CancelUserRead(ServerReadEnum.HeroHeadIcon);
		ChangePlayerInfoViewModel changePlayerInfoViewModel = new ChangePlayerInfoViewModel(this, playerInfo.Title, playerInfo.IconId, playerInfo.IconFrame, roleData.ItemList);
		childVMs.Add(typeof(ChangePlayerInfoViewModel).FullName, changePlayerInfoViewModel);
		changePlayerInfoViewModel.IsVisible = true;
		openWindowRequest.Raise(new OpenViewArg(typeof(ChangePlayerInfoView), changePlayerInfoViewModel, "PlayerInfo", isOpenWindow: false));
		return changePlayerInfoViewModel;
	}

	private void GetIconOri()
	{
		try
		{
			DRHeadAvatar dataRow = GameEntry.DataTable.GetDataRow<DRHeadAvatar>(playerInfo.IconId);
			if (dataRow != null)
			{
				DRUIHeroSkin dataRow2 = GameEntry.DataTable.GetDataRow<DRUIHeroSkin>(dataRow.UnlockEX);
				if (dataRow2 != null)
				{
					DRHeroInfo dataRow3 = GameEntry.DataTable.GetDataRow<DRHeroInfo>(dataRow.HeroId);
					oriImage = dataRow3.Original + dataRow2.Suffix;
				}
				else if (isSelf)
				{
					HeroModel heroById = Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetHeroById(dataRow.HeroId);
					if (heroById != null && !heroById.Empty)
					{
						oriImage = heroById.Original;
					}
					else
					{
						oriImage = $"CharacterImagePrefabs/PlayerPrefabs/PlayerCharacter_{((playerInfo.CharacterIndex >= 0) ? playerInfo.CharacterIndex : 0)}";
					}
				}
				else
				{
					DRHeroInfo dataRow4 = GameEntry.DataTable.GetDataRow<DRHeroInfo>(dataRow.HeroId);
					DRUIHeroSkin dataRow5 = GameEntry.DataTable.GetDataRow<DRUIHeroSkin>(dataRow4.InitialHeroSkin);
					oriImage = dataRow4.Original + dataRow5.Suffix;
				}
				return;
			}
		}
		catch (Exception ex)
		{
			Log.Error("获取立绘发生异常" + ex.Message + " / " + ex.StackTrace);
		}
		oriImage = $"CharacterImagePrefabs/PlayerPrefabs/PlayerCharacter_{((playerInfo.CharacterIndex >= 0) ? playerInfo.CharacterIndex : 0)}";
	}

	private async void OnOptClick(string optName)
	{
		optCommand.Enabled = false;
		try
		{
			if (optName.Equals("ChangeHead"))
			{
				ChangePlayerInfoViewModel changePlayerInfoViewModel = await GetChangePlayerInfo();
				if (changePlayerInfoViewModel == null)
				{
					Log.Error("获取ChangePlayerInfoViewModel失败！");
					Toast.ShowInfo("打开更换头像界面失败！");
				}
				else
				{
					showViewRequest.Raise(new ShowViewArg(changePlayerInfoViewModel, isShow: true));
					changePlayerInfoViewModel.SetCurInfo(playerInfo.IconId, playerInfo.IconFrame, playerInfo.Title);
					changePlayerInfoViewModel.SetState(4);
				}
			}
			else if (optName.Equals("CopyUID"))
			{
				Utility.Text.Copy2ClipBoard($"{playerInfo.Uid}");
				Toast.ShowInfo("复制成功！");
				optCommand.Enabled = true;
			}
			else if (optName.Equals("ChangeName"))
			{
				nameSetVM = new PlayerNameChangeViewModel(this);
				openWindowRequest.Raise(new OpenViewArg(typeof(PlayerNameChangeWindow), nameSetVM), delegate
				{
					optCommand.Enabled = true;
					nameSetVM = null;
				});
			}
			else if (optName.Equals("ChangeTitle"))
			{
				await GetChangePlayerInfo();
				GetVM<ChangePlayerInfoViewModel>().IsVisible = true;
				GetVM<ChangePlayerInfoViewModel>().SetCurInfo(playerInfo.IconId, playerInfo.IconFrame, playerInfo.Title);
				GetVM<ChangePlayerInfoViewModel>().SetState(2);
			}
			else if (optName.Equals("AddFriend"))
			{
				AddFriendOrRemoveFriend();
			}
			else
			{
				if (optName.Equals("OptBlack"))
				{
					return;
				}
				if (optName.Equals("OptReport"))
				{
					openWindowRequest.Raise(new OpenViewArg(typeof(ReportWindow), new ReportViewModel(this, ReportTypeEnum.Player, playerInfo.Name, playerInfo.Uid)), delegate
					{
						optCommand.Enabled = true;
					});
				}
				else if (optName.Equals("OpenBoardChange"))
				{
					OpenBoardChange();
				}
				else if (optName.Equals("CopyInfo"))
				{
					SetCopyInfoShowOrHide();
				}
			}
		}
		catch (Exception message)
		{
			Log.Error(message);
			optCommand.Enabled = true;
		}
	}

	private void SetCopyInfoShowOrHide()
	{
		optCommand.Enabled = !optCommand.Enabled;
		if (!isSelf)
		{
			return;
		}
		if (!CopyInfoImgShowOrHide)
		{
			SendCopyInfoShowOrHide();
			return;
		}
		IAsyncResult<int> result = AlertDialog.Show("提示", "隐藏后，其他传火者将无法查看您的挑战信息，是否确定隐藏?", "确定", "取消");
		result.Callbackable().OnCallback(async delegate
		{
			if (result.Result == -1)
			{
				SendCopyInfoShowOrHide();
			}
		});
	}

	private async void SendCopyInfoShowOrHide()
	{
		CopyInfoImgShowOrHide = !CopyInfoImgShowOrHide;
		if (await Singleton<ServiceSystem>.Instance.GetService<IRoleService>().SendPlayerInfoUseCopyInfoShowOrSetBackGround(5, CopyInfoImgShowOrHide ? 1 : (-1)))
		{
			playerInfo.SetShowCopyInfo(CopyInfoImgShowOrHide);
			if (CopyInfoImgShowOrHide)
			{
				Toast.ShowInfo("已取消隐藏");
			}
			else
			{
				Toast.ShowInfo("已设置为隐藏");
			}
		}
	}

	public AddHeroItemViewModel GetEmptyVM()
	{
		return addHeroVM;
	}

	public AddAchiItemViewModel GetAchiEmptyVM()
	{
		return addAchiVM;
	}

	private async Task ChangeName(string name)
	{
		IAccountService.ChangeRoleResult result = null;
		if (name.Equals(playerInfo.Name))
		{
			Toast.ShowInfo("名字和原来一样！");
			nameSetVM.SetResult(result);
			return;
		}
		Loading loading = await Loading.Show();
		result = await Singleton<ServiceSystem>.Instance.GetService<IAccountService>().ChangeName(name);
		loading.Dispose();
		nameSetVM.SetResult(result);
	}

	private async Task ChangeInfo(int id, RoleDecorateEnum type)
	{
		if (await Singleton<ServiceSystem>.Instance.GetService<IRoleService>().ChangeIconOrTitle(type, id))
		{
			GetVM<ChangePlayerInfoViewModel>().Hide();
			AddPlayerInfoChangeTDA();
		}
		else
		{
			Toast.ShowInfo("更换失败，请重试！");
		}
	}

	public override void Close()
	{
		GetVM<ChangePlayerInfoViewModel>()?.Close();
		base.Close();
	}

	private void AddPlayerInfoChangeTDA()
	{
		_003C_003Ec__DisplayClass96_0 obj = new _003C_003Ec__DisplayClass96_0();
		RoleService.AddPlayerInfoChangeTDA();
	}

	private void OpenBoardChange()
	{
		optCommand.Enabled = !optCommand.Enabled;
		if (optCommand.Enabled)
		{
			if (childVMs.ContainsKey(typeof(PlayerInfoBoardHeroChangeViewModel).FullName))
			{
				boardChangeVM = GetVM<PlayerInfoBoardHeroChangeViewModel>();
				showViewRequest.Raise(new ShowViewArg(BoardChangeVM, isShow: true));
				BoardChangeVM.OnOpen(playerInfo.ShowPosterGirl);
			}
			else
			{
				openWindowRequest.Raise(new OpenViewArg(typeof(PlayerInfoBoardHeroChange), BoardChangeVM, "PlayerInfo", isOpenWindow: false));
				childVMs.Add(typeof(PlayerInfoBoardHeroChangeViewModel).FullName, BoardChangeVM);
				BoardChangeVM.IsVisible = true;
			}
		}
	}

	private void SelectAchiShow(int achiId)
	{
		if (optCommand.Enabled)
		{
			if (childVMs.ContainsKey(typeof(PlayerInfoAchiSelectViewModel).FullName))
			{
				PlayerInfoAchiSelectViewModel vM = GetVM<PlayerInfoAchiSelectViewModel>();
				showViewRequest.Raise(new ShowViewArg(vM, isShow: true));
				return;
			}
			PlayerInfoAchiSelectViewModel playerInfoAchiSelectViewModel = new PlayerInfoAchiSelectViewModel(this);
			playerInfoAchiSelectViewModel.OnOpen(achiIdList, achiId);
			openWindowRequest.Raise(new OpenViewArg(typeof(PlayerInfoAchiSelectView), playerInfoAchiSelectViewModel, "PlayerInfo", isOpenWindow: false));
			childVMs.Add(typeof(PlayerInfoAchiSelectViewModel).FullName, playerInfoAchiSelectViewModel);
			playerInfoAchiSelectViewModel.IsVisible = true;
		}
	}

	private void SelectHeroShow(int heroId)
	{
		if (optCommand.Enabled)
		{
			if (childVMs.ContainsKey(typeof(PlayerInfoHeroSelectViewModel).FullName))
			{
				PlayerInfoHeroSelectViewModel vM = GetVM<PlayerInfoHeroSelectViewModel>();
				showViewRequest.Raise(new ShowViewArg(vM, isShow: true));
				return;
			}
			PlayerInfoHeroSelectViewModel playerInfoHeroSelectViewModel = new PlayerInfoHeroSelectViewModel(this);
			playerInfoHeroSelectViewModel.OnOpen(heroIdList, heroId);
			openWindowRequest.Raise(new OpenViewArg(typeof(PlayerInfoHeroSelectView), playerInfoHeroSelectViewModel, "PlayerInfo", isOpenWindow: false));
			childVMs.Add(typeof(PlayerInfoHeroSelectViewModel).FullName, playerInfoHeroSelectViewModel);
			playerInfoHeroSelectViewModel.IsVisible = true;
		}
	}

	private async Task OnShowHeroes(PlayerInfoHeroSelectViewModel selectViewModel)
	{
		heroItemList.Clear();
		heroIdList.Clear();
		foreach (HeroItemViewModel heroItemViewModel in selectViewModel.HeroItemViewModels)
		{
			if (heroItemViewModel.IsChecked)
			{
				heroItemList.Add(new HeroItemViewModel(this, heroItemViewModel.HeroModel));
				heroIdList.Add(heroItemViewModel.HeroModel.Id);
			}
		}
		updateHeroListRequest.Raise();
		bool num = await Singleton<ServiceSystem>.Instance.GetService<IRoleService>().ChangeShowHero(heroIdList);
		GetVM<PlayerInfoHeroSelectViewModel>().EnableOpt();
		if (num)
		{
			AddPlayerInfoChangeTDA();
		}
	}

	private async void OnShowAchis(PlayerInfoAchiSelectViewModel selectViewModel)
	{
		achiInfoList.Clear();
		achiIdList.Clear();
		List<PbMedalInfo> setMedals = new List<PbMedalInfo>();
		foreach (AchiItemData achiItemData in selectViewModel.AchiItemDatas)
		{
			if (achiItemData.IsChecked)
			{
				AchiItemData item = new AchiItemData(this, achiItemData.AchievementMedal);
				achiInfoList.Add(item);
				achiIdList.Add(achiItemData.AchiId);
				setMedals.Add(new PbMedalInfo
				{
					MedalId = achiItemData.AchiId,
					Rank = achiItemData.AchiRank,
					Tag = achiItemData.AchiTag
				});
			}
		}
		updateAchiListRequest.Raise();
		if (await Singleton<ServiceSystem>.Instance.GetService<IRoleService>().SendPlayerInfoUseMedals(setMedals))
		{
			playerInfo.SetWearMedals(setMedals);
			RoleService.AddPlayerInfoChangeTDA();
			Toast.ShowInfo("修改成功");
		}
	}

	public T GetVM<T>() where T : OptionBase
	{
		if (childVMs.ContainsKey(typeof(T).FullName))
		{
			return childVMs[typeof(T).FullName] as T;
		}
		return null;
	}

	private void InitPlayerInfoCopyInfoItem()
	{
		string[] array = new string[3] { "深潜区", "肃清裂隙", "极潜区" };
		for (int i = 0; i < 3; i++)
		{
			PlayerInfoCopyInfoItemViewModel item = new PlayerInfoCopyInfoItemViewModel(this, playerInfo.CopyChallengeInfos[i], array[i]);
			playerInfoCopyInfoItems.Add(item);
		}
	}

	public void RefreshFunctionList()
	{
		if (!IsSelf)
		{
			FunctionList.Clear();
			bool flag = Singleton<ServiceSystem>.Instance.GetService<ISocialService>().GetFriendViewModel().CheckBlackListExist(PlayerInfo.Uid);
			bool num = Singleton<ServiceSystem>.Instance.GetService<ISocialService>().GetFriendViewModel().CheckFriendExist(PlayerInfo.Uid);
			if (num)
			{
				functionList.Add(new TabItemNormalData(this, "empty", 1, isSelected: false, "删除好友"));
			}
			else if (!flag)
			{
				functionList.Add(new TabItemNormalData(this, "empty", 1, isSelected: false, "添加好友"));
			}
			functionList.Add(new TabItemNormalData(this, "empty", 2, isSelected: false, "私信"));
			functionList.Add(new TabItemNormalData(this, "empty", 3, isSelected: false, "举报"));
			if (num)
			{
				functionList.Add(new TabItemNormalData(this, "empty", 4, isSelected: false, "加入黑名单"));
			}
			else if (flag)
			{
				functionList.Add(new TabItemNormalData(this, "empty", 4, isSelected: false, "移出黑名单"));
			}
			else
			{
				functionList.Add(new TabItemNormalData(this, "empty", 4, isSelected: false, "加入黑名单"));
			}
		}
	}

	private async void AddFriendOrRemoveFriend()
	{
		if (Singleton<ServiceSystem>.Instance.GetService<ISocialService>().GetFriendViewModel().CheckFriendExist(PlayerInfo.Uid))
		{
			if (await Singleton<ServiceSystem>.Instance.GetService<ISocialService>().DelFriend(PlayerInfo.Uid))
			{
				Toast.ShowInfo("删除好友成功");
			}
		}
		else
		{
			IAsyncResult<KeyValuePair<int, string>> result = VerifyDialog.Show("添加好友", "申请后需等待对方通过", "请输入验证信息（最多15字）", "确定");
			result.Callbackable().OnCallback(delegate
			{
				if (result.Result.Key == -1)
				{
					if (result.Result.Value.Length > 15)
					{
						Toast.ShowInfo("验证信息不可超过15字");
					}
					else
					{
						AddFriend(result.Result.Value);
					}
				}
			});
		}
		optCommand.Enabled = true;
		PlayerInfoFunctionViewModel.CloseView();
	}

	private async void AddFriend(string verifyMsg)
	{
		Loading loading = await Loading.Show();
		await Singleton<ServiceSystem>.Instance.GetService<ISocialService>().AddFriend(playerInfo, verifyMsg);
		loading.Dispose();
	}

	private async void PrivateChat()
	{
		if (Singleton<ServiceSystem>.Instance.GetService<ISocialService>().GetFriendViewModel().CheckFriendExist(PlayerInfo.Uid))
		{
			try
			{
				FriendWindowViewModel vm = new FriendWindowViewModel(this);
				await vm.RequestAllFriendData();
				vm.SetTargetUidt(PlayerInfo.Uid);
				openWindowRequest.Raise(new OpenViewArg(typeof(FriendWindow), vm));
			}
			catch (Exception message)
			{
				Log.Error(message);
			}
		}
		else
		{
			Toast.ShowInfo("无法向陌生传火者发送私信哦~");
		}
		PlayerInfoFunctionViewModel.CloseView();
	}

	private async void Report()
	{
		openWindowRequest.Raise(new OpenViewArg(typeof(ReportWindow), new ReportViewModel(this, ReportTypeEnum.Player, playerInfo.Name, playerInfo.Uid)), delegate
		{
			optCommand.Enabled = true;
		});
		PlayerInfoFunctionViewModel.CloseView();
	}

	private async void AddToBlackListOrRemoveFromBlackList()
	{
		if (Singleton<ServiceSystem>.Instance.GetService<ISocialService>().GetFriendViewModel().CheckBlackListExist(PlayerInfo.Uid))
		{
			if (await Singleton<ServiceSystem>.Instance.GetService<ISocialService>().HandleFriendBlackList(playerInfo, ope: false))
			{
				Toast.ShowInfo("取消拉黑成功");
			}
		}
		else
		{
			if (playerInfo.RelationShip == PlayerData.RelationState.BlackList)
			{
				Toast.ShowInfo("已在黑名单中");
				optCommand.Enabled = true;
				return;
			}
			Loading loading = await Loading.Show();
			bool num = await Singleton<ServiceSystem>.Instance.GetService<ISocialService>().HandleFriendBlackList(playerInfo, ope: true);
			loading.Dispose();
			if (num)
			{
				Toast.ShowInfo("拉黑成功");
			}
		}
		optCommand.Enabled = true;
		PlayerInfoFunctionViewModel.CloseView();
	}
}
