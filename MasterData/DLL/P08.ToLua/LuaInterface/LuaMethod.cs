using System;
using System.Collections.Generic;
using System.Reflection;

namespace LuaInterface;

public sealed class LuaMethod
{
	private MethodInfo method;

	private List<Type> list = new List<Type>();

	private Type kclass;

	[NoToLua]
	public LuaMethod(MethodInfo md, Type t, Type[] types)
	{
		method = md;
		kclass = t;
		if (types != null)
		{
			list.AddRange(types);
		}
	}

	public int Call(IntPtr L)
	{
		object[] array = null;
		object obj = null;
		int num = 1;
		if (!method.IsStatic)
		{
			num++;
			obj = ToLua.CheckObject(L, 2, kclass);
		}
		ToLua.CheckArgsCount(L, list.Count + num);
		if (list.Count > 0)
		{
			array = new object[list.Count];
			num++;
			for (int i = 0; i < list.Count; i++)
			{
				Type t = (list[i].IsByRef ? list[i].GetElementType() : list[i]);
				object obj2 = ToLua.CheckVarObject(L, i + num, t);
				array[i] = obj2;
			}
		}
		object obj3 = method.Invoke(obj, array);
		int num2 = 0;
		if (method.ReturnType != typeof(void))
		{
			num2++;
			ToLua.Push(L, obj3);
		}
		for (int j = 0; j < list.Count; j++)
		{
			if (list[j].IsByRef)
			{
				num2++;
				ToLua.Push(L, array[j]);
			}
		}
		return num2;
	}

	public void Destroy()
	{
		method = null;
		list.Clear();
	}
}
