using System.Collections.Generic;

namespace Ase;

public class HomeComeTaskProgressData
{
	public int Id { get; private set; }

	public int Progress { get; private set; }

	public int TargetValue { get; private set; }

	public int State { get; private set; }

	public void Update(PbHomeComeTaskProgress pbData)
	{
		if (pbData != null)
		{
			Id = pbData.Id;
			Progress = pbData.Progress;
			TargetValue = pbData.TargetValue;
			State = pbData.State;
		}
	}

	public bool CanClaim(HashSet<int> claimedTaskIds)
	{
		if (State == 1)
		{
			if (claimedTaskIds != null)
			{
				return !claimedTaskIds.Contains(Id);
			}
			return true;
		}
		return false;
	}
}
