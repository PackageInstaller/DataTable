using System;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using System.Text;
using UnityEngine;

namespace LuaInterface;

public class ObjectTranslator
{
	private class DelayGC
	{
		public int id;

		public UnityEngine.Object obj;

		public float time;

		public DelayGC(int id, UnityEngine.Object obj, float time)
		{
			this.id = id;
			this.time = time;
			this.obj = obj;
		}
	}

	private class CompareObject : IEqualityComparer<object>
	{
		public new bool Equals(object x, object y)
		{
			return x == y;
		}

		public int GetHashCode(object obj)
		{
			return RuntimeHelpers.GetHashCode(obj);
		}
	}

	public readonly Dictionary<object, int> objectsBackMap = new Dictionary<object, int>(257, new CompareObject());

	public readonly LuaObjectPool objects = new LuaObjectPool();

	private List<DelayGC> gcList = new List<DelayGC>();

	private Action<object, int> removeInvalidObject;

	private static ObjectTranslator _translator;

	public bool LogGC { get; set; }

	public StringBuilder LogObjectTranslator()
	{
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.AppendLine("Log ObjectTranslator: ");
		stringBuilder.AppendLine("    GCList: ");
		foreach (DelayGC gc in gcList)
		{
			stringBuilder.AppendLine($"        {gc.obj.name}: 引用次数-{gc.time} ");
		}
		stringBuilder.AppendLine("    End GCList ");
		stringBuilder.AppendLine("    Object: ");
		for (int i = 0; i < 10000 && objects[i] != null; i++)
		{
			stringBuilder.AppendLine($"        {objects[i].ToString()}: 下标-{i}  ");
		}
		stringBuilder.AppendLine("    End Object ");
		return stringBuilder;
	}

	public ObjectTranslator()
	{
		LogGC = false;
		_translator = this;
		removeInvalidObject = RemoveObject;
	}

	public int AddObject(object obj)
	{
		int num = objects.Add(obj);
		if (!TypeChecker.IsValueType(obj.GetType()))
		{
			objectsBackMap[obj] = num;
		}
		return num;
	}

	public static ObjectTranslator Get(IntPtr L)
	{
		return _translator;
	}

	private void RemoveObject(object o, int udata)
	{
		int value = -1;
		if (objectsBackMap.TryGetValue(o, out value) && value == udata)
		{
			objectsBackMap.Remove(o);
		}
	}

	public void RemoveObject(int udata)
	{
		object obj = objects.Remove(udata);
		if (obj != null)
		{
			if (!TypeChecker.IsValueType(obj.GetType()))
			{
				RemoveObject(obj, udata);
			}
			if (LogGC)
			{
				Debugger.Log("gc object {0}, id {1}", obj, udata);
			}
		}
	}

	public object GetObject(int udata)
	{
		return objects.TryGetValue(udata);
	}

	public void Destroy(int udata)
	{
		object obj = objects.Destroy(udata);
		if (obj != null)
		{
			if (!TypeChecker.IsValueType(obj.GetType()))
			{
				RemoveObject(obj, udata);
			}
			if (LogGC)
			{
				Debugger.Log("destroy object {0}, id {1}", obj, udata);
			}
		}
	}

	public void DelayDestroy(int id, float time)
	{
		UnityEngine.Object obj = (UnityEngine.Object)GetObject(id);
		if (obj != null)
		{
			gcList.Add(new DelayGC(id, obj, time));
		}
	}

	public bool Getudata(object o, out int index)
	{
		index = -1;
		return objectsBackMap.TryGetValue(o, out index);
	}

	public void Destroyudata(int udata)
	{
		objects.Destroy(udata);
	}

	public void SetBack(int index, object o)
	{
		objects.Replace(index, o);
	}

	private bool RemoveFromGCList(int id)
	{
		int num = gcList.FindIndex((DelayGC p) => p.id == id);
		if (num >= 0)
		{
			gcList.RemoveAt(num);
			return true;
		}
		return false;
	}

	private void DestroyUnityObject(int udata, UnityEngine.Object obj)
	{
		object obj2 = objects.TryGetValue(udata);
		if (obj2 == obj)
		{
			RemoveObject(obj2, udata);
			objects.Destroy(udata);
			if (LogGC)
			{
				Debugger.Log("destroy object {0}, id {1}", obj2, udata);
			}
		}
		UnityEngine.Object.Destroy(obj);
	}

	public void Collect()
	{
		if (gcList.Count == 0)
		{
			return;
		}
		float deltaTime = Time.deltaTime;
		for (int num = gcList.Count - 1; num >= 0; num--)
		{
			float num2 = gcList[num].time - deltaTime;
			if (num2 <= 0f)
			{
				DestroyUnityObject(gcList[num].id, gcList[num].obj);
				gcList.RemoveAt(num);
			}
			else
			{
				gcList[num].time = num2;
			}
		}
	}

	public void StepCollect()
	{
		objects.StepCollect(removeInvalidObject);
	}

	public void Dispose()
	{
		objectsBackMap.Clear();
		objects.Clear();
		_translator = null;
	}
}
