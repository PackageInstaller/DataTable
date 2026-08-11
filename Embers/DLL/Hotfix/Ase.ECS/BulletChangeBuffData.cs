using System.Collections.Generic;

namespace Ase.ECS;

public class BulletChangeBuffData
{
	public int entityId;

	public BulletModifyEnum modifyEnum;

	public ChangeType changeType;

	public int bulletId;

	public string bulletLabel;

	public List<int> buffList;

	public List<int> targetList;

	public bool IsVaild()
	{
		if (buffList != null && targetList != null && buffList.Count == targetList.Count)
		{
			if (changeType != ChangeType.Add)
			{
				return changeType != ChangeType.Dec;
			}
			return false;
		}
		return true;
	}
}
