using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using ParadoxNotion;
using UnityEngine;

namespace FlowCanvas.Nodes.Legacy;

public abstract class ReflectedMethodNode
{
	protected delegate void ActionCall();

	protected delegate void ActionCall<T1>(T1 a);

	protected delegate void ActionCall<T1, T2>(T1 a, T2 b);

	protected delegate void ActionCall<T1, T2, T3>(T1 a, T2 b, T3 c);

	protected delegate void ActionCall<T1, T2, T3, T4>(T1 a, T2 b, T3 c, T4 d);

	protected delegate void ActionCall<T1, T2, T3, T4, T5>(T1 a, T2 b, T3 c, T4 d, T5 e);

	protected delegate void ActionCall<T1, T2, T3, T4, T5, T6>(T1 a, T2 b, T3 c, T4 d, T5 e, T6 f);

	protected delegate void ActionCall<T1, T2, T3, T4, T5, T6, T7>(T1 a, T2 b, T3 c, T4 d, T5 e, T6 f, T7 g);

	protected delegate void ActionCall<T1, T2, T3, T4, T5, T6, T7, T8>(T1 a, T2 b, T3 c, T4 d, T5 e, T6 f, T7 g, T8 h);

	protected delegate TResult FunctionCall<TResult>();

	protected delegate TResult FunctionCall<T1, TResult>(T1 a);

	protected delegate TResult FunctionCall<T1, T2, TResult>(T1 a, T2 b);

	protected delegate TResult FunctionCall<T1, T2, T3, TResult>(T1 a, T2 b, T3 c);

	protected delegate TResult FunctionCall<T1, T2, T3, T4, TResult>(T1 a, T2 b, T3 c, T4 d);

	protected delegate TResult FunctionCall<T1, T2, T3, T4, T5, TResult>(T1 a, T2 b, T3 c, T4 d, T5 e);

	protected delegate TResult FunctionCall<T1, T2, T3, T4, T5, T6, TResult>(T1 a, T2 b, T3 c, T4 d, T5 e, T6 f);

	protected delegate TResult FunctionCall<T1, T2, T3, T4, T5, T6, T7, TResult>(T1 a, T2 b, T3 c, T4 d, T5 e, T6 f, T7 g);

	protected delegate TResult FunctionCall<T1, T2, T3, T4, T5, T6, T7, T8, TResult>(T1 a, T2 b, T3 c, T4 d, T5 e, T6 f, T7 g, T8 h);

	public ReflectedMethodNode()
	{
	}

	public static ReflectedMethodNode Create(MethodInfo method)
	{
		ParameterInfo[] parameters = method.GetParameters();
		if (method.DeclaringType.RTIsValueType() || parameters.Any((ParameterInfo p) => p.ParameterType.IsByRef || p.IsParams(parameters)))
		{
			return new PureReflectedMethodNode();
		}
		try
		{
			return TryCreateJit(method);
		}
		catch
		{
			return new PureReflectedMethodNode();
		}
	}

	private static ReflectedMethodNode TryCreateJit(MethodInfo method)
	{
		if (method.ReturnType == typeof(void))
		{
			Type type = null;
			List<Type> list = new List<Type>();
			ParameterInfo[] parameters = method.GetParameters();
			int num = parameters.Length;
			if (!method.IsStatic)
			{
				num++;
				list.Add(method.DeclaringType);
			}
			if (num == 0)
			{
				type = typeof(ReflectedActionNode);
			}
			if (num == 1)
			{
				type = typeof(ReflectedActionNode<>);
			}
			if (num == 2)
			{
				type = typeof(ReflectedActionNode<, >);
			}
			if (num == 3)
			{
				type = typeof(ReflectedActionNode<, , >);
			}
			if (num == 4)
			{
				type = typeof(ReflectedActionNode<, , , >);
			}
			if (num == 5)
			{
				type = typeof(ReflectedActionNode<, , , , >);
			}
			if (num == 6)
			{
				type = typeof(ReflectedActionNode<, , , , , >);
			}
			if (num == 7)
			{
				type = typeof(ReflectedActionNode<, , , , , , >);
			}
			if (num == 8)
			{
				type = typeof(ReflectedActionNode<, , , , , , , >);
			}
			if (num >= 9)
			{
				Debug.LogError("ReflectedActionNode currently supports up to 8 parameters");
				return null;
			}
			list.AddRange(parameters.Select((ParameterInfo p) => p.ParameterType));
			return (ReflectedMethodNode)Activator.CreateInstance((list.Count > 0) ? type.RTMakeGenericType(list.ToArray()) : type);
		}
		Type type2 = null;
		List<Type> list2 = new List<Type>();
		ParameterInfo[] parameters2 = method.GetParameters();
		int num2 = parameters2.Length;
		if (!method.IsStatic)
		{
			num2++;
			list2.Add(method.DeclaringType);
		}
		if (num2 == 0)
		{
			type2 = typeof(ReflectedFunctionNode<>);
		}
		if (num2 == 1)
		{
			type2 = typeof(ReflectedFunctionNode<, >);
		}
		if (num2 == 2)
		{
			type2 = typeof(ReflectedFunctionNode<, , >);
		}
		if (num2 == 3)
		{
			type2 = typeof(ReflectedFunctionNode<, , , >);
		}
		if (num2 == 4)
		{
			type2 = typeof(ReflectedFunctionNode<, , , , >);
		}
		if (num2 == 5)
		{
			type2 = typeof(ReflectedFunctionNode<, , , , , >);
		}
		if (num2 == 6)
		{
			type2 = typeof(ReflectedFunctionNode<, , , , , , >);
		}
		if (num2 == 7)
		{
			type2 = typeof(ReflectedFunctionNode<, , , , , , , >);
		}
		if (num2 == 8)
		{
			type2 = typeof(ReflectedFunctionNode<, , , , , , , , >);
		}
		if (num2 >= 9)
		{
			Debug.LogError("ReflectedFunctionNode currently supports up to 8 parameters");
			return null;
		}
		list2.AddRange(parameters2.Select((ParameterInfo p) => p.ParameterType));
		list2.Add(method.ReturnType);
		return (ReflectedMethodNode)Activator.CreateInstance(type2.RTMakeGenericType(list2.ToArray()));
	}

	public string GetName(MethodInfo method, int i)
	{
		if (method == null)
		{
			return null;
		}
		ParameterInfo[] parameters = method.GetParameters();
		if (method.IsStatic)
		{
			return parameters[i].Name;
		}
		string text = method.DeclaringType.FriendlyName();
		if (i == 0)
		{
			return text;
		}
		string name = parameters[i - 1].Name;
		if (!(name != text))
		{
			return name + " ";
		}
		return name;
	}

	public abstract void RegisterPorts(FlowNode node, MethodInfo method, ReflectedMethodRegistrationOptions options);
}
