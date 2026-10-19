using System;
using System.Reflection;
using UnityEngine;
using UnityEngine.InputSystem;

namespace ACT.Battle;

internal class MethodInvokeHelper
{
	public readonly Type ParameterType;

	public readonly string BindingPath;

	private readonly MethodInfo _method;

	public readonly InputAction Action;

	public readonly bool CheckMouseAction;

	public string MethodName => _method.Name;

	public IGameInputBindingHandle Handle { get; private set; }

	public int Priority => Handle?.Priority ?? int.MaxValue;

	private void InvokeDefault()
	{
		switch (Action.expectedControlType)
		{
		case "Axis":
			Invoke(0f);
			break;
		case "Button":
			Invoke(false);
			break;
		case "Vector2":
			Invoke(Vector2.zero);
			break;
		}
	}

	public MethodInvokeHelper(InputAction action, IGameInputBindingHandle handle, MethodInfo method, string bindingPath, Type parameterType, bool checkMouseAction)
	{
		Action = action;
		Handle = handle;
		BindingPath = bindingPath;
		ParameterType = parameterType;
		CheckMouseAction = checkMouseAction;
		_method = method;
	}

	private bool CouldInvoke()
	{
		if (Application.isFocused)
		{
			return !Handle.ActionDisableList.Contains(BindingPath);
		}
		return false;
	}

	public void Invoke(object value)
	{
		if (!CouldInvoke())
		{
			return;
		}
		try
		{
			_method.Invoke(Handle, new object[1] { value });
		}
		catch (Exception exception)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("执行输入回调方法(" + Handle.GetType().Name + "." + _method.Name + ")发生异常！");
				Debug.LogException(exception);
			}
		}
	}
}
