using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using System.Threading.Tasks;
using GameFramework.Runtime;
using Spine;
using Spine.Unity;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class HomelandMainWindow : UGuiWindowBase
{
	public GameObject nameRoot;

	public new Text name;

	public TextMeshProUGUI level1;

	public TextMeshProUGUI level2;

	public GameObject normalLevelRoot;

	public GameObject maxLevelRoot;

	public GameObject effectNormalRoot;

	public GameObject effectMaxRoot;

	public GameObject upgradeRed;

	public Button btnUpgradeLevel;

	public HomelandUpgradeView UpgradeView;

	public AutoDispose upgradeEffect;

	public GameObject effect1;

	public GameObject effectMax;

	public TextMeshProUGUI upgradeEffectText1;

	public TextMeshProUGUI upgradeEffectText2;

	public TextMeshProUGUI upgradeEffectTextMax1;

	public TextMeshProUGUI upgradeEffectTextMax2;

	public RectTransform pos1;

	public RectTransform pos2;

	public RectTransform buildsRoot;

	public List<HomelandBuildingItemView> buildItems;

	public LoopListView2 buildingUpgradeList;

	public Transform buildingUpgradeRoot;

	public Button btnOpenBuild;

	public GameObject buildRed;

	public HomelandBuildingUpgradeView BuildingUpgradeView;

	public Button upgradeMaskBg;

	public LoopListView2 friendList;

	public Transform friendListRoot;

	public Button btnOpenFriend;

	public Button btnClose;

	public Button btnBg;

	public SkeletonGraphic spine;

	public string loadAniName;

	public string defaultAniName;

	private bool isSelf;

	public MoneyView moneyView;

	private HomelandMainViewModel viewModel;

	private AnimationState.TrackEntryDelegate playFinish;

	public bool IsSelf
	{
		get
		{
			return isSelf;
		}
		set
		{
			isSelf = value;
			btnUpgradeLevel.gameObject.SetActive(isSelf);
			btnOpenBuild.gameObject.SetActive(isSelf);
			nameRoot.gameObject.SetActive(!isSelf);
			for (int i = 0; i < buildItems.Count; i++)
			{
				buildItems[i].IsSelf = true;
			}
		}
	}

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<HomelandMainViewModel>();
		BindingSet<HomelandMainWindow, HomelandMainViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind<TextMeshProUGUI>(level1).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((HomelandMainViewModel vm) => $"{vm.Level}");
		bindingSet.Bind<TextMeshProUGUI>(level2).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((HomelandMainViewModel vm) => $"{vm.LevelMax}");
		bindingSet.Bind(normalLevelRoot).For((GameObject v) => v.activeSelf).ToExpression((HomelandMainViewModel vm) => vm.Level < vm.LevelMax);
		bindingSet.Bind(maxLevelRoot).For((GameObject v) => v.activeSelf).ToExpression((HomelandMainViewModel vm) => vm.Level >= vm.LevelMax);
		bindingSet.Bind(upgradeRed).For((GameObject v) => v.activeSelf).To((HomelandMainViewModel vm) => vm.CanUpgrade);
		bindingSet.Bind(btnClose).For((Button v) => v.onClick).To((HomelandMainViewModel vm) => vm.OptCommand)
			.CommandParameter("OnLeft");
		bindingSet.Bind(buildRed).For((GameObject v) => v.activeSelf).To((HomelandMainViewModel vm) => vm.HasRed);
		bindingSet.Bind(this).For((HomelandMainWindow v) => v.OnDismissRequest).To((HomelandMainViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((HomelandMainWindow v) => v.OpenUguiWindow).To((HomelandMainViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind().For((HomelandMainWindow v) => v.IsSelf).To((HomelandMainViewModel vm) => vm.IsSelf);
		bindingSet.Bind(name).For((Text v) => v.text).To((HomelandMainViewModel vm) => vm.FriendName);
		bindingSet.Bind().For((HomelandMainWindow v) => v.SettleOpt).To((HomelandMainViewModel vm) => vm.OptRequest);
		bindingSet.Bind(btnUpgradeLevel).For((Button v) => v.onClick).To((HomelandMainViewModel vm) => vm.OptCommand)
			.CommandParameter("OnOpenUpgradeLevel");
		bindingSet.Bind(btnOpenBuild).For((Button v) => v.onClick).To((HomelandMainViewModel vm) => vm.OptCommand)
			.CommandParameter("OnOpenBuilding");
		bindingSet.Bind(btnOpenFriend).For((Button v) => v.onClick).To((HomelandMainViewModel vm) => vm.OptCommand)
			.CommandParameter("OnOpenFriend");
		bindingSet.Build();
		nameRoot.gameObject.SetActive(value: false);
		if (buildItems != null)
		{
			for (int num = 0; num < buildItems.Count; num++)
			{
				HomelandBuildingItemViewModel buildVMById = viewModel.GetBuildVMById(buildItems[num].buildingId);
				buildItems[num].Init(buildVMById);
				buildItems[num].ShowNameTab(isShow: false);
				if (buildVMById.Data.Id == 3)
				{
					buildItems[num].GetComponent<UIRedPoint>()?.Init().AddEnum(RedPointMessageEnum.HomelandShopRefreshRed).AddEnum(RedPointMessageEnum.HomelandFriendShopRefreshRed)
						.SetFuncOnMessage(delegate
						{
							IHomeLandService service = Singleton<ServiceSystem>.Instance.GetService<IHomeLandService>();
							bool valueOrDefault = service?.GetHomeShopViewModel()?.GetHomeShopRefreshRed() == true;
							bool valueOrDefault2 = service?.GetHomeShopViewModel()?.GetFriendHomeShopRefreshRed() == true;
							return ((service?.GetHomeShopViewModel()?.CheckFriendHomeShopOpened() == true) & valueOrDefault2) | valueOrDefault;
						})
						.Invoke();
				}
				if (buildVMById.Data.Id == 1)
				{
					buildItems[num].GetComponent<UIRedPoint>()?.Init().AddEnum(RedPointMessageEnum.HomelandFarmRed).SetFuncOnMessage((RedPointMessage msg) => Singleton<ServiceSystem>.Instance?.GetService<IHomeLandService>()?.GetVm()?.CheckCanHarvestByType(1) == true)
						.Invoke();
				}
				if (buildVMById.Data.Id == 2)
				{
					buildItems[num].GetComponent<UIRedPoint>()?.Init().AddEnum(RedPointMessageEnum.HomelandSailRed).SetFuncOnMessage((RedPointMessage msg) => Singleton<ServiceSystem>.Instance?.GetService<IHomeLandService>()?.GetVm()?.CheckCanHarvestByType(2) == true)
						.Invoke();
				}
			}
		}
		friendListRoot.gameObject.SetActive(value: false);
		SetBuildingPos(isOri: true);
		upgradeMaskBg.gameObject.SetActive(value: false);
		UpgradeView.gameObject.SetActive(value: false);
		buildingUpgradeRoot.gameObject.SetActive(value: false);
		BuildingUpgradeView.gameObject.SetActive(value: false);
		upgradeMaskBg.onClick.AddListener(delegate
		{
			Settle("OnCloseBuilding");
			Settle("OnCloseFriend");
		});
		moneyView.Init(new MoneyViewModel(viewModel));
		upgradeEffect.AddDisposeAction(delegate(GameObject p)
		{
			p.gameObject.SetActive(value: false);
		});
		PlaySpineAni();
		IsSelf = viewModel.IsSelf;
	}

	protected override void OnShow()
	{
		base.OnShow();
		OpenWindowOnShow();
	}

	private async void OpenWindowOnShow()
	{
		await Task.Delay(100);
		viewModel.OpenWindowOnShow();
	}

	private void PlaySpineAni()
	{
		for (int i = 0; i < buildItems.Count; i++)
		{
			buildItems[i].ShowNameTab(isShow: false);
		}
		spine.AnimationState.SetAnimation(0, loadAniName, loop: false);
		playFinish = delegate
		{
			for (int j = 0; j < buildItems.Count; j++)
			{
				buildItems[j].ShowNameTab(isShow: true);
			}
			spine.AnimationState.Complete -= playFinish;
			playFinish = null;
		};
		spine.AnimationState.Complete += playFinish;
		spine.AnimationState.AddAnimation(0, defaultAniName, loop: true, 0f);
	}

	private void SetBuildingPos(bool isOri)
	{
		if (isOri)
		{
			buildsRoot.SetParent(pos1);
			buildsRoot.anchoredPosition = Vector2.zero;
		}
		else
		{
			buildsRoot.SetParent(pos2);
			buildsRoot.anchoredPosition = Vector2.zero;
		}
	}

	private void SettleOpt(object sender, InteractionEventArgs e)
	{
		string opt = (string)e.Context;
		Settle(opt);
	}

	private void Settle(string opt)
	{
		if ("OnOpenUpgradeLevel".Equals(opt))
		{
			UpgradeView.gameObject.SetActive(value: true);
			UpgradeView.Init(viewModel.UpgradeVm);
		}
		else if ("OnCloseUpgradeLevel".Equals(opt))
		{
			UpgradeView.gameObject.SetActive(value: false);
		}
		else if ("ShowUpgradeLevelEffect".Equals(opt))
		{
			if (viewModel.Level < viewModel.LevelMax - 1)
			{
				effect1.gameObject.SetActive(value: true);
				effectMax.gameObject.SetActive(value: false);
				((TMP_Text)upgradeEffectText1).text = $"{viewModel.Level}";
				((TMP_Text)upgradeEffectText2).text = $"{viewModel.Level + 1}";
			}
			else
			{
				effect1.gameObject.SetActive(value: false);
				effectMax.gameObject.SetActive(value: true);
				((TMP_Text)upgradeEffectTextMax1).text = $"{viewModel.Level}";
				((TMP_Text)upgradeEffectTextMax2).text = $"{viewModel.Level + 1}";
			}
			upgradeEffect.gameObject.SetActive(value: false);
			upgradeEffect.gameObject.SetActive(value: true);
		}
		else if ("OnOpenBuildingUpgrade".Equals(opt))
		{
			BuildingUpgradeView.gameObject.SetActive(value: true);
			BuildingUpgradeView.Init(viewModel.CurBuildingItem);
		}
		else if ("OnCloseBuildingUpgrade".Equals(opt))
		{
			BuildingUpgradeView.gameObject.SetActive(value: false);
		}
		else if ("OnOpenBuilding".Equals(opt))
		{
			if (!buildingUpgradeList.IsInited)
			{
				buildingUpgradeList.InitListView(viewModel.GetBuildVMs().Count, OnGetBuildingUpgradeItemByIndex);
			}
			buildingUpgradeRoot.gameObject.SetActive(value: true);
			SetBuildingPos(isOri: false);
			upgradeMaskBg.gameObject.SetActive(value: true);
			for (int i = 0; i < buildItems.Count; i++)
			{
				buildItems[i].nameRoot.SetActive(value: false);
			}
		}
		else if ("OnOpenFriend".Equals(opt))
		{
			if (friendListRoot.gameObject.activeSelf)
			{
				friendListRoot.gameObject.SetActive(value: false);
				upgradeMaskBg.gameObject.SetActive(value: false);
				return;
			}
			friendListRoot.gameObject.SetActive(value: true);
			upgradeMaskBg.gameObject.SetActive(value: true);
			if (!friendList.IsInited)
			{
				friendList.InitListView(viewModel.FriendList.Count, OnGetFriendItemByIndex);
			}
		}
		else if ("OnCloseFriend".Equals(opt))
		{
			friendListRoot.gameObject.SetActive(value: false);
			upgradeMaskBg.gameObject.SetActive(value: false);
		}
		else if ("OnCloseBuilding".Equals(opt))
		{
			buildingUpgradeRoot.gameObject.SetActive(value: false);
			SetBuildingPos(isOri: true);
			upgradeMaskBg.gameObject.SetActive(value: false);
			for (int j = 0; j < buildItems.Count; j++)
			{
				buildItems[j].IsSelf = isSelf;
			}
		}
		else if ("ShowFriendHomeland".Equals(opt))
		{
			for (int k = 0; k < buildItems.Count; k++)
			{
				buildItems[k].Init(viewModel.GetFriendBuildVMById(buildItems[k].buildingId));
				buildItems[k].IsSelf = false;
			}
			ShowLevelEffect();
			PlaySpineAni();
		}
		else if ("ShowSelfHomeland".Equals(opt))
		{
			btnOpenBuild.gameObject.SetActive(value: true);
			for (int l = 0; l < buildItems.Count; l++)
			{
				buildItems[l].Init(viewModel.GetBuildVMById(buildItems[l].buildingId));
				buildItems[l].IsSelf = true;
			}
			ShowLevelEffect();
			PlaySpineAni();
		}
	}

	private void ShowLevelEffect()
	{
		if (viewModel.Level < viewModel.LevelMax)
		{
			effectNormalRoot.gameObject.SetActive(value: false);
			effectNormalRoot.gameObject.SetActive(value: true);
		}
		else
		{
			effectMaxRoot.gameObject.SetActive(value: false);
			effectMaxRoot.gameObject.SetActive(value: true);
		}
	}

	private LoopListViewItem2 OnGetFriendItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.FriendList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("HomelandFriendItemView");
		if (loopListViewItem != null)
		{
			HomelandFriendItemView component = loopListViewItem.GetComponent<HomelandFriendItemView>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.FriendList[index]);
			}
			else
			{
				component.RefreshData(viewModel.FriendList[index]);
			}
		}
		return loopListViewItem;
	}

	private LoopListViewItem2 OnGetBuildingUpgradeItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.GetBuildVMs().Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("BuildingItemView");
		if (loopListViewItem != null)
		{
			BuildingItemUpgradeView component = loopListViewItem.GetComponent<BuildingItemUpgradeView>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.GetBuildVMs()[index]);
			}
			else
			{
				component.RefreshData(viewModel.GetBuildVMs()[index]);
			}
		}
		return loopListViewItem;
	}
}
