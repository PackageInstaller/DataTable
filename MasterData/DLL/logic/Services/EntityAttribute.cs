using System.Collections.Generic;

namespace Services;

public class EntityAttribute
{
	private Dictionary<int, EntityAttributeStruct> attr = new Dictionary<int, EntityAttributeStruct>(new IntComparer());

	private HashSet<int> mDirtyAttributes = new HashSet<int>();

	private int mID;

	public EntityAttribute(int id)
	{
		mID = id;
	}

	public Dictionary<int, EntityAttributeStruct> GetAttr()
	{
		return attr;
	}

	public bool GetAttributeWithIntName(int varName, out long baseValue, out long plusValue, out long tempPlusValue)
	{
		baseValue = 0L;
		plusValue = 0L;
		tempPlusValue = 0L;
		if (attr == null || !attr.TryGetValue(varName, out var value))
		{
			return false;
		}
		baseValue = value.baseValue;
		plusValue = value.plusValue;
		tempPlusValue = value.tempPlusValue;
		baseValue ^= mID;
		plusValue ^= mID;
		tempPlusValue ^= mID;
		return true;
	}

	public void SetAttributeWithIntName(int varName, long baseValue, long plusValue, long factor)
	{
		if (factor != 0L)
		{
			mDirtyAttributes.Add(varName);
		}
		baseValue ^= mID;
		plusValue ^= mID;
		factor ^= mID;
		attr[varName] = new EntityAttributeStruct(baseValue, plusValue, factor);
	}

	public void ResetTempAttributes()
	{
		if (mDirtyAttributes == null)
		{
			return;
		}
		foreach (int mDirtyAttribute in mDirtyAttributes)
		{
			EntityAttributeStruct entityAttributeStruct = attr[mDirtyAttribute];
			attr[mDirtyAttribute] = new EntityAttributeStruct(entityAttributeStruct.baseValue, entityAttributeStruct.plusValue, 0 ^ mID);
		}
		mDirtyAttributes.Clear();
	}
}
