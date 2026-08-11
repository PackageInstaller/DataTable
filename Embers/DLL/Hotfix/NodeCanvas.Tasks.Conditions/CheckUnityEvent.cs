using System;
using System.Reflection;
using NodeCanvas.Framework;
using ParadoxNotion;
using ParadoxNotion.Design;
using ParadoxNotion.Serialization;
using ParadoxNotion.Serialization.FullSerializer;
using UnityEngine;
using UnityEngine.Events;

namespace NodeCanvas.Tasks.Conditions;

[Category("✫ Reflected/Events")]
[Description("Will subscribe to a public UnityEvent and return true when that event is raised.")]
[fsMigrateVersions(new Type[] { typeof(CheckUnityEvent_0) })]
public class CheckUnityEvent : ConditionTask, IReflectedWrapper, IMigratable<CheckUnityEvent_0>, IMigratable
{
	[SerializeField]
	private SerializedUnityEventInfo _eventInfo;

	private UnityEvent unityEvent;

	private MemberInfo targetMember
	{
		get
		{
			if (_eventInfo == null)
			{
				return null;
			}
			return _eventInfo.AsMemberInfo();
		}
	}

	private bool isStatic
	{
		get
		{
			if (_eventInfo == null)
			{
				return false;
			}
			return _eventInfo.isStatic;
		}
	}

	private Type eventType
	{
		get
		{
			if (_eventInfo == null)
			{
				return null;
			}
			return _eventInfo.memberType;
		}
	}

	private FieldInfo targetEventField => _eventInfo;

	private PropertyInfo targetEventProp => _eventInfo;

	public override Type agentType
	{
		get
		{
			if (targetMember == null)
			{
				return typeof(Transform);
			}
			if (!isStatic)
			{
				return targetMember.RTReflectedOrDeclaredType();
			}
			return null;
		}
	}

	protected override string info
	{
		get
		{
			if (_eventInfo == null)
			{
				return "No Event Selected";
			}
			if (targetMember == null)
			{
				return _eventInfo.AsString().FormatError();
			}
			return $"'{targetMember.Name}' Raised";
		}
	}

	void IMigratable<CheckUnityEvent_0>.Migrate(CheckUnityEvent_0 model)
	{
		_eventInfo = new SerializedUnityEventInfo(model.targetType?.RTGetField(model.eventName));
	}

	ISerializedReflectedInfo IReflectedWrapper.GetSerializedInfo()
	{
		return _eventInfo;
	}

	protected override string OnInit()
	{
		if (_eventInfo == null)
		{
			return "No Event Selected";
		}
		if (targetMember == null)
		{
			return _eventInfo.AsString();
		}
		if (targetEventField != null)
		{
			unityEvent = (UnityEvent)targetEventField.GetValue(base.agent);
		}
		if (targetEventProp != null)
		{
			unityEvent = (UnityEvent)targetEventProp.GetValue(base.agent);
		}
		return null;
	}

	protected override void OnEnable()
	{
		if (unityEvent != null)
		{
			unityEvent.AddListener(Raised);
		}
	}

	protected override void OnDisable()
	{
		if (unityEvent != null)
		{
			unityEvent.RemoveListener(Raised);
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

	private void SetTargetEvent(MemberInfo newMember)
	{
		if (newMember != null)
		{
			_eventInfo = new SerializedUnityEventInfo(newMember);
		}
	}
}
[Category("✫ Reflected/Events")]
[Description("Will subscribe to a public UnityEvent<T> and return true when that event is raised.")]
[fsMigrateVersions(new Type[] { typeof(CheckUnityEvent_0<>) })]
public class CheckUnityEvent<T> : ConditionTask, IReflectedWrapper, IMigratable<CheckUnityEvent_0<T>>, IMigratable
{
	[SerializeField]
	private SerializedUnityEventInfo _eventInfo;

	[SerializeField]
	[BlackboardOnly]
	private BBParameter<T> saveAs;

	private UnityEvent<T> unityEvent;

	private MemberInfo targetMember
	{
		get
		{
			if (_eventInfo == null)
			{
				return null;
			}
			return _eventInfo.AsMemberInfo();
		}
	}

	private bool isStatic
	{
		get
		{
			if (_eventInfo == null)
			{
				return false;
			}
			return _eventInfo.isStatic;
		}
	}

	private Type eventType
	{
		get
		{
			if (_eventInfo == null)
			{
				return null;
			}
			return _eventInfo.memberType;
		}
	}

	private FieldInfo targetEventField => _eventInfo;

	private PropertyInfo targetEventProp => _eventInfo;

	public override Type agentType
	{
		get
		{
			if (targetMember == null)
			{
				return typeof(Transform);
			}
			if (!isStatic)
			{
				return targetMember.RTReflectedOrDeclaredType();
			}
			return null;
		}
	}

	protected override string info
	{
		get
		{
			if (_eventInfo == null)
			{
				return "No Event Selected";
			}
			if (targetMember == null)
			{
				return _eventInfo.AsString().FormatError();
			}
			return $"'{targetMember.Name}' Raised";
		}
	}

	void IMigratable<CheckUnityEvent_0<T>>.Migrate(CheckUnityEvent_0<T> model)
	{
		_eventInfo = new SerializedUnityEventInfo(model.targetType?.RTGetField(model.eventName));
	}

	ISerializedReflectedInfo IReflectedWrapper.GetSerializedInfo()
	{
		return _eventInfo;
	}

	protected override string OnInit()
	{
		if (_eventInfo == null)
		{
			return "No Event Selected";
		}
		if (targetMember == null)
		{
			return _eventInfo.AsString();
		}
		if (targetEventField != null)
		{
			unityEvent = (UnityEvent<T>)targetEventField.GetValue(base.agent);
		}
		if (targetEventProp != null)
		{
			unityEvent = (UnityEvent<T>)targetEventProp.GetValue(base.agent);
		}
		return null;
	}

	protected override void OnEnable()
	{
		if (unityEvent != null)
		{
			unityEvent.AddListener(Raised);
		}
	}

	protected override void OnDisable()
	{
		if (unityEvent != null)
		{
			unityEvent.RemoveListener(Raised);
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

	private void SetTargetEvent(MemberInfo newMember)
	{
		if (newMember != null)
		{
			_eventInfo = new SerializedUnityEventInfo(newMember);
		}
	}
}
