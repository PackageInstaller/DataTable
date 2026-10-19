using System.Collections.Generic;

namespace ACT.Model;

public class BottleMaterialSlot
{
	public List<BottleMatType> types { get; }

	public SlotState curState { get; private set; }

	public int matId { get; private set; }

	public BottleMaterialSlot(int[] typeArray)
	{
		matId = -1;
		types = new List<BottleMatType>();
		foreach (int item in typeArray)
		{
			types.Add((BottleMatType)item);
		}
		curState = SlotState.IsLock;
	}

	public void ChangeSlotState(SlotState state)
	{
		curState = state;
	}

	public void FillMaterial(int target)
	{
		matId = target;
	}
}
