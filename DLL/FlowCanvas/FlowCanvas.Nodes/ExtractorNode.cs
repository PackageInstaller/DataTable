using System;
using System.Collections.Generic;
using System.Linq;
using ParadoxNotion;

namespace FlowCanvas.Nodes;

public abstract class ExtractorNode : SimplexNode
{
	private static Dictionary<Type, Type> _extractors;

	public static Type GetExtractorType(Type type)
	{
		if (_extractors == null)
		{
			_extractors = new Dictionary<Type, Type>();
			foreach (Type item in from t in ReflectionTools.GetImplementationsOf(typeof(ExtractorNode))
				where !t.IsGenericTypeDefinition
				select t)
			{
				Type parameterType = item.RTGetMethod("Invoke").GetParameters()[0].ParameterType;
				_extractors[parameterType] = item;
			}
		}
		Type value = null;
		_extractors.TryGetValue(type, out value);
		return value;
	}
}
public abstract class ExtractorNode<TInstance, T1, T2> : ExtractorNode
{
	private T1 a;

	private T2 b;

	public abstract void Invoke(TInstance instance, out T1 a, out T2 b);

	protected sealed override void OnRegisterPorts(FlowNode node)
	{
		ValueInput<TInstance> i = node.AddValueInput<TInstance>(typeof(TInstance).FriendlyName());
		node.AddValueOutput(base.parameters[1].Name, delegate
		{
			Invoke(i.value, out a, out b);
			return a;
		});
		node.AddValueOutput(base.parameters[2].Name, delegate
		{
			Invoke(i.value, out a, out b);
			return b;
		});
	}
}
public abstract class ExtractorNode<TInstance, T1, T2, T3> : ExtractorNode
{
	private T1 a;

	private T2 b;

	private T3 c;

	public abstract void Invoke(TInstance instance, out T1 a, out T2 b, out T3 c);

	protected sealed override void OnRegisterPorts(FlowNode node)
	{
		ValueInput<TInstance> i = node.AddValueInput<TInstance>(typeof(TInstance).FriendlyName());
		node.AddValueOutput(base.parameters[1].Name, delegate
		{
			Invoke(i.value, out a, out b, out c);
			return a;
		});
		node.AddValueOutput(base.parameters[2].Name, delegate
		{
			Invoke(i.value, out a, out b, out c);
			return b;
		});
		node.AddValueOutput(base.parameters[3].Name, delegate
		{
			Invoke(i.value, out a, out b, out c);
			return c;
		});
	}
}
public abstract class ExtractorNode<TInstance, T1, T2, T3, T4> : ExtractorNode
{
	private T1 a;

	private T2 b;

	private T3 c;

	private T4 d;

	public abstract void Invoke(TInstance instance, out T1 a, out T2 b, out T3 c, out T4 d);

	protected sealed override void OnRegisterPorts(FlowNode node)
	{
		ValueInput<TInstance> i = node.AddValueInput<TInstance>(typeof(TInstance).FriendlyName());
		node.AddValueOutput(base.parameters[1].Name, delegate
		{
			Invoke(i.value, out a, out b, out c, out d);
			return a;
		});
		node.AddValueOutput(base.parameters[2].Name, delegate
		{
			Invoke(i.value, out a, out b, out c, out d);
			return b;
		});
		node.AddValueOutput(base.parameters[3].Name, delegate
		{
			Invoke(i.value, out a, out b, out c, out d);
			return c;
		});
		node.AddValueOutput(base.parameters[4].Name, delegate
		{
			Invoke(i.value, out a, out b, out c, out d);
			return d;
		});
	}
}
public abstract class ExtractorNode<TInstance, T1, T2, T3, T4, T5> : ExtractorNode
{
	private T1 a;

	private T2 b;

	private T3 c;

	private T4 d;

	private T5 e;

	public abstract void Invoke(TInstance instance, out T1 a, out T2 b, out T3 c, out T4 d, out T5 e);

	protected sealed override void OnRegisterPorts(FlowNode node)
	{
		ValueInput<TInstance> i = node.AddValueInput<TInstance>(typeof(TInstance).FriendlyName());
		node.AddValueOutput(base.parameters[1].Name, delegate
		{
			Invoke(i.value, out a, out b, out c, out d, out e);
			return a;
		});
		node.AddValueOutput(base.parameters[2].Name, delegate
		{
			Invoke(i.value, out a, out b, out c, out d, out e);
			return b;
		});
		node.AddValueOutput(base.parameters[3].Name, delegate
		{
			Invoke(i.value, out a, out b, out c, out d, out e);
			return c;
		});
		node.AddValueOutput(base.parameters[4].Name, delegate
		{
			Invoke(i.value, out a, out b, out c, out d, out e);
			return d;
		});
		node.AddValueOutput(base.parameters[5].Name, delegate
		{
			Invoke(i.value, out a, out b, out c, out d, out e);
			return e;
		});
	}
}
public abstract class ExtractorNode<TInstance, T1, T2, T3, T4, T5, T6> : ExtractorNode
{
	private T1 a;

	private T2 b;

	private T3 c;

	private T4 d;

	private T5 e;

	private T6 f;

	public abstract void Invoke(TInstance instance, out T1 a, out T2 b, out T3 c, out T4 d, out T5 e, out T6 f);

	protected sealed override void OnRegisterPorts(FlowNode node)
	{
		ValueInput<TInstance> i = node.AddValueInput<TInstance>(typeof(TInstance).FriendlyName());
		node.AddValueOutput(base.parameters[1].Name, delegate
		{
			Invoke(i.value, out a, out b, out c, out d, out e, out f);
			return a;
		});
		node.AddValueOutput(base.parameters[2].Name, delegate
		{
			Invoke(i.value, out a, out b, out c, out d, out e, out f);
			return b;
		});
		node.AddValueOutput(base.parameters[3].Name, delegate
		{
			Invoke(i.value, out a, out b, out c, out d, out e, out f);
			return c;
		});
		node.AddValueOutput(base.parameters[4].Name, delegate
		{
			Invoke(i.value, out a, out b, out c, out d, out e, out f);
			return d;
		});
		node.AddValueOutput(base.parameters[5].Name, delegate
		{
			Invoke(i.value, out a, out b, out c, out d, out e, out f);
			return e;
		});
		node.AddValueOutput(base.parameters[6].Name, delegate
		{
			Invoke(i.value, out a, out b, out c, out d, out e, out f);
			return f;
		});
	}
}
