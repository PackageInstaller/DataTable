using System;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class CopySecondType3ExtremeView : UGuiView
{
	public Button backButton;

	public Button rankButton;

	public Button challengeButton;

	public LoadUISprite bossIcon;

	public TextMeshProUGUI copyNameText;

	public TextMeshProUGUI scoreText;

	public TextMeshProUGUI heroNameText;

	public LoopListView2 attributeList;

	public GameObject scoreBarGo;

	public LoopListView2 rankList;

	public GameObject rankLoadingItem;

	private CopySecondType3SingleModeViewModelBase viewModel;

	public CopySecondType3SingleModeViewModelBase ViewModel
	{
		get
		{
			return viewModel;
		}
		set
		{
			if (viewModel == null)
			{
				OnInit(value);
			}
			else
			{
				RefreshData(value);
			}
		}
	}

	protected override void OnInit(object userData)
	{
		if (viewModel != null)
		{
			RefreshData(userData);
			return;
		}
		viewModel = userData as CopySecondType3SingleModeViewModelBase;
		BindingSet<CopySecondType3ExtremeView, CopySecondType3SingleModeViewModelBase> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((CopySecondType3ExtremeView v) => v.OnOpt).To((CopySecondType3SingleModeViewModelBase vm) => vm.OptRequest);
		bindingSet.Bind<TextMeshProUGUI>(copyNameText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CopySecondType3SingleModeViewModelBase vm) => vm.CopyName);
		bindingSet.Bind(bossIcon).For((LoadUISprite v) => v.Path).To((CopySecondType3SingleModeViewModelBase vm) => vm.BossIconPath);
		bindingSet.Bind<TextMeshProUGUI>(heroNameText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CopySecondType3SingleModeViewModelBase vm) => vm.CurrentHeroName);
		bindingSet.Bind<TextMeshProUGUI>(scoreText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CopySecondType3SingleModeViewModelBase vm) => vm.ScoreText);
		bindingSet.Bind(backButton).For((Button v) => v.onClick).To((CopySecondType3SingleModeViewModelBase vm) => vm.OptCommand)
			.CommandParameter("Back");
		bindingSet.Bind(rankButton).For((Button v) => v.onClick).To((CopySecondType3SingleModeViewModelBase vm) => vm.OptCommand)
			.CommandParameter("Rank");
		bindingSet.Bind(challengeButton).For((Button v) => v.onClick).To((CopySecondType3SingleModeViewModelBase vm) => vm.OptCommand)
			.CommandParameter("Challenge");
		bindingSet.Build();
		if (rankButton != null)
		{
			rankButton.gameObject.SetActive(value: true);
		}
		InitAttributeList();
		SetScoreBarVisible(visible: false);
		InitRankList();
		RefreshRankListState();
	}

	public override void RefreshData(object userData)
	{
		viewModel = userData as CopySecondType3SingleModeViewModelBase;
		this.SetDataContext(viewModel);
		if (rankButton != null)
		{
			rankButton.gameObject.SetActive(value: true);
		}
		RefreshAttributeList();
		RefreshRankListState();
	}

	private void OnOpt(object sender, InteractionEventArgs e)
	{
		string value = (string)e.Context;
		if ("RefreshCopyRanks".Equals(value))
		{
			ShowRankList();
		}
		else if ("SetRankLoading".Equals(value))
		{
			ShowRankLoading();
		}
	}

	private int GetRankListDisplayCount()
	{
		int rankListCount = GetRankListCount();
		if (viewModel == null || !viewModel.UseType5RankDisplay)
		{
			return rankListCount;
		}
		return rankListCount + 1;
	}

	private int GetRankListCount()
	{
		if (viewModel == null)
		{
			return 0;
		}
		return viewModel.RankItemVms.Count;
	}

	private LoopListViewItem2 OnGetRankItemByIndex(LoopListView2 listView2, int index)
	{
		if (viewModel == null || index < 0 || index >= GetRankListDisplayCount())
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = null;
		if (viewModel.UseType5RankDisplay && index >= GetRankListCount())
		{
			loopListViewItem = listView2.NewListViewItem("ScoreBarRoot");
			if (scoreBarGo != null)
			{
				scoreBarGo.transform.SetParent(loopListViewItem.transform);
				scoreBarGo.GetComponent<RectTransform>().anchoredPosition = Vector2.zero;
				SetScoreBarVisible(visible: true);
			}
			return loopListViewItem;
		}
		loopListViewItem = (viewModel.RankItemVms[index].IsEmpty ? listView2.NewListViewItem("ScoreItemViewEmpty") : listView2.NewListViewItem("ScoreItemView"));
		if (loopListViewItem != null)
		{
			CopyRankItemView component = loopListViewItem.GetComponent<CopyRankItemView>();
			if (!loopListViewItem.IsInitHandlerCalled)
			{
				loopListViewItem.IsInitHandlerCalled = true;
				component.Init(viewModel.RankItemVms[index]);
			}
			else
			{
				component.RefreshData(viewModel.RankItemVms[index]);
			}
		}
		return loopListViewItem;
	}

	private void SetScoreBarVisible(bool visible)
	{
		if (scoreBarGo != null)
		{
			scoreBarGo.SetActive(visible);
		}
	}

	private void InitRankList()
	{
		if (!(rankList == null) && !rankList.IsInited)
		{
			rankList.InitListView(GetRankListDisplayCount(), OnGetRankItemByIndex);
		}
	}

	private void InitAttributeList()
	{
		if (!(attributeList == null) && !attributeList.IsInited)
		{
			attributeList.InitListView(GetAttributeCount(), OnGetAttributeItemByIndex);
		}
	}

	private void RefreshAttributeList()
	{
		if (!(attributeList == null))
		{
			if (!attributeList.IsInited)
			{
				InitAttributeList();
				return;
			}
			attributeList.SetListItemCount(GetAttributeCount());
			attributeList.RefreshAllShownItem();
		}
	}

	private int GetAttributeCount()
	{
		if (viewModel == null || viewModel.AdItemList == null)
		{
			return 0;
		}
		return viewModel.AdItemList.Count;
	}

	private LoopListViewItem2 OnGetAttributeItemByIndex(LoopListView2 listView2, int index)
	{
		if (viewModel == null || viewModel.AdItemList == null || index < 0 || index >= viewModel.AdItemList.Count)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = listView2.NewListViewItem("AttriItem");
		if (loopListViewItem != null)
		{
			CopyBuffItemView component = loopListViewItem.GetComponent<CopyBuffItemView>();
			component.Init();
			component.SetIcon(viewModel.AdItemList[index]);
		}
		return loopListViewItem;
	}

	private void RefreshRankListState()
	{
		if (viewModel != null)
		{
			if (viewModel.IsRankLoading)
			{
				ShowRankLoading();
			}
			else
			{
				ShowRankList();
			}
		}
	}

	private void ShowRankLoading()
	{
		if (rankLoadingItem != null)
		{
			rankLoadingItem.SetActive(value: true);
		}
		if (rankList != null)
		{
			rankList.gameObject.SetActive(value: false);
		}
		SetScoreBarVisible(visible: false);
	}

	private void ShowRankList()
	{
		if (rankLoadingItem != null)
		{
			rankLoadingItem.SetActive(value: false);
		}
		if (!(rankList == null))
		{
			SetScoreBarVisible(visible: false);
			rankList.gameObject.SetActive(value: true);
			rankList.SetListItemCount(GetRankListDisplayCount());
			rankList.RefreshAllShownItem();
		}
	}
}
