using System;
using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class HLPlantSpeedUpViewModel : OptionBase
{
	private SimpleCommand confirmCmd;

	private InteractionRequest<float> fixSliderRequest;

	private int useCount;

	private int useCountMax;

	private long leftTime;

	private Timer timer;

	private string leftTimeText;

	private bool canAdd;

	private bool canDec;

	private float useFillAmount;

	private bool needFix;

	private KnapsackItemViewModel curItemViewModel;

	private List<KnapsackItemViewModel> knapsackItemViewList;

	public int UseCount
	{
		get
		{
			return useCount;
		}
		private set
		{
			Set(ref useCount, value, "UseCount");
		}
	}

	public float UseFillAmount
	{
		get
		{
			return useFillAmount;
		}
		set
		{
			Set(ref useFillAmount, value, "UseFillAmount");
			if (needFix)
			{
				SetFillAmount((int)(value * (float)UseCountMax));
			}
			needFix = true;
		}
	}

	public bool CanAdd
	{
		get
		{
			return canAdd;
		}
		private set
		{
			Set(ref canAdd, value, "CanAdd");
		}
	}

	public bool CanDec
	{
		get
		{
			return canDec;
		}
		private set
		{
			Set(ref canDec, value, "CanDec");
		}
	}

	public int UseCountMax
	{
		get
		{
			return useCountMax;
		}
		private set
		{
			Set(ref useCountMax, value, "UseCountMax");
		}
	}

	public List<KnapsackItemViewModel> KnapsackItemViewList
	{
		get
		{
			return knapsackItemViewList;
		}
		private set
		{
			Set(ref knapsackItemViewList, value, "KnapsackItemViewList");
		}
	}

	public long LeftTime
	{
		get
		{
			return leftTime;
		}
		private set
		{
			Set(ref leftTime, value, "LeftTime");
		}
	}

	public string LeftTimeText
	{
		get
		{
			return leftTimeText;
		}
		private set
		{
			Set(ref leftTimeText, value, "LeftTimeText");
		}
	}

	public ICommand ConfirmCmd => confirmCmd;

	public IInteractionRequest FixSliderRequest => fixSliderRequest;

	public KnapsackItemViewModel CurItemViewModel => curItemViewModel;

	public HLPlantSpeedUpViewModel(OptionBase parent, long leftTime)
	{
		base.parent = parent;
		confirmCmd = new SimpleCommand(Confirm);
		this.leftTime = leftTime;
		fixSliderRequest = new InteractionRequest<float>();
		OpenTimer();
		RefreshProp();
	}

	public override void ItemOnClick(object obj)
	{
		if (obj is KnapsackItemViewModel item)
		{
			curItemViewModel.IsSelected = false;
			SetItem(item);
		}
	}

	private void OpenTimer()
	{
		timer = Timer.Register(1f, RefreshTime, null, isLooped: true, useRealTime: true);
	}

	public override void Close()
	{
		Timer.Cancel(timer);
		base.Close();
	}

	private void RefreshTime()
	{
		if (LeftTime >= 0)
		{
			LeftTime--;
			LeftTimeText = "剩余培育时间:" + new DateTime(1970, 1, 1).AddSeconds(LeftTime).ToString("H小时m分钟");
		}
	}

	private void RefreshProp()
	{
		knapsackItemViewList = new List<KnapsackItemViewModel>();
		List<DRProp> list = new List<DRProp>();
		DRProp[] allDataRows = GameEntry.DataTable.GetDataTable<DRProp>().GetAllDataRows();
		foreach (DRProp dRProp in allDataRows)
		{
			foreach (int item in dRProp.UseType)
			{
				if (item == 13)
				{
					list.Add(dRProp);
				}
			}
		}
		foreach (DRProp item2 in list)
		{
			PropDataBase prop = Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>().GetKnapsackViewModel().GetProp(item2.Id);
			KnapsackItemViewModel knapsackItemViewModel;
			if (prop == null)
			{
				prop = PropDataBase.CreateByType(item2.Type, item2.Id, 0);
				knapsackItemViewModel = new KnapsackItemViewModel(this, prop);
				knapsackItemViewModel.IsActive = false;
			}
			else
			{
				knapsackItemViewModel = new KnapsackItemViewModel(this, prop);
			}
			knapsackItemViewModel.ExValueText = $"-{knapsackItemViewModel.ExValue}分";
			KnapsackItemViewList.Add(knapsackItemViewModel);
		}
		foreach (KnapsackItemViewModel knapsackItemView in KnapsackItemViewList)
		{
			if (knapsackItemView.PropDataBase.Amount > 0)
			{
				SetItem(knapsackItemView);
				return;
			}
		}
		if (CurItemViewModel == null && KnapsackItemViewList.Count > 0)
		{
			List<KnapsackItemViewModel> list2 = KnapsackItemViewList;
			int i = list2.Count - 1;
			SetItem(list2[i]);
		}
	}

	private void SetItem(KnapsackItemViewModel knapsackItemViewModel)
	{
		curItemViewModel = knapsackItemViewModel;
		curItemViewModel.IsSelected = true;
		SetCurSelected();
	}

	private void SetCurSelected()
	{
		CalItemCountRange();
		UseFillAmount = CalUseFillAmount(1);
		fixSliderRequest.Raise(UseFillAmount);
	}

	private void CalItemCountRange()
	{
		UseCountMax = (int)LeftTime / CurItemViewModel.ExValue;
		UseCountMax = ((CurItemViewModel.PropDataBase.Amount > UseCountMax) ? UseCountMax : CurItemViewModel.PropDataBase.Amount);
	}

	private float CalUseFillAmount(int useCount)
	{
		CanAdd = UseCount < UseCountMax;
		CanDec = UseCount > 0;
		return (float)useCount * 1f / (float)useCountMax;
	}

	private void SetUseCount(int useCount)
	{
		UseCount = ((useCount <= 0) ? 1 : useCount);
		CanDec = UseCount > 1 && UseCountMax != 0;
		CanAdd = UseCount < UseCountMax;
		UseFillAmount = CalUseFillAmount(UseCount);
		fixSliderRequest.Raise(UseFillAmount);
	}

	private void SetFillAmount(int amout)
	{
		UseCount = ((amout <= 0) ? 1 : amout);
		CanDec = UseCount > 1;
		CanAdd = UseCount < UseCountMax;
	}

	public void Confirm()
	{
		confirmCmd.Enabled = false;
		parent?.ItemOnClick(new OptionArg(this, "SpeedUpPlant"));
	}

	public void AddProp()
	{
		if (UseCount < UseCountMax || UseCountMax == 0)
		{
			int num = useCount + 1;
			needFix = false;
			SetUseCount(num);
		}
	}

	public void DecProp()
	{
		if (useCount > 1)
		{
			int num = useCount - 1;
			needFix = false;
			SetUseCount(num);
		}
	}
}
