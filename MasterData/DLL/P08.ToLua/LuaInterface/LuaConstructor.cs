using System;
using System.Collections.Generic;
using System.Reflection;

namespace LuaInterface;

public sealed class LuaConstructor
{
	private ConstructorInfo method;

	private List<Type> list;

	[NoToLua]
	public LuaConstructor(ConstructorInfo func, Type[] types)
	{
		method = func;
		if (types != null)
		{
			list = new List<Type>(types);
		}
	}

	public int Call(IntPtr L)
	{
		object[] array = null;
		ToLua.CheckArgsCount(L, list.Count + 1);
		if (list.Count > 0)
		{
			array = new object[list.Count];
			for (int i = 0; i < list.Count; i++)
			{
				Type t = (list[i].IsByRef ? list[i].GetElementType() : list[i]);
				object obj = ToLua.CheckVarObject(L, i + 2, t);
				array[i] = obj;
			}
		}
		object obj2 = method.Invoke(array);
		int num = 1;
		ToLua.Push(L, obj2);
		for (int j = 0; j < list.Count; j++)
		{
			if (list[j].IsByRef)
			{
				num++;
				ToLua.Push(L, array[j]);
			}
		}
		return num;
	}

	public void Destroy()
	{
		method = null;
		list.Clear();
	}
}
