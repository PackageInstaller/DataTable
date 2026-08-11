using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class DrawCardActivityViewModel : ActivityViewModelBase
{
	private string _desc;

	private MoneyItemData _moneyData1;

	private MoneyItemData _moneyData2;

	private PropDataBase _costPropData;

	private string _drawCardText;

	private bool _drawCardFinished;

	private string _rewardProgressText;

	private string _ruleTitle;

	private string _ruleContent;

	private List<KnapsackItemViewModel> _displayRewards = new List<KnapsackItemViewModel>();

	private List<KnapsackItemViewModel> _rewardItemList = new List<KnapsackItemViewModel>();

	private DRActivitySkinGet _config;

	private DrawCardActivityInfo _drawCardInfo;

	private string _jumpWindowName;

	private List<int> _jumpArgs;

	private SimpleCommand _drawCardCmd;

	private SimpleCommand<JumpWindowParams> _jumpWindowCmd;

	private InteractionRequest _openMoneyGetPanelRst = new InteractionRequest();

	private InteractionRequest<bool> _playResultAniRst = new InteractionRequest<bool>();

	private InteractionRequest<string> _addMsgRst = new InteractionRequest<string>();

	private bool _consumeEnough;

	private DrawCardActivityResult _drawCardActivityResult;

	private bool openPropPopupWindowEnable = true;

	private InteractionRequest<KeyValuePair<RoleMoneyEnum, Vector3>> openPropPopupRst = new InteractionRequest<KeyValuePair<RoleMoneyEnum, Vector3>>();

	private bool _startAniPlayed;

	private ISubscription<BroadcastNotify> subscription_broadcastNotify;

	public int MaxMsgDataCount;

	private Queue<string> _newMsgQueue = new Queue<string>();

	private List<(string, bool)> _msgList = new List<(string, bool)>();

	public int MsgIndex;

	private BroadcastNotify _broadcastWaitAdd;

	public MoneyItemData MoneyData1 => _moneyData1;

	public MoneyItemData MoneyData2 => _moneyData2;

	public InteractionRequest OpenMoneyGetPanelRst => _openMoneyGetPanelRst;

	public InteractionRequest<KeyValuePair<RoleMoneyEnum, Vector3>> OpenPropPopupRst => openPropPopupRst;

	public bool StartAniPlayed => _startAniPlayed;

	public List<(string, bool)> MsgList
	{
		get
		{
			return _msgList;
		}
		set
		{
			_msgList = value;
		}
	}

	public Queue<string> NewMsgQueue
	{
		get
		{
			return _newMsgQueue;
		}
		set
		{
			_newMsgQueue = value;
		}
	}

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

	public SimpleCommand DrawCardCmd => _drawCardCmd;

	public SimpleCommand<JumpWindowParams> JumpWindowCmd => _jumpWindowCmd;

	public InteractionRequest<bool> PlayResultAniRst => _playResultAniRst;

	public InteractionRequest<string> AddMsgRst => _addMsgRst;

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

	public List<KnapsackItemViewModel> DisplayRewards => _displayRewards;

	public List<KnapsackItemViewModel> RewardItemList => _rewardItemList;

	public DrawCardActivityViewModel()
	{
		_drawCardCmd = new SimpleCommand(TryDrawCard);
		_jumpWindowCmd = new SimpleCommand<JumpWindowParams>(JumpWindow);
		subscription_broadcastNotify = Singleton<NetworkSystem>.Instance.Subscribe<BroadcastNotify>(OnBroadcastNotify);
		LoadLocalCache();
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
		else if (obj is OptionArg { Obj: var obj3 } optionArg && obj3 is KeyValuePair<RoleMoneyEnum, Vector3> context && optionArg.OptionName == "OnIconBtnClick" && openPropPopupWindowEnable)
		{
			openPropPopupRst.Raise(context);
		}
	}

	public override void Init(OpActViewModel opActViewModel, DRActivityType drData)
	{
		base.Init(opActViewModel, drData);
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
		for (int num = 0; num < _config.ShowID.Count; num++)
		{
			if (_config.ShowType.Count > num)
			{
				_displayRewards.Add(new KnapsackItemViewModel(this, PropDataBase.CreateByType(_config.ShowType[num], _config.ShowID[num])));
			}
		}
		DRGameExplain dataRow2 = GameEntry.DataTable.GetDataRow<DRGameExplain>(_config.ExplainId);
		if (dataRow2 != null)
		{
			RuleTitle = dataRow2.Title;
			RuleContent = dataRow2.Content.Replace("\\n", "\n");
		}
		RequestInfo();
	}

	public override async Task RequestDataBeforeShow()
	{
		await RequestInfo();
	}

	private async Task RequestInfo()
	{
		(DrawCardActivityInfo, BroadcastJsonData) tuple = await Singleton<ServiceSystem>.Instance.GetService<IOpActivityService>().SendDrawCardInfoRst(base.ActivityTypeId);
		MsgList = tuple.Item2.BroadcastNotifies.ConvertAll((BroadcastNotify p) => (Content: p.Content, p.Param1.Equals("1")));
		RefreshDrawCardInfo(tuple.Item1);
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
		_drawCardInfo = newInfo;
		if (_drawCardInfo == null || _config == null || _drawCardInfo.DrawState.Count <= _config.PerfactRewardIndex)
		{
			return;
		}
		List<int> drawState = _drawCardInfo.DrawState;
		DrawCardFinished = drawState[_config.PerfactRewardIndex] == 1;
		DrawCardText = (DrawCardFinished ? "已获得所有奖励" : "祈愿一次");
		RewardProgressText = $"奖励进度 {_drawCardInfo.AllTimes}/{drawState.Count}";
		int amount = ((_config.UseCountGroup.Count > newInfo.AllTimes) ? _config.UseCountGroup[newInfo.AllTimes] : 0);
		_costPropData.Amount = amount;
		int num = 0;
		for (int i = 0; i < _config.RewardIdGroup.Count; i++)
		{
			DRActivityTaskReward dataRow = GameEntry.DataTable.GetDataRow<DRActivityTaskReward>(_config.RewardIdGroup[i]);
			if (dataRow == null)
			{
				continue;
			}
			PropDataBase propDataBase = PropDataBase.CreateByType((dataRow.RewardType.Count > 0) ? dataRow.RewardType[0] : 0, (dataRow.RewardId.Count > 0) ? dataRow.RewardId[0] : 0, (dataRow.RewardNum.Count > 0) ? dataRow.RewardNum[0] : 0);
			if (propDataBase != null && !propDataBase.Empty)
			{
				if (_rewardItemList.Count <= num)
				{
					_rewardItemList.Add(new KnapsackItemViewModel(this, propDataBase)
					{
						IsActive = (drawState.Count > i && drawState[i] == 0)
					});
				}
				else
				{
					_rewardItemList[num].IsActive = drawState.Count > i && drawState[i] == 0;
				}
				num++;
			}
		}
		RefreshConsumeEnoughState();
	}

	private async void TryDrawCard()
	{
		if (_costPropData == null || _costPropData.Empty)
		{
			return;
		}
		if (!PropHelper.CheckPropEnough(_costPropData.Id, _costPropData.Amount))
		{
			_openMoneyGetPanelRst.Raise();
			return;
		}
		_drawCardCmd.Enabled = false;
		Loading loading = await Loading.Show();
		DrawCardActivityResult drawCardActivityResult = await Singleton<ServiceSystem>.Instance.GetService<IOpActivityService>().SendDrawCardRst(base.ActivityTypeId);
		loading?.Dispose();
		if (drawCardActivityResult == null)
		{
			_drawCardCmd.Enabled = true;
			return;
		}
		_drawCardActivityResult = drawCardActivityResult;
		bool flag = drawCardActivityResult.Pos == _config.PerfactRewardIndex;
		if (flag)
		{
			int id = _config.RewardIdGroup[_config.PerfactRewardIndex];
			DRActivityTaskReward perfactRewardConfig = GameEntry.DataTable.GetDataRow<DRActivityTaskReward>(id);
			if (perfactRewardConfig != null)
			{
				RewardGetData rewardData = _drawCardActivityResult.RewardData;
				List<PropDataBase> normalSkinPropList = new List<PropDataBase>();
				rewardData.HeroSkinList.ForEach(delegate(int skinId)
				{
					if (!perfactRewardConfig.RewardId.Contains(skinId))
					{
						normalSkinPropList.Add(PropDataBase.CreateByType(PropTypeEnum.HeroSkin, skinId));
					}
				});
				rewardData.HeroSkinList.RemoveAll((int p) => !perfactRewardConfig.RewardId.Contains(p));
				normalSkinPropList.AddRange(rewardData.PropList);
				rewardData.PropList = normalSkinPropList;
			}
		}
		_playResultAniRst.Raise(flag);
	}

	public void OnResultAniFinished(bool isSp)
	{
		if (_drawCardActivityResult == null)
		{
			_drawCardCmd.Enabled = true;
			return;
		}
		if (_drawCardActivityResult.RewardData != null)
		{
			OpenPropGetWindow(isSp);
		}
		RefreshDrawCardInfo(_drawCardActivityResult.Info);
		Singleton<ServiceSystem>.Instance.GetService<IOpActivityService>()?.GetActivityVm()?.RefreshTypeAndFinishState();
		_drawCardActivityResult = null;
		_drawCardCmd.Enabled = true;
	}

	public void OnViewDestroy()
	{
		if (_drawCardActivityResult != null && _config != null)
		{
			bool isSp = _drawCardActivityResult.Pos == _config.PerfactRewardIndex;
			OnResultAniFinished(isSp);
		}
	}

	private void OpenPropGetWindow(bool isSp)
	{
		if (isSp)
		{
			_drawCardActivityResult.RewardData.PropList.ForEach(delegate(PropDataBase p)
			{
				p.CustomTag = true;
			});
		}
		PropGetViewModel propGetViewModel = new PropGetViewModel(parent, _drawCardActivityResult.RewardData);
		propGetViewModel.GetItemsWindowType = PropGetItemsWindowType.Activity;
		propGetViewModel.MergeProp();
		parent?.ItemOnClick(new OpenViewArg(typeof(PropGetWindow), propGetViewModel, "DrawCardActivity", isOpenWindow: true, "DEFAULT", DoAddSelfMsg));
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

	public void UpdateWindowMaskTime(float time)
	{
		parent?.ItemOnClick(new OptionArg(time, "UpdateWindowMaskTime"));
	}

	public void SetWindowUiVisible(bool visible)
	{
		parent?.ItemOnClick(new OptionArg(visible, "SetUiVisible"));
	}

	private string GetLocalCacheKey()
	{
		return $"DrawCardActivity_StartAnimation_{(Singleton<ServiceSystem>.Instance.GetService<IRoleService>()?.GetRoleData()?.Uid).GetValueOrDefault()}";
	}

	private void LoadLocalCache()
	{
		int num = PlayerPrefs.GetInt(GetLocalCacheKey(), 0);
		_startAniPlayed = num == 1;
	}

	public void SetStartAniPlayed()
	{
		if (!_startAniPlayed)
		{
			_startAniPlayed = true;
			PlayerPrefs.SetInt(GetLocalCacheKey(), 1);
		}
	}

	public override bool CheckAllTaskFinished()
	{
		if (_drawCardInfo == null)
		{
			return true;
		}
		return !_drawCardInfo.DrawState.Contains(0);
	}

	private void OnBroadcastNotify(BroadcastNotify notify)
	{
		if (notify != null)
		{
			long uid = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().Uid;
			if (long.TryParse(notify.Param1, out var result) && uid == result)
			{
				_broadcastWaitAdd = notify;
			}
			else
			{
				_addMsgRst.Raise(notify.Content);
			}
		}
	}

	private void DoAddSelfMsg()
	{
		if (_broadcastWaitAdd != null)
		{
			_addMsgRst.Raise(_broadcastWaitAdd.Content);
			_broadcastWaitAdd = null;
		}
	}

	public bool GetNextMsg(out string msg, out bool isNew)
	{
		if (NewMsgQueue.Count > 0)
		{
			msg = NewMsgQueue.Dequeue();
			MsgList.Add((msg, true));
			if (MsgList.Count > MaxMsgDataCount)
			{
				int num = MsgList.FindLastIndex(((string, bool) p) => !p.Item2);
				if (num < 0)
				{
					num = MsgList.Count - 1;
				}
				MsgList.RemoveAt(num);
			}
			isNew = true;
			return true;
		}
		if (MsgList.Count > 0)
		{
			MsgIndex = ((MsgList.Count > MsgIndex) ? MsgIndex : 0);
			msg = MsgList[MsgIndex].Item1;
			MsgIndex = ((MsgIndex + 1 < MsgList.Count) ? (MsgIndex + 1) : 0);
			isNew = false;
			return true;
		}
		msg = string.Empty;
		isNew = false;
		return false;
	}

	public void AddNewMsg(string newMsg)
	{
		NewMsgQueue.Enqueue(newMsg);
	}

	protected override void Dispose(bool disposing)
	{
		subscription_broadcastNotify?.Dispose();
		subscription_broadcastNotify = null;
		base.Dispose(disposing);
	}
}
