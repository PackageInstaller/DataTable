using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using GameFramework.Runtime;
using Spine.Unity;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class LotteryActivityView : ActivityViewBase
{
	[SerializeField]
	private TextMeshProUGUI desc;

	[SerializeField]
	private RectTransform lotteryItemRoot;

	[SerializeField]
	private Button btnOpenRewardPanel;

	[SerializeField]
	private TextMeshProUGUI rewardProgressText;

	[SerializeField]
	private CanvasGroup rewardProgressPanel;

	[SerializeField]
	private LoopGridView rewardProgressList;

	[SerializeField]
	private Button btnHideRewardPanel1;

	[SerializeField]
	private Button btnHideRewardPanel2;

	[SerializeField]
	private Button btnOpenRule;

	[SerializeField]
	private Button btnCloseRule;

	[SerializeField]
	private CanvasGroup rulePanel;

	[SerializeField]
	private TextMeshProUGUI ruleTitle;

	[SerializeField]
	private TextMeshProUGUI ruleContent;

	[SerializeField]
	private Button btnJumpTry;

	[SerializeField]
	private string jumpWindow;

	[SerializeField]
	private List<int> jumpParams;

	[SerializeField]
	private GameObject costRoot;

	[SerializeField]
	private Image costIcon;

	[SerializeField]
	private TextMeshProUGUI costTextNotEnough;

	[SerializeField]
	private TextMeshProUGUI costTextEnough;

	[SerializeField]
	private MoneyItem money1;

	[SerializeField]
	private MoneyItem money2;

	[SerializeField]
	private Button btnGetVoucher;

	[SerializeField]
	private Button btnGetMoney2;

	[SerializeField]
	private CanvasGroup moneyGetPanel;

	[SerializeField]
	private Button btnCloseMoneyGet1;

	[SerializeField]
	private Button btnCloseMoneyGet2;

	[SerializeField]
	private Button btnOpenExcWindow;

	[SerializeField]
	private Button btnJumpGetMoney2;

	[SerializeField]
	private string getMoney2Window;

	[SerializeField]
	private List<int> getMoney2Params;

	[SerializeField]
	private CanvasGroup lotteryConfirmPanel;

	[SerializeField]
	private Button btnHideConfirm1;

	[SerializeField]
	private Button btnHideConfirm2;

	[SerializeField]
	private Button btnHideConfirm3;

	[SerializeField]
	private Button btnConfirm;

	[SerializeField]
	private TextMeshProUGUI confirmTipsText;

	[SerializeField]
	private Toggle toggleIgnoreConfirm;

	[SerializeField]
	private Animation animation;

	public bool testStart;

	[SerializeField]
	private GameObject spineGo;

	[SerializeField]
	private List<SkeletonGraphic> startSpines;

	public string startSpineAniName;

	public string startSpineIdleAniName;

	public float startSpineAniTime;

	public GameObject startAudio;

	private float _msgItemHeight;

	private LotteryActivityViewModel _viewModel;

	public override void Init(ActivityViewModelBase viewModel)
	{
		_viewModel = (LotteryActivityViewModel)viewModel;
		base.Init(viewModel);
		BindingSet<LotteryActivityView, LotteryActivityViewModel> bindingSet = this.CreateBindingSet((LotteryActivityViewModel)viewModel);
		bindingSet.Bind(this).For((LotteryActivityView v) => v.OpenPropPopupRst).To((LotteryActivityViewModel vm) => vm.OpenPropPopupRst);
		if ((UnityEngine.Object)(object)desc != null)
		{
			bindingSet.Bind<TextMeshProUGUI>(desc).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((LotteryActivityViewModel vm) => vm.Desc);
		}
		bindingSet.Bind<TextMeshProUGUI>(rewardProgressText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((LotteryActivityViewModel vm) => vm.RewardProgressText);
		bindingSet.Bind<TextMeshProUGUI>(ruleTitle).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((LotteryActivityViewModel vm) => vm.RuleTitle);
		bindingSet.Bind<TextMeshProUGUI>(ruleContent).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((LotteryActivityViewModel vm) => vm.RuleContent);
		bindingSet.Bind(costRoot).For((GameObject v) => v.activeSelf).ToExpression((LotteryActivityViewModel vm) => !vm.DrawCardFinished);
		bindingSet.Bind(costIcon).For((Image v) => v.sprite).ToExpression((LotteryActivityViewModel vm) => vm.CostPropData.Icon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(costIcon.gameObject).For((GameObject v) => v.activeSelf).ToExpression((LotteryActivityViewModel vm) => vm.CostPropData.Amount > 0);
		bindingSet.Bind(((Component)(object)costTextNotEnough).gameObject).For((GameObject v) => v.activeSelf).ToExpression((LotteryActivityViewModel vm) => !vm.ConsumeEnough);
		bindingSet.Bind(((Component)(object)costTextEnough).gameObject).For((GameObject v) => v.activeSelf).To((LotteryActivityViewModel vm) => vm.ConsumeEnough);
		bindingSet.Bind<TextMeshProUGUI>(costTextNotEnough).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((LotteryActivityViewModel vm) => vm.DrawCardText);
		bindingSet.Bind<TextMeshProUGUI>(costTextEnough).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((LotteryActivityViewModel vm) => vm.DrawCardText);
		if (btnJumpTry != null)
		{
			JumpWindowParams jumpWindowParams = new JumpWindowParams(jumpWindow, jumpParams);
			bindingSet.Bind(btnJumpTry).For((Button v) => v.onClick).To((LotteryActivityViewModel vm) => vm.JumpWindowCmd)
				.CommandParameter(jumpWindowParams);
		}
		bindingSet.Bind<CanvasGroup>(lotteryConfirmPanel).For((Expression<Func<CanvasGroup, float>>)((CanvasGroup v) => v.alpha)).ToExpression((LotteryActivityViewModel vm) => vm.ShowLotteryConfirm ? 1 : 0);
		bindingSet.Bind<CanvasGroup>(lotteryConfirmPanel).For((Expression<Func<CanvasGroup, bool>>)((CanvasGroup v) => v.blocksRaycasts)).To((LotteryActivityViewModel vm) => vm.ShowLotteryConfirm);
		bindingSet.Bind(btnHideConfirm1).For((Button v) => v.onClick).To((LotteryActivityViewModel vm) => vm.CancelLotteryConfirmPanel);
		bindingSet.Bind(btnHideConfirm2).For((Button v) => v.onClick).To((LotteryActivityViewModel vm) => vm.CancelLotteryConfirmPanel);
		bindingSet.Bind(btnHideConfirm3).For((Button v) => v.onClick).To((LotteryActivityViewModel vm) => vm.CancelLotteryConfirmPanel);
		bindingSet.Bind(btnConfirm).For((Button v) => v.onClick).To((LotteryActivityViewModel vm) => vm.OnLotteryConfirmClick);
		bindingSet.Bind<TextMeshProUGUI>(confirmTipsText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((LotteryActivityViewModel vm) => vm.LotteryConfirmTips);
		bindingSet.Bind(toggleIgnoreConfirm).For((Toggle v) => v.isOn, (Toggle v) => v.onValueChanged).To((LotteryActivityViewModel vm) => vm.LotteryNoConfirmToggle)
			.TwoWay();
		bindingSet.Build();
		InitMoneyView();
		btnOpenRewardPanel.onClick.AddListener(delegate
		{
			rewardProgressPanel.alpha = 1f;
			rewardProgressPanel.blocksRaycasts = true;
		});
		btnHideRewardPanel1.onClick.AddListener(delegate
		{
			rewardProgressPanel.alpha = 0f;
			rewardProgressPanel.blocksRaycasts = false;
		});
		btnHideRewardPanel2.onClick.AddListener(delegate
		{
			rewardProgressPanel.alpha = 0f;
			rewardProgressPanel.blocksRaycasts = false;
		});
		rewardProgressList.InitGridView(_viewModel.RewardItemList.Count, OnGetItemByIndex);
		btnOpenRule.onClick.AddListener(delegate
		{
			rulePanel.alpha = 1f;
			rulePanel.blocksRaycasts = true;
		});
		btnCloseRule.onClick.AddListener(delegate
		{
			rulePanel.alpha = 0f;
			rulePanel.blocksRaycasts = false;
		});
		InitLotteryItems();
		StreamerMode.ApplySpineSkin(spineGo);
		if (testStart || !_viewModel.StartAniPlayed)
		{
			animation.playAutomatically = false;
			_viewModel.SetWindowUiVisible(visible: false);
			CancelInvoke("StartSpineIdle");
			StartSpinePlay();
			Invoke("StartSpineIdle", startSpineAniTime);
			_viewModel.SetStartAniPlayed();
			startAudio.SetActive(value: false);
			startAudio.SetActive(value: true);
			startAudio.SetActive(value: false);
		}
		else
		{
			animation.Play();
			animation.playAutomatically = true;
		}
	}

	private void InitLotteryItems()
	{
		for (int i = 0; i < lotteryItemRoot.childCount; i++)
		{
			Transform child = lotteryItemRoot.GetChild(i);
			LotteryActItem item = child.GetComponent<LotteryActItem>();
			if (item == null || item.index <= 0)
			{
				child.gameObject.SetActive(value: false);
				continue;
			}
			LotteryActItemData lotteryActItemData = _viewModel.LotteryItemDataList.Find((LotteryActItemData p) => p.Index == item.index);
			if (lotteryActItemData == null)
			{
				child.gameObject.SetActive(value: false);
				continue;
			}
			item.Init(lotteryActItemData);
			item.gameObject.SetActive(value: true);
		}
	}

	private LoopGridViewItem OnGetItemByIndex(LoopGridView arg1, int dataIndex, int row, int column)
	{
		if (dataIndex < 0 || dataIndex >= _viewModel.RewardItemList.Count)
		{
			return null;
		}
		KnapsackItemViewModel knapsackItemViewModel = _viewModel.RewardItemList[dataIndex];
		if (knapsackItemViewModel == null)
		{
			return null;
		}
		LoopGridViewItem loopGridViewItem = rewardProgressList.NewListViewItem("PropItem");
		KnapsackItemNew component = loopGridViewItem.GetComponent<KnapsackItemNew>();
		if (!loopGridViewItem.IsInitHandlerCalled)
		{
			loopGridViewItem.IsInitHandlerCalled = true;
			component.Init(knapsackItemViewModel);
		}
		else
		{
			component.RefreshData(knapsackItemViewModel);
		}
		return loopGridViewItem;
	}

	private void InitMoneyView()
	{
		if (_viewModel.MoneyData1 != null)
		{
			money1.Init(_viewModel.MoneyData1);
		}
		if (_viewModel.MoneyData2 != null)
		{
			money2.Init(_viewModel.MoneyData2);
		}
		btnGetVoucher.onClick.AddListener(delegate
		{
			if (!Singleton<ServiceSystem>.Instance.GetService<ISOService>().GetState(70005))
			{
				Toast.ShowInfo("采购未开启");
			}
			else
			{
				_viewModel.ItemOnClick(new OpenViewArg(typeof(ShopWindow), new ShopWindowViewModel(_viewModel.Parent, 998), "DrawCardActivity"));
			}
		});
		btnGetMoney2.onClick.AddListener(delegate
		{
			_viewModel.OpenPropExcWindow(1);
		});
	}

	private void OpenPropPopupRst(object sender, InteractionEventArgs e)
	{
		if (e != null && e.Context is KeyValuePair<RoleMoneyEnum, Vector3> keyValuePair)
		{
			OpenPropInfoWindow(keyValuePair.Key, keyValuePair.Value);
		}
	}

	private void OpenPropInfoWindow(RoleMoneyEnum moneyEnum, Vector3 iconWorldPos)
	{
		DRProp dataRow = GameEntry.DataTable.GetDataRow<DRProp>((int)moneyEnum);
		if (dataRow != null)
		{
			Vector2 vector = RectTransformUtility.WorldToScreenPoint(UIUtilly.GetUICamera(), iconWorldPos);
			Vector2 pos = default(Vector2);
			RectTransformUtility.ScreenPointToLocalPointInRectangle(RectTransform, vector, UIUtilly.GetUICamera(), ref pos);
			_viewModel.OpenPropPopupWindow(dataRow, pos);
		}
	}

	private void StartSpinePlay()
	{
		if (startSpines == null)
		{
			return;
		}
		foreach (SkeletonGraphic startSpine in startSpines)
		{
			if (!((UnityEngine.Object)(object)startSpine == null))
			{
				startSpine.AnimationState.SetAnimation(0, startSpineAniName, loop: false);
			}
		}
	}

	private void StartSpineIdle()
	{
		if (startSpines != null)
		{
			foreach (SkeletonGraphic startSpine in startSpines)
			{
				if (!((UnityEngine.Object)(object)startSpine == null))
				{
					startSpine.AnimationState.SetAnimation(0, startSpineIdleAniName, loop: true);
				}
			}
		}
		animation.Play();
		animation.playAutomatically = true;
		_viewModel.SetWindowUiVisible(visible: true);
	}

	protected override void OnDisable()
	{
		_viewModel?.SetWindowUiVisible(visible: true);
		base.OnDisable();
	}

	protected override void OnDestroy()
	{
		_viewModel?.OnViewDestroy();
		base.OnDestroy();
	}
}
