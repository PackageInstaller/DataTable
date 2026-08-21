using System;
using System.Collections;
using System.Reflection;
using NodeCanvas.Framework.Internal;
using ParadoxNotion;
using ParadoxNotion.Design;
using ParadoxNotion.Serialization;
using ParadoxNotion.Serialization.FullSerializer;
using ParadoxNotion.Services;
using UnityEngine;
using UnityEngine.Scripting;

namespace NodeCanvas.Framework;

[Serializable]
[fsDeserializeOverwrite]
[SpoofAOT]
[Preserve]
public abstract class Task : ISerializationCollectable, ISerializationCallbackReceiver
{
	[AttributeUsage(AttributeTargets.Field)]
	protected class GetFromAgentAttribute : Attribute
	{
	}

	[fsSerializeAs("_isDisabled")]
	private bool _isUserDisabled;

	[fsSerializeAs("overrideAgent")]
	protected internal TaskAgentParameter _agentParameter;

	private ITaskSystem _ownerSystem;

	private Component _currentAgent;

	private string _taskName;

	private string _taskDescription;

	private string _obsoleteInfo;

	private bool _isRuntimeActive;

	private bool _isInitSuccess;

	private EventRouter _eventRouter;

	public ITaskSystem ownerSystem
	{
		get
		{
			return _ownerSystem;
		}
		private set
		{
			_ownerSystem = value;
		}
	}

	public Component ownerSystemAgent
	{
		get
		{
			if (ownerSystem == null)
			{
				return null;
			}
			return ownerSystem.agent;
		}
	}

	public IBlackboard ownerSystemBlackboard
	{
		get
		{
			if (ownerSystem == null)
			{
				return null;
			}
			return ownerSystem.blackboard;
		}
	}

	public float ownerSystemElapsedTime
	{
		get
		{
			if (ownerSystem == null)
			{
				return 0f;
			}
			return ownerSystem.elapsedTime;
		}
	}

	public bool isUserEnabled
	{
		get
		{
			return !_isUserDisabled;
		}
		internal set
		{
			_isUserDisabled = !value;
		}
	}

	public string obsolete
	{
		get
		{
			if (_obsoleteInfo == null)
			{
				ObsoleteAttribute obsoleteAttribute = GetType().RTGetAttribute<ObsoleteAttribute>(inherited: true);
				_obsoleteInfo = ((obsoleteAttribute != null) ? obsoleteAttribute.Message : string.Empty);
			}
			return _obsoleteInfo;
		}
	}

	public string name
	{
		get
		{
			if (_taskName == null)
			{
				NameAttribute nameAttribute = GetType().RTGetAttribute<NameAttribute>(inherited: false);
				_taskName = ((nameAttribute != null) ? nameAttribute.name : GetType().FriendlyName().SplitCamelCase());
			}
			return _taskName;
		}
	}

	public string description
	{
		get
		{
			if (_taskDescription == null)
			{
				DescriptionAttribute descriptionAttribute = GetType().RTGetAttribute<DescriptionAttribute>(inherited: true);
				_taskDescription = ((descriptionAttribute != null) ? descriptionAttribute.description : string.Empty);
			}
			return _taskDescription;
		}
	}

	public string summaryInfo
	{
		get
		{
			if (this is ActionTask)
			{
				return (agentIsOverride ? "* " : "") + info;
			}
			if (this is ConditionTask)
			{
				return (agentIsOverride ? "* " : "") + ((this as ConditionTask).invert ? "If <b>!</b> " : "If ") + info;
			}
			return info;
		}
	}

	protected virtual string info => name;

	public virtual Type agentType => null;

	public string agentInfo
	{
		get
		{
			if (_agentParameter == null)
			{
				return "<b>Self</b>";
			}
			return _agentParameter.ToString();
		}
	}

	public string agentParameterName
	{
		get
		{
			if (_agentParameter == null)
			{
				return null;
			}
			return _agentParameter.name;
		}
	}

