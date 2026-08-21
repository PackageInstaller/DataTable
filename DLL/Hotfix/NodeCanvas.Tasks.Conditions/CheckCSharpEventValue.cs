using System;
using System.Reflection;
using NodeCanvas.Framework;
using ParadoxNotion;
using ParadoxNotion.Design;
using ParadoxNotion.Serialization;
using ParadoxNotion.Serialization.FullSerializer;
using UnityEngine;

namespace NodeCanvas.Tasks.Conditions;

[Category("✫ Reflected/Events")]
[Description("Will subscribe to a public event of Action<T> type and return true when the event is raised and it's value is equal to provided value as well.\n(eg public event System.Action<T> [name])")]
[fsMigrateVersions(new Type[] { typeof(CheckCSharpEventValue_0<>) })]
public class CheckCSharpEventValue<T> : ConditionTask, IReflectedWrapper, IMigratable<CheckCSharpEventValue_0<T>>, IMigratable
{
	[SerializeField]
	private SerializedEventInfo eventInfo;

	[SerializeField]
	private BBParameter<T> checkValue;

	private Delegate handler;

	private EventInfo targetEvent => eventInfo;

	public override Type agentType
	{
		get
		{
			if (targetEvent == null)
			{
				return typeof(Transform);
			}
			if (!targetEvent.IsStatic())
			{
				return targetEvent.RTReflectedOrDeclaredType();
			}
			return null;
		}
	}

	protected override string info
	{
		get
		{
			if (eventInfo == null)
			{
				return "No Event Selected";
			}
			if (targetEvent == null)
			{
				return eventInfo.AsString().FormatError();
			}
			return $"'{targetEvent.Name}' Raised && Value == {checkValue}";
		}
	}

	void IMigratable<CheckCSharpEventValue_0<T>>.Migrate(CheckCSharpEventValue_0<T> model)
	{
		SetTargetEvent(model.targetType?.RTGetEvent(model.eventName));
	}

	ISerializedReflectedInfo IReflectedWrapper.GetSerializedInfo()
	{
		return eventInfo;
	}

	protected override string OnInit()
	{
		if (eventInfo == null)
		{
			return "No Event Selected";
		}
		if (targetEvent == null)
		{
			return eventInfo.AsString().FormatError();
		}
		MethodInfo method = GetType().RTGetMethod("Raised");
		handler = method.RTCreateDelegate(targetEvent.EventHandlerType, this);
		return null;
	}

	protected override void OnEnable()
	{
		if ((object)handler != null)
		{
			targetEvent.AddEventHandler(targetEvent.IsStatic() ? null : base.agent, handler);
		}
	}

	protected override void OnDisable()
	{
		if ((object)handler != null)
		{
			targetEvent.RemoveEventHandler(targetEvent.IsStatic() ? null : base.agent, handler);
		}
	}

	public void Raised(T eventValue)
	{
		if (ObjectUtils.AnyEquals(checkValue.value, eventValue))
		{
			YieldReturn(value: true);
		}
	}

	protected override bool OnCheck()
	{
		return false;
	}

	private void SetTargetEvent(EventInfo info)
	{
		if (info != null)
		{
			eventInfo = new SerializedEventInfo(info);
		}
	}
}
