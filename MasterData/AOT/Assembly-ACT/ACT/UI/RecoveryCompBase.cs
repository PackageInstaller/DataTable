using System.Collections.Generic;
using ACT.Core;
using ACT.UI.DataProxy;
using ACT.Utility;
using Fundamental;

namespace ACT.UI;

public abstract class RecoveryCompBase : BaseUIComponent
{
	public ActButton RecoveryBtn;

	public CommonNumberComponent SelectNumber;

	protected MonoInventoryView monoInventoryView;

	protected List<ItemUnifierProxy> unifierProxies = new List<ItemUnifierProxy>();

	public virtual void Init(MonoInventoryView monoInventoryView)
	{
		this.monoInventoryView = monoInventoryView;
		RecoveryBtn.SetBtnClick(OnClickRecoveryBtnHandle);
		RefreshSelectCount(0);
	}

	protected virtual void OnClickRecoveryBtnHandle()
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_RECOVERYITEM, new RecoveryItemViewData
		{
			RecoveryItems = unifierProxies,
			OnRecovery = OnRecovery
		});
	}

	public virtual void RefreshSelectCount(int number)
	{
		SelectNumber.UpdateNumber(number, RuntimeConfigs.data.game.BagRecycleLimit);
		RecoveryBtn.interactable = number > 0;
	}

	public virtual void OnRecoveryItemChange(List<ItemUnifierProxy> items)
	{
		unifierProxies = items;
		RefreshSelectCount(items.Count);
	}

	protected virtual void OnRecovery()
	{
		unifierProxies.Clear();
		RefreshSelectCount(0);
		monoInventoryView.OnRecovery();
	}

	public virtual void Show()
	{
		gameObject.SetActive(value: true);
	}

	public virtual void Hide()
	{
		gameObject.SetActive(value: false);
	}
}