	public bool agentIsOverride
	{
		get
		{
			return _agentParameter != null;
		}
		set
		{
			if (!value && _agentParameter != null)
			{
				_agentParameter = null;
			}
			if (value && _agentParameter == null)
			{
				_agentParameter = new TaskAgentParameter();
				_agentParameter.bb = blackboard;
			}
		}
	}

	public Component agent
	{
		get
		{
			if (_currentAgent != null)
			{
				return _currentAgent;
			}
			return (agentIsOverride ? ((Component)_agentParameter.value) : ownerSystemAgent).TransformToType(agentType);
		}
	}

	public IBlackboard blackboard => ownerSystemBlackboard;

	public EventRouter router
	{
		get
		{
			if (!(_eventRouter != null))
			{
				return _eventRouter = ((agent == null) ? null : agent.gameObject.GetAddComponent<EventRouter>());
			}
			return _eventRouter;
		}
	}

	void ISerializationCallbackReceiver.OnBeforeSerialize()
	{
		if (agentType == null)
		{
			_agentParameter = null;
		}
		if (_agentParameter != null)
		{
			_agentParameter.SetType(agentType);
		}
	}

	void ISerializationCallbackReceiver.OnAfterDeserialize()
	{
	}

	public Task()
	{
	}

	public static T Create<T>(ITaskSystem newOwnerSystem) where T : Task
	{
		return (T)Create(typeof(T), newOwnerSystem);
	}

	public static Task Create(Type type, ITaskSystem newOwnerSystem)
	{
		if (type.IsGenericTypeDefinition)
		{
			type = type.MakeGenericType(type.GetFirstGenericParameterConstraintType());
		}
		Task obj = (Task)Activator.CreateInstance(type);
		BBParameter.SetBBFields(obj, newOwnerSystem.blackboard);
		obj.Validate(newOwnerSystem);
		obj.OnCreate(newOwnerSystem);
		return obj;
	}

	public virtual Task Duplicate(ITaskSystem newOwnerSystem)
	{
		Task task = JSONSerializer.Clone(this);
		BBParameter.SetBBFields(task, newOwnerSystem.blackboard);
		task.Validate(newOwnerSystem);
		return task;
	}

	public void Validate(ITaskSystem ownerSystem)
	{
		SetOwnerSystem(ownerSystem);
		OnValidate(ownerSystem);
		GetHardError();
	}

	public void SetOwnerSystem(ITaskSystem newOwnerSystem)
	{
		ownerSystem = newOwnerSystem;
	}

	protected bool Set(Component newAgent, IBlackboard newBB)
	{
		if (agentIsOverride)
		{
			newAgent = (Component)_agentParameter.value;
		}
		if (_currentAgent != null && newAgent != null && _currentAgent.gameObject == newAgent.gameObject)
		{
			return _isInitSuccess;
		}
		return _isInitSuccess = Initialize(newAgent);
	}

	private bool Initialize(Component newAgent)
	{
		_eventRouter = null;
		_currentAgent = newAgent.TransformToType(agentType);
		if (_currentAgent == null && agentType != null)
		{
			return Error("Failed to resolve Agent to requested type '" + agentType?.ToString() + "', or new Agent is NULL. Does the Agent has the requested Component?");
		}
		if (!InitializeFieldAttributes(_currentAgent))
		{
			return false;
		}
		string text = OnInit();
		if (text != null)
		{
			return Error(text);
		}
		return true;
	}

	private bool InitializeFieldAttributes(Component newAgent)
	{
		FieldInfo[] array = GetType().RTGetFields();
		foreach (FieldInfo fieldInfo in array)
		{
			if (newAgent != null && (typeof(Component).RTIsAssignableFrom(fieldInfo.FieldType) || fieldInfo.FieldType.IsInterface) && fieldInfo.RTIsDefined<GetFromAgentAttribute>(inherited: true))
			{
				Component component = newAgent.GetComponent(fieldInfo.FieldType);
				fieldInfo.SetValue(this, component);
				if ((object)component == null)
				{
					return Error($"GetFromAgent Attribute failed to get the required Component of type '{fieldInfo.FieldType.Name}' from '{agent.gameObject.name}'. Does it exist?");
				}
			}
		}
		return true;
	}

