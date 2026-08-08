using System;
using System.Collections.Generic;
using UnityEngine;

namespace ControllerExSpace;

[Serializable]
public class ControllerEx
{
	public string _name;

	[HideInInspector]
	public int selectedIndex;

	[HideInInspector]
	public int defaultIndex;

	public List<Property> properties = new List<Property>();

	public List<ControllerState> states = new List<ControllerState>();

	public List<TweenParams> tweens = new List<TweenParams>();

	public List<ControllerRootParams> controllers = new List<ControllerRootParams>();

	private Dictionary<int, Dictionary<GearType, TweenParams>> propertyTweenDict;

	private bool isInit;

	public ControllerEx(string name)
	{
		_name = name;
	}

	public static bool CheckGaearStatus(uint _tags, GearType type)
	{
		return (_tags & (uint)type) == (uint)type;
	}

	public static uint SetGearStatus(uint _tags, GearType type, bool value)
	{
		if (value)
		{
			return _tags | (uint)type;
		}
		return _tags & (uint)(~type);
	}

	public void AddProperty()
	{
		properties.Add(new Property());
	}

	public void RemoveProperty()
	{
		if (properties.Count != 0)
		{
			int index = properties.Count - 1;
			RemoveProperty(index);
		}
	}

	public void RemoveProperty(int index)
	{
		int count = properties.Count;
		if (index >= count)
		{
			return;
		}
		foreach (ControllerState state in states)
		{
			state.RemoveGameObject(properties[index].gameObject);
		}
		Dictionary<int, int> dictionary = new Dictionary<int, int>();
		for (int i = 0; i < properties.Count; i++)
		{
			if (properties[i].gameObject != null)
			{
				dictionary.Add(properties[i].gameObject.GetInstanceID(), i);
			}
		}
		properties.RemoveAt(index);
		Dictionary<int, int> dictionary2 = new Dictionary<int, int>();
		for (int j = 0; j < properties.Count; j++)
		{
			if (properties[j].gameObject != null)
			{
				if (dictionary.ContainsKey(properties[j].gameObject.GetInstanceID()))
				{
					dictionary2.Add(dictionary[properties[j].gameObject.GetInstanceID()], j);
				}
				else
				{
					dictionary2.Add(j, j);
				}
			}
		}
		RebuildTween(dictionary2);
		RebuildController(dictionary2);
	}

	public void SetPropertyGameObject(Property property, GameObject gameObject)
	{
		GameObject gameObject2 = property.gameObject;
		if (null == gameObject)
		{
			property.gameObject = null;
			property.tags = 0u;
		}
		else
		{
			property.gameObject = gameObject;
		}
		foreach (ControllerState state in states)
		{
			state.SetGameObject(gameObject2, property);
		}
	}

	public void SetPropertyTags(Property property, uint tags)
	{
		property.tags = tags;
		foreach (ControllerState state in states)
		{
			state.SetTags(property);
		}
	}

	public int GetDefaultIndex()
	{
		if (defaultIndex == -1)
		{
			defaultIndex = selectedIndex;
			return selectedIndex;
		}
		return defaultIndex;
	}

	public string GetSelectedState()
	{
		if (0 <= selectedIndex && states.Count > selectedIndex)
		{
			return states[selectedIndex].stateName;
		}
		return "none";
	}

	public int GetSelectedIndex()
	{
		return selectedIndex;
	}

	public void SetSelectedIndex(int newIndex, bool immediately = false)
	{
		if (newIndex >= states.Count)
		{
			Debug.LogWarning($"控制器{_name}的状态总共有{states.Count}个，但是传来的index = {newIndex}，设置index = {states.Count - 1}");
			newIndex = states.Count - 1;
		}
		if (newIndex < 0)
		{
			newIndex = 0;
		}
		if (selectedIndex != newIndex || !isInit)
		{
			selectedIndex = newIndex;
			isInit = true;
			states[selectedIndex].ApplyState(immediately, GetPropertyTweenDict());
		}
	}

	public void SetSelectedState(string value, bool immediately = false)
	{
		for (int i = 0; i < states.Count; i++)
		{
			if (value == states[i].stateName)
			{
				SetSelectedIndex(i, immediately);
				return;
			}
		}
		SetSelectedIndex(0);
	}

	public void AddState()
	{
		ControllerState controllerState = new ControllerState("state" + states.Count);
		controllerState.UpdateState(properties, controllers);
		states.Add(controllerState);
	}

