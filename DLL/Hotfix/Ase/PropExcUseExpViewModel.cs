using System.Collections.Generic;
using GameFramework.Runtime;
using Sirenix.Utilities;
using UnityEngine;

namespace Ase;

public class PropExcUseExpViewModel : OptionBase
{
	private KnapsackItemViewModel _targetProp;

	private Dictionary<int, KnapsackItemViewModel> _consumePropDatas = new Dictionary<int, KnapsackItemViewModel>();

	private Dictionary<int, int> _convertExpData = new Dictionary<int, int>();

	private InteractionRequest _useCountChangeRst = new InteractionRequest();

	private SimpleCommand _confirmCmd;

	private bool _showConfirmMask;

	private string _confirmText;

	private int _needExp;

	private int _overflowExp;

	private int _useCount;

	private int _useCountMin;

	private int _useCountMax;

	private int _singleCoinCost;

	private string _tips1;

	public InteractionRequest UseCountChangeRst => _useCountChangeRst;

	public int SingleCoinCost
	{
		get
		{
			return _singleCoinCost;
		}
		set
		{
			Set(ref _singleCoinCost, value, "SingleCoinCost");
		}
	}

	public string Tips1
	{
		get
		{
			return _tips1;
		}
		set
		{
			Set(ref _tips1, value, "Tips1");
		}
	}

	public KnapsackItemViewModel TargetProp => _targetProp;

	public Dictionary<int, KnapsackItemViewModel> ConsumePropDatas => _consumePropDatas;

	public int UseCount
	{
		get
		{
			return _useCount;
		}
		private set
		{
			if (Set(ref _useCount, value, "UseCount"))
			{
				CalConsumeInfo();
			}
		}
	}

	public int UseCountMin
	{
		get
		{
			return _useCountMin;
		}
		private set
		{
			Set(ref _useCountMin, value, "UseCountMin");
		}
	}

	public int UseCountMax
	{
		get
		{
			return _useCountMax;
		}
		private set
		{
			Set(ref _useCountMax, value, "UseCountMax");
		}
	}

	public bool ShowConfirmMask
	{
		get
		{
			return _showConfirmMask;
		}
		set
		{
			Set(ref _showConfirmMask, value, "ShowConfirmMask");
		}
	}

	public string ConfirmText
	{
		get
		{
			return _confirmText;
		}
		set
		{
			Set(ref _confirmText, value, "ConfirmText");
		}
	}

	public ICommand ConfirmCmd => _confirmCmd;

	public PropExcUseExpViewModel()
	{
	}

	public PropExcUseExpViewModel(OptionBase parent, (int, int) target, List<(int, int)> consumes)
	{
		base.parent = parent;
		_confirmCmd = new SimpleCommand(Confirm);
		_needExp = target.Item2;
		DRProp dataRow = GameEntry.DataTable.GetDataRow<DRProp>(target.Item1);
		_targetProp = new KnapsackItemViewModel(this, new PropDataBase(dataRow), showOwner: false, showName: true);
		if (consumes != null)
		{
			consumes.Sort(((int, int) a, (int, int) b) => a.Item2.CompareTo(b.Item2));
			foreach (var consume in consumes)
			{
				DRProp dataRow2 = GameEntry.DataTable.GetDataRow<DRProp>(consume.Item1);
				if (dataRow2 != null)
				{
					_consumePropDatas.Add(consume.Item1, new KnapsackItemViewModel(this, new PropDataBase(dataRow2, 0)));
					_convertExpData.Add(consume.Item1, consume.Item2);
				}
			}
		}
		SingleCoinCost = (int)GameEntry.DataTable.GetDataRow<DRConstantConfig>(1038).Value;
		CalSliderParams();
		CalConsumeInfo();
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (obj is KnapsackItemViewModel knapsackItemViewModel)
		{
			OpenViewArg openViewArg = knapsackItemViewModel.OpenPopupWindow(this);
			if (openViewArg != null)
			{
				openWindowRequest.Raise(openViewArg);
			}
		}
		else if (obj is ViewBackArg arg)
		{
			RefreshWhenBack(arg);
		}
	}

	public override void RefreshWhenBack(ViewBackArg arg)
	{
		if (arg == null || (!(arg.Obj is PropWindowViewModel) && !(arg.Obj is ArmourPopupViewModel) && !(arg.Obj is ExpPropReturnViewModel) && !(arg.Obj is ArmourAutoSelectRuleViewModel)))
		{
			CalSliderParams();
			CalConsumeInfo();
			_useCountChangeRst.Raise();
		}
	}

