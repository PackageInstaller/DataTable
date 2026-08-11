using System.Collections.Generic;

namespace Ase.ECS;

public class BulletChangeTagData
{
	public int entityId;

	public List<int> checkConfigIdList;

	public List<string> checkTagList;

	public ChangeType changeType;

	public List<string> modifyTagList;

	public bool Contains(BulletChangeTagData other)
	{
		if (other == null || other.IsVaild() || IsVaild())
		{
			return false;
		}
		if (entityId == other.entityId && checkConfigIdList.IsEqualIgnoreOrder(other.checkConfigIdList) && checkTagList.IsEqualIgnoreOrder(other.checkTagList) && changeType == other.changeType)
		{
			return modifyTagList.IsEqualIgnoreOrder(other.modifyTagList);
		}
		return false;
	}

	public bool IsVaild()
	{
		if (!checkTagList.IsNullOrEmpty() && !checkTagList.IsNullOrEmpty())
		{
			return modifyTagList.IsNullOrEmpty();
		}
		return true;
	}
}
