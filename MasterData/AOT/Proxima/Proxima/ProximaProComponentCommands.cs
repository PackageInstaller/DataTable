using System;
using System.Collections.Generic;
using System.Reflection;
using UnityEngine;

namespace Proxima;

internal class ProximaProComponentCommands
{
	[ProximaInitialize]
	public static void Init()
	{
		ProximaComponentCommands.ProHook_CreateComponentButtons = CreateComponentButtons;
	}

	public static void CreateComponentButtons(Component component, ProximaComponentCommands.ComponentInfo ci)
	{
		MethodInfo[] methods = component.GetType().GetMethods(BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic);
		foreach (MethodInfo methodInfo in methods)
		{
			ProximaButtonAttribute customAttribute = methodInfo.GetCustomAttribute<ProximaButtonAttribute>();
			if (customAttribute != null)
			{
				ProximaComponentCommands.ButtonInfo item = new ProximaComponentCommands.ButtonInfo
				{
					Id = Guid.NewGuid().ToString(),
					Text = customAttribute.Text,
					Method = methodInfo
				};
				ci.Btns.Add(item);
			}
		}
	}

	private static bool TryGetPropertyChain(int componentId, string name, out Component component, out Stack<ProximaComponentCommands.PropertyInfo> propertyChain)
	{
		if (!ProximaComponentCommands.IdToComponentInfo.TryGetValue(componentId, out var value))
		{
			Log.Error($"TryGetPropertyChain: Component not found: {componentId}.");
			propertyChain = null;
			component = null;
			return false;
		}
		component = value.Component;
		string[] parts = name.Split('.');
		List<ProximaComponentCommands.PropertyInfo> list = value.Props;
		propertyChain = new Stack<ProximaComponentCommands.PropertyInfo>();
		int i;
		for (i = 0; i < parts.Length; i++)
		{
			ProximaComponentCommands.PropertyInfo propertyInfo = list?.Find((ProximaComponentCommands.PropertyInfo p) => p.Name == parts[i]);
			if (propertyInfo == null)
			{
				Log.Error($"TryGetPropertyChain: Property {name} not found on component {value.Id}.");
				propertyChain = null;
				return false;
			}
			list = propertyInfo.ChildProps;
			propertyChain.Push(propertyInfo);
		}
		return true;
	}

	private static void SetPropertyChain(Component component, Stack<ProximaComponentCommands.PropertyInfo> propertyChain, object value)
	{
		ProximaComponentCommands.PropertyInfo propertyInfo = propertyChain.Pop();
		propertyInfo.Value = value;
		while (propertyChain.Count > 0)
		{
			ProximaComponentCommands.PropertyInfo propertyInfo2 = propertyChain.Pop();
			object value2 = propertyInfo2.Value;
			if (propertyInfo.Setter != null && (propertyInfo.PropertyType.IsArray || propertyInfo.PropertyType.IsValueType || propertyInfo.PropertyType == typeof(string)))
			{
				propertyInfo.Setter(value2, propertyInfo.Value);
			}
			propertyInfo2.Value = value2;
			propertyInfo = propertyInfo2;
		}
		if (propertyInfo.Setter != null && (propertyInfo.PropertyType.IsArray || propertyInfo.PropertyType.IsValueType || propertyInfo.PropertyType == typeof(string)))
		{
			propertyInfo.Setter(component, propertyInfo.Value);
		}
	}

	[ProximaCommand("Internal", "", "", "", "")]
	public static void SetProperty(int componentId, string name, string value)
	{
		if (TryGetPropertyChain(componentId, name, out var component, out var propertyChain))
		{
			ProximaComponentCommands.PropertyInfo propertyInfo = propertyChain.Peek();
			if (!ProximaSerialization.TryDeserialize(propertyInfo.PropertyType, value, out var result))
			{
				Log.Error($"SetProperty: Failed to deserialize {value} to {propertyInfo.PropertyType}.");
			}
			else if (propertyInfo.Setter == null)
			{
				Log.Error($"SetProperty: Property {name} on component {componentId} is not writable.");
			}
			else
			{
				SetPropertyChain(component, propertyChain, result);
			}
		}
	}

	[ProximaCommand("Internal", "", "", "", "")]
	public static void SetArraySize(int componentId, string name, int size)
	{
		if (TryGetPropertyChain(componentId, name, out var component, out var propertyChain))
		{
			ProximaComponentCommands.PropertyInfo propertyInfo = propertyChain.Peek();
			if (propertyInfo.Value == null)
			{
				Log.Error("SetArraySize: Property " + name + " on component " + component.name + " is null.");
			}
			else if (!ArrayOrList.IsArrayOrList(propertyInfo.PropertyType))
			{
				Log.Error("SetArraySize: Property " + name + " on component " + component.name + " is not an array or list.");
			}
			else
			{
				object value = ArrayOrList.Resize(propertyInfo.Value, size);
				SetPropertyChain(component, propertyChain, value);
			}
		}
	}

	[ProximaCommand("Internal", "", "", "", "")]
	public static void MoveArrayElement(int componentId, string name, int from, int to)
	{
		if (TryGetPropertyChain(componentId, name, out var component, out var propertyChain))
		{
			ProximaComponentCommands.PropertyInfo propertyInfo = propertyChain.Peek();
			if (propertyInfo.Value == null)
			{
				Log.Error("MoveArrayElement: Property " + name + " on component " + component.name + " is null.");
			}
			else if (!ArrayOrList.IsArrayOrList(propertyInfo.PropertyType))
			{
				Log.Error("MoveArrayElement: Property " + name + " on component " + component.name + " is not an array or list.");
			}
			else
			{
				ArrayOrList.MoveElement(propertyInfo.Value, from, to);
			}
		}
	}

	[ProximaCommand("Internal", "", "", "", "")]
	public static void RemoveArrayElement(int componentId, string name, int index)
	{
		if (TryGetPropertyChain(componentId, name, out var component, out var propertyChain))
		{
			ProximaComponentCommands.PropertyInfo propertyInfo = propertyChain.Peek();
			if (propertyInfo.Value == null)
			{
				Log.Error("MoveArrayElement: Property " + name + " on component " + component.name + " is null.");
			}
			else if (!ArrayOrList.IsArrayOrList(propertyInfo.PropertyType))
			{
				Log.Error("RemoveArrayElement: Property " + name + " on component " + component.name + " is not an array or list.");
			}
			else
			{
				object value = ArrayOrList.RemoveElement(propertyInfo.Value, index);
				SetPropertyChain(component, propertyChain, value);
			}
		}
	}

	[ProximaCommand("Internal", "", "", "", "")]
	public static void InvokeButton(int componentId, string buttonId)
	{
		if (!ProximaComponentCommands.IdToComponentInfo.TryGetValue(componentId, out var value))
		{
			Log.Error($"InvokeButton: Component not found: {componentId}.");
			return;
		}
		ProximaComponentCommands.ButtonInfo buttonInfo = value.Btns.Find((ProximaComponentCommands.ButtonInfo b) => b.Id == buttonId);
		if (buttonInfo == null)
		{
			Log.Error("InvokeButton: Button " + buttonId + " not found on component " + value.Name + ".");
		}
		else
		{
			buttonInfo.Method.Invoke(value.Component, null);
		}
	}
}
