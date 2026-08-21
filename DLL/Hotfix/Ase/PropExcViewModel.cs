using System;
using System.Threading.Tasks;
using GameFramework.Runtime;

namespace Ase;

public class PropExcViewModel : OptionBase
{
	protected SimpleCommand confirmCmd;

	protected InteractionRequest<float> fixSliderRequest;

	private PropDataBase usePropInBag;

	private PropDataBase targetProp;

	private int propCountNeed;

	protected int useCount;

	protected int useCountMax;

	protected int excRate;

	private bool canAdd;

	private bool canDec;

	private float useFillAmount;

	private string showName;

	private string showStatus;

	public bool needFix;

	private bool isFixChange;

	public PropDataBase UsePropInBag
	{
		get
		{
			return usePropInBag;
		}
		private set
		{
			Set(ref usePropInBag, value, "UsePropInBag");
		}
	}

	public PropDataBase TargetProp
	{
		get
		{
			return targetProp;
		}
		private set
		{
			Set(ref targetProp, value, "TargetProp");
		}
	}

	public int UseCount
	{
		get
		{
			return useCount;
		}
		protected set
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
		protected set
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
		protected set
		{
			Set(ref canDec, value, "CanDec");
		}
	}

	public int PropCountNeed
	{
		get
		{
			return propCountNeed;
		}
		protected set
		{
			Set(ref propCountNeed, value, "PropCountNeed");
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

	public ICommand ConfirmCmd => confirmCmd;

	public IInteractionRequest FixSliderRequest => fixSliderRequest;

	public PropExcViewModel()
	{
	}

	public PropExcViewModel(OptionBase parent, PropDataBase targetProp, PropDataBase usePropInBag, int excRate)
	{
		base.parent = parent;
		confirmCmd = new SimpleCommand(Confirm);
		fixSliderRequest = new InteractionRequest<float>();
		this.excRate = excRate;
		this.targetProp = targetProp;
		this.usePropInBag = usePropInBag;
		needFix = true;
		Refresh();
	}

	public PropExcViewModel(OptionBase parent, PropDataBase targetProp, int fixNeedCount, PropDataBase usePropInBag, int targetCount)
	{
		base.parent = parent;
		confirmCmd = new SimpleCommand(Confirm);
		fixSliderRequest = new InteractionRequest<float>();
		this.targetProp = targetProp;
		this.usePropInBag = usePropInBag;
		isFixChange = true;
		UseCount = targetCount;
		UseCountMax = targetCount;
		PropCountNeed = fixNeedCount * targetCount;
	}

	public void TrySetUseCount(int targetCount)
	{
		needFix = false;
		if (targetCount > UseCountMax)
		{
			SetUseCount(UseCountMax);
		}
		else if (targetCount < 0)
		{
			SetUseCount(0);
		}
		else
		{
			SetUseCount(targetCount);
		}
	}

	protected virtual void Refresh()
	{
		RefreshProp();
		SetCurSelected();
	}

	protected void RefreshProp()
	{
		int id = UsePropInBag.Id;
		int propType = UsePropInBag.PropType;
		if (Enum.IsDefined(typeof(RoleMoneyEnum), id))
		{
			UsePropInBag.Amount = (int)MoneyDefinition.GetMoneyCount((RoleMoneyEnum)id);
			return;
		}
		UsePropInBag = Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>().GetKnapsackViewModel().GetProp(id);
		UsePropInBag = UsePropInBag ?? PropDataBase.CreateByType(propType, id, 0);
	}

	protected virtual void SetCurSelected()
	{
		CalItemCountRange();
		UseFillAmount = CalUseFillAmount(1);
		fixSliderRequest.Raise(UseFillAmount);
	}

	protected void CalItemCountRange()
	{
		if (usePropInBag.Amount == 0)
		{
			UseCountMax = 0;
		}
		else if (excRate != 0)
		{
			UseCountMax = ((UsePropInBag.Amount / excRate == 0) ? 1 : (UsePropInBag.Amount / excRate));
		}
		else
		{
			Toast.ShowError("兑换比例为0");
		}
	}

	protected virtual float CalUseFillAmount(int useCount)
	{
		UseCount = ((useCount <= 0) ? 1 : useCount);
		CanDec = UseCount > 1 && UseCountMax != 0;
		CanAdd = UseCount < UseCountMax;
		if (useCountMax != 0)
		{
			return (float)useCount * 1f / (float)useCountMax;
		}
		return 1f;
	}

	protected virtual void SetUseCount(int useCount)
	{
		UseCount = ((useCount <= 0) ? 1 : useCount);
		CanDec = UseCount > 1 && UseCountMax != 0;
		CanAdd = UseCount < UseCountMax;
		UseFillAmount = CalUseFillAmount(UseCount);
		fixSliderRequest.Raise(UseFillAmount);
		PropCountNeed = UseCount * excRate;
	}

	protected virtual void SetFillAmount(int amout)
	{
		UseCount = ((amout <= 0) ? 1 : amout);
		CanDec = UseCount > 1 && UseCountMax != 0;
		CanAdd = UseCount < UseCountMax;
		PropCountNeed = UseCount * excRate;
	}

	private async void Confirm()
	{
		confirmCmd.Enabled = false;
		await SendExc();
		confirmCmd.Enabled = true;
		Refresh();
	}

	private async Task SendExc()
	{
		Loading loading = await Loading.Show();
		PropGetViewModel propGetViewModel = await Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>().SendCurrencyExchange(UsePropInBag.Id, TargetProp.Id, UseCount);
		loading.Dispose();
		if (propGetViewModel != null)
		{
			propGetViewModel.SetParent(this);
			Refresh();
			openWindowRequest.Raise(new OpenViewArg(typeof(PropGetWindow), propGetViewModel));
		}
		else
		{
			Toast.ShowInfo("兑换" + TargetProp.Name + "失败");
		}
		Close();
	}

	public virtual void AddProp()
	{
		if (UseCount < UseCountMax || UseCountMax == 0)
		{
			int num = UseCount + 1;
			needFix = false;
			SetUseCount(num);
		}
	}

	public virtual void DecProp()
	{
		if (UseCount > 1)
		{
			int num = UseCount - 1;
			needFix = false;
			SetUseCount(num);
		}
	}

	protected virtual void SetText()
	{
	}
}
