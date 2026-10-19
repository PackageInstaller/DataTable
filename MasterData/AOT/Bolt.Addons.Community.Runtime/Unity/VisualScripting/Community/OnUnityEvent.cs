using System;
using System.Linq;
using System.Reflection;
using UnityEngine;
using UnityEngine.Events;

namespace Unity.VisualScripting.Community;

[UnitTitle("On Unity Event")]
[UnitCategory("Events")]
public class OnUnityEvent : EventUnit<EventData>
{
	[DoNotSerialize]
	public ValueInput UnityEvent;

	protected override bool register => false;

	public Type Type { get; private set; }

	public override IGraphElementData CreateData()
	{
		return new OnUnityEventData();
	}

	protected override void Definition()
	{
		base.Definition();
		UnityEvent = ValueInput<UnityEventBase>("event");
		if (Type != null)
		{
			Type[] genericArguments = Type.GetGenericArguments();
			for (int i = 0; i < genericArguments.Length; i++)
			{
				ValueOutput(genericArguments[i], $"arg{i}");
			}
		}
	}

	public override void StartListening(GraphStack stack)
	{
		OnUnityEventData data = GetData(stack);
		if (data.EventListener == null && UnityEvent.hasValidConnection)
		{
			UpdatePorts();
			GraphReference reference = stack.ToReference();
			UnityEventBase obj = Flow.FetchValue<UnityEventBase>(UnityEvent, reference);
			MethodInfo method = Type.GetMethod("AddListener");
			Type delegateType = (((object)method != null) ? method.GetParameters()[0].ParameterType : null);
			data.EventListener = CreateAction(delegateType, reference);
			method?.Invoke(obj, new object[1] { data.EventListener });
		}
	}

	public override void StopListening(GraphStack stack)
	{
		OnUnityEventData data = GetData(stack);
		if (data.EventListener != null)
		{
			GraphReference reference = stack.ToReference();
			UnityEventBase obj = Flow.FetchValue<UnityEventBase>(UnityEvent, reference);
			Type.GetMethod("RemoveListener")?.Invoke(obj, new object[1] { data.EventListener });
			data.EventListener = null;
		}
	}

	public void UpdatePorts()
	{
		Type = GetEventType();
		Define();
	}

	private Type GetEventType()
	{
		Type type = UnityEvent?.connection?.source?.type;
		while (type != null && type.BaseType != typeof(UnityEventBase))
		{
			type = type.BaseType;
		}
		return type;
	}

	private object CreateAction(Type delegateType, GraphReference reference)
	{
		int num = delegateType.GetGenericArguments().Length;
		if (num == 0)
		{
			return new UnityAction(Action);
		}
		if (Application.platform == RuntimePlatform.WindowsEditor || Application.platform == RuntimePlatform.LinuxEditor || Application.platform == RuntimePlatform.OSXEditor)
		{
			return GetType().GetMethod(num switch
			{
				1 => "OneParamHandler", 
				2 => "TwoParamsHandler", 
				3 => "ThreeParamsHandler", 
				_ => "FourParamsHandler", 
			}, BindingFlags.Instance | BindingFlags.NonPublic | BindingFlags.InvokeMethod)?.MakeGenericMethod(delegateType.GetGenericArguments()).Invoke(this, new object[1] { reference });
		}
		if (GetAotSupportMethodsType() != null)
		{
			return GetAotSupportMethodsType().GetMethods().First((MethodInfo method) => method.ReturnType == delegateType)?.Invoke(null, new object[2] { reference, this });
		}
		throw new InvalidOperationException("Could not find AOT Support Methods");
		void Action()
		{
			Trigger(reference, new EventData());
		}
	}

	internal UnityAction<T1> OneParamHandler<T1>(GraphReference reference)
	{
		return (T1 arg0) =>
		{
			Trigger(reference, new EventData
			{
				Value0 = arg0
			});
		};
	}

	internal UnityAction<T1, T2> TwoParamsHandler<T1, T2>(GraphReference reference)
	{
		return (T1 arg0, T2 arg1) =>
		{
			Trigger(reference, new EventData
			{
				Value0 = arg0,
				Value1 = arg1
			});
		};
	}

	internal UnityAction<T1, T2, T3> ThreeParamsHandler<T1, T2, T3>(GraphReference reference)
	{
		return (T1 arg0, T2 arg1, T3 arg2) =>
		{
			Trigger(reference, new EventData
			{
				Value0 = arg0,
				Value1 = arg1,
				Value2 = arg2
			});
		};
	}

	internal UnityAction<T1, T2, T3, T4> FourParamsHandler<T1, T2, T3, T4>(GraphReference reference)
	{
		return (T1 arg0, T2 arg1, T3 arg2, T4 arg3) =>
		{
			Trigger(reference, new EventData
			{
				Value0 = arg0,
				Value1 = arg1,
				Value2 = arg2,
				Value3 = arg3
			});
		};
	}

	protected override void AssignArguments(Flow flow, EventData args)
	{
		int count = valueOutputs.Count;
		if (count > 0)
		{
			flow.SetValue(valueOutputs[0], args.Value0);
		}
		if (count > 1)
		{
			flow.SetValue(valueOutputs[1], args.Value1);
		}
		if (count > 2)
		{
			flow.SetValue(valueOutputs[2], args.Value2);
		}
		if (count > 3)
		{
			flow.SetValue(valueOutputs[3], args.Value3);
		}
	}

	private OnUnityEventData GetData(GraphPointer stack)
	{
		return stack.GetElementData<OnUnityEventData>(this);
	}

	private Type GetAotSupportMethodsType()
	{
		Assembly[] assemblies = AppDomain.CurrentDomain.GetAssemblies();
		for (int i = 0; i < assemblies.Length; i++)
		{
			Type[] types = assemblies[i].GetTypes();
			foreach (Type type in types)
			{
				if (type.Name == "AotSupportMethods")
				{
					return type;
				}
			}
		}
		return null;
	}
}
