using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using DG.Tweening;
using FMOD.Studio;
using GameFramework.Runtime;
using Spine.Unity;
using SuperScrollView;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class DrawCardActivityView : ActivityViewBase
{
	private enum State
	{
		Stay,
		Waiting,
		Rolling
	}

	[SerializeField]
	private TextMeshProUGUI desc;

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
	private Button btnJumpOther;

	[SerializeField]
	private string jumpWindow2;

	[SerializeField]
	private List<int> jumpParams2;

	[SerializeField]
	private GameObject costRoot;

	[SerializeField]
	private Image costIcon;

	[SerializeField]
	private TextMeshProUGUI costTextNotEnough;

	[SerializeField]
	private TextMeshProUGUI costTextEnough;

	[SerializeField]
	private Button btnDrawCard;

	[SerializeField]
	private TextMeshProUGUI btnDrawCardText;

	[SerializeField]
	private GameObject btnDrawCardMask;

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
	private RectTransform rewardMsgRollingContent;

	[SerializeField]
	private RectTransform rewardMsgStayContent;

	[SerializeField]
	private GameObject rewardMsgItemTpl;

	[SerializeField]
	private int maxRewardMsgCount;

	[SerializeField]
	private float msgPadding;

	[SerializeField]
	private float rollingTime;

	[SerializeField]
	private int duration1;

	[SerializeField]
	private int duration2;

	[SerializeField]
	private int maxMsgDataCount = 100;

	[SerializeField]
	private Animation animation;

	[SerializeField]
	private GameObject resultPanel;

	[SerializeField]
	private Button btnSkipResultAni;

	[SerializeField]
	private List<SkeletonGraphic> startSpines;

	public string startSpineAniName;

	public string startSpineIdleAniName;

	public float startSpineAniTime;

	[SerializeField]
	private SkeletonGraphic normalResultSpine;

	public float normalResultSpineTime;

	public string normalResultSpineAniName;

	[SerializeField]
	private SkeletonGraphic spResultSpine;

	public float spResultSpineTime;

	public string spResultSpineAniName;

	[SerializeField]
	private List<KnapsackItemNew> displayRewardItems;

	public bool testStart;

	[SerializeField]
	private float volume1 = 1f;

	[SerializeField]
	private List<AudioParameterSerializable> paramList1 = new List<AudioParameterSerializable>();

	[SerializeField]
	private float volume2 = 1f;

	[SerializeField]
	private List<AudioParameterSerializable> paramList2 = new List<AudioParameterSerializable>();

	[SerializeField]
	private float volume3 = 1f;

	[SerializeField]
	private List<AudioParameterSerializable> paramList3 = new List<AudioParameterSerializable>();

	private float _msgItemHeight;

	private DrawCardActivityViewModel _viewModel;

	private SkeletonGraphic _curSkeletonGraphic;

	private bool _isSp;

	private bool _resultAniPlaying;

	private State _state;

	private List<GameObject> _msgItemList = new List<GameObject>();

	public override void Init(ActivityViewModelBase viewModel)
	{
		_viewModel = (DrawCardActivityViewModel)viewModel;
		_viewModel.MaxMsgDataCount = maxMsgDataCount;
		base.Init(viewModel);
		BindingSet<DrawCardActivityView, DrawCardActivityViewModel> bindingSet = this.CreateBindingSet((DrawCardActivityViewModel)viewModel);
		bindingSet.Bind(this).For((DrawCardActivityView v) => v.OpenPropPopupRst).To((DrawCardActivityViewModel vm) => vm.OpenPropPopupRst);
		bindingSet.Bind<TextMeshProUGUI>(desc).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((DrawCardActivityViewModel vm) => vm.Desc);
		bindingSet.Bind<TextMeshProUGUI>(rewardProgressText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((DrawCardActivityViewModel vm) => vm.RewardProgressText);
		bindingSet.Bind<TextMeshProUGUI>(ruleTitle).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((DrawCardActivityViewModel vm) => vm.RuleTitle);
		bindingSet.Bind<TextMeshProUGUI>(ruleContent).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((DrawCardActivityViewModel vm) => vm.RuleContent);
		bindingSet.Bind(costRoot).For((GameObject v) => v.activeSelf).ToExpression((DrawCardActivityViewModel vm) => !vm.DrawCardFinished);
		bindingSet.Bind(costIcon).For((Image v) => v.sprite).ToExpression((DrawCardActivityViewModel vm) => vm.CostPropData.Icon)
			.WithConversion("ItemIcon");
		bindingSet.Bind(((Component)(object)costTextNotEnough).gameObject).For((GameObject v) => v.activeSelf).ToExpression((DrawCardActivityViewModel vm) => !vm.ConsumeEnough);
		bindingSet.Bind(((Component)(object)costTextEnough).gameObject).For((GameObject v) => v.activeSelf).To((DrawCardActivityViewModel vm) => vm.ConsumeEnough);
		bindingSet.Bind<TextMeshProUGUI>(costTextNotEnough).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((DrawCardActivityViewModel vm) => $"×{vm.CostPropData.Amount}");
		bindingSet.Bind<TextMeshProUGUI>(costTextEnough).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).ToExpression((DrawCardActivityViewModel vm) => $"×{vm.CostPropData.Amount}");
		if (btnJumpTry != null)
		{
			JumpWindowParams jumpWindowParams = new JumpWindowParams(jumpWindow, jumpParams);
			bindingSet.Bind(btnJumpTry).For((Button v) => v.onClick).To((DrawCardActivityViewModel vm) => vm.JumpWindowCmd)
				.CommandParameter(jumpWindowParams);
		}
		if (btnJumpOther != null)
		{
			JumpWindowParams jumpWindowParams2 = new JumpWindowParams(jumpWindow2, jumpParams2);
			bindingSet.Bind(btnJumpOther).For((Button v) => v.onClick).To((DrawCardActivityViewModel vm) => vm.JumpWindowCmd)
				.CommandParameter(jumpWindowParams2);
		}
		bindingSet.Bind(btnDrawCard).For((Button v) => v.onClick).To((DrawCardActivityViewModel vm) => vm.DrawCardCmd);
		bindingSet.Bind(btnDrawCard).For((Button v) => v.enabled).ToExpression((DrawCardActivityViewModel vm) => !vm.DrawCardFinished);
		bindingSet.Bind(btnDrawCardMask).For((GameObject v) => v.activeSelf).To((DrawCardActivityViewModel vm) => vm.DrawCardFinished);
		bindingSet.Bind<TextMeshProUGUI>(btnDrawCardText).For((Expression<Func<TextMeshProUGUI, string>>)((TextMeshProUGUI v) => ((TMP_Text)v).text)).To((DrawCardActivityViewModel vm) => vm.DrawCardText);
		bindingSet.Bind().For((DrawCardActivityView v) => v.OpenMoneyGetPanel).To((DrawCardActivityViewModel vm) => vm.OpenMoneyGetPanelRst);
		bindingSet.Bind().For((DrawCardActivityView v) => v.PlayResultSpine).To((DrawCardActivityViewModel vm) => vm.PlayResultAniRst);
		bindingSet.Bind().For((DrawCardActivityView v) => v.AddMsg).To((DrawCardActivityViewModel vm) => vm.AddMsgRst);
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
		if (displayRewardItems != null)
		{
			for (int num = 0; num < displayRewardItems.Count; num++)
			{
				KnapsackItemNew knapsackItemNew = displayRewardItems[num];
				if (!(knapsackItemNew == null))
				{
					if (_viewModel.DisplayRewards.Count <= num)
					{
						knapsackItemNew.gameObject.SetActive(value: false);
					}
					else
					{
						knapsackItemNew.Init(_viewModel.DisplayRewards[num]);
					}
				}
			}
		}
		btnSkipResultAni.onClick.AddListener(OnSkipResultAniClick);
		InitRewardMsgItems();
		TryStartRolling();
		if (testStart || !_viewModel.StartAniPlayed)
		{
			animation.playAutomatically = false;
			_viewModel.SetWindowUiVisible(visible: false);
			CancelInvoke("StartSpineIdle");
			StartSpinePlay();
			Invoke("StartSpineIdle", startSpineAniTime);
			_viewModel.SetStartAniPlayed();
		}
		else
		{
			animation.Play();
			animation.playAutomatically = true;
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
			moneyGetPanel.alpha = 1f;
			moneyGetPanel.blocksRaycasts = true;
		});
		btnCloseMoneyGet1.onClick.AddListener(delegate
		{
			moneyGetPanel.alpha = 0f;
			moneyGetPanel.blocksRaycasts = false;
		});
		btnCloseMoneyGet2.onClick.AddListener(delegate
		{
			moneyGetPanel.alpha = 0f;
			moneyGetPanel.blocksRaycasts = false;
		});
		btnJumpGetMoney2.onClick.AddListener(JumpGetMoney2);
		btnOpenExcWindow.onClick.AddListener(delegate
		{
			_viewModel.OpenPropExcWindow(1);
			moneyGetPanel.alpha = 0f;
			moneyGetPanel.blocksRaycasts = false;
		});
	}

	private async void JumpGetMoney2()
	{
		JumpWindowParams param = new JumpWindowParams
		{
			WindowName = getMoney2Window,
			Args = getMoney2Params.ConvertAll((Converter<int, object>)((int p) => p))
		};
		_viewModel.JumpWindow(param);
		moneyGetPanel.alpha = 0f;
		moneyGetPanel.blocksRaycasts = false;
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

	private void OpenMoneyGetPanel(object sender, InteractionEventArgs e)
	{
		moneyGetPanel.alpha = 1f;
		moneyGetPanel.blocksRaycasts = true;
	}

	private void PlayResultSpine(object sender, InteractionEventArgs e)
	{
		if (!_resultAniPlaying)
		{
			_isSp = (bool)e.Context;
			_curSkeletonGraphic = (_isSp ? spResultSpine : normalResultSpine);
			float time = (_isSp ? spResultSpineTime : normalResultSpineTime);
			string startingAnimation = (_isSp ? spResultSpineAniName : normalResultSpineAniName);
			CancelInvoke("OnResultAniFinished");
			Invoke("OnResultAniFinished", time);
			((Component)(object)_curSkeletonGraphic).gameObject.SetActive(value: true);
			_curSkeletonGraphic.startingAnimation = startingAnimation;
			_curSkeletonGraphic.Initialize(true);
			resultPanel.gameObject.SetActive(value: true);
			_viewModel.SetWindowUiVisible(visible: false);
			SetBgmParameter((!_isSp) ? 1 : 2);
			_resultAniPlaying = true;
		}
	}

	private void OnResultAniFinished()
	{
		if ((UnityEngine.Object)(object)_curSkeletonGraphic != null)
		{
			((Component)(object)_curSkeletonGraphic).gameObject.SetActive(value: false);
		}
		resultPanel.gameObject.SetActive(value: false);
		_resultAniPlaying = false;
		_viewModel.OnResultAniFinished(_isSp);
		_viewModel.SetWindowUiVisible(visible: true);
		SetBgmParameter(3);
	}

	private void OnSkipResultAniClick()
	{
		if (_resultAniPlaying)
		{
			CancelInvoke("OnResultAniFinished");
			OnResultAniFinished();
		}
	}

	private void SetBgmParameter(int index)
	{
		switch (index)
		{
		case 1:
			Singleton<AudioSystem>.Instance?.SetCurBgmParameter(new FMOD_Define.BgmParameter(volume1, paramList1, canReturn: true, (STOP_MODE)0));
			break;
		case 2:
			Singleton<AudioSystem>.Instance?.SetCurBgmParameter(new FMOD_Define.BgmParameter(volume2, paramList2, canReturn: true, (STOP_MODE)0));
			break;
		case 3:
			Singleton<AudioSystem>.Instance?.SetCurBgmParameter(new FMOD_Define.BgmParameter(volume3, paramList3, canReturn: true, (STOP_MODE)0));
			break;
		}
	}

	protected override void OnDisable()
	{
		_viewModel?.SetWindowUiVisible(visible: true);
		base.OnDisable();
	}

	protected override void OnDestroy()
	{
		_viewModel?.OnViewDestroy();
		CancelInvoke("OnResultAniFinished");
		CancelInvoke("StartMsgRolling");
		CancelInvoke("FinishMsgRolling");
		CancelInvoke("StartSpineIdle");
		base.OnDestroy();
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

	private void InitRewardMsgItems()
	{
		_msgItemHeight = rewardMsgItemTpl.GetComponent<RectTransform>().sizeDelta.y;
		for (int i = 0; i < maxRewardMsgCount + 1; i++)
		{
			GameObject gameObject = UnityEngine.Object.Instantiate(rewardMsgItemTpl, rewardMsgRollingContent);
			gameObject.SetActive(value: false);
			_msgItemList.Add(gameObject);
		}
		int num = Mathf.Min(_viewModel.MsgList.Count, maxRewardMsgCount);
		if (num > 0)
		{
			for (int j = 0; j < num; j++)
			{
				GameObject obj = _msgItemList[j];
				RectTransform component = obj.GetComponent<RectTransform>();
				component.anchoredPosition = new Vector2(component.anchoredPosition.x, (float)(num - 1 - j) * (msgPadding + _msgItemHeight));
				((TMP_Text)obj.GetComponentInChildren<TextMeshProUGUI>()).text = _viewModel.MsgList[j].Item1;
				obj.transform.SetAsLastSibling();
				obj.SetActive(value: true);
			}
			_viewModel.MsgIndex = ((num < _viewModel.MsgList.Count) ? num : 0);
		}
	}

	private void TryStartRolling()
	{
		if ((_viewModel.NewMsgQueue.Count > 0 || _viewModel.MsgList.Count > maxRewardMsgCount) && _state != State.Rolling && _state != State.Waiting)
		{
			if (PrepareNextMsgItem(out var isNew))
			{
				_state = State.Waiting;
				int num = ((!isNew) ? GetRandomDuration() : 0);
				CancelInvoke("StartMsgRolling");
				Invoke("StartMsgRolling", num);
			}
			else
			{
				_state = State.Stay;
			}
		}
	}

	private bool PrepareNextMsgItem(out bool isNew)
	{
		if (!_viewModel.GetNextMsg(out var msg, out isNew))
		{
			return false;
		}
		GameObject item = GetItem();
		if (item == null)
		{
			return false;
		}
		item.transform.SetParent(rewardMsgRollingContent);
		RectTransform component = item.GetComponent<RectTransform>();
		component.anchoredPosition = new Vector2(component.anchoredPosition.x, 0f - msgPadding - _msgItemHeight);
		((TMP_Text)item.GetComponentInChildren<TextMeshProUGUI>()).text = msg;
		item.transform.SetAsLastSibling();
		item.SetActive(value: true);
		return true;
	}

	private GameObject GetItem()
	{
		GameObject item = _msgItemList.Find((GameObject p) => !p.activeSelf);
		if (item == null)
		{
			_msgItemList.ForEach(delegate(GameObject p)
			{
				if (item == null || p.GetComponent<RectTransform>().anchoredPosition.y > item.GetComponent<RectTransform>().anchoredPosition.y)
				{
					item = p;
				}
			});
		}
		return item;
	}

	private int GetRandomDuration()
	{
		return new System.Random().Next(duration1, duration2);
	}

	private void StartMsgRolling()
	{
		_state = State.Rolling;
		DOTweenModuleUI.DOAnchorPosY(rewardMsgRollingContent, msgPadding + _msgItemHeight, rollingTime, false).SetEase(Ease.Linear);
		CancelInvoke("FinishMsgRolling");
		Invoke("FinishMsgRolling", rollingTime + 0.1f);
	}

	private void FinishMsgRolling()
	{
		_msgItemList.ForEach(delegate(GameObject p)
		{
			p.transform.SetParent(rewardMsgStayContent);
		});
		rewardMsgRollingContent.anchoredPosition = new Vector2(rewardMsgRollingContent.anchoredPosition.x, 0f);
		_msgItemList.ForEach(delegate(GameObject p)
		{
			p.transform.SetParent(rewardMsgRollingContent);
		});
		_state = State.Stay;
		TryStartRolling();
	}

	private void StartRollingImmediate()
	{
		CancelInvoke("StartMsgRolling");
		StartMsgRolling();
	}

	private void AddMsg(object sender, InteractionEventArgs e)
	{
		if (e.Context is string newMsg)
		{
			_viewModel.AddNewMsg(newMsg);
			if (_state == State.Waiting)
			{
				StartRollingImmediate();
			}
			else
			{
				TryStartRolling();
			}
		}
	}
}
