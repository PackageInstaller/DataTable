#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Linq.Expressions;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ActivityChallengeWindow : UGuiWindowBase
{
	public Button btnBack;

	public TextMeshProUGUI activityTime;

	public TextMeshProUGUI beatCount;

	public TextMeshProUGUI bossName;

	public GameObject GoIsFirst;

	public GameObject goReward;

	public GameObject goRewardRed;

	public GameObject goUnReward;

	public Button btnOpenMulti;

	public Button btnReward;

	public Image bgImg;

	public GameObject bgBlack;

	[SerializeField]
	private GameObject scoreRoot;

	[SerializeField]
	private TextMeshProUGUI scoreText;

	[SerializeField]
	private Button btnRank;

	public CopyItemDetail1View detailView;

	public LoopListView2 itemList;

	public TextMeshProUGUI buffName;

	public TextMeshProUGUI buffDesc;

	public GameObject buffBar;

	public Button btnHide;

	public LoopListView2 enviroBuffList;

	[SerializeField]
	private GameObject rewardDetailView;

	[SerializeField]
	private Button closeRewardDetailView;

	[SerializeField]
	private Transform rewardDetailViewRect;

	[SerializeField]
	private GameObject rewardDetailItem;

	private ActivityChallengeViewModel viewModel;

	private string bgImgPath;

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		this.viewModel = GetData<ActivityChallengeViewModel>();
		BindingSet<ActivityChallengeWindow, ActivityChallengeViewModel> bindingSet = this.CreateBindingSet(this.viewModel);
		bindingSet.Bind(this).For((ActivityChallengeWindow v) => v.OnDismissRequest).To((ActivityChallengeViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((ActivityChallengeWindow v) => v.OpenUguiWindow).To((ActivityChallengeViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind().For((ActivityChallengeWindow v) => v.SetChildViewVisibility).To((ActivityChallengeViewModel vm) => vm.ShowViewRequest);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((ActivityChallengeViewModel vm) => vm.CloseWindow);
		bindingSet.Bind<TextMeshProUGUI>(buffName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ActivityChallengeViewModel vm) => vm.BuffName);
		bindingSet.Bind<TextMeshProUGUI>(buffDesc).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ActivityChallengeViewModel vm) => vm.BuffDesc);
		bindingSet.Bind(buffBar).For((GameObject v) => v.activeSelf).To((ActivityChallengeViewModel vm) => vm.ShowBuffBar);
		bindingSet.Bind(btnHide).For((Button v) => v.onClick).To((ActivityChallengeViewModel vm) => vm.HideBuffBar);
		bindingSet.Bind<TextMeshProUGUI>(activityTime).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ActivityChallengeViewModel vm) => vm.ActivityTimeText2);
		bindingSet.Bind<TextMeshProUGUI>(beatCount).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((ActivityChallengeViewModel vm) => $"{vm.CurBeatCount}/{vm.MaxBeatCount}");
		bindingSet.Bind<TextMeshProUGUI>(bossName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((ActivityChallengeViewModel vm) => vm.BossName);
		bindingSet.Bind(GoIsFirst).For((GameObject v) => v.activeSelf).To((ActivityChallengeViewModel vm) => vm.IsFirst);
		bindingSet.Bind(goReward).For((GameObject v) => v.activeSelf).ToExpression((ActivityChallengeViewModel vm) => !vm.IsReward);
		bindingSet.Bind(goUnReward).For((GameObject v) => v.activeSelf).ToExpression((ActivityChallengeViewModel vm) => vm.IsReward);
		bindingSet.Bind(goRewardRed).For((GameObject v) => v.activeSelf).ToExpression((ActivityChallengeViewModel vm) => vm.Red);
		bindingSet.Bind(detailView).For((CopyItemDetail1View v) => v.ViewModel).To((ActivityChallengeViewModel vm) => vm.DetailViewModel);
		bindingSet.Bind(this).For((ActivityChallengeWindow v) => v.OnOpt).To((ActivityChallengeViewModel vm) => vm.OptRequest);
		bindingSet.Bind(btnReward).For((Button v) => v.onClick).To((ActivityChallengeViewModel vm) => vm.OptCommand)
			.CommandParameter("OnReward");
		bindingSet.Bind(btnOpenMulti).For((Button v) => v.onClick).To((ActivityChallengeViewModel vm) => vm.OptCommand)
			.CommandParameter("OnMulti");
		if (scoreRoot != null)
		{
			bindingSet.Bind(scoreRoot).For((GameObject v) => v.activeSelf).To((ActivityChallengeViewModel vm) => vm.ShowRankRoot);
		}
		if ((UnityEngine.Object)(object)scoreText != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(scoreText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((ActivityChallengeViewModel vm) => vm.RankScore.ToString());
		}
		if (btnRank != null)
		{
			bindingSet.Bind(btnRank).For((Button v) => v.onClick).To((ActivityChallengeViewModel vm) => vm.OptCommand)
				.CommandParameter("OnRank");
		}
		bindingSet.Build();
		itemList.InitListView(this.viewModel.ListItems.Count, OnGetItemByIndex);
		enviroBuffList.InitListView(this.viewModel.EnviroBuffItems.Count, OnGetEnviroBuffItemByIndex);
		closeRewardDetailView.onClick.AddListener(delegate
		{
			rewardDetailView.gameObject.SetActive(value: false);
		});
		buffBar.gameObject.SetActive(value: false);
		RequestChallengeCopyPlayerRankInfoAfterVisible().Forget();
		if (this.viewModel is ActivityChallengeViewModel2 viewModel)
		{
			TryOpenSingleBattleReadyAfterVisible(viewModel).Forget();
		}
	}

	protected override async void OnShow()
	{
		try
		{
			if (bgImg != null && viewModel != null)
			{
				bgImgPath = AssetUtility.GetUIItemAsset($"Activity/Challenge/Challenge{viewModel.ActivityTypeId}Bg");
				if (bgImgPath != null)
				{
					Image component = (await GameEntry.Resource.LoadAssetAsync<GameObject>(bgImgPath)).GetComponent<Image>();
					bgImg.sprite = component.sprite;
					bgImg.color = Color.white;
					bgBlack.gameObject.SetActive(value: true);
					bgImg.gameObject.SetActive(value: true);
				}
				else
				{
					bgBlack.gameObject.SetActive(value: false);
					bgImg.gameObject.SetActive(value: false);
				}
			}
		}
		catch (Exception ex)
		{
			Log.Error("加载挑战活动背景图发生异常 " + ex.Message + " / " + ex.StackTrace);
			bgBlack.gameObject.SetActive(value: false);
			bgImg.gameObject.SetActive(value: false);
		}
		base.OnShow();
	}

	private async UniTaskVoid TryOpenSingleBattleReadyAfterVisible(ActivityChallengeViewModel2 viewModel2)
	{
		await UniTask.WaitUntil(() => Visibility);
		await UniTask.Yield();
		viewModel2.TryOpenSingleBattleReady();
	}

	private async UniTaskVoid RequestChallengeCopyPlayerRankInfoAfterVisible()
	{
		await UniTask.WaitUntil(() => Visibility);
		if (viewModel != null)
		{
			await viewModel.RequestChallengeCopyPlayerRankInfo();
			viewModel.RefreshRankUI();
		}
	}

	private void OnOpt(object sender, InteractionEventArgs e)
	{
		string optName = (string)e.Context;
		SettleOpt(optName);
	}

	private void SettleOpt(string optName)
	{
		if ("ShowRewardPop".Equals(optName))
		{
			OpenRewardDetailView();
		}
		else if (!"OnDayRefresh".Equals(optName))
		{
			if ("RefreshBuff".Equals(optName))
			{
				enviroBuffList.SetListItemCount(viewModel.EnviroBuffItems.Count);
				enviroBuffList.RefreshAllShownItem();
			}
			else if ("RefreshCopyList".Equals(optName))
			{
				itemList.SetListItemCount(viewModel.ListItems.Count);
				itemList.RefreshAllShownItem();
			}
		}
	}

	private void OpenRewardDetailView()
	{
		for (int i = 0; i < rewardDetailViewRect.childCount; i++)
		{
			UnityEngine.Object.Destroy(rewardDetailViewRect.GetChild(i).gameObject);
		}
		foreach (KnapsackItemViewModel showRewardItemData in viewModel.ShowRewardItemDataList)
		{
			GameObject obj = UnityEngine.Object.Instantiate(rewardDetailItem, rewardDetailViewRect);
			obj.transform.GetComponent<KnapsackItemNew>().Init(showRewardItemData);
			obj.gameObject.SetActive(value: true);
		}
		rewardDetailView.gameObject.SetActive(value: true);
	}

	private LoopListViewItem2 OnGetItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.ListItems.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = null;
		loopListViewItem = ((!viewModel.ListItems[index].IsSelect) ? listView2.NewListViewItem("CopyItemViewNormal") : listView2.NewListViewItem("CopyItemViewSelect"));
		if (loopListViewItem != null)
		{
			ActivityChallengeCopyItemView component = loopListViewItem.GetComponent<ActivityChallengeCopyItemView>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.ListItems[index]);
			}
			else
			{
				component.RefreshData(viewModel.ListItems[index]);
			}
		}
		return loopListViewItem;
	}

	private LoopListViewItem2 OnGetEnviroBuffItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.EnviroBuffItems.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("EnviroBuffItem");
		if (loopListViewItem != null)
		{
			ReportItemView component = loopListViewItem.GetComponent<ReportItemView>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.EnviroBuffItems[index]);
			}
			else
			{
				component.RefreshData(viewModel.EnviroBuffItems[index]);
			}
		}
		return loopListViewItem;
	}

	protected override void OnDestroy()
	{
		if (bgImg != null)
		{
			bgImg.sprite = null;
		}
		base.OnDestroy();
	}
}
