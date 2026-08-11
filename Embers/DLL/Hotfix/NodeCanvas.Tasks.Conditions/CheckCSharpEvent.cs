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
[Description("Will subscribe to a public event of Action type and return true when the event is raised.\n(eg public event System.Action [name])")]
[fsMigrateVersions(new Type[] { typeof(CheckCSharpEvent_0) })]
public class CheckCSharpEvent : ConditionTask, IReflectedWrapper, IMigratable<CheckCSharpEvent_0>, IMigratable, IMigratable<CheckStaticCSharpEvent>
{
	[SerializeField]
	private SerializedEventInfo eventInfo;

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
			return $"'{targetEvent.Name}' Raised";
		}
	}

	void IMigratable<CheckCSharpEvent_0>.Migrate(CheckCSharpEvent_0 model)
	{
		EventInfo eventInfo = model.targetType?.RTGetEvent(model.eventName);
		if (eventInfo != null)
		{
			this.eventInfo = new SerializedEventInfo(eventInfo);
		}
	}

	void IMigratable<CheckStaticCSharpEvent>.Migrate(CheckStaticCSharpEvent model)
	{
		EventInfo eventInfo = model.targetType?.RTGetEvent(model.eventName);
		if (eventInfo != null)
		{
			this.eventInfo = new SerializedEventInfo(eventInfo);
		}
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

	public void Raised()
	{
		YieldReturn(value: true);
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
[Category("✫ Reflected/Events")]
[Description("Will subscribe to a public event of Action<T> type and return true when the event is raised.\n(eg public event System.Action<T> [name])")]
[fsMigrateVersions(new Type[] { typeof(CheckCSharpEvent_0<>) })]
public class CheckCSharpEvent<T> : ConditionTask, IReflectedWrapper, IMigratable<CheckCSharpEvent_0<T>>, IMigratable, IMigratable<CheckStaticCSharpEvent<T>>
{
	[SerializeField]
	private SerializedEventInfo eventInfo;

	[SerializeField]
	[BlackboardOnly]
	private BBParameter<T> saveAs;

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
			return $"'{targetEvent.Name}' Raised";
		}
	}

	void IMigratable<CheckCSharpEvent_0<T>>.Migrate(CheckCSharpEvent_0<T> model)
	{
		SetTargetEvent(model.targetType?.RTGetEvent(model.eventName));
	}

	void IMigratable<CheckStaticCSharpEvent<T>>.Migrate(CheckStaticCSharpEvent<T> model)
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
		saveAs.value = eventValue;
		YieldReturn(value: true);
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
