using System.Collections.Generic;

namespace AIScript;

public class PoolBranchesInfo
{
	public int index;

	public List<PoolBranchInfo> braches;

	public void ResetBranchCdExpireTime()
	{
		if (braches == null || braches.Count <= 0)
		{
			return;
		}
		foreach (PoolBranchInfo brach in braches)
		{
			brach.ResetBranchCdExpireTime();
		}
	}
}
