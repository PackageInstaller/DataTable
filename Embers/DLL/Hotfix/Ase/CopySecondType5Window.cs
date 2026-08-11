using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class CopySecondType5Window : UGuiWindowBase
{
	public Transform copyTypeRoot;

	public CopyType5ItemView copyType5Templ;

	public TextMeshProUGUI timeLeft;

	public TextMeshProUGUI totalScore;

	public Button btnReward;

	public Button btnBack;

	public GameObject red;

	public Button btnRule;

	public Button btnRuleClose;

	public Button btnRuleClose2;

	public GameObject ruleRoot;

	public TextMeshProUGUI ruleText;

	public TextMeshProUGUI copyName;

	public TextMeshProUGUI curScore;

	public Button btnRank;

	public Button btnEnter;

	public Image buffIconImg;

	public CopyST4RewardView rewardView;

	public VerticalLayoutGroup verticalLayout;

	public CopyItem5View curSelectItem;

	public RectTransform up;

	public RectTransform toggleRect;

	public CopyItem5View copyItemTempl;

	public float templHeight;

	public Button windowMask;

	public Button btnOpenList;

	private List<CopyItem5View> copyItemList;

	private bool isOpenList;

	public GameObject scoreBarGo;

	public LoopListView2 rankList;

	public GameObject rankLoadingItem;

	private List<CopyType5ItemView> copyTypeList;

	public CopyST5EnterItemView enterItemView;

	public Button btnAddBuff;

	public SelectBuffView selectBuffView;

	public CopyHeroSelectView heroSelectView;

	public GameObject heroSelectMask;

	public Button btnHideHeroView;

	private CopySecondType5ViewModel viewModel;

	public bool IsOpenList
	{
		get
		{
			return isOpenList;
		}
		set
		{
			if (value != isOpenList)
			{
				if (value)
				{
					windowMask.gameObject.SetActive(value: true);
					up.localRotation = Quaternion.Euler(0f, 0f, 90f);
					toggleRect.gameObject.SetActive(value: true);
					int count = viewModel.CopyItemVms.Count;
					float y = templHeight * (float)count + verticalLayout.spacing * (float)Math.Clamp(count - 1, 0, count - 1) + (float)verticalLayout.padding.top + (float)verticalLayout.padding.bottom;
					toggleRect.sizeDelta = new Vector2(toggleRect.sizeDelta.x, y);
					if (copyItemList == null)
					{
						copyItemList = new List<CopyItem5View>();
					}
					for (int i = 0; i < count; i++)
					{
						if (copyItemList.Count > i)
						{
							copyItemList[i].Init(viewModel.CopyItemVms[i]);
							copyItemList[i].gameObject.SetActive(value: true);
							continue;
						}
						GameObject gameObject = UnityEngine.Object.Instantiate(copyItemTempl.gameObject, toggleRect);
						if (gameObject != null)
						{
							CopyItem5View component = gameObject.GetComponent<CopyItem5View>();
							component.Init(viewModel.CopyItemVms[i]);
							component.gameObject.SetActive(value: true);
							copyItemList.Add(component);
						}
					}
					for (int j = count; j < copyItemList.Count; j++)
					{
						copyItemList[j].gameObject.SetActive(value: false);
					}
				}
				else
				{
					windowMask.gameObject.SetActive(value: false);
					up.localEulerAngles = new Vector3(0f, 0f, -90f);
					toggleRect.gameObject.SetActive(value: false);
					curSelectItem.Init(viewModel.CurSelectItem);
				}
			}
			isOpenList = value;
		}
	}

	protected override void OnCreate(IBundle bundle)
	{
		base.OnCreate(bundle);
		viewModel = GetData<CopySecondType5ViewModel>();
		BindingSet<CopySecondType5Window, CopySecondType5ViewModel> bindingSet = this.CreateBindingSet(viewModel);
		bindingSet.Bind(this).For((CopySecondType5Window v) => v.OnDismissRequest).To((CopySecondType5ViewModel vm) => vm.DismissRequest);
		bindingSet.Bind(this).For((CopySecondType5Window v) => v.OpenUguiWindow).To((CopySecondType5ViewModel vm) => vm.OpenWindowRequest);
		bindingSet.Bind(this).For((CopySecondType5Window v) => v.SetChildViewVisibility).To((CopySecondType5ViewModel vm) => vm.ShowViewRequest);
		bindingSet.Bind(this).For((CopySecondType5Window v) => v.OnOpt).To((CopySecondType5ViewModel vm) => vm.OptRequest);
		bindingSet.Bind(btnBack).For((Button v) => v.onClick).To((CopySecondType5ViewModel vm) => ((OptionBase)vm).Close);
		bindingSet.Bind<TextMeshProUGUI>(totalScore).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CopySecondType5ViewModel vm) => vm.TotalScore);
		bindingSet.Bind(btnReward).For((Button v) => v.onClick).To((CopySecondType5ViewModel vm) => vm.OptCommand)
			.CommandParameter("OpenReward");
		bindingSet.Bind(red).For((GameObject v) => v.activeSelf).To((CopySecondType5ViewModel vm) => vm.Red);
		bindingSet.Bind<TextMeshProUGUI>(copyName).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CopySecondType5ViewModel vm) => vm.CurSelectItem.Data.Name);
		bindingSet.Bind<TextMeshProUGUI>(curScore).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CopySecondType5ViewModel vm) => vm.CurScore);
		bindingSet.Bind<TextMeshProUGUI>(timeLeft).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((CopySecondType5ViewModel vm) => vm.TimeLeft);
		bindingSet.Bind(this).For((CopySecondType5Window v) => v.IsOpenList).To((CopySecondType5ViewModel vm) => vm.IsOpenList);
		bindingSet.Bind(btnOpenList).For((Button v) => v.onClick).To((CopySecondType5ViewModel vm) => vm.OptCommand)
			.CommandParameter("OpenList");
		bindingSet.Bind(windowMask).For((Button v) => v.onClick).To((CopySecondType5ViewModel vm) => vm.OptCommand)
			.CommandParameter("CloseList");
		bindingSet.Bind(btnRank).For((Button v) => v.onClick).To((CopySecondType5ViewModel vm) => vm.OptCommand)
			.CommandParameter("OpenRank");
		bindingSet.Bind(btnEnter).For((Button v) => v.onClick).To((CopySecondType5ViewModel vm) => vm.OptCommand)
			.CommandParameter("OpenEnter");
		if (buffIconImg != null)
		{
			bindingSet.Bind(buffIconImg).For((Image v) => v.sprite).To((CopySecondType5ViewModel vm) => vm.BuffIcon)
				.WithConversion("ItemIcon");
			bindingSet.Bind(buffIconImg.gameObject).For((GameObject v) => v.activeSelf).ToExpression((CopySecondType5ViewModel vm) => !string.IsNullOrEmpty(vm.BuffIcon));
		}
		bindingSet.Bind(btnAddBuff).For((Button v) => v.onClick).To((CopySecondType5ViewModel vm) => vm.OptCommand)
			.CommandParameter("OpenAddBuff");
		bindingSet.Bind(enterItemView).For((CopyST5EnterItemView v) => v.ViewModel).To((CopySecondType5ViewModel vm) => vm.CopySt5EnterItemVm);
		bindingSet.Bind(selectBuffView).For((SelectBuffView v) => v.ViewModel).To((CopySecondType5ViewModel vm) => vm.SelectBuffVM);
		bindingSet.Bind(selectBuffView.gameObject).For((GameObject v) => v.activeSelf).To((CopySecondType5ViewModel vm) => vm.SelectBuffVM.IsShow);
		if (heroSelectView != null)
		{
			bindingSet.Bind(heroSelectView).For((CopyHeroSelectView v) => v.ViewModel).To((CopySecondType5ViewModel vm) => vm.HeroSelectVm);
			heroSelectView.gameObject.SetActive(value: false);
		}
		if (btnHideHeroView != null)
		{
			bindingSet.Bind(btnHideHeroView).For((Button v) => v.onClick).To((CopySecondType5ViewModel vm) => vm.OptCommand)
				.CommandParameter("HideTeamView");
		}
		bindingSet.Build();
		rewardView.gameObject.SetActive(value: false);
		AddCopyTypeItems();
		SetToggle();
		((TMP_Text)ruleText).text = viewModel.RuleDesc;
		btnRule.onClick.AddListener(delegate
		{
			ruleRoot.gameObject.SetActive(value: true);
		});
		btnRuleClose.onClick.AddListener(delegate
		{
			ruleRoot.gameObject.SetActive(value: false);
		});
		btnRuleClose2.onClick.AddListener(delegate
		{
			ruleRoot.gameObject.SetActive(value: false);
		});
	}

	protected override void OnShow()
	{
		base.OnShow();
		viewModel.OnJump();
	}

	private LoopListViewItem2 OnGetRankItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.RankItemVms.Count + 1)
		{
			return null;
		}
		LoopListViewItem2 loopListViewItem = null;
		if (index >= viewModel.RankItemVms.Count)
		{
			loopListViewItem = listView2.NewListViewItem("ScoreBarRoot");
			scoreBarGo.transform.SetParent(loopListViewItem.transform);
			scoreBarGo.GetComponent<RectTransform>().anchoredPosition = Vector2.zero;
			return loopListViewItem;
		}
		loopListViewItem = ((!viewModel.RankItemVms[index].IsEmpty) ? listView2.NewListViewItem("ScoreItemView") : listView2.NewListViewItem("ScoreItemViewEmpty"));
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

	private void SetToggle()
	{
		windowMask.gameObject.SetActive(value: false);
		btnOpenList.gameObject.SetActive(value: true);
		up.localRotation = Quaternion.Euler(0f, 0f, -90f);
		toggleRect.gameObject.SetActive(value: false);
		curSelectItem.Init(viewModel.CurSelectItem);
		copyItemTempl.gameObject.SetActive(value: false);
	}

	private void OnOpt(object sender, InteractionEventArgs e)
	{
		string optName = (string)e.Context;
		SettleOpt(optName);
	}

	private void SettleOpt(string optName)
	{
		if ("OpenReward".Equals(optName))
		{
			if (rewardView != null)
			{
				rewardView.Init(viewModel.RewardVm);
				rewardView.gameObject.SetActive(value: true);
			}
		}
		else if ("RefreshCopyItems".Equals(optName))
		{
			curSelectItem.Init(viewModel.CurSelectItem);
		}
		else if ("RefreshCopyTypeItems".Equals(optName))
		{
			AddCopyTypeItems();
		}
		else if ("RefreshCopyRanks".Equals(optName))
		{
			rankLoadingItem.gameObject.SetActive(value: false);
			rankList.gameObject.SetActive(value: true);
			if (!rankList.IsInited)
			{
				rankList.InitListView(viewModel.RankItemVms.Count + 1, OnGetRankItemByIndex);
				return;
			}
			rankList.SetListItemCount(viewModel.RankItemVms.Count + 1);
			rankList.RefreshAllShownItem();
		}
		else if ("SetRankLoading".Equals(optName))
		{
			rankLoadingItem.gameObject.SetActive(value: true);
			rankList.gameObject.SetActive(value: false);
		}
		else if ("OpenTeamView".Equals(optName))
		{
			if (heroSelectView != null)
			{
				heroSelectView.Init(viewModel.HeroSelectVm);
				heroSelectView.gameObject.SetActive(value: true);
			}
			if (heroSelectMask != null)
			{
				heroSelectMask.gameObject.SetActive(value: true);
			}
		}
		else if ("HideTeamView".Equals(optName))
		{
			if (heroSelectView != null)
			{
				heroSelectView.gameObject.SetActive(value: false);
			}
			if (heroSelectMask != null)
			{
				heroSelectMask.gameObject.SetActive(value: false);
			}
		}
		else if ("RefreshBuffList".Equals(optName))
		{
			selectBuffView.RefreshBuffList();
		}
	}

	private void AddCopyTypeItems()
	{
		if (copyTypeList == null)
		{
			copyTypeList = new List<CopyType5ItemView>();
		}
		copyType5Templ.gameObject.SetActive(value: false);
		for (int i = 0; i < viewModel.TypeVms.Count; i++)
		{
			if (copyTypeList.Count > i)
			{
				copyTypeList[i].RefreshData(viewModel.TypeVms[i]);
				copyTypeList[i].gameObject.SetActive(value: true);
				continue;
			}
			GameObject gameObject = UnityEngine.Object.Instantiate(copyType5Templ.gameObject, copyTypeRoot);
			if (gameObject != null)
			{
				CopyType5ItemView component = gameObject.GetComponent<CopyType5ItemView>();
				copyTypeList.Add(component);
				component.Init(viewModel.TypeVms[i]);
				gameObject.SetActive(value: true);
			}
		}
		for (int j = viewModel.TypeVms.Count; j < copyTypeList.Count; j++)
		{
			copyTypeList[j].gameObject.SetActive(value: false);
		}
	}

	private LoopListViewItem2 OnGetAttributeItemByIndex(LoopListView2 listView2, int index)
	{
		if (index < 0 || index >= viewModel.AdItemList.Count)
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

	protected override void OnDestroy()
	{
		if (copyTypeList != null && copyTypeList.Count > 0)
		{
			for (int num = copyTypeList.Count - 1; num >= 0; num--)
			{
				UnityEngine.Object.Destroy(copyTypeList[num].gameObject);
			}
			copyTypeList.Clear();
		}
		base.OnDestroy();
	}
}
