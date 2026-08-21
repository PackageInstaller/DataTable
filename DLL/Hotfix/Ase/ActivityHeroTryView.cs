#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Linq.Expressions;
using GameFramework;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ActivityHeroTryView : ActivityViewBase
{
	public Button btnHeroPreview;

	public Button btnTry;

	public Button btnDrawcard;

	public Image seatIcon;

	public Image attrIcon;

	public TextMeshProUGUI heroName;

	public TextMeshProUGUI heroTitle;

	public TextMeshProUGUI heroDesc;

	public LoopListView2 heroList;

	public ActivityTaskItem rewardItem;

	public GameObject rewardEffectGo;

	public Transform fgRoot;

	private ActivityHeroTryViewModel viewModel;

	public float scaleSize;

	private GameObject roleImgObj;

	private string oldobj;

	public override void Init(ActivityViewModelBase viewModel)
	{
		this.viewModel = (ActivityHeroTryViewModel)viewModel;
		base.Init(viewModel);
		BindingSet<ActivityHeroTryView, ActivityHeroTryViewModel> bindingSet = this.CreateBindingSet(this.viewModel);
		bindingSet.Bind(this).For((ActivityHeroTryView v) => v.OnVisibleChanged).To((ActivityHeroTryViewModel vm) => vm.VisibleRequest);
		bindingSet.Bind(seatIcon).For((Image v) => v.sprite).ToExpression((ActivityHeroTryViewModel vm) => $"Hero_Seat_{vm.Hero.Hero.DestinyLevel}")
			.WithConversion("ItemIcon");
		bindingSet.Bind(attrIcon).For((Image v) => v.sprite).ToExpression((ActivityHeroTryViewModel vm) => $"hero_attr_{(int)vm.Hero.Hero.Attribute}")
			.WithConversion("ItemIcon");
		bindingSet.Bind<TextMeshProUGUI>(heroName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ActivityHeroTryViewModel vm) => vm.Hero.Hero.Name);
		bindingSet.Bind<TextMeshProUGUI>(heroTitle).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ActivityHeroTryViewModel vm) => vm.HeroTitle);
		bindingSet.Bind<TextMeshProUGUI>(heroDesc).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ActivityHeroTryViewModel vm) => vm.HeroDesc);
		bindingSet.Bind(btnHeroPreview).For((Button v) => v.onClick).To((ActivityHeroTryViewModel vm) => vm.OptCmd)
			.CommandParameter("OpenPreview");
		bindingSet.Bind(btnTry).For((Button v) => v.onClick).To((ActivityHeroTryViewModel vm) => vm.OptCmd)
			.CommandParameter("OpenTry");
		bindingSet.Bind(btnDrawcard).For((Button v) => v.onClick).To((ActivityHeroTryViewModel vm) => vm.OptCmd)
			.CommandParameter("OpenDrawcard");
		bindingSet.Bind().For((ActivityHeroTryView v) => v.OnOpt).To((ActivityHeroTryViewModel vm) => vm.OptRequest);
		bindingSet.Build();
		heroList.InitListView(this.viewModel.HeroList.Count, OnGetHeroItemByIndex);
		rewardItem.Init(this.viewModel.RewardItemViewModel);
		rewardEffectGo.gameObject.SetActive(this.viewModel.RewardItemViewModel.TaskState == ActivityTaskStateEnum.Normal || this.viewModel.RewardItemViewModel.TaskState == ActivityTaskStateEnum.Accept);
		SettleOpt("RefreshHero");
	}

	private void OnOpt(object sender, InteractionEventArgs e)
	{
		string optName = (string)e.Context;
		SettleOpt(optName);
	}

	private void SettleOpt(string optName)
	{
		if ("RefreshHero".Equals(optName))
		{
			heroList.RefreshAllShownItem();
			ChangeHeroFgImg();
			rewardItem.RefreshActivityTaskItem(viewModel.RewardItemViewModel);
		}
	}

	public async void ChangeHeroFgImg()
	{
		if (oldobj != null && oldobj.Equals(viewModel.Hero.Hero.Original))
		{
			return;
		}
		if (roleImgObj != null)
		{
			UnityEngine.Object.DestroyImmediate(roleImgObj);
			roleImgObj = null;
		}
		string oriPath = viewModel.Hero.Hero.Original;
		if (oriPath != null)
		{
			GameObject gameObject = await InstantiateAsync(AssetUtility.GetUIItemAsset(oriPath), fgRoot);
			if (gameObject != null)
			{
				roleImgObj = gameObject;
				roleImgObj.transform.localScale = new Vector3(scaleSize, scaleSize, 1f);
				oldobj = oriPath;
				StreamerMode.ApplySpineSkin(gameObject);
			}
			else
			{
				Log.Error("加载资源失败，请检查资源路径是否配置正确 " + oriPath + "！");
				Toast.ShowInfo("加载资源失败");
			}
		}
	}

	private LoopListViewItem2 OnGetHeroItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.HeroList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = null;
		loopListViewItem = ((!viewModel.HeroList[index].IsSelect) ? listView2.NewListViewItem("HeroItemViewSmall") : listView2.NewListViewItem("HeroItemViewBig"));
		if (loopListViewItem != null)
		{
			ActivityHeroTryItemView component = loopListViewItem.GetComponent<ActivityHeroTryItemView>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.HeroList[index]);
			}
			else
			{
				component.RefreshData(viewModel.HeroList[index]);
			}
		}
		return loopListViewItem;
	}

	protected override void OnDestroy()
	{
		base.OnDestroy();
	}
}
