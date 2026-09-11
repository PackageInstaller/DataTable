using System;
using System.Collections;
using System.Reflection;
using NodeCanvas.Framework.Internal;
using ParadoxNotion;
using ParadoxNotion.Design;
using ParadoxNotion.Serialization;
using ParadoxNotion.Services;
using UnityEngine;

namespace NodeCanvas.Framework;

[Serializable]
[SpoofAOT]
public abstract class Task : ISubParametersContainer
{
	[AttributeUsage(AttributeTargets.Class)]
	protected class EventReceiverAttribute : Attribute
	{
		public readonly string[] eventMessages;

		public EventReceiverAttribute(params string[] args)
		{
			eventMessages = args;
		}
	}

	[AttributeUsage(AttributeTargets.Field)]
	protected class GetFromAgentAttribute : Attribute
	{
	}

	[SerializeField]
	private bool _isDisabled;

	[SerializeField]
	private TaskAgentParameter overrideAgent;

	[NonSerialized]
	private IBlackboard _blackboard;

	[NonSerialized]
	private ITaskSystem _ownerSystem;

	[NonSerialized]
	private Component current;

	[NonSerialized]
	private string _taskName;

	[NonSerialized]
	private string _taskDescription;

	[NonSerialized]
	private string _obsoleteInfo;

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

	public Component ownerAgent
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

	public IBlackboard ownerBlackboard
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

	protected float ownerElapsedTime
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

