using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class LotteryActivityViewModel : ActivityViewModelBase
{
	private List<LotteryActItemData> _lotteryItemDataList = new List<LotteryActItemData>();

	private string _desc;

	private MoneyItemData _moneyData1;

	private MoneyItemData _moneyData2;

	private PropDataBase _costPropData;

	private string _drawCardText;

	private bool _drawCardFinished;

	private string _rewardProgressText;

	private string _ruleTitle;

	private string _ruleContent;

	private List<KnapsackItemViewModel> _rewardItemList = new List<KnapsackItemViewModel>();

	private DRActivitySkinGet _config;

	private DrawCardActivityInfo _drawCardInfo;

	private string _jumpWindowName;

	private List<int> _jumpArgs;

	private bool _drawCardEnabled = true;

	private SimpleCommand<JumpWindowParams> _jumpWindowCmd;

	private bool _consumeEnough;

	private DrawCardActivityResult _drawCardActivityResult;

	private bool openPropPopupWindowEnable = true;

	private InteractionRequest<KeyValuePair<RoleMoneyEnum, Vector3>> openPropPopupRst = new InteractionRequest<KeyValuePair<RoleMoneyEnum, Vector3>>();

	private bool _showLotteryConfirmPanel;

	private bool _lotteryNoConfirmToggle;

	private string _lotteryConfirmTips;

	private LotteryActItemData _itemWaitLottery;

	private bool _startAniPlayed;

	public InteractionRequest<KeyValuePair<RoleMoneyEnum, Vector3>> OpenPropPopupRst => openPropPopupRst;

	public bool ShowLotteryConfirm
	{
		get
		{
			return _showLotteryConfirmPanel;
		}
		set
		{
			Set(ref _showLotteryConfirmPanel, value, "ShowLotteryConfirm");
		}
	}

	public bool LotteryNoConfirmToggle
	{
		get
		{
			return _lotteryNoConfirmToggle;
		}
		set
		{
			Set(ref _lotteryNoConfirmToggle, value, "LotteryNoConfirmToggle");
		}
	}

	public string LotteryConfirmTips
	{
		get
		{
			return _lotteryConfirmTips;
		}
		set
		{
			Set(ref _lotteryConfirmTips, value, "LotteryConfirmTips");
		}
	}

	public bool StartAniPlayed => _startAniPlayed;

	public string Desc
	{
		get
		{
			return _desc;
		}
		set
		{
			Set(ref _desc, value, "Desc");
		}
	}

	public List<LotteryActItemData> LotteryItemDataList => _lotteryItemDataList;

	public MoneyItemData MoneyData1 => _moneyData1;

	public MoneyItemData MoneyData2 => _moneyData2;

	public PropDataBase CostPropData => _costPropData;

	public string DrawCardText
	{
		get
		{
			return _drawCardText;
		}
		set
		{
			Set(ref _drawCardText, value, "DrawCardText");
		}
	}

	public SimpleCommand<JumpWindowParams> JumpWindowCmd => _jumpWindowCmd;

	public bool ConsumeEnough
	{
		get
		{
			return _consumeEnough;
		}
		set
		{
			Set(ref _consumeEnough, value, "ConsumeEnough");
		}
	}

	public bool DrawCardFinished
	{
		get
		{
			return _drawCardFinished;
		}
		set
		{
			Set(ref _drawCardFinished, value, "DrawCardFinished");
		}
	}

	public string RewardProgressText
	{
		get
		{
			return _rewardProgressText;
		}
		set
		{
			Set(ref _rewardProgressText, value, "RewardProgressText");
		}
	}

	public string RuleTitle
	{
		get
		{
			return _ruleTitle;
		}
		set
		{
			Set(ref _ruleTitle, value, "RuleTitle");
		}
	}

	public string RuleContent
	{
		get
		{
			return _ruleContent;
		}
		set
		{
			Set(ref _ruleContent, value, "RuleContent");
		}
	}

	public List<KnapsackItemViewModel> RewardItemList => _rewardItemList;

	public LotteryActivityViewModel()
	{
		_jumpWindowCmd = new SimpleCommand<JumpWindowParams>(JumpWindow);
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is KnapsackItemViewModel)
		{
			parent?.ItemOnClick(obj);
		}
		else if (obj is OpenViewArg obj2)
		{
			parent?.ItemOnClick(obj2);
		}
		else if (obj is OptionArg { Obj: var obj3 } optionArg)
		{
			if (obj3 is KeyValuePair<RoleMoneyEnum, Vector3> context)
			{
				if (optionArg.OptionName == "OnIconBtnClick" && openPropPopupWindowEnable)
				{
					openPropPopupRst.Raise(context);
				}
			}
			else if (optionArg.Obj is float time && optionArg.OptionName == "UpdateWindowMaskTime")
			{
				UpdateWindowMaskTime(time);
			}
		}
		else if (obj is LotteryActItemData itemData)
		{
			OnLotteryItemClick(itemData);
		}
	}

	public override void Init(OpActViewModel opActViewModel, DRActivityType drData)
	{
		base.Init(opActViewModel, drData);
		LoadLocalCache();
		_config = GameEntry.DataTable.GetDataRow((DRActivitySkinGet p) => p.ActivityId == drData.Id);
		if (_config == null)
		{
			_costPropData = new PropDataBase();
			return;
		}
		Desc = _config.Desc;
		_costPropData = PropDataBase.CreateByType(_config.UsePropType, _config.UsePropID);
		MoneyData moneyData = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().GetMoneyData();
		KnapsackViewModel knapsackViewModel = Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>().GetKnapsackViewModel();
		_moneyData1 = new MoneyItemData(this, moneyData.GetMoney(MoneyEnum.Voucher));
		DRMoney dataRow = GameEntry.DataTable.GetDataRow((DRMoney p) => p.PropId == _config.UsePropID);
		if (dataRow != null)
		{
			if (Enum.IsDefined(typeof(MoneyEnum), dataRow.PropId))
			{
				_moneyData2 = new MoneyItemData(this, moneyData.GetMoney((MoneyEnum)dataRow.PropId));
			}
			else
			{
				KnapsackPropData prop = knapsackViewModel.GetProp(dataRow.PropId, emptyCreate: true);
				if (prop != null)
				{
					_moneyData2 = new MoneyItemData(this, prop);
				}
			}
		}
		_moneyData1.IconBtnEnable = true;
		if (_moneyData2 != null)
		{
			_moneyData2.IconBtnEnable = true;
		}
		DRGameExplain dataRow2 = GameEntry.DataTable.GetDataRow<DRGameExplain>(_config.ExplainId);
		if (dataRow2 != null)
		{
			RuleTitle = dataRow2.Title;
			RuleContent = dataRow2.Content.Replace("\\n", "\n");
		}
		for (int num = 0; num < _config.RewardIdGroup.Count; num++)
		{
			_lotteryItemDataList.Add(new LotteryActItemData(this, num + 1));
		}
		RequestInfo();
	}

	public override async Task RequestDataBeforeShow()
	{
		await RequestInfo();
	}

	private async Task RequestInfo()
	{
		RefreshDrawCardInfo(await Singleton<ServiceSystem>.Instance.GetService<IOpActivityService>().SendLotteryInfoRst(base.ActivityTypeId));
		Singleton<ServiceSystem>.Instance.GetService<IOpActivityService>()?.GetActivityVm()?.RefreshTypeAndFinishState();
	}

	private void RefreshConsumeEnoughState()
	{
		if (_costPropData == null || _costPropData.Empty)
		{
			ConsumeEnough = false;
		}
		else
		{
			ConsumeEnough = PropHelper.CheckPropEnough(_costPropData.Id, _costPropData.Amount);
		}
	}

	private void RefreshDrawCardInfo(DrawCardActivityInfo newInfo)
	{
		if (newInfo == null)
		{
			return;
		}
		if (_drawCardInfo == null)
		{
			_drawCardInfo = newInfo;
		}
		else
		{
			Dictionary<int, int> positionRewards = (from x in _drawCardInfo.PositionRewards.Union(newInfo.PositionRewards)
				group x by x.Key).ToDictionary((IGrouping<int, KeyValuePair<int, int>> g) => g.Key, (IGrouping<int, KeyValuePair<int, int>> g) => g.Last().Value);
			_drawCardInfo = newInfo;
			_drawCardInfo.PositionRewards = positionRewards;
		}
		if (_config == null)
		{
			return;
		}
		List<int> drawState = _drawCardInfo.DrawState;
		Dictionary<int, int> positionRewards2 = _drawCardInfo.PositionRewards;
		bool drawCardFinished;
		int num;
		int num2;
		if (positionRewards2 == null || positionRewards2.Count <= 0)
		{
			drawCardFinished = false;
			num = 0;
			num2 = ((_config.UseCountGroup.Count > 0) ? _config.UseCountGroup[0] : (-1));
		}
		else
		{
			drawCardFinished = positionRewards2.Count >= _config.RewardIdGroup.Count;
			num = positionRewards2.Count;
			num2 = ((_config.UseCountGroup.Count > num) ? _config.UseCountGroup[num] : (-1));
		}
		DrawCardFinished = drawCardFinished;
		DrawCardText = ((num2 > 0) ? $"×{num2}" : "免费领取");
		RewardProgressText = $"奖励进度 {num}/{_config.UseCountGroup.Count}";
		_costPropData.Amount = num2;
		int num3 = 0;
		for (int num4 = 0; num4 < _config.RewardIdGroup.Count; num4++)
		{
			DRActivityTaskReward dataRow = GameEntry.DataTable.GetDataRow<DRActivityTaskReward>(_config.RewardIdGroup[num4]);
			if (dataRow == null)
			{
				continue;
			}
			PropDataBase propDataBase = PropDataBase.CreateByType((dataRow.RewardType.Count > 0) ? dataRow.RewardType[0] : 0, (dataRow.RewardId.Count > 0) ? dataRow.RewardId[0] : 0, (dataRow.RewardNum.Count > 0) ? dataRow.RewardNum[0] : 0);
			if (propDataBase != null && !propDataBase.Empty)
			{
				bool isActive = drawState.Count > num4 && drawState[num4] == 0;
				if (_rewardItemList.Count <= num3)
				{
					_rewardItemList.Add(new KnapsackItemViewModel(this, propDataBase)
					{
						IsActive = isActive
					});
				}
				else
				{
					_rewardItemList[num3].IsActive = isActive;
				}
				num3++;
				int rewardConfigId = ((positionRewards2 != null && positionRewards2.ContainsKey(num4 + 1)) ? positionRewards2[num4 + 1] : 0);
				_lotteryItemDataList[num4].RefreshResultData(rewardConfigId);
			}
		}
		RefreshConsumeEnoughState();
	}

	private void OnLotteryItemClick(LotteryActItemData itemData)
	{
		if (!_drawCardEnabled || _costPropData == null || _costPropData.Empty)
		{
			return;
		}
		int propOwnedCount = PropHelper.GetPropOwnedCount(_costPropData.Id);
		if (propOwnedCount < _costPropData.Amount)
		{
			OpenPropExcWindow(_costPropData.Amount - propOwnedCount);
			return;
		}
		if (_costPropData.Amount > 0 && !LotteryNoConfirmToggle)
		{
			ShowLotteryConfirmPanel(itemData);
			return;
		}
		_drawCardEnabled = false;
		itemData.PlayLotteryAni(delegate
		{
			DrawCard(itemData.Index);
		});
	}

	private async void DrawCard(int pos)
	{
		Loading loading = await Loading.Show();
		DrawCardActivityResult drawCardActivityResult = await Singleton<ServiceSystem>.Instance.GetService<IOpActivityService>().SendLotteryRst(base.ActivityTypeId, pos);
		loading?.Dispose();
		if (drawCardActivityResult == null)
		{
			_drawCardEnabled = true;
			return;
		}
		_drawCardActivityResult = drawCardActivityResult;
		OnResultAniFinished();
		_drawCardEnabled = true;
	}

	private void OnResultAniFinished()
	{
		if (_drawCardActivityResult != null)
		{
			if (_drawCardActivityResult.RewardData != null)
			{
				OpenPropGetWindow();
			}
			RefreshDrawCardInfo(_drawCardActivityResult.Info);
			Singleton<ServiceSystem>.Instance.GetService<IOpActivityService>()?.GetActivityVm()?.RefreshTypeAndFinishState();
			_drawCardActivityResult = null;
		}
	}

	public void OnViewDestroy()
	{
		if (_drawCardActivityResult != null && _config != null)
		{
			OnResultAniFinished();
		}
	}

	private void OpenPropGetWindow()
	{
		PropGetViewModel propGetViewModel = new PropGetViewModel(parent, _drawCardActivityResult.RewardData);
		propGetViewModel.MergeProp();
		parent?.ItemOnClick(new OpenViewArg(typeof(PropGetWindow), propGetViewModel, "DrawCardActivity"));
	}

	public async void JumpWindow(JumpWindowParams param)
	{
		if (_jumpWindowCmd.Enabled && !string.IsNullOrEmpty(param.WindowName) && (parent == null || parent.CheckOpen(this, param)))
		{
			OpenViewArg openViewArg = await new UIJumpHelper().CreateViewJumpData(param, parent, "DrawCardActivity", delegate
			{
				RefreshConsumeEnoughState();
				_jumpWindowCmd.Enabled = true;
			});
			if (openViewArg != null)
			{
				_jumpWindowCmd.Enabled = false;
				parent?.ItemOnClick(openViewArg);
			}
		}
	}

	public void OpenPropExcWindow(int initExcCount)
	{
		if (!_jumpWindowCmd.Enabled || _costPropData == null || _costPropData.Empty)
		{
			return;
		}
		DRExchangeRate dataRow = GameEntry.DataTable.GetDataRow((DRExchangeRate p) => p.ConsumePropId == 9006 && p.TargetPropId == _config.UsePropID);
		if (dataRow == null)
		{
			Toast.ShowError("无有效兑换比例配置");
			return;
		}
		PropDataBase usePropInBag = PropDataBase.CreateByType(PropTypeEnum.Coin, 9006);
		PropDataBase targetProp = PropDataBase.CreateByType(_config.UsePropType, _config.UsePropID);
		PropExcViewModel propExcViewModel = new PropExcViewModel(this, targetProp, usePropInBag, dataRow.Rate);
		propExcViewModel.TrySetUseCount(initExcCount);
		_jumpWindowCmd.Enabled = false;
		parent?.ItemOnClick(new OpenViewArg(typeof(PropExcView), propExcViewModel, "DrawCardActivity", isOpenWindow: true, "DEFAULT", delegate
		{
			RefreshConsumeEnoughState();
			_jumpWindowCmd.Enabled = true;
		}));
	}

	public void OpenPropPopupWindow(DRProp drProp, Vector2 pos)
	{
		if (openPropPopupWindowEnable)
		{
			openPropPopupWindowEnable = false;
			Vector2 zero = Vector2.zero;
			if (pos.x < (0f - UIUtilly.GetCanvasSize().x) / 2f + 522f)
			{
				pos = new Vector2(pos.x + 50f, pos.y);
				zero = new Vector2(0f, 1f);
			}
			else
			{
				zero = Vector2.one;
			}
			PropWindowViewModel propWindowViewModel = new PropWindowViewModel(parent, allowSkipWindow: true);
			propWindowViewModel.RefreshData(new PropData(drProp));
			propWindowViewModel.SetPosition(pos);
			propWindowViewModel.SetRectInfo(new Vector2(0.5f, 0.5f), new Vector2(0.5f, 0.5f), zero);
			parent?.ItemOnClick(new OpenViewArg(typeof(PropPopupWindow), propWindowViewModel, "DrawCardActivity", isOpenWindow: true, "DEFAULT", delegate
			{
				openPropPopupWindowEnable = true;
			}));
		}
	}

	public void SetWindowUiVisible(bool visible)
	{
		parent?.ItemOnClick(new OptionArg(visible, "SetUiVisible"));
	}

	public void UpdateWindowMaskTime(float time)
	{
		parent?.ItemOnClick(new OptionArg(time, "UpdateWindowMaskTime"));
	}

	public override bool CheckAllTaskFinished()
	{
		if (_drawCardInfo == null)
		{
			return true;
		}
		return !_drawCardInfo.DrawState.Contains(0);
	}

	public override void RefreshActivityTime(bool getLeftTime = true)
	{
		_leftActivityTime = OpActivityDefinition.GetActivityTime(base.DrActivityType);
		string activityTimeText = OpActivityDefinition.GetActivityTimeText(_leftActivityTime);
		base.ActivityTimeText = (string.IsNullOrEmpty(activityTimeText) ? activityTimeText : ("优惠剩余时间：" + activityTimeText));
	}

	public void ShowLotteryConfirmPanel(LotteryActItemData itemData)
	{
		_itemWaitLottery = itemData;
		LotteryConfirmTips = $"确定消耗{_costPropData.Amount}{_costPropData.Name}进行抽取？";
		ShowLotteryConfirm = true;
	}

	public void CancelLotteryConfirmPanel()
	{
		HideLotteryConfirmPanel(cancel: true);
	}

	private void HideLotteryConfirmPanel(bool cancel)
	{
		if (cancel)
		{
			LotteryNoConfirmToggle = false;
		}
		ShowLotteryConfirm = false;
		_itemWaitLottery = null;
	}

	public void OnLotteryConfirmClick()
	{
		if (LotteryNoConfirmToggle)
		{
			SetLotteryNoConfirm();
		}
		if (_itemWaitLottery != null)
		{
			int index = _itemWaitLottery.Index;
			_itemWaitLottery.PlayLotteryAni(delegate
			{
				DrawCard(index);
			});
		}
		HideLotteryConfirmPanel(cancel: false);
	}

	private string GetLocalCacheKey(string key)
	{
		return $"LotteryAct_{key}_{base.ActivityTypeId}_{(Singleton<ServiceSystem>.Instance.GetService<IRoleService>()?.GetRoleData()?.Uid).GetValueOrDefault()}";
	}

	private void LoadLocalCache()
	{
		int num = PlayerPrefs.GetInt(GetLocalCacheKey("StartAnimation"), 0);
		_startAniPlayed = num == 1;
		int num2 = PlayerPrefs.GetInt(GetLocalCacheKey("LotteryNoConfirm"), 0);
		LotteryNoConfirmToggle = num2 == 1;
	}

	public void SetStartAniPlayed()
	{
		_startAniPlayed = true;
		PlayerPrefs.SetInt(GetLocalCacheKey("StartAnimation"), 1);
	}

	public void SetLotteryNoConfirm()
	{
		LotteryNoConfirmToggle = true;
		PlayerPrefs.SetInt(GetLocalCacheKey("LotteryNoConfirm"), 1);
	}
}
