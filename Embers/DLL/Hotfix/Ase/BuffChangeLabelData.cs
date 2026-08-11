using System.Collections.Generic;

namespace Ase;

public class BuffChangeLabelData
{
	public int entityId;

	public List<int> checkConfigIdList;

	public List<string> checkLabelList;

	public ChangeType changeType;

	public List<string> modifyLabelList;

	public bool Contains(BuffChangeLabelData other)
	{
		if (other == null || other.IsVaild() || IsVaild())
		{
			return false;
		}
		if (entityId == other.entityId && IsEqualIgnoreOrder(checkConfigIdList, other.checkConfigIdList) && IsEqualIgnoreOrder(checkLabelList, other.checkLabelList) && changeType == other.changeType)
		{
			return IsEqualIgnoreOrder(modifyLabelList, other.modifyLabelList);
		}
		return false;
	}

	public bool IsVaild()
	{
		if ((!checkConfigIdList.IsNullOrEmpty() || !checkLabelList.IsNullOrEmpty()) && !modifyLabelList.IsNullOrEmpty())
		{
			if (changeType != ChangeType.Add)
			{
				return changeType != ChangeType.Dec;
			}
			return false;
		}
		return true;
	}

	private static bool IsEqualIgnoreOrder<T>(List<T> list1, List<T> list2)
	{
		if (list1.IsNullOrEmpty() && list2.IsNullOrEmpty())
		{
			return true;
		}
		if (list1.IsNullOrEmpty() || list2.IsNullOrEmpty())
		{
			return false;
		}
		return list1.IsEqualIgnoreOrder(list2);
	}
}
