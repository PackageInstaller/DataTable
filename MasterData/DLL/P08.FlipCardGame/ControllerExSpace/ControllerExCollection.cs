using System.Collections.Generic;
using UnityEngine;

namespace ControllerExSpace;

[DisallowMultipleComponent]
public class ControllerExCollection : MonoBehaviour
{
	public List<ControllerEx> list = new List<ControllerEx>();

	public void Add()
	{
		ControllerEx item = new ControllerEx("default" + list.Count);
		list.Add(item);
	}

	public void Remove(int index)
	{
		if (index < list.Count)
		{
			list.RemoveAt(index);
		}
	}

	public ControllerEx GetController(string name)
	{
		foreach (ControllerEx item in list)
		{
			if (name == item._name)
			{
				return item;
			}
		}
		return null;
	}
}
