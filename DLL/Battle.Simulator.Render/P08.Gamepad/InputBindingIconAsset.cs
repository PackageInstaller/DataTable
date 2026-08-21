using System;
using System.Collections.Generic;
using UnityEngine;

namespace P08.Gamepad;

public class InputBindingIconAsset : ScriptableObject
{
	[Serializable]
	public struct BindingIcon
	{
		public string name;

		public Sprite icon;
	}

	public List<BindingIcon> bindings;

	private Dictionary<string, Sprite> _bindingMap;

	public Dictionary<string, Sprite> bindingMap
	{
		get
		{
			if (_bindingMap == null)
			{
				Init();
			}
			return _bindingMap;
		}
	}

	public void Init()
	{
		_bindingMap = new Dictionary<string, Sprite>();
		foreach (BindingIcon binding in bindings)
		{
			_bindingMap.Add(binding.name, binding.icon);
		}
	}
}
