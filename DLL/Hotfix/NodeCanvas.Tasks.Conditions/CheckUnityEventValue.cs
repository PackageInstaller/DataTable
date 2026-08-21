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
[Description("Will subscribe to a public UnityEvent<T> and return true when that event is raised and it's value is equal to provided value as well.")]
[fsMigrateVersions(new Type[] { typeof(CheckUnityEventValue_0<>) })]
public class CheckUnityEventValue<T> : ConditionTask, IReflectedWrapper, IMigratable<CheckUnityEventValue_0<T>>, IMigratable
{
	[SerializeField]
	private SerializedUnityEventInfo _eventInfo;

	[SerializeField]
	private BBParameter<T> checkValue;

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
			return $"'{targetMember.Name}' Raised && Value == {checkValue}";
		}
	}

	void IMigratable<CheckUnityEventValue_0<T>>.Migrate(CheckUnityEventValue_0<T> model)
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
		if (targetEventField == null)
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
		if (ObjectUtils.AnyEquals(checkValue.value, eventValue))
		{
			YieldReturn(value: true);
		}
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