	protected bool Error(string error, string tag = "Execution")
	{
		return false;
	}

	protected Coroutine StartCoroutine(IEnumerator routine)
	{
		if (!(MonoManager.current != null))
		{
			return null;
		}
		return MonoManager.current.StartCoroutine(routine);
	}

	protected void StopCoroutine(Coroutine routine)
	{
		if (MonoManager.current != null)
		{
			MonoManager.current.StopCoroutine(routine);
		}
	}

	protected void SendEvent(string name)
	{
		if (ownerSystem != null)
		{
			ownerSystem.SendEvent(name, null, this);
		}
	}

	protected void SendEvent<T>(string name, T value)
	{
		if (ownerSystem != null)
		{
			ownerSystem.SendEvent(name, value, this);
		}
	}

	internal virtual string GetWarningOrError()
	{
		string hardError = GetHardError();
		if (hardError != null)
		{
			return "* " + hardError;
		}
		string text = OnErrorCheck();
		if (text != null)
		{
			return text;
		}
		if (obsolete != string.Empty)
		{
			return $"Task is obsolete: '{obsolete}'";
		}
		if (agentType != null && agent == null && (_agentParameter == null || (_agentParameter.isNoneOrNull && !_agentParameter.isDefined)))
		{
			return $"* '{agentType.Name}' target agent is null";
		}
		FieldInfo[] array = GetType().RTGetFields();
		foreach (FieldInfo fieldInfo in array)
		{
			if (!fieldInfo.RTIsDefined<RequiredFieldAttribute>(inherited: true))
			{
				continue;
			}
			object value = fieldInfo.GetValue(this);
			if (value == null || value.Equals(null))
			{
				return $"* Required field '{fieldInfo.Name.SplitCamelCase()}' is null";
			}
			if (fieldInfo.FieldType == typeof(string) && string.IsNullOrEmpty((string)value))
			{
				return $"* Required string field '{fieldInfo.Name.SplitCamelCase()}' is null or empty";
			}
			if (typeof(BBParameter).RTIsAssignableFrom(fieldInfo.FieldType))
			{
				if (!(value is BBParameter bBParameter))
				{
					return $"* BBParameter '{fieldInfo.Name.SplitCamelCase()}' is null";
				}
				if (!bBParameter.isDefined && bBParameter.isNoneOrNull)
				{
					return $"* Required parameter '{fieldInfo.Name.SplitCamelCase()}' is null";
				}
			}
		}
		return null;
	}

	protected virtual string OnErrorCheck()
	{
		return null;
	}

	private string GetHardError()
	{
		if (this is IMissingRecoverable)
		{
			return $"Missing Task '{(this as IMissingRecoverable).missingType}'";
		}
		if (this is IReflectedWrapper)
		{
			ISerializedReflectedInfo serializedInfo = (this as IReflectedWrapper).GetSerializedInfo();
			if (serializedInfo != null && serializedInfo.AsMemberInfo() == null)
			{
				return $"Missing Reflected Info '{serializedInfo.AsString()}'";
			}
		}
		return null;
	}

	protected virtual string OnInit()
	{
		return null;
	}

	public virtual void OnCreate(ITaskSystem ownerSystem)
	{
	}

	public virtual void OnValidate(ITaskSystem ownerSystem)
	{
	}

	[Obsolete("Use OnDrawGizmosSelected")]
	public virtual void OnDrawGizmos()
	{
		OnDrawGizmosSelected();
	}

	public virtual void OnDrawGizmosSelected()
	{
	}

	public override string ToString()
	{
		return summaryInfo;
	}
}
