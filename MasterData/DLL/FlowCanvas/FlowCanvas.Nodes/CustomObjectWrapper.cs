using System;
using System.Collections.Generic;
using ParadoxNotion;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

public abstract class CustomObjectWrapper : FlowNode
{
	public static Type[] FindCustomObjectWrappersForType(Type targetType)
	{
		List<Type> list = new List<Type>();
		Type[] implementationsOf = ReflectionTools.GetImplementationsOf(typeof(CustomObjectWrapper));
		foreach (Type type in implementationsOf)
		{
			Type[] genericArguments = type.BaseType.GetGenericArguments();
			if (genericArguments.Length == 1 && genericArguments[0] == targetType)
			{
				list.Add(type);
			}
		}
		return list.ToArray();
	}

	public abstract void SetTarget(UnityEngine.Object target);
}
[Icon("", false, "GetRuntimeIconType")]
public abstract class CustomObjectWrapper<T> : CustomObjectWrapper where T : UnityEngine.Object
{
	[SerializeField]
	private T _target;

	public T target
	{
		get
		{
			return _target;
		}
		set
		{
			if (_target != value)
			{
				_target = value;
				GatherPorts();
			}
		}
	}

	public override string name
	{
		get
		{
			if (!(target != null))
			{
				return base.name;
			}
			return target.name;
		}
	}

	public override void SetTarget(UnityEngine.Object target)
	{
		if (target is T)
		{
			this.target = (T)target;
		}
	}

	protected Type GetRuntimeIconType()
	{
		if (!(target != null))
		{
			return null;
		}
		return target.GetType();
	}
}