	public bool isActive
	{
		get
		{
			return !_isDisabled;
		}
		set
		{
			_isDisabled = !value;
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

	public virtual Type agentType => null;

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

	public string agentInfo
	{
		get
		{
			if (overrideAgent == null)
			{
				return "<b>owner</b>";
			}
			return overrideAgent.ToString();
		}
	}

	public bool agentIsOverride
	{
		get
		{
			return overrideAgent != null;
		}
		set
		{
			if (!value && overrideAgent != null)
			{
				overrideAgent = null;
			}
			if (value && overrideAgent == null)
			{
				overrideAgent = new TaskAgentParameter();
				overrideAgent.bb = blackboard;
			}
		}
	}

	public string overrideAgentParameterName
	{
		get
		{
			if (overrideAgent == null)
			{
				return null;
			}
			return overrideAgent.name;
		}
	}

	public Component agent
	{
		get
		{
			if (current != null)
			{
				return current;
			}
			return TransformAgent(agentIsOverride ? ((Component)overrideAgent.value) : ownerAgent, agentType);
		}
	}

	public IBlackboard blackboard
	{
		get
		{
			return _blackboard;
		}
		private set
		{
			if (_blackboard != value)
			{
				_blackboard = value;
				BBParameter.SetBBFields(this, value);
				if (overrideAgent != null)
				{
					overrideAgent.bb = value;
				}
			}
		}
	}

	public string firstWarningMessage { get; private set; }

	BBParameter[] ISubParametersContainer.GetSubParameters()
	{
		if (overrideAgent == null)
		{
			return null;
		}
		return new BBParameter[1] { overrideAgent };
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
		Task obj = (Task)Activator.CreateInstance(type);
		newOwnerSystem.RecordUndo("New Task");
		obj.SetOwnerSystem(newOwnerSystem);
		BBParameter.SetBBFields(obj, newOwnerSystem.blackboard);
		obj.OnValidate(newOwnerSystem);
		obj.OnCreate(newOwnerSystem);
		return obj;
	}

	public virtual Task Duplicate(ITaskSystem newOwnerSystem)
	{
		Task task = JSONSerializer.Clone(this);
		newOwnerSystem.RecordUndo("Duplicate Task");
		task.SetOwnerSystem(newOwnerSystem);
		BBParameter.SetBBFields(task, newOwnerSystem.blackboard);
		task.OnValidate(newOwnerSystem);
		return task;
	}

	public virtual void OnCreate(ITaskSystem ownerSystem)
	{
	}

	public virtual void OnValidate(ITaskSystem ownerSystem)
	{
	}

	public void SetOwnerSystem(ITaskSystem newOwnerSystem)
	{
		if (newOwnerSystem == null)
		{
			ParadoxNotion.Services.Logger.LogError("ITaskSystem set in task is null!!", "Init", this);
		}
		else
		{
			ownerSystem = newOwnerSystem;
		}
	}

	protected Coroutine StartCoroutine(IEnumerator routine)
	{
		return MonoManager.current.StartCoroutine(routine);
	}

	protected void StopCoroutine(Coroutine routine)
	{
		MonoManager.current.StopCoroutine(routine);
	}

	protected void SendEvent(EventData eventData)
	{
		if (ownerSystem != null)
		{
			ownerSystem.SendEvent(eventData, this);
		}
	}

	protected virtual string OnInit()
	{
		return null;
	}

	protected bool Set(Component newAgent, IBlackboard newBB)
	{
		blackboard = newBB;
		if (agentIsOverride)
		{
			newAgent = (Component)overrideAgent.value;
		}
		if (current != null && newAgent != null && current.gameObject == newAgent.gameObject)
		{
			return isActive = true;
		}
		return isActive = Initialize(newAgent);
	}

	private static Component TransformAgent(Component input, Type type)
	{
		if (input != null && type != null && !type.RTIsAssignableFrom(input.GetType()) && (type.RTIsSubclassOf(typeof(Component)) || type.RTIsInterface()))
		{
			input = input.GetComponent(type);
		}
		return input;
	}

	private bool Initialize(Component newAgent)
	{
		UnRegisterAllEvents();
		newAgent = TransformAgent(newAgent, agentType);
		current = newAgent;
		if (newAgent == null && agentType != null)
		{
			return Error("Failed to resolve Agent to requested type '" + agentType?.ToString() + "', or new Agent is NULL. Does the Agent has the requested Component?");
		}
		EventReceiverAttribute eventReceiverAttribute = GetType().RTGetAttribute<EventReceiverAttribute>(inherited: true);
		if (eventReceiverAttribute != null)
		{
			RegisterEvents(eventReceiverAttribute.eventMessages);
		}
		if (!InitializeAttributes(newAgent))
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

	private bool InitializeAttributes(Component newAgent)
	{
		FieldInfo[] array = GetType().RTGetFields();
		foreach (FieldInfo fieldInfo in array)
		{
			if (newAgent != null && typeof(Component).RTIsAssignableFrom(fieldInfo.FieldType) && fieldInfo.RTIsDefined<GetFromAgentAttribute>(inherited: true))
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

	protected bool Error(string error)
	{
		ParadoxNotion.Services.Logger.LogError($"{error} | TASK DISABLED | {((ownerSystem != null) ? ownerSystem.contextObject : null)}", "Task", this);
		return false;
	}

	public void RegisterEvent(string eventName)
	{
		RegisterEvents(eventName);
	}

	public void RegisterEvents(params string[] eventNames)
	{
		if (!(agent == null))
		{
			MessageRouter messageRouter = agent.GetComponent<MessageRouter>();
			if (messageRouter == null)
			{
				messageRouter = agent.gameObject.AddComponent<MessageRouter>();
			}
			messageRouter.Register(this, eventNames);
		}
	}

	public void UnRegisterEvent(string eventName)
	{
		UnRegisterEvents(eventName);
	}

	public void UnRegisterEvents(params string[] eventNames)
	{
		if (!(agent == null))
		{
			MessageRouter component = agent.GetComponent<MessageRouter>();
			if (component != null)
			{
				component.UnRegister(this, eventNames);
			}
		}
	}

	public void UnRegisterAllEvents()
	{
		if (!(agent == null))
		{
			MessageRouter component = agent.GetComponent<MessageRouter>();
			if (component != null)
			{
				component.UnRegister(this);
			}
		}
	}

	public string GetWarning()
	{
		firstWarningMessage = Internal_GetWarning();
		return firstWarningMessage;
	}

	private string Internal_GetWarning()
	{
		if (obsolete != string.Empty)
		{
			return $"Task is obsolete: '{obsolete}'.";
		}
		if (agent == null && agentType != null)
		{
			return $"'{agentType.Name}' target is currently null.";
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
				return $"Required field '{fieldInfo.Name.SplitCamelCase()}' is currently null.";
			}
			if (fieldInfo.FieldType == typeof(string) && string.IsNullOrEmpty((string)value))
			{
				return $"Required string field '{fieldInfo.Name.SplitCamelCase()}' is currently null or empty.";
			}
			if (typeof(BBParameter).RTIsAssignableFrom(fieldInfo.FieldType))
			{
				if (!(value is BBParameter bBParameter))
				{
					return $"BBParameter '{fieldInfo.Name.SplitCamelCase()}' is null.";
				}
				if (bBParameter.isNull)
				{
					return $"Required parameter '{fieldInfo.Name.SplitCamelCase()}' is currently null.";
				}
			}
		}
		return null;
	}

	public override string ToString()
	{
		return summaryInfo;
	}

	public virtual void OnDrawGizmos()
	{
	}

	public virtual void OnDrawGizmosSelected()
	{
	}
}
