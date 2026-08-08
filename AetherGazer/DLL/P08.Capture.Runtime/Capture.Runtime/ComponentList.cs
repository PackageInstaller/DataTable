using UnityEngine;

namespace Capture.Runtime;

public class ComponentList<T> where T : struct
{
	private int maxComponentsCount = 100;

	private T[] components;

	private int maxCount;

	private int count;

	public int Count => count;

	public T this[int index]
	{
		get
		{
			if (index < count && index >= 0)
			{
				return components[index];
			}
			Debug.LogError("访问Component越界");
			return default(T);
		}
		set
		{
			if (index < count && index >= 0)
			{
				components[index] = value;
			}
			else
			{
				Debug.LogError("访问Component越界");
			}
		}
	}

	public ComponentList()
	{
		count = 0;
		components = new T[10];
		maxCount = 10;
	}

	public void Add(T value)
	{
		if (count == maxCount)
		{
			EnsureCapacity(count + 1);
		}
		components[count] = value;
		count++;
	}

	private void EnsureCapacity(int min)
	{
		int num = maxCount;
		if (maxCount < min)
		{
			num = Mathf.Clamp(maxCount * 2, 0, maxComponentsCount);
			if (num < min)
			{
				Debug.LogError("最大组件数量过小，无法分配");
				return;
			}
			T[] array = new T[num];
			components.CopyTo(array, 0);
			components = array;
			maxCount = num;
		}
	}
}
