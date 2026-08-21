#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.Pool;
using UnityEngine.UI;

namespace Ase;

public class PlayerInfoWindow : UGuiWindow
{
	[SerializeField]
	private Button btnBack1;

	[SerializeField]
	private Button btnBack2;

	[SerializeField]
	private Button btnChangeHead;

	[SerializeField]
	private Button btnChangeHead2;

	[SerializeField]
	private Button btnCopy;

	[SerializeField]
	private Button btnChangeName;

	[SerializeField]
	private Button btnChangeTitle;

	[SerializeField]
	private LoopListView2 heroList;

	[SerializeField]
	private Button btnAddFriend;

	[SerializeField]
	private Button btnOptFriend;

	[SerializeField]
	private StateItem userState;

	[SerializeField]
	private StateItem titleState;

	[SerializeField]
	private TextMeshProUGUI copyRankName;

	[SerializeField]
	private TextMeshProUGUI copyStarCount;

	[SerializeField]
	private LoadUISprite copyStarColor;

	[SerializeField]
	private LoopListView2 achiList;

	[SerializeField]
	private GameObject hideCopyInfoList;

	[SerializeField]
	private GameObject showCopyInfoList;

	[SerializeField]
	private LoopListView2 copyInfoList;

	[SerializeField]
	private Button BtnChangeBoardHero;

	[SerializeField]
	private RectTransform spineRoot;

	[SerializeField]
	private Button btnShowCopyInfo;

	[SerializeField]
	private Button btnHideCopyInfo;

	[SerializeField]
	private GameObject headRed;

	[SerializeField]
	private GameObject optRoot;

	[SerializeField]
	private Button btnCancel;

	[SerializeField]
	private MainRoleInfoView roleInfo;

	[SerializeField]
	private PlayerInfoFunctionView playerInfoFunctionView;

	public Transform fgRoot;

	public float scaleSize;

	private GameObject roleImgObj;

	private PlayerInfoViewModel viewModel;

	private string heroAssetPath;

	private string oldobj;

