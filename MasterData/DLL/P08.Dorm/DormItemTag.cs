using System;
using LuaInterface;
using UnityEngine;

[DisallowMultipleComponent]
[QuickOptions(new string[] { "restaurant.pos.item", "restaurant.pos.static.item" })]
public class DormItemTag : DormTagBase, IEquatable<DormItemTag>
{
	[HideInInspector]
	public int entityID;

	public bool Equals(DormItemTag others)
	{
		if ((object)this == others)
		{
			return true;
		}
		if ((object)this == null || (object)others == null)
		{
			return false;
		}
		return base.transform == others.transform;
	}

	public int GetHashCode(DormItemTag obj)
	{
		if ((object)obj == null || !obj.transform)
		{
			return 0;
		}
		return obj.transform.GetHashCode();
	}

	internal override void Record(int key)
	{
		LuaFunction func = LuaHelper.GetFunc("Dorm.RecordItemTagData");
		func.Call(m_namespace, key, this);
		DormItemSubTagBase[] components = base.transform.GetComponents<DormItemSubTagBase>();
		foreach (DormItemSubTagBase dormItemSubTagBase in components)
		{
			func.Call(dormItemSubTagBase.m_namespace, key, dormItemSubTagBase.Value);
		}
	}
}
