using System.Collections.Generic;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class MoneyViewModel : OptionBase
{
	private bool openPropPopupWindowEnable = true;

	private SimpleCommand<RoleMoneyEnum> onAddBtnClickCmd;

	private SimpleCommand<MoneyUIConfig> onCustomGetBtnClickCmd;

	private InteractionRequest<KeyValuePair<RoleMoneyEnum, Vector3>> openPropPopupRst = new InteractionRequest<KeyValuePair<RoleMoneyEnum, Vector3>>();

	public InteractionRequest<KeyValuePair<RoleMoneyEnum, Vector3>> OpenPropPopupRst => openPropPopupRst;

	public MoneyViewModel()
	{
	}

	public MoneyViewModel(OptionBase parent)
	{
		base.parent = parent;
		onAddBtnClickCmd = new SimpleCommand<RoleMoneyEnum>(OnAddBtnClick);
		onCustomGetBtnClickCmd = new SimpleCommand<MoneyUIConfig>(OnCustomGetBtnClick);
	}

	public override void ItemOnClick(object obj)
	{
		base.ItemOnClick(obj);
		if (!(obj is OptionArg { Obj: var obj2 } optionArg))
		{
			return;
		}
		if (obj2 is RoleMoneyEnum roleMoneyEnum)
		{
			if (optionArg.OptionName == "OnGetBtnClick")
			{
				onAddBtnClickCmd.Execute(roleMoneyEnum);
			}
		}
		else if (optionArg.Obj is MoneyUIConfig parameter)
		{
			onCustomGetBtnClickCmd.Execute(parameter);
		}
		else if (optionArg.Obj is KeyValuePair<RoleMoneyEnum, Vector3> context && optionArg.OptionName == "OnIconBtnClick" && openPropPopupWindowEnable)
		{
			openPropPopupRst.Raise(context);
		}
	}

	private async void OnCustomGetBtnClick(MoneyUIConfig uiConfig)
	{
		onCustomGetBtnClickCmd.Enabled = false;
		OptionBase optionBase = parent.Parent ?? parent;
		OpenViewArg openViewArg = await new UIJumpHelper().CreateViewJumpData(uiConfig.GetJumpWindowConfig.ConvertToParams(), optionBase, "MoneyView", delegate
		{
			onCustomGetBtnClickCmd.Enabled = true;
		});
		if (openViewArg == null)
		{
			onCustomGetBtnClickCmd.Enabled = true;
		}
		else if (parent?.Parent == null)
		{
			openWindowRequest.Raise(openViewArg);
		}
		else
		{
			parent.ItemOnClick(openViewArg);
		}
	}

	private void OnAddBtnClick(RoleMoneyEnum moneyEnum)
	{
		switch (moneyEnum)
		{
		case RoleMoneyEnum.Energy:
			OpenAddEnergyView();
			break;
		case RoleMoneyEnum.SoulCrystal:
			OpenSoulCrystalView();
			break;
		case RoleMoneyEnum.RedSoulCrystal:
			OpenRedSoulCrystalView();
			break;
		case RoleMoneyEnum.Diamond:
			OpenDiamondView();
			break;
		case RoleMoneyEnum.ArmourAffixRefresh:
			OpenArmourAffixRefreshExc();
			break;
		}
	}

	private async void OpenAddEnergyView()
	{
		onAddBtnClickCmd.Enabled = false;
		await Singleton<ServiceSystem>.Instance.GetService<IRoleService>().UpdateAccountLimit();
		EnergyExcViewModel userData = new EnergyExcViewModel();
		parent.ItemOnClick(new OpenViewArg(typeof(EnergyExcWindow), userData, delegate
		{
			onAddBtnClickCmd.Enabled = true;
		}));
	}

	private void OpenSoulCrystalView()
	{
		onAddBtnClickCmd.Enabled = false;
		PropDataBase targetProp = PropDataBase.CreateByType(1, 9410400);
		PropDataBase usePropInBag = PropDataBase.CreateByType(3, 9002);
		float num = Singleton<OuterSystem>.Instance.GetConstantConfigInt(Constant.ConstantConfig.RatioDiamond2NormalDraw, 160);
		PropExcViewModel userData = new PropExcViewModel(this, targetProp, usePropInBag, (int)num);
		OpenWindow(new OpenViewArg(typeof(PropExcView), userData, delegate
		{
			onAddBtnClickCmd.Enabled = true;
		}));
	}

	private void OpenRedSoulCrystalView()
	{
		onAddBtnClickCmd.Enabled = false;
		PropDataBase targetProp = PropDataBase.CreateByType(1, 9410401);
		PropDataBase usePropInBag = PropDataBase.CreateByType(3, 9002);
		float num = Singleton<OuterSystem>.Instance.GetConstantConfigInt(Constant.ConstantConfig.RatioDiamond2LimitDraw, 160);
		PropExcViewModel userData = new PropExcViewModel(this, targetProp, usePropInBag, (int)num);
		OpenWindow(new OpenViewArg(typeof(PropExcView), userData, delegate
		{
			onAddBtnClickCmd.Enabled = true;
		}));
	}

	private void OpenDiamondView()
	{
		onAddBtnClickCmd.Enabled = false;
		PropDataBase targetProp = PropDataBase.CreateByType(3, 9002);
		PropDataBase usePropInBag = PropDataBase.CreateByType(3, 9006);
		float num = Singleton<OuterSystem>.Instance.GetConstantConfigInt(Constant.ConstantConfig.RatioMoney2Diamond, 1);
		PropExcViewModel userData = new PropExcViewModel(this, targetProp, usePropInBag, (int)num);
		OpenWindow(new OpenViewArg(typeof(PropExcView), userData, delegate
		{
			onAddBtnClickCmd.Enabled = true;
		}));
	}

	private void OpenArmourAffixRefreshExc()
	{
		onAddBtnClickCmd.Enabled = false;
		int num = (int)(GameEntry.DataTable.GetDataRow<DRConstantConfig>(1037)?.Value ?? 0f);
		DRProp dataRow = GameEntry.DataTable.GetDataRow<DRProp>(num);
		if (dataRow == null)
		{
			onAddBtnClickCmd.Enabled = true;
			return;
		}
		(int, int) target = (num, dataRow.EX1);
		List<(int, int)> list = new List<(int, int)>();
		DRProp[] dataRows = GameEntry.DataTable.GetDataRows((DRProp p) => p.UseType.Contains(2));
		foreach (DRProp dRProp in dataRows)
		{
			list.Add((dRProp.Id, dRProp.EX1));
		}
		PropExcUseExpViewModel propExcUseExpViewModel = new PropExcUseExpViewModel(parent, target, list);
		propExcUseExpViewModel.SetTips1("兑换所需明饰经验道具");
		OpenPropExcUseExpWindow(propExcUseExpViewModel);
	}

	private void OpenPropExcUseExpWindow(PropExcUseExpViewModel vm)
	{
		OpenWindow(new OpenViewArg(typeof(PropExcUseExpWindow), vm, delegate
		{
			onAddBtnClickCmd.Enabled = true;
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
			bool cacheRoom = GetCacheRoom();
			PropWindowViewModel propWindowViewModel = new PropWindowViewModel(parent, cacheRoom);
			propWindowViewModel.RefreshData(new PropData(drProp));
			propWindowViewModel.SetPosition(pos);
			propWindowViewModel.SetRectInfo(new Vector2(0.5f, 0.5f), new Vector2(0.5f, 0.5f), zero);
			OpenWindow(new OpenViewArg(typeof(PropPopupWindow), propWindowViewModel, "MoneyView", isOpenWindow: true, "DEFAULT", delegate
			{
				openPropPopupWindowEnable = true;
			}));
		}
	}

	private bool GetCacheRoom()
	{
		List<object> cachedVm = UIWindowHelper.GetCachedVm();
		if (cachedVm == null || cachedVm.Count == 0)
		{
			return false;
		}
		if (cachedVm != null)
		{
			foreach (object item in cachedVm)
			{
				if (item.GetType().Equals(typeof(MultiRoomViewModel)))
				{
					return false;
				}
			}
		}
		return true;
	}

	private void OpenWindow(OpenViewArg arg)
	{
		if (parent?.Parent == null)
		{
			openWindowRequest.Raise(arg);
		}
		else
		{
			parent.ItemOnClick(arg);
		}
	}
}