	private List<string> _loadedSpine;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<PlayerInfoViewModel>();
		if (_loadedSpine == null)
		{
			_loadedSpine = CollectionPool<List<string>, string>.Get();
		}
		_loadedSpine.Clear();
		BindingSet<PlayerInfoWindow, PlayerInfoViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((PlayerInfoWindow v) => v.OnDismissRequest).To((PlayerInfoViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((PlayerInfoWindow v) => v.OpenUguiWindow).To((PlayerInfoViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(this).For((PlayerInfoWindow v) => v.SetChildViewVisibility).To((PlayerInfoViewModel vm) => vm.ShowViewRequest);
		bindingSet.Bind<TextMeshProUGUI>(copyRankName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((PlayerInfoViewModel vm) => vm.CopyRankName);
		bindingSet.Bind<TextMeshProUGUI>(copyStarCount).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((PlayerInfoViewModel vm) => vm.PlayerInfo.WeeklyStarCount);
		bindingSet.Bind(copyStarColor).For((LoadUISprite v) => v.Path).ToExpression((PlayerInfoViewModel vm) => $"ItemIcons/Copy/Chapter/copy_star_{((vm.PlayerInfo.WeeklyRank > 1) ? 1 : 2)}.png");
		bindingSet.Bind(btnBack2).For((Button v) => v.onClick).To((PlayerInfoViewModel vm) => ((OptionBase)vm).Close);
		bindingSet.Bind(btnChangeHead).For((Button v) => v.onClick).To((PlayerInfoViewModel vm) => vm.OptCommand)
			.CommandParameter("ChangeHead");
		bindingSet.Bind(btnChangeHead2).For((Button v) => v.onClick).To((PlayerInfoViewModel vm) => vm.OptCommand)
			.CommandParameter("ChangeHead");
		bindingSet.Bind(btnCopy).For((Button v) => v.onClick).To((PlayerInfoViewModel vm) => vm.OptCommand)
			.CommandParameter("CopyUID");
		bindingSet.Bind(btnChangeName).For((Button v) => v.onClick).To((PlayerInfoViewModel vm) => vm.OptCommand)
			.CommandParameter("ChangeName");
		bindingSet.Bind(btnChangeName.gameObject).For((GameObject v) => v.activeSelf).To((PlayerInfoViewModel vm) => vm.EverHadCard);
		bindingSet.Bind(btnChangeTitle).For((Button v) => v.onClick).To((PlayerInfoViewModel vm) => vm.OptCommand)
			.CommandParameter("ChangeTitle");
		bindingSet.Bind(btnAddFriend).For((Button v) => v.onClick).To((PlayerInfoViewModel vm) => vm.OptCommand)
			.CommandParameter("AddFriend");
		bindingSet.Bind(btnOptFriend.gameObject).For((GameObject v) => v.activeSelf).ToExpression((PlayerInfoViewModel vm) => !vm.IsSelf);
		bindingSet.Bind(userState).For((StateItem v) => v.CurState).ToExpression((PlayerInfoViewModel vm) => vm.IsSelf ? 0 : (((int)vm.PlayerInfo.RelationShip == 3 || (int)vm.PlayerInfo.RelationShip == 4) ? 1 : 2));
		bindingSet.Bind().For((PlayerInfoWindow v) => v.UpdateHeroList).To((PlayerInfoViewModel vm) => vm.UpdateHeroListRequest);
		bindingSet.Bind().For((PlayerInfoWindow v) => v.UpdateHeroInfo).To((PlayerInfoViewModel vm) => vm.UpdateHeroInfoRequest);
		bindingSet.Bind().For((PlayerInfoWindow v) => v.UpdateAchiList).To((PlayerInfoViewModel vm) => vm.UpdateAchiListRequest);
		bindingSet.Bind(hideCopyInfoList).For((GameObject v) => v.activeSelf).ToExpression((PlayerInfoViewModel vm) => !vm.IsSelf && !vm.CopyInfoImgShowOrHide);
		bindingSet.Bind(showCopyInfoList).For((GameObject v) => v.activeSelf).ToExpression((PlayerInfoViewModel vm) => vm.IsSelf || vm.CopyInfoImgShowOrHide);
		bindingSet.Bind(BtnChangeBoardHero).For((Button v) => v.onClick).To((PlayerInfoViewModel vm) => vm.OptCommand)
			.CommandParameter("OpenBoardChange");
		bindingSet.Bind(BtnChangeBoardHero.gameObject).For((GameObject v) => v.activeSelf).ToExpression((PlayerInfoViewModel vm) => vm.IsSelf);
		bindingSet.Bind().For((PlayerInfoWindow v) => RefreshSpine).To((PlayerInfoViewModel vm) => vm.RefreshSpineRst);
		bindingSet.Bind(btnShowCopyInfo).For((Button v) => v.onClick).To((PlayerInfoViewModel vm) => vm.OptCommand)
			.CommandParameter("CopyInfo");
		bindingSet.Bind(btnHideCopyInfo).For((Button v) => v.onClick).To((PlayerInfoViewModel vm) => vm.OptCommand)
			.CommandParameter("CopyInfo");
		bindingSet.Bind(btnShowCopyInfo.gameObject).For((GameObject v) => v.activeSelf).ToExpression((PlayerInfoViewModel vm) => vm.CopyInfoImgShowOrHide);
		bindingSet.Bind(btnHideCopyInfo.gameObject).For((GameObject v) => v.activeSelf).ToExpression((PlayerInfoViewModel vm) => !vm.CopyInfoImgShowOrHide);
		bindingSet.Build();
		roleInfo.Init(viewModel.PlayerInfo);
		heroList.InitListView(3, OnGetHeroItemByIndex);
		achiList.InitListView(4, OnGetAchiItemByIndex);
		copyInfoList.InitListView(viewModel.PlayerInfoCopyInfoItems.Count, OnGetCopyInfoItemByIndex);
		playerInfoFunctionView.Init(viewModel.PlayerInfoFunctionViewModel);
		optRoot.SetActive(value: false);
		btnOptFriend.onClick.AddListener(OpenOptRoot);
		btnCancel.onClick.AddListener(CloseOptRoot);
		InitRedPoint();
		LoadInitialSpine();
	}

	protected override async void OnShow()
	{
		base.OnShow();
		await viewModel.OnShow();
		ChangeHeroFgImg();
	}

	private void InitRedPoint()
	{
		try
		{
			headRed.GetComponent<UIRedPoint>()?.Init().AddEnum(RedPointMessageEnum.HeroHeadIcon).SetFuncOnMessage((RedPointMessage message) => viewModel.IsSelf && Singleton<ServiceSystem>.Instance.GetService<IRedPointService>().GetUserRead(ServerReadEnum.HeroHeadIcon))
				.Invoke();
			headRed.gameObject.SetActive(viewModel.IsSelf && Singleton<ServiceSystem>.Instance.GetService<IRedPointService>().GetUserRead(ServerReadEnum.HeroHeadIcon));
		}
		catch (Exception)
		{
		}
	}

	private void CloseOptRoot()
	{
		optRoot.SetActive(value: false);
		btnCancel.gameObject.SetActive(value: false);
	}

	private void OpenOptRoot()
	{
		optRoot.SetActive(value: true);
		btnCancel.gameObject.SetActive(value: true);
		viewModel.RefreshFunctionList();
		viewModel.PlayerInfoFunctionViewModel.SetFunctionList(viewModel);
	}

	private void UpdateHeroInfo(object sender, InteractionEventArgs e)
	{
		ChangeHeroFgImg();
	}

	private void UpdateHeroList(object sender, InteractionEventArgs e)
	{
		heroList.SetListItemCount(3);
		heroList.RefreshAllShownItem();
	}

	private LoopListViewItem2 OnGetHeroItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= 3)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = null;
		if (index >= viewModel.HeroItemList.Count)
		{
			loopListViewItem = listView2.NewListViewItem("EmptyItem");
			if (loopListViewItem != null)
			{
				AddHeroItemView component = loopListViewItem.GetComponent<AddHeroItemView>();
				if (!loopListViewItem.IsInitHandlerCalled)
				{
					loopListViewItem.IsInitHandlerCalled = true;
					component.Init(viewModel.GetEmptyVM());
				}
			}
			return loopListViewItem;
		}
		loopListViewItem = listView2.NewListViewItem("HeroItem");
		if (loopListViewItem != null)
		{
			HeroItem component2 = loopListViewItem.GetComponent<HeroItem>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component2.Init(viewModel.HeroItemList[index]);
			}
			else
			{
				component2.RefreshData(viewModel.HeroItemList[index]);
			}
		}
		return loopListViewItem;
	}

	public async void ChangeHeroFgImg()
	{
		if (oldobj != null && oldobj.Equals(viewModel.OriImage))
		{
			return;
		}
		if (roleImgObj != null)
		{
			UnityEngine.Object.DestroyImmediate(roleImgObj);
			roleImgObj = null;
		}
		if (viewModel.OriImage != null)
		{
			GameObject gameObject = await InstantiateAsync(AssetUtility.GetUIItemAsset(viewModel.OriImage), fgRoot);
			if (gameObject != null)
			{
				roleImgObj = gameObject;
				roleImgObj.transform.localScale = new Vector3(scaleSize, scaleSize, 1f);
				oldobj = viewModel.OriImage;
				StreamerMode.ApplySpineSkin(gameObject);
			}
			else
			{
				Log.Error("加载资源失败，请检查资源路径是否配置正确 " + viewModel.OriImage + "！");
				Toast.ShowInfo("加载资源失败");
			}
		}
	}

	protected override void OnDismiss()
	{
		base.OnDismiss();
		if (roleImgObj != null)
		{
			UnityEngine.Object.DestroyImmediate(roleImgObj);
			roleImgObj = null;
		}
	}

	private void UpdateAchiList(object sender, InteractionEventArgs e)
	{
		achiList.SetListItemCount(4);
		achiList.RefreshAllShownItem();
	}

	private LoopListViewItem2 OnGetCopyInfoItemByIndex(LoopListView2 view, int index)
	{
		if (index < 0 || index >= viewModel.PlayerInfoCopyInfoItems.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = view.NewListViewItem("CopyInfoItem");
		if (loopListViewItem != null)
		{
			PlayerInfoCopyInfoItem component = loopListViewItem.GetComponent<PlayerInfoCopyInfoItem>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.PlayerInfoCopyInfoItems[index]);
			}
			else
			{
				component.RefreshData(viewModel.PlayerInfoCopyInfoItems[index]);
			}
		}
		return loopListViewItem;
	}

