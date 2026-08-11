using System.Collections.Generic;

namespace Ase.ECS;

public class BulletChangeAdditionData
{
	public int entityId;

	public List<int> checkConfigIdList;

	public List<string> checkTagList;

	public ChangeType changeType;

	public BulletAdditionEnum modifyAdditionEnum;

	public List<float> modifyValues;

	public bool Contains(BulletChangeAdditionData other)
	{
		if (other == null || other.IsVaild() || IsVaild())
		{
			return false;
		}
		if (entityId == other.entityId && checkConfigIdList.IsEqualIgnoreOrder(other.checkConfigIdList) && checkTagList.IsEqualIgnoreOrder(other.checkTagList) && changeType == other.changeType && modifyAdditionEnum == other.modifyAdditionEnum)
		{
			return modifyValues.IsEqualIgnoreOrder(other.modifyValues);
		}
		return false;
	}

	public bool IsVaild()
	{
		if (!checkTagList.IsNullOrEmpty() && !checkTagList.IsNullOrEmpty())
		{
			return modifyValues.IsNullOrEmpty();
		}
		return true;
	}
}
