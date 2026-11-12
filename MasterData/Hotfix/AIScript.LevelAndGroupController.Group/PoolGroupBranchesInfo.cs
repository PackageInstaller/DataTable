using System.Collections.Generic;

namespace AIScript.LevelAndGroupController.Group;

public class PoolGroupBranchesInfo
{
	public int index;

	public List<PoolGroupBranchInfo> braches;

	public void ResetBranchCdExpireTime()
	{
		if (braches == null || braches.Count <= 0)
		{
			return;
		}
		foreach (PoolGroupBranchInfo brach in braches)
		{
			brach.ResetBranchCdExpireTime();
		}
	}
}
