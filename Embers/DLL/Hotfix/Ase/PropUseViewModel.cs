using System;
using GameFramework.Runtime;

namespace Ase;

public class PropUseViewModel : OptionBase
{
	private SimpleCommand confirmCmd;

	private InteractionRequest<float> fixSliderRequest;

	private PropDataBase usePropInBag;

	private PropDataBase targetProp;

	private int propCountNeed;

	private int useCount;

	private int useCountMax;

	private int excRate;

	private bool canAdd;

	private bool canDec;

	private float useFillAmount;

	private bool needFix;

	private string showName;

	private string showStatus;

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

	public int PropCountNeed
	{
		get
		{
			return propCountNeed;
		}
		private set
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

	public PropUseViewModel()
	{
	}

	public PropUseViewModel(OptionBase parent, PropDataBase targetProp, PropDataBase usePropInBag, int excRate)
	{
		base.parent = parent;
		confirmCmd = new SimpleCommand(Confirm);
		fixSliderRequest = new InteractionRequest<float>();
		this.targetProp = targetProp;
		this.usePropInBag = usePropInBag;
		this.excRate = excRate;
		needFix = true;
		Refresh();
	}

	private void Refresh()
	{
		RefreshProp();
		SetCurSelected();
	}

	private void RefreshProp()
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

	private void SetCurSelected()
	{
		CalItemCountRange();
		UseFillAmount = CalUseFillAmount(1);
		fixSliderRequest.Raise(UseFillAmount);
	}

	private void CalItemCountRange()
	{
		if (UsePropInBag.Id == 9420301)
		{
			int num = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().GetMoneyData()
				.GetLeftEnergyAdd() / excRate;
			UseCountMax = ((num > usePropInBag.Amount) ? usePropInBag.Amount : num);
		}
		else
		{
			UseCountMax = UsePropInBag.Amount;
		}
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
		SendExc();
	}

	private async void SendExc()
	{
		if (UsePropInBag.Amount == 0)
		{
			Toast.ShowInfo(UsePropInBag.Name + "数量不足");
			confirmCmd.Enabled = true;
			return;
		}
		if (!Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().GetMoneyData()
			.CheckAddEnergy(excRate * UseCount))
		{
			Toast.ShowInfo("可燃魂数量已达上限");
			confirmCmd.Enabled = true;
			return;
		}
		Loading loading = await Loading.Show();
		RecoverUserVitRequest recoverUserVitRequest = RecoverUserVitRequest.Create();
		recoverUserVitRequest.Typ = 2;
		recoverUserVitRequest.Id = UsePropInBag.Id;
		recoverUserVitRequest.UseCount = useCount;
		RecoverUserVitResponse recoverUserVitResponse = await Singleton<NetworkSystem>.Instance.Call<RecoverUserVitResponse>(recoverUserVitRequest);
		loading.Dispose();
		if (Singleton<NetResponseHandler>.Instance.ValidateResponse(recoverUserVitResponse, "可燃魂兑换"))
		{
			if (Singleton<NetResponseHandler>.Instance.ValidateErrorCode(recoverUserVitResponse.Error, "可燃魂兑换失败"))
			{
				MoneyDefinition.SetMoney(RoleMoneyEnum.Energy, (int)recoverUserVitResponse.Vit);
				KnapsackPropData propData = KnapsackPropData.Create(usePropInBag.Id, (int)recoverUserVitResponse.ItemChange.ItemDelta);
				Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>().AddProp(propData);
				Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().GetMoneyData()
					.SetAutoAddEnergyLastTime(recoverUserVitResponse.LastVitRecoverTime);
				Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().GetMoneyData()
					.OpenAutoAddEnergy();
				Toast.ShowInfo("兑换可燃魂成功");
				parent?.ItemOnClick(this);
				Close();
			}
			else
			{
				confirmCmd.Enabled = true;
			}
		}
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