	private void Confirm()
	{
		if (_targetProp?.PropDataBase == null || UseCount <= 0)
		{
			return;
		}
		int targetPropId = _targetProp.PropDataBase.Id;
		int targetCount = UseCount;
		_confirmCmd.Enabled = false;
		(bool, List<PropDataBase>) tuple = CheckConsumeReturn();
		if (tuple.Item1)
		{
			ExpPropReturnViewModel returnViewModel = new ExpPropReturnViewModel(this, tuple.Item2);
			returnViewModel.SetTips("本次兑换经验溢出，将返还以下材料，是否继续？");
			openWindowRequest.Raise(new OpenViewArg(typeof(ExpPropReturnWindow), returnViewModel), delegate
			{
				if (returnViewModel.result)
				{
					RequestExchange(targetPropId, targetCount);
				}
				else
				{
					_confirmCmd.Enabled = true;
				}
			});
		}
		else
		{
			RequestExchange(targetPropId, targetCount);
		}
	}

	private async void RequestExchange(int targetPropId, int count)
	{
		Loading loading = await Loading.Show();
		PropGetViewModel propGetViewModel = await Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>().SendCurrencyExchange(targetPropId, count);
		loading?.Dispose();
		if (propGetViewModel != null)
		{
			propGetViewModel.SetParent(parent);
			parent?.ItemOnClick(new OpenViewArg(typeof(PropGetWindow), propGetViewModel));
			Close();
		}
		else
		{
			_confirmCmd.Enabled = true;
		}
	}

	private (bool, List<PropDataBase>) CheckConsumeReturn()
	{
		if (_overflowExp <= 0)
		{
			return (false, null);
		}
		int num = _overflowExp;
		List<PropDataBase> list = new List<PropDataBase>();
		List<(int, int)> list2 = new List<(int, int)>();
		foreach (KeyValuePair<int, int> convertExpDatum in _convertExpData)
		{
			list2.Add((convertExpDatum.Key, convertExpDatum.Value));
		}
		list2.Sort(((int, int) a, (int, int) b) => -a.Item2.CompareTo(b.Item2));
		foreach (var item3 in list2)
		{
			int item = item3.Item1;
			int item2 = item3.Item2;
			int num2 = Mathf.FloorToInt((float)num / (float)item2);
			if (num2 > 0)
			{
				DRProp dataRow = GameEntry.DataTable.GetDataRow<DRProp>(item);
				if (dataRow != null)
				{
					num -= num2 * item2;
					list.Add(new PropDataBase(dataRow, num2));
				}
			}
		}
		return (list.Count > 0, list);
	}

	public void SetTips1(string text)
	{
		Tips1 = text;
	}

	private void CalConsumeInfo()
	{
		if (_needExp <= 0)
		{
			return;
		}
		_targetProp.PropDataBase.Amount = UseCount;
		_overflowExp = 0;
		_consumePropDatas.ForEach(delegate(KeyValuePair<int, KnapsackItemViewModel> p)
		{
			p.Value.PropDataBase.Amount = 0;
		});
		int num = UseCount * _needExp;
		foreach (KeyValuePair<int, KnapsackItemViewModel> consumePropData in _consumePropDatas)
		{
			int key = consumePropData.Key;
			if (_convertExpData.ContainsKey(key))
			{
				int num2 = _convertExpData[key];
				int propOwnedCount = PropHelper.GetPropOwnedCount(key);
				if (num <= num2 * propOwnedCount)
				{
					int num3 = Mathf.CeilToInt((float)num / (float)num2);
					consumePropData.Value.PropDataBase.Amount = num3;
					_overflowExp = num2 * num3 - num;
					break;
				}
				consumePropData.Value.PropDataBase.Amount = propOwnedCount;
				num -= num2 * propOwnedCount;
			}
		}
	}

	private void CalSliderParams()
	{
		if (_needExp <= 0)
		{
			UseCountMin = 0;
			UseCountMax = 0;
			UseCount = 0;
			ShowConfirmMask = true;
			return;
		}
		int num = 0;
		foreach (KeyValuePair<int, int> convertExpDatum in _convertExpData)
		{
			num += PropHelper.GetPropOwnedCount(convertExpDatum.Key) * convertExpDatum.Value;
		}
		int propOwnedCount = PropHelper.GetPropOwnedCount(9001);
		int a = num / _needExp;
		int b = propOwnedCount / SingleCoinCost;
		UseCountMax = Mathf.Min(a, b);
		UseCountMin = ((UseCountMax > 0) ? 1 : 0);
		UseCount = ((UseCountMax > 0) ? 1 : 0);
		ShowConfirmMask = UseCountMax <= 0;
		ConfirmText = (ShowConfirmMask ? "道具不足" : "确定");
	}

	public bool AddProp()
	{
		if (UseCount >= UseCountMax)
		{
			return false;
		}
		UseCount++;
		return true;
	}

	public bool DecProp()
	{
		if (UseCount <= UseCountMin)
		{
			return false;
		}
		UseCount--;
		return true;
	}

	public void SetUseCount(int count)
	{
		UseCount = count;
	}
}
