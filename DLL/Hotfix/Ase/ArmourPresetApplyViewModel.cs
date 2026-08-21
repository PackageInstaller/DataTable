using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class ArmourPresetApplyViewModel : OptionBase
{
	private InteractionRequest refreshRequest;

	private readonly List<ArmourPresetConflictItemData> conflictItems = new List<ArmourPresetConflictItemData>();

	private int roleId;

	private int slotId;

	public List<ArmourPresetConflictItemData> ConflictItems => conflictItems;

	public InteractionRequest RefreshRequest => refreshRequest;

	public ArmourPresetApplyViewModel()
	{
		refreshRequest = new InteractionRequest();
	}

	public ArmourPresetApplyViewModel(OptionBase parent, int roleId, int slotId, List<ArmourPresetConflictData> conflicts)
		: this()
	{
		base.parent = parent;
		this.roleId = roleId;
		this.slotId = slotId;
		if (conflicts != null)
		{
			for (int i = 0; i < conflicts.Count; i++)
			{
				conflictItems.Add(new ArmourPresetConflictItemData(this, conflicts[i]));
			}
		}
	}

	public override void Close()
	{
		if (parent is ArmourPresetWindowViewModel armourPresetWindowViewModel)
		{
			armourPresetWindowViewModel.CloseApplyView();
		}
	}

	public void ConfirmApply()
	{
		ApplyPreset();
	}

	protected virtual async void ApplyPreset(bool forceApply = true)
	{
		Loading loading = await Loading.Show();
		try
		{
			ArmourPresetApplyResultData armourPresetApplyResultData = await Singleton<ServiceSystem>.Instance.GetService<IEquipmentService>().ApplyPresetEquipment(roleId, slotId, forceApply);
			if (armourPresetApplyResultData != null && !armourPresetApplyResultData.HasConflicts)
			{
				if (parent is ArmourPresetWindowViewModel armourPresetWindowViewModel)
				{
					armourPresetWindowViewModel.OnPresetApplySucceeded();
				}
				else
				{
					Close();
				}
			}
		}
		finally
		{
			loading.Dispose();
		}
	}
}