	private LoopListViewItem2 OnGetAchiItemByIndex(LoopListView2 view, int index)
	{
		if (index < 0 || index >= 4)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = null;
		if (index >= viewModel.AchiInfoList.Count)
		{
			loopListViewItem = view.NewListViewItem("AchiEmpty");
			if (loopListViewItem != null)
			{
				AddAchiItemView component = loopListViewItem.GetComponent<AddAchiItemView>();
				if (!loopListViewItem.IsInitHandlerCalled)
				{
					loopListViewItem.IsInitHandlerCalled = true;
					component.Init(viewModel.GetAchiEmptyVM());
				}
			}
			return loopListViewItem;
		}
		loopListViewItem = view.NewListViewItem("AchiItem");
		if (loopListViewItem != null)
		{
			AchiItem component2 = loopListViewItem.GetComponent<AchiItem>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component2.Init(viewModel.AchiInfoList[index]);
			}
			else
			{
				component2.RefreshData(viewModel.AchiInfoList[index]);
			}
		}
		return loopListViewItem;
	}

	private async void LoadInitialSpine()
	{
		int id = ((viewModel.PlayerInfo.ShowPosterGirl == 0) ? 110400 : viewModel.PlayerInfo.ShowPosterGirl);
		DRBoardHeroList dRBoardHeroList = ((viewModel.PlayerInfo.ShowPosterGirl != 0) ? GameEntry.DataTable.GetDataRow<DRBoardHeroList>(viewModel.PlayerInfo.ShowPosterGirl) : GameEntry.DataTable.GetDataRow<DRBoardHeroList>(id));
		heroAssetPath = dRBoardHeroList.AssetPath;
		if (!string.IsNullOrEmpty(heroAssetPath))
		{
			string uIItemAsset = AssetUtility.GetUIItemAsset(BoardHeroData.GetSpineAssetPath(heroAssetPath));
			AddLoadedSpinePath(uIItemAsset);
			GameObject gameObject = await InstantiateAsync(uIItemAsset, spineRoot);
			if (!(gameObject == null))
			{
				GameObject heroSpine = viewModel.HeroSpine;
				DisposeHeroSpine(heroSpine);
				viewModel.HeroSpine = gameObject;
				SetHeroSpine();
				StreamerMode.ApplySpineSkin(gameObject);
			}
		}
	}

	private async void RefreshSpine(object sender, InteractionEventArgs e)
	{
		if (viewModel.BoardChangeVM.CurSelectSpineItemData == null)
		{
			return;
		}
		DRBoardHeroList drHero = viewModel.BoardChangeVM.CurSelectSpineItemData.DrHero;
		string text = heroAssetPath;
		if (!string.IsNullOrEmpty(text))
		{
			AddLoadedSpinePath(AssetUtility.GetUIItemAsset(BoardHeroData.GetSpineAssetPath(text)));
		}
		heroAssetPath = drHero.AssetPath;
		if (!string.IsNullOrEmpty(heroAssetPath))
		{
			string uIItemAsset = AssetUtility.GetUIItemAsset(BoardHeroData.GetSpineAssetPath(heroAssetPath));
			AddLoadedSpinePath(uIItemAsset);
			GameObject gameObject = await InstantiateAsync(uIItemAsset, spineRoot);
			if (!(gameObject == null))
			{
				GameObject heroSpine = viewModel.HeroSpine;
				DisposeHeroSpine(heroSpine);
				viewModel.HeroSpine = gameObject;
				StreamerMode.ApplySpineSkin(gameObject);
				SetHeroSpine();
			}
		}
	}

	private void AddLoadedSpinePath(string path)
	{
		if (_loadedSpine != null && !_loadedSpine.Contains(path))
		{
			_loadedSpine.Add(path);
		}
	}

	private void DisposeHeroSpine(GameObject spineObj)
	{
		if (spineObj != null)
		{
			SpineFusion componentInChildren = spineObj.transform.GetComponentInChildren<SpineFusion>();
			if ((UnityEngine.Object)(object)componentInChildren != null)
			{
				componentInChildren.ResetToIdle();
			}
			UnityEngine.Object.Destroy(spineObj);
		}
	}

	private void SetHeroSpine()
	{
		if (viewModel.BoardChangeVM == null)
		{
			viewModel.BoardChangeVM = new PlayerInfoBoardHeroChangeViewModel(viewModel, new BoardHeroData((viewModel.PlayerInfo.ShowPosterGirl == 0) ? 110400 : viewModel.PlayerInfo.ShowPosterGirl, viewModel.PlayerInfo.ShowPosterGirl));
		}
		if (viewModel.BoardChangeVM.CurSelectSpineItemData != null)
		{
			DRBoardHeroList drHero = viewModel.BoardChangeVM.CurSelectSpineItemData.DrHero;
			AddLoadedSpinePath(AssetUtility.GetUIItemAsset(BoardHeroData.GetSpineAssetPath(drHero.AssetPath)));
			spineRoot.localScale = new Vector3((drHero.Scale.Count > 0) ? drHero.Scale[0] : 1f, (drHero.Scale.Count > 1) ? drHero.Scale[1] : 1f, (drHero.Scale.Count > 2) ? drHero.Scale[2] : 1f);
			spineRoot.anchoredPosition = new Vector2((drHero.Position.Count > 0) ? drHero.Position[0] : 0f, (drHero.Position.Count > 1) ? drHero.Position[1] : 0f);
			viewModel.HeroSpine.transform.SetParent(spineRoot);
			SpineFusion componentInChildren = viewModel.HeroSpine.transform.GetComponentInChildren<SpineFusion>();
			if (!((UnityEngine.Object)(object)componentInChildren == null) && !((UnityEngine.Object)(object)componentInChildren.SkeletonGraphic == null))
			{
				((Behaviour)(object)componentInChildren).enabled = true;
				((Graphic)(object)componentInChildren.SkeletonGraphic).raycastTarget = false;
				componentInChildren.SkeletonGraphic.freeze = false;
				SpineHelper.SetSpineInteractivity(viewModel.HeroSpine.transform, interactivity: false);
			}
		}
	}
}
