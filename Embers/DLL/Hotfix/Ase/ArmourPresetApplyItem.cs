using UnityEngine;

namespace Ase;

public class ArmourPresetApplyItem : UGuiView
{
	[SerializeField]
	private ArmourItem armourItem;

	[SerializeField]
	private EquipWearerItem wearerItem;

	private ArmourPresetConflictItemData viewModel;

	public void Init(ArmourPresetConflictItemData viewModel)
	{
		this.viewModel = viewModel;
		if (armourItem != null && viewModel?.ArmourItemData != null)
		{
			armourItem.Init(viewModel.ArmourItemData);
		}
		if (wearerItem != null && viewModel?.WearerItemData != null)
		{
			wearerItem.Init(viewModel.WearerItemData);
		}
	}

	public void RefreshData(ArmourPresetConflictItemData viewModel)
	{
		this.viewModel = viewModel;
		if (armourItem != null && viewModel?.ArmourItemData != null)
		{
			armourItem.RefreshData(viewModel.ArmourItemData);
		}
		if (wearerItem != null && viewModel?.WearerItemData != null)
		{
			wearerItem.RefreshData(viewModel.WearerItemData);
		}
	}
}
