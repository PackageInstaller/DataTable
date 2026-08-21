#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using System.Threading.Tasks;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class GameHeroInfoWindow : UGuiWindow
{
	[SerializeField]
	private Button btnBack;

	[SerializeField]
	private List<TabItemNormal> tagList;

	[SerializeField]
	private TextMeshProUGUI heroName;

	[SerializeField]
	private TextMeshProUGUI heroTitle;

	[SerializeField]
	private TextMeshProUGUI heroBirthday;

	[SerializeField]
	private TextMeshProUGUI heroAffiliation;

	[SerializeField]
	private Image heroFaction;

	[SerializeField]
	private TextMeshProUGUI heroProfile;

	[SerializeField]
	private LoopListView2 heroTagList;

	[SerializeField]
	private RectTransform heroDetailTextRect;

	[SerializeField]
	private GameObject heroDetailObj;

	[SerializeField]
	private UIGameObjectSort uiGameObjectSort;

	[SerializeField]
	private GameObject btnTreasureLeftObj;

	[SerializeField]
	private Button btnTreasureLeft;

	[SerializeField]
	private GameObject btnTreasureRightObj;

	[SerializeField]
	private Button btnTreasureRight;

	[SerializeField]
	private GameHeroInfoItem heroTreasure;

	[SerializeField]
	private LoopListView2 pointList;

	[SerializeField]
	private GameObject pointListObj;

	[SerializeField]
	private RectTransform heroStoryRect;

	[SerializeField]
	private GameObject heroStoryObj;

	[SerializeField]
	private GameObject spaceObj;

	[SerializeField]
	private UIGameObjectSort uiGameObjectSort2;

	[SerializeField]
	private HeroVoiceView heroVoiceView;

	[SerializeField]
	private LoopListView2 heroSkinList;

	[SerializeField]
	private GameObject heroSkinEmptyObj;

	[SerializeField]
	private LoopGridView heroCGList;

	[SerializeField]
	private GameObject heroCGEmptyObj;

	[SerializeField]
	private GameObject _spineContainerView;

	[SerializeField]
	private RectTransform _spineContainer;

	[SerializeField]
	private List<GameNoteHeroTab> _spineBindTabs;

	private GameHeroInfoViewModel viewModel;

	private GameNoteHeroTab _curSelectedTab;

	private List<GameObject> createObjList = new List<GameObject>();

	public GameNoteHeroTab CurSelectedTab
	{
		get
		{
			return _curSelectedTab;
		}
		set
		{
			if (_curSelectedTab != value)
			{
				_curSelectedTab = value;
				_spineContainerView.SetActive(_spineBindTabs.Contains(_curSelectedTab));
			}
		}
	}

	private void InitSpineContainer()
	{
		if (_spineBindTabs.Contains(_curSelectedTab) && !_spineContainerView.activeSelf)
		{
			_spineContainerView.SetActive(value: true);
		}
	}

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<GameHeroInfoViewModel>();
		BindingSet<GameHeroInfoWindow, GameHeroInfoViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((GameHeroInfoViewModel vm) => ((OptionBase)vm).Close);
		bindingSet.Bind(this).For((GameHeroInfoWindow v) => v.OpenUguiWindow).To((GameHeroInfoViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(this).For((GameHeroInfoWindow v) => v.CloseWindow).To((GameHeroInfoViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((GameHeroInfoWindow v) => v.CurSelectedTab).To((GameHeroInfoViewModel vm) => vm.SelectedTag)
			.OneWay();
		bindingSet.Bind(btnTreasureLeft).For((Button v) => v.onClick).To((GameHeroInfoViewModel vm) => vm.TreasureLeft);
		bindingSet.Bind(btnTreasureRight).For((Button v) => v.onClick).To((GameHeroInfoViewModel vm) => vm.TreasureRight);
		bindingSet.Bind<TextMeshProUGUI>(heroName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GameHeroInfoViewModel vm) => vm.HeroModel.Name);
		bindingSet.Bind<TextMeshProUGUI>(heroTitle).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((GameHeroInfoViewModel vm) => vm.HeroModel.Title);
		bindingSet.Bind<TextMeshProUGUI>(heroBirthday).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((GameHeroInfoViewModel vm) => $"生日:{vm.HeroModel.Birthday}");
		bindingSet.Bind<TextMeshProUGUI>(heroAffiliation).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((GameHeroInfoViewModel vm) => $"所属:{vm.HeroModel.Affiliation}");
		bindingSet.Bind<TextMeshProUGUI>(heroProfile).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((GameHeroInfoViewModel vm) => $"简介:{vm.HeroModel.Story}");
		bindingSet.Build();
		InitTagList();
		InitSpineContainer();
		LoadHeroImg();
		heroVoiceView.Init(viewModel.HeroVoiceViewModel);
		heroTagList.InitListView(viewModel.HeroTagList.Count, OnGetTagItemByIndex);
		LoadHeroDetailText();
		LoadStory();
		pointList.InitListView(viewModel.HeroTreasurePointList.Count, OnGetHeroTreasureItemByIndex);
		heroSkinList.InitListView(viewModel.HeroSkinList.Count, OnGetHeroSkinItemByIndex);
		heroSkinEmptyObj.SetActive(viewModel.HeroSkinList.Count == 0);
		heroCGList.InitGridView(viewModel.HeroCgList.Count, OnGetCGItemByIndex);
		heroCGEmptyObj.SetActive(viewModel.HeroCgList.Count == 0);
		heroTreasure.Init(viewModel.HeroTreasureItemData);
	}

	private void InitTagList()
	{
		if (tagList.Count != viewModel.TagList.Count)
		{
			Toast.ShowError("标签数量不匹配");
			return;
		}
		for (int i = 0; i < tagList.Count; i++)
		{
			tagList[i].Init(viewModel.TagList[i]);
			tagList[i].gameObject.SetActive(!GameEntry.BuiltinData.OpenTestFlight || !Constant.DisabledHeroInfoTabs.Contains(i));
		}
	}

	private void LoadStory()
	{
		for (int i = 0; i < viewModel.HeroStoryList.Count; i++)
		{
			GameObject gameObject = UnityEngine.Object.Instantiate(spaceObj, heroStoryRect);
			GameObject obj = UnityEngine.Object.Instantiate(heroStoryObj, heroStoryRect);
			gameObject.gameObject.SetActive(value: true);
			obj.transform.GetComponent<GameHeroInfoItem>().Init(viewModel.HeroStoryList[i]);
			obj.gameObject.SetActive(value: true);
		}
		uiGameObjectSort2.Sort();
	}

	private void LoadHeroDetailText()
	{
		for (int i = 0; i < viewModel.HeroDetailList.Count; i++)
		{
			GameObject obj = UnityEngine.Object.Instantiate(heroDetailObj, heroDetailTextRect);
			obj.transform.GetComponent<GameHeroInfoItem>().Init(viewModel.HeroDetailList[i]);
			obj.gameObject.SetActive(value: true);
		}
		uiGameObjectSort.Sort();
		btnTreasureLeftObj.gameObject.SetActive(viewModel.HeroTreasureList.Count > 1);
		btnTreasureRightObj.gameObject.SetActive(viewModel.HeroTreasureList.Count > 1);
		pointList.gameObject.SetActive(viewModel.HeroTreasureList.Count > 1);
	}

	private LoopListViewItem2 OnGetTagItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.HeroTagList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = (viewModel.HeroTagList[index].IsLock ? listView2.NewListViewItem("HeroTagItemRight") : listView2.NewListViewItem("HeroTagItemLeft"));
		if (loopListViewItem != null)
		{
			GameHeroInfoItem component = loopListViewItem.GetComponent<GameHeroInfoItem>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.HeroTagList[index]);
			}
			else
			{
				component.RefreshInfoData(viewModel.HeroTagList[index]);
			}
		}
		return loopListViewItem;
	}

	private LoopListViewItem2 OnGetHeroTreasureItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.HeroTreasurePointList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("Point");
		if (loopListViewItem != null)
		{
			TabItemNormal component = loopListViewItem.GetComponent<TabItemNormal>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.HeroTreasurePointList[index]);
			}
			else
			{
				component.RefreshData(viewModel.HeroTreasurePointList[index]);
			}
		}
		return loopListViewItem;
	}

	private LoopListViewItem2 OnGetHeroSkinItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.HeroSkinList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("HeroSkinItem");
		if (loopListViewItem != null)
		{
			HeroSkinItem component = loopListViewItem.GetComponent<HeroSkinItem>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.HeroSkinList[index]);
			}
			else
			{
				component.RefreshData(viewModel.HeroSkinList[index]);
			}
		}
		return loopListViewItem;
	}

	private LoopGridViewItem OnGetCGItemByIndex(LoopGridView arg1, int index, int row, int column)
	{
		GameStoryGuideItemData gameStoryGuideItemData = viewModel.HeroCgList[index];
		if (gameStoryGuideItemData == null)
		{
			return null;
		}
		LoopGridViewItem loopGridViewItem = heroCGList.NewListViewItem("CGItem");
		GameStoryGuideItem component = loopGridViewItem.GetComponent<GameStoryGuideItem>();
		if (!loopGridViewItem.IsInitHandlerCalled)
		{
			loopGridViewItem.IsInitHandlerCalled = true;
			component.Init(gameStoryGuideItemData);
		}
		else
		{
			component.RefreshStoryGuideItem(gameStoryGuideItemData);
		}
		return loopGridViewItem;
	}

	private async void LoadHeroImg()
	{
		await LoadHeroFaction();
		await LoadHeroObj();
	}

	private async Task LoadHeroFaction()
	{
		string textureAsset = AssetUtility.GetTextureAsset("Hero/HeroFaction/Icon_" + viewModel.HeroModel.FactionIcon);
		Image image = heroFaction;
		image.sprite = await LoadSpriteAsync(textureAsset);
		heroFaction.gameObject.SetActive(value: true);
	}

	private async UniTask LoadHeroObj()
	{
		string uIItemAsset = AssetUtility.GetUIItemAsset(viewModel.HeroModel.Original);
		GameObject gameObject = await InstantiateAsync(uIItemAsset, _spineContainer);
		if (gameObject == null)
		{
			Log.Error("找不到预制体路径 " + viewModel.HeroModel.Original);
			return;
		}
		GameObject gameObject2 = gameObject;
		StreamerMode.ApplySpineSkin(gameObject);
		createObjList.Add(gameObject2);
		UIUtilly.SpineMatchRectHelper(gameObject2, _spineContainer, overwrite: false);
		Transform transform = gameObject2.transform.Find("HeadPos");
		if (transform != null && gameObject2 != null)
		{
			Vector2 anchoredPosition = transform.GetComponent<RectTransform>().anchoredPosition;
			gameObject2.GetComponent<Transform>().SetLocalPositionX(0f - anchoredPosition.x);
			gameObject2.GetComponent<Transform>().SetLocalPositionY(0f - anchoredPosition.y);
		}
	}

	private void CloseWindow(object sender, InteractionEventArgs e)
	{
		for (int i = 0; i < createObjList.Count; i++)
		{
			UnityEngine.Object.Destroy(createObjList[i]);
		}
		createObjList.Clear();
		Dismiss();
	}

	protected override void OnDestroy()
	{
		base.OnDestroy();
	}
}