	public void RemoveState(int index)
	{
		int count = states.Count;
		if (index < count)
		{
			states.RemoveAt(index);
		}
	}

	public Dictionary<int, Dictionary<GearType, TweenParams>> GetPropertyTweenDict()
	{
		if (tweens == null || tweens.Count == 0)
		{
			return null;
		}
		if (propertyTweenDict == null)
		{
			propertyTweenDict = new Dictionary<int, Dictionary<GearType, TweenParams>>();
			for (int i = 0; i < tweens.Count; i++)
			{
				if (!propertyTweenDict.ContainsKey(tweens[i].propertyIndex))
				{
					propertyTweenDict.Add(tweens[i].propertyIndex, new Dictionary<GearType, TweenParams>());
				}
				propertyTweenDict[tweens[i].propertyIndex][tweens[i].type] = tweens[i];
			}
		}
		return propertyTweenDict;
	}

	private void RebuildTween(Dictionary<int, int> oldNewIdxMap)
	{
		if (tweens == null || tweens.Count == 0)
		{
			return;
		}
		tweens.RemoveAll((TweenParams item) => !oldNewIdxMap.ContainsKey(item.propertyIndex));
		for (int num = 0; num < tweens.Count; num++)
		{
			if (oldNewIdxMap.ContainsKey(tweens[num].propertyIndex))
			{
				TweenParams value = tweens[num];
				value.propertyIndex = oldNewIdxMap[tweens[num].propertyIndex];
				tweens[num] = value;
			}
		}
	}

	public bool HasTween(int propertyIndex, GearType type, out TweenParams tween)
	{
		tween = default(TweenParams);
		if (tweens == null)
		{
			return false;
		}
		for (int i = 0; i < tweens.Count; i++)
		{
			if (tweens[i].type == type && tweens[i].propertyIndex == propertyIndex)
			{
				tween = tweens[i];
				return true;
			}
		}
		return false;
	}

	public void AddTween(int propertyIndex, GearType type, bool isTween, float during, LeanTweenType ease)
	{
		if (tweens == null)
		{
			if (isTween)
			{
				tweens = new List<TweenParams>();
				tweens.Add(new TweenParams
				{
					propertyIndex = propertyIndex,
					duration = during,
					ease = ease,
					type = type,
					runtimeTweenId = -1
				});
			}
			return;
		}
		if (isTween)
		{
			for (int i = 0; i < tweens.Count; i++)
			{
				if (tweens[i].type == type && tweens[i].propertyIndex == propertyIndex)
				{
					tweens[i] = new TweenParams
					{
						propertyIndex = propertyIndex,
						duration = during,
						ease = ease,
						type = type,
						runtimeTweenId = -1
					};
					return;
				}
			}
			tweens.Add(new TweenParams
			{
				propertyIndex = propertyIndex,
				duration = during,
				ease = ease,
				type = type,
				runtimeTweenId = -1
			});
			return;
		}
		int num = -1;
		for (int j = 0; j < tweens.Count; j++)
		{
			if (tweens[j].type == type && tweens[j].propertyIndex == propertyIndex)
			{
				num = j;
				break;
			}
		}
		if (num != -1)
		{
			tweens.RemoveAt(num);
		}
		if (tweens.Count == 0)
		{
			tweens = null;
		}
	}

	public void RebuildController(Dictionary<int, int> oldNewIdxMap)
	{
		if (controllers == null || controllers.Count == 0)
		{
			return;
		}
		controllers.RemoveAll((ControllerRootParams item) => !oldNewIdxMap.ContainsKey(item.propertyIndex));
		for (int num = 0; num < controllers.Count; num++)
		{
			if (oldNewIdxMap.ContainsKey(controllers[num].propertyIndex))
			{
				ControllerRootParams value = controllers[num];
				value.propertyIndex = oldNewIdxMap[controllers[num].propertyIndex];
				controllers[num] = value;
			}
		}
	}

	public bool HasController(int propertyIndex, out int index)
	{
		index = -1;
		if (controllers == null)
		{
			return false;
		}
		for (int i = 0; i < controllers.Count; i++)
		{
			if (controllers[i].propertyIndex == propertyIndex)
			{
				index = i;
				return true;
			}
		}
		return false;
	}

	public bool AddController(int propertyIndex, out int index)
	{
		index = -1;
		if (controllers == null)
		{
			return false;
		}
		controllers.Add(new ControllerRootParams
		{
			propertyIndex = propertyIndex,
			param = new List<ControllerParams>()
		});
		index = controllers.Count - 1;
		return true;
	}
}
