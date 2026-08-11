using System;
using UnityEngine.Scripting;

namespace UnityEngine;

[RequiredByNativeCode]
[AttributeUsage(AttributeTargets.Method, AllowMultiple = true)]
public sealed class ContextMenu : Attribute
{
	public readonly string menuItem;

	public readonly bool validate;

	public readonly int priority;

	public ContextMenu(string itemName)
		: this(itemName, isValidateFunction: false)
	{
	}

	public ContextMenu(string itemName, bool isValidateFunction)
		: this(itemName, isValidateFunction, 1000000)
	{
	}

	public ContextMenu(string itemName, bool isValidateFunction, int priority)
	{
		menuItem = itemName;
		validate = isValidateFunction;
		this.priority = priority;
	}
}
