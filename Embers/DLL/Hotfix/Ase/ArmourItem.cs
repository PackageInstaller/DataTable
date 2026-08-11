using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class ArmourItem : KnapsackItemNew
{
	private ArmourItemData viewModel;

	[SerializeField]
	private GameObject lockObj;

	[SerializeField]
	private Image lockFrame;

	[SerializeField]
	private Image lockBg;

	[SerializeField]
	private Image entryIcon;

	[SerializeField]
	private GameObject entryIconObj;

	[SerializeField]
	private GameObject currentPresetSlotObj;

	public void Init(ArmourItemData viewModel)
	{
		this.viewModel = viewModel;
		Init((KnapsackItemViewModel)this.viewModel);
		BindingSet<ArmourItem, ArmourItemData> bindingSet = this.CreateBindingSet(this.viewModel);
		if (lockObj != null)
		{
			bindingSet.Bind(lockObj).For((GameObject v) => v.activeSelf).To((ArmourItemData vm) => vm.Data.IsLock);
		}
		if (entryIcon != null)
		{
			bindingSet.Bind(entryIcon).For((Image v) => v.sprite).To((ArmourItemData vm) => vm.EntryIconPath)
				.WithConversion("ItemIcon");
		}
		if (entryIconObj != null)
		{
			bindingSet.Bind(entryIconObj).For((GameObject v) => v.activeSelf).ToExpression((ArmourItemData vm) => (int)vm.Data.EquipmentEnum == 16);
		}
		if (currentPresetSlotObj != null)
		{
			bindingSet.Bind(currentPresetSlotObj).For((GameObject v) => v.activeSelf).To((ArmourItemData vm) => vm.IsInCurrentPresetSlot);
		}
		bindingSet.Build();
	}

	public void RefreshData(ArmourItemData viewModel)
	{
		this.viewModel = viewModel;
		base.RefreshData(viewModel);
		this.SetDataContext(viewModel);
	}
}
