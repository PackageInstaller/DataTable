using System;
using System.Collections.Generic;
using NodeCanvas.Framework;
using ParadoxNotion.Serialization;
using ParadoxNotion.Services;
using UnityEngine;

namespace NodeCanvas;

[AddComponentMenu("NodeCanvas/Standalone Action List (Bonus)")]
public class ActionListPlayer : MonoBehaviour, ITaskSystem, ISerializationCallbackReceiver
{
	public bool playOnAwake;

	[SerializeField]
	private GraphByteData _graphByteData = new GraphByteData();

	private string _serializedList;

	[SerializeField]
	private List<UnityEngine.Object> _objectReferences;

	[SerializeField]
	private Blackboard _blackboard;

	[NonSerialized]
	private ActionList _actionList;

	private float timeStarted;

	public ActionList actionList => _actionList;

	public float elapsedTime => Time.time - timeStarted;

	public float IntervalTimer => Time.deltaTime;

	public float deltaTime => Time.deltaTime;

	UnityEngine.Object ITaskSystem.contextObject => this;

	Component ITaskSystem.agent => this;

	public IBlackboard blackboard
	{
		get
		{
			return _blackboard;
		}
		set
		{
			if (_blackboard != value)
			{
				_blackboard = (Blackboard)value;
				UpdateTasksOwner();
			}
		}
	}

	public bool FrozenFrameIsPauseTree => false;

	public Graph graph => null;

	void ISerializationCallbackReceiver.OnBeforeSerialize()
	{
		if (!Threader.applicationIsPlaying)
		{
			_objectReferences = new List<UnityEngine.Object>();
			_serializedList = JSONSerializer.Serialize(typeof(ActionList), _actionList, _graphByteData, _objectReferences);
		}
	}

	void ISerializationCallbackReceiver.OnAfterDeserialize()
	{
		_actionList = JSONSerializer.Deserialize<ActionList>(_serializedList, _graphByteData, _objectReferences);
		if (_actionList == null)
		{
			_actionList = (ActionList)Task.Create(typeof(ActionList), this);
		}
	}

	public static ActionListPlayer Create()
	{
		return new GameObject("ActionList").AddComponent<ActionListPlayer>();
	}

	protected void Awake()
	{
		UpdateTasksOwner();
		if (playOnAwake)
		{
			Play();
		}
	}

	public void UpdateTasksOwner()
	{
		actionList.SetOwnerSystem(this);
		foreach (ActionTask action in actionList.actions)
		{
			action.SetOwnerSystem(this);
			BBParameter.SetBBFields(action, blackboard);
		}
	}

	void ITaskSystem.SendEvent(string name, object value, object sender)
	{
	}

	void ITaskSystem.SendEvent<T>(string name, T value, object sender)
	{
	}

	[ContextMenu("Play")]
	public void Play()
	{
		Play(this, blackboard, null);
	}

	public void Play(Action<Status> OnFinish)
	{
		Play(this, blackboard, OnFinish);
	}

	public void Play(Component agent, IBlackboard blackboard, Action<Status> OnFinish)
	{
		if (Application.isPlaying)
		{
			timeStarted = Time.time;
			actionList.ExecuteIndependent(agent, blackboard, OnFinish);
		}
	}

	public Status Execute()
	{
		return actionList.Execute(this, blackboard);
	}

	public Status Execute(Component agent)
	{
		return actionList.Execute(agent, blackboard);
	}
}
