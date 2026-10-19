using System;
using System.Collections;
using System.Collections.Generic;
using System.Reflection;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace BehaviorDesigner.Runtime;

[Serializable]
public abstract class Behavior : MonoBehaviour, IBehavior
{
	public enum EventTypes
	{
		OnCollisionEnter,
		OnCollisionExit,
		OnTriggerEnter,
		OnTriggerExit,
		OnCollisionEnter2D,
		OnCollisionExit2D,
		OnTriggerEnter2D,
		OnTriggerExit2D,
		OnControllerColliderHit,
		OnLateUpdate,
		OnFixedUpdate,
		OnAnimatorIK,
		None
	}

	public delegate void BehaviorHandler(Behavior behavior);

	public enum GizmoViewMode
	{
		Running,
		Always,
		Selected,
		Never
	}

	[SerializeField]
	[UnityEngine.Tooltip("If true, the behavior tree will start running when the component is enabled.")]
	private bool startWhenEnabled = true;

	[UnityEngine.Tooltip("Specifies if the behavior tree should load in a separate thread.Because Unity does not allow for API calls to be made on worker threads this option should be disabled if you are using property mappingsfor the shared variables.")]
	[SerializeField]
	private bool asynchronousLoad;

	[SerializeField]
	[UnityEngine.Tooltip("If true, the behavior tree will pause when the component is disabled. If false, the behavior tree will end.")]
	private bool pauseWhenDisabled;

	[SerializeField]
	[UnityEngine.Tooltip("If true, the behavior tree will restart from the beginning when it has completed execution. If false, the behavior tree will end.")]
	private bool restartWhenComplete;

	[UnityEngine.Tooltip("Used for debugging. If enabled, the behavior tree will output any time a task status changes, such as it starting or stopping.")]
	[SerializeField]
	private bool logTaskChanges;

	[SerializeField]
	[UnityEngine.Tooltip("A numerical grouping of behavior trees. Can be used to easily find behavior trees.")]
	private int group;

	[SerializeField]
	[UnityEngine.Tooltip("If true, the variables and task public variables will be reset to their original values when the tree restarts.")]
	private bool resetValuesOnRestart;

	[SerializeField]
	[UnityEngine.Tooltip("A field to specify the external behavior tree that should be run when this behavior tree starts.")]
	private ExternalBehavior externalBehavior;

	private bool hasInheritedVariables;

	[SerializeField]
	private BehaviorSource mBehaviorSource;

	private bool isPaused;

	private TaskStatus executionStatus;

	private bool initialized;

	private bool isAsyncLoading;

	private Dictionary<Task, Dictionary<string, object>> defaultValues;

	private Dictionary<SharedVariable, object> defaultVariableValues;

	private bool[] hasEvent = new bool[12];

	private Dictionary<string, List<TaskCoroutine>> activeTaskCoroutines;

	private Dictionary<Type, Dictionary<string, Delegate>> eventTable;

	public GizmoViewMode gizmoViewMode;

	public bool showBehaviorDesignerGizmo = true;

	public bool StartWhenEnabled
	{
		get
		{
			return startWhenEnabled;
		}
		set
		{
			startWhenEnabled = value;
		}
	}

	public bool AsynchronousLoad
	{
		get
		{
			return asynchronousLoad;
		}
		set
		{
			asynchronousLoad = value;
		}
	}

	public bool PauseWhenDisabled
	{
		get
		{
			return pauseWhenDisabled;
		}
		set
		{
			pauseWhenDisabled = value;
		}
	}

	public bool RestartWhenComplete
	{
		get
		{
			return restartWhenComplete;
		}
		set
		{
			restartWhenComplete = value;
		}
	}

	public bool LogTaskChanges
	{
		get
		{
			return logTaskChanges;
		}
		set
		{
			logTaskChanges = value;
		}
	}

	public int Group
	{
		get
		{
			return group;
		}
		set
		{
			group = value;
		}
	}

	public bool ResetValuesOnRestart
	{
		get
		{
			return resetValuesOnRestart;
		}
		set
		{
			resetValuesOnRestart = value;
		}
	}

	public ExternalBehavior ExternalBehavior
	{
		get
		{
			return externalBehavior;
		}
		set
		{
			if (externalBehavior == value)
			{
				return;
			}
			if (BehaviorManager.instance != null)
			{
				BehaviorManager.instance.DisableBehavior(this);
			}
			if (value != null && value.Initialized)
			{
				List<SharedVariable> allVariables = mBehaviorSource.GetAllVariables();
				mBehaviorSource = value.BehaviorSource;
				mBehaviorSource.HasSerialized = true;
				if (allVariables != null)
				{
					for (int i = 0; i < allVariables.Count; i++)
					{
						if (allVariables[i] != null)
						{
							mBehaviorSource.SetVariable(allVariables[i].Name, allVariables[i]);
						}
					}
				}
			}
			else
			{
				mBehaviorSource.HasSerialized = false;
				hasInheritedVariables = false;
			}
			initialized = false;
			externalBehavior = value;
			if (startWhenEnabled)
			{
				EnableBehavior();
			}
		}
	}

	public bool HasInheritedVariables
	{
		get
		{
			return hasInheritedVariables;
		}
		set
		{
			hasInheritedVariables = value;
		}
	}

	public string BehaviorName
	{
		get
		{
			return mBehaviorSource.behaviorName;
		}
		set
		{
			mBehaviorSource.behaviorName = value;
		}
	}

	public string BehaviorDescription
	{
		get
		{
			return mBehaviorSource.behaviorDescription;
		}
		set
		{
			mBehaviorSource.behaviorDescription = value;
		}
	}

	public TaskStatus ExecutionStatus
	{
		get
		{
			return executionStatus;
		}
		set
		{
			executionStatus = value;
		}
	}

	public bool IsAsyncLoading
	{
		get
		{
			return isAsyncLoading;
		}
		set
		{
			isAsyncLoading = value;
		}
	}

	public bool[] HasEvent => hasEvent;

	public event BehaviorHandler OnBehaviorStart;

	public event BehaviorHandler OnBehaviorRestart;

	public event BehaviorHandler OnBehaviorEnd;

	public BehaviorSource GetBehaviorSource()
	{
		return mBehaviorSource;
	}

	public void SetBehaviorSource(BehaviorSource behaviorSource)
	{
		mBehaviorSource = behaviorSource;
	}

	public UnityEngine.Object GetObject()
	{
		return this;
	}

	public string GetOwnerName()
	{
		return gameObject.name;
	}

	public Behavior()
	{
		mBehaviorSource = new BehaviorSource(this);
	}

	public void Start()
	{
		if (startWhenEnabled)
		{
			EnableBehavior();
		}
	}

	public void EnableBehavior()
	{
		CreateBehaviorManager();
		if (BehaviorManager.instance != null)
		{
			BehaviorManager.instance.EnableBehavior(this);
		}
	}

	public void DisableBehavior()
	{
		if (BehaviorManager.instance != null)
		{
			BehaviorManager.instance.DisableBehavior(this, pauseWhenDisabled);
			isPaused = pauseWhenDisabled;
		}
	}

	public void DisableBehavior(bool pause)
	{
		if (BehaviorManager.instance != null)
		{
			BehaviorManager.instance.DisableBehavior(this, pause);
			isPaused = pause;
		}
	}

	public void OnEnable()
	{
		if (BehaviorManager.instance != null && isPaused)
		{
			BehaviorManager.instance.EnableBehavior(this);
			isPaused = false;
		}
		else if (startWhenEnabled && initialized)
		{
			EnableBehavior();
		}
	}

	public void OnDisable()
	{
		DisableBehavior();
	}

	public void OnDestroy()
	{
		if (BehaviorManager.instance != null)
		{
			BehaviorManager.instance.DestroyBehavior(this);
		}
	}

	public SharedVariable GetVariable(string name)
	{
		CheckForSerialization();
		return mBehaviorSource.GetVariable(name);
	}

	public void SetVariable(string name, SharedVariable item)
	{
		CheckForSerialization();
		mBehaviorSource.SetVariable(name, item);
	}

	public void SetVariableValue(string name, object value)
	{
		SharedVariable variable = GetVariable(name);
		if (variable != null)
		{
			if (value is SharedVariable)
			{
				SharedVariable sharedVariable = value as SharedVariable;
				if (!string.IsNullOrEmpty(sharedVariable.PropertyMapping))
				{
					variable.PropertyMapping = sharedVariable.PropertyMapping;
					variable.PropertyMappingOwner = sharedVariable.PropertyMappingOwner;
					variable.InitializePropertyMapping(mBehaviorSource);
				}
				else
				{
					variable.SetValue(sharedVariable.GetValue());
				}
			}
			else
			{
				variable.SetValue(value);
			}
		}
		else if (value is SharedVariable)
		{
			SharedVariable sharedVariable2 = value as SharedVariable;
			SharedVariable sharedVariable3 = TaskUtility.CreateInstance(sharedVariable2.GetType()) as SharedVariable;
			sharedVariable3.Name = sharedVariable2.Name;
			sharedVariable3.IsShared = sharedVariable2.IsShared;
			sharedVariable3.IsGlobal = sharedVariable2.IsGlobal;
			if (!string.IsNullOrEmpty(sharedVariable2.PropertyMapping))
			{
				sharedVariable3.PropertyMapping = sharedVariable2.PropertyMapping;
				sharedVariable3.PropertyMappingOwner = sharedVariable2.PropertyMappingOwner;
				sharedVariable3.InitializePropertyMapping(mBehaviorSource);
			}
			else
			{
				sharedVariable3.SetValue(sharedVariable2.GetValue());
			}
			mBehaviorSource.SetVariable(name, sharedVariable3);
		}
		else
		{
			Debug.LogError("Error: No variable exists with name " + name);
		}
	}

	public List<SharedVariable> GetAllVariables()
	{
		CheckForSerialization();
		return mBehaviorSource.GetAllVariables();
	}

	public void CheckForSerialization()
	{
		CheckForSerialization(forceSerialization: false, BehaviorManager.IsPlaying);
	}

	public void CheckForSerialization(bool forceSerialization, bool isPlaying)
	{
		if (externalBehavior != null)
		{
			bool hasSerialized = mBehaviorSource.HasSerialized;
			mBehaviorSource.CheckForSerialization(forceSerialization || !hasSerialized, null, isPlaying);
			List<SharedVariable> allVariables = mBehaviorSource.GetAllVariables();
			hasInheritedVariables = allVariables != null && allVariables.Count > 0;
			externalBehavior.BehaviorSource.Owner = ExternalBehavior;
			externalBehavior.BehaviorSource.CheckForSerialization(forceSerialization || !hasSerialized, GetBehaviorSource(), isPlaying);
			externalBehavior.BehaviorSource.EntryTask = mBehaviorSource.EntryTask;
			if (!hasInheritedVariables)
			{
				return;
			}
			for (int i = 0; i < allVariables.Count; i++)
			{
				if (allVariables[i] != null)
				{
					mBehaviorSource.SetVariable(allVariables[i].Name, allVariables[i]);
				}
			}
		}
		else
		{
			mBehaviorSource.CheckForSerialization(force: false, null, isPlaying);
		}
	}

	public void OnCollisionEnter(Collision collision)
	{
		if (hasEvent[0] && BehaviorManager.instance != null)
		{
			BehaviorManager.instance.BehaviorOnCollisionEnter(collision, this);
		}
	}

	public void OnCollisionExit(Collision collision)
	{
		if (hasEvent[1] && BehaviorManager.instance != null)
		{
			BehaviorManager.instance.BehaviorOnCollisionExit(collision, this);
		}
	}

	public void OnTriggerEnter(Collider other)
	{
		if (hasEvent[2] && BehaviorManager.instance != null)
		{
			BehaviorManager.instance.BehaviorOnTriggerEnter(other, this);
		}
	}

	public void OnTriggerExit(Collider other)
	{
		if (hasEvent[3] && BehaviorManager.instance != null)
		{
			BehaviorManager.instance.BehaviorOnTriggerExit(other, this);
		}
	}

	public void OnCollisionEnter2D(Collision2D collision)
	{
		if (hasEvent[4] && BehaviorManager.instance != null)
		{
			BehaviorManager.instance.BehaviorOnCollisionEnter2D(collision, this);
		}
	}

	public void OnCollisionExit2D(Collision2D collision)
	{
		if (hasEvent[5] && BehaviorManager.instance != null)
		{
			BehaviorManager.instance.BehaviorOnCollisionExit2D(collision, this);
		}
	}

	public void OnTriggerEnter2D(Collider2D other)
	{
		if (hasEvent[6] && BehaviorManager.instance != null)
		{
			BehaviorManager.instance.BehaviorOnTriggerEnter2D(other, this);
		}
	}

	public void OnTriggerExit2D(Collider2D other)
	{
		if (hasEvent[7] && BehaviorManager.instance != null)
		{
			BehaviorManager.instance.BehaviorOnTriggerExit2D(other, this);
		}
	}

	public void OnControllerColliderHit(ControllerColliderHit hit)
	{
		if (hasEvent[8] && BehaviorManager.instance != null)
		{
			BehaviorManager.instance.BehaviorOnControllerColliderHit(hit, this);
		}
	}

	public void OnAnimatorIK()
	{
		if (hasEvent[11] && BehaviorManager.instance != null)
		{
			BehaviorManager.instance.BehaviorOnAnimatorIK(this);
		}
	}

	public void OnDrawGizmos()
	{
		DrawTaskGizmos(selected: false);
	}

	public void OnDrawGizmosSelected()
	{
		if (showBehaviorDesignerGizmo)
		{
			Gizmos.DrawIcon(transform.position, "Behavior Designer Scene Icon.png");
		}
		DrawTaskGizmos(selected: true);
	}

	private void DrawTaskGizmos(bool selected)
	{
		if (gizmoViewMode == GizmoViewMode.Never || (gizmoViewMode == GizmoViewMode.Selected && !selected) || (gizmoViewMode != GizmoViewMode.Running && gizmoViewMode != GizmoViewMode.Always && (!Application.isPlaying || ExecutionStatus != TaskStatus.Running) && Application.isPlaying))
		{
			return;
		}
		CheckForSerialization();
		DrawTaskGizmos(mBehaviorSource.RootTask);
		List<Task> detachedTasks = mBehaviorSource.DetachedTasks;
		if (detachedTasks != null)
		{
			for (int i = 0; i < detachedTasks.Count; i++)
			{
				DrawTaskGizmos(detachedTasks[i]);
			}
		}
	}

	private void DrawTaskGizmos(Task task)
	{
		if (task == null || (gizmoViewMode == GizmoViewMode.Running && !task.NodeData.IsReevaluating && (task.NodeData.IsReevaluating || task.NodeData.ExecutionStatus != TaskStatus.Running)))
		{
			return;
		}
		task.OnDrawGizmos();
		if (!(task is ParentTask))
		{
			return;
		}
		ParentTask parentTask = task as ParentTask;
		if (parentTask.Children != null)
		{
			for (int i = 0; i < parentTask.Children.Count; i++)
			{
				DrawTaskGizmos(parentTask.Children[i]);
			}
		}
	}

	public T FindTask<T>() where T : Task
	{
		CheckForSerialization();
		return FindTask<T>(mBehaviorSource.RootTask);
	}

	private T FindTask<T>(Task task) where T : Task
	{
		if (task.GetType().Equals(typeof(T)))
		{
			return (T)task;
		}
		if (task is ParentTask { Children: not null } parentTask)
		{
			for (int i = 0; i < parentTask.Children.Count; i++)
			{
				T val = null;
				if ((val = FindTask<T>(parentTask.Children[i])) != null)
				{
					return val;
				}
			}
		}
		return null;
	}

	public List<T> FindTasks<T>() where T : Task
	{
		CheckForSerialization();
		List<T> taskList = new List<T>();
		FindTasks(mBehaviorSource.RootTask, ref taskList);
		return taskList;
	}

	private void FindTasks<T>(Task task, ref List<T> taskList) where T : Task
	{
		if (typeof(T).IsAssignableFrom(task.GetType()))
		{
			taskList.Add((T)task);
		}
		if (task is ParentTask { Children: not null } parentTask)
		{
			for (int i = 0; i < parentTask.Children.Count; i++)
			{
				FindTasks(parentTask.Children[i], ref taskList);
			}
		}
	}

	public Task FindTaskWithName(string taskName)
	{
		CheckForSerialization();
		return FindTaskWithName(taskName, mBehaviorSource.RootTask);
	}

	private Task FindTaskWithName(string taskName, Task task)
	{
		if (task.FriendlyName.Equals(taskName))
		{
			return task;
		}
		if (task is ParentTask { Children: not null } parentTask)
		{
			for (int i = 0; i < parentTask.Children.Count; i++)
			{
				Task task2 = null;
				if ((task2 = FindTaskWithName(taskName, parentTask.Children[i])) != null)
				{
					return task2;
				}
			}
		}
		return null;
	}

	public List<Task> FindTasksWithName(string taskName)
	{
		CheckForSerialization();
		List<Task> taskList = new List<Task>();
		FindTasksWithName(taskName, mBehaviorSource.RootTask, ref taskList);
		return taskList;
	}

	private void FindTasksWithName(string taskName, Task task, ref List<Task> taskList)
	{
		if (task.FriendlyName.Equals(taskName))
		{
			taskList.Add(task);
		}
		if (task is ParentTask { Children: not null } parentTask)
		{
			for (int i = 0; i < parentTask.Children.Count; i++)
			{
				FindTasksWithName(taskName, parentTask.Children[i], ref taskList);
			}
		}
	}

	public List<Task> GetActiveTasks()
	{
		if (BehaviorManager.instance == null)
		{
			return null;
		}
		return BehaviorManager.instance.GetActiveTasks(this);
	}

	public Coroutine StartTaskCoroutine(Task task, string methodName)
	{
		MethodInfo method = task.GetType().GetMethod(methodName, BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic);
		if (method == null)
		{
			Debug.LogError("Unable to start coroutine " + methodName + ": method not found");
			return null;
		}
		if (activeTaskCoroutines == null)
		{
			activeTaskCoroutines = new Dictionary<string, List<TaskCoroutine>>();
		}
		TaskCoroutine taskCoroutine = new TaskCoroutine(this, (IEnumerator)method.Invoke(task, new object[0]), methodName);
		if (activeTaskCoroutines.ContainsKey(methodName))
		{
			List<TaskCoroutine> list = activeTaskCoroutines[methodName];
			list.Add(taskCoroutine);
			activeTaskCoroutines[methodName] = list;
		}
		else
		{
			List<TaskCoroutine> list2 = new List<TaskCoroutine>();
			list2.Add(taskCoroutine);
			activeTaskCoroutines.Add(methodName, list2);
		}
		return taskCoroutine.Coroutine;
	}

	public Coroutine StartTaskCoroutine(Task task, string methodName, object value)
	{
		MethodInfo method = task.GetType().GetMethod(methodName, BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic);
		if (method == null)
		{
			Debug.LogError("Unable to start coroutine " + methodName + ": method not found");
			return null;
		}
		if (activeTaskCoroutines == null)
		{
			activeTaskCoroutines = new Dictionary<string, List<TaskCoroutine>>();
		}
		TaskCoroutine taskCoroutine = new TaskCoroutine(this, (IEnumerator)method.Invoke(task, new object[1] { value }), methodName);
		if (activeTaskCoroutines.ContainsKey(methodName))
		{
			List<TaskCoroutine> list = activeTaskCoroutines[methodName];
			list.Add(taskCoroutine);
			activeTaskCoroutines[methodName] = list;
		}
		else
		{
			List<TaskCoroutine> list2 = new List<TaskCoroutine>();
			list2.Add(taskCoroutine);
			activeTaskCoroutines.Add(methodName, list2);
		}
		return taskCoroutine.Coroutine;
	}

	public void StopTaskCoroutine(string methodName)
	{
		if (activeTaskCoroutines.ContainsKey(methodName))
		{
			List<TaskCoroutine> list = activeTaskCoroutines[methodName];
			for (int i = 0; i < list.Count; i++)
			{
				list[i].Stop();
			}
		}
	}

	public void StopAllTaskCoroutines()
	{
		StopAllCoroutines();
		if (activeTaskCoroutines == null)
		{
			return;
		}
		foreach (KeyValuePair<string, List<TaskCoroutine>> activeTaskCoroutine in activeTaskCoroutines)
		{
			List<TaskCoroutine> value = activeTaskCoroutine.Value;
			for (int i = 0; i < value.Count; i++)
			{
				value[i].Stop();
			}
		}
	}

	public void TaskCoroutineEnded(TaskCoroutine taskCoroutine, string coroutineName)
	{
		if (activeTaskCoroutines.ContainsKey(coroutineName))
		{
			List<TaskCoroutine> list = activeTaskCoroutines[coroutineName];
			if (list.Count == 1)
			{
				activeTaskCoroutines.Remove(coroutineName);
				return;
			}
			list.Remove(taskCoroutine);
			activeTaskCoroutines[coroutineName] = list;
		}
	}

	public void OnBehaviorStarted()
	{
		if (!initialized)
		{
			CheckForEventMethods(new HashSet<Type>(), mBehaviorSource.RootTask);
			initialized = true;
		}
		if (OnBehaviorStart != null)
		{
			OnBehaviorStart(this);
		}
	}

	private void CheckForEventMethods(HashSet<Type> typesChecked, Task task)
	{
		if (task == null)
		{
			return;
		}
		if (!typesChecked.Contains(task.GetType()))
		{
			MethodInfo[] methods = task.GetType().GetMethods(BindingFlags.DeclaredOnly | BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic);
			if (methods != null)
			{
				for (int i = 0; i < 12; i++)
				{
					if (hasEvent[i])
					{
						continue;
					}
					EventTypes eventTypes = (EventTypes)i;
					string value = eventTypes.ToString();
					for (int j = 0; j < methods.Length; j++)
					{
						hasEvent[i] = methods[j].Name.Equals(value);
						if (hasEvent[i])
						{
							break;
						}
					}
					typesChecked.Add(task.GetType());
				}
			}
		}
		if (!(task is ParentTask))
		{
			return;
		}
		ParentTask parentTask = task as ParentTask;
		if (parentTask.Children != null)
		{
			for (int k = 0; k < parentTask.Children.Count; k++)
			{
				CheckForEventMethods(typesChecked, parentTask.Children[k]);
			}
		}
	}

	public void OnBehaviorRestarted()
	{
		if (OnBehaviorRestart != null)
		{
			OnBehaviorRestart(this);
		}
	}

	public void OnBehaviorEnded()
	{
		if (OnBehaviorEnd != null)
		{
			OnBehaviorEnd(this);
		}
	}

	private void RegisterEvent(string name, Delegate handler)
	{
		if (eventTable == null)
		{
			eventTable = new Dictionary<Type, Dictionary<string, Delegate>>();
		}
		if (!eventTable.TryGetValue(handler.GetType(), out var value))
		{
			value = new Dictionary<string, Delegate>();
			eventTable.Add(handler.GetType(), value);
		}
		if (value.TryGetValue(name, out var value2))
		{
			value[name] = Delegate.Combine(value2, handler);
		}
		else
		{
			value.Add(name, handler);
		}
	}

	public void RegisterEvent(string name, System.Action handler)
	{
		RegisterEvent(name, (Delegate)handler);
	}

	public void RegisterEvent<T>(string name, Action<T> handler)
	{
		RegisterEvent(name, (Delegate)handler);
	}

	public void RegisterEvent<T, U>(string name, Action<T, U> handler)
	{
		RegisterEvent(name, (Delegate)handler);
	}

	public void RegisterEvent<T, U, V>(string name, Action<T, U, V> handler)
	{
		RegisterEvent(name, (Delegate)handler);
	}

	private Delegate GetDelegate(string name, Type type)
	{
		if (eventTable != null && eventTable.TryGetValue(type, out var value) && value.TryGetValue(name, out var value2))
		{
			return value2;
		}
		return null;
	}

	public void SendEvent(string name)
	{
		if (GetDelegate(name, typeof(System.Action)) is System.Action action)
		{
			action();
		}
	}

	public void SendEvent<T>(string name, T arg1)
	{
		if (GetDelegate(name, typeof(Action<T>)) is Action<T> action)
		{
			action(arg1);
		}
	}

	public void SendEvent<T, U>(string name, T arg1, U arg2)
	{
		if (GetDelegate(name, typeof(Action<T, U>)) is Action<T, U> action)
		{
			action(arg1, arg2);
		}
	}

	public void SendEvent<T, U, V>(string name, T arg1, U arg2, V arg3)
	{
		if (GetDelegate(name, typeof(Action<T, U, V>)) is Action<T, U, V> action)
		{
			action(arg1, arg2, arg3);
		}
	}

	private void UnregisterEvent(string name, Delegate handler)
	{
		if (eventTable != null && eventTable.TryGetValue(handler.GetType(), out var value) && value.TryGetValue(name, out var value2))
		{
			value[name] = Delegate.Remove(value2, handler);
		}
	}

	public void UnregisterEvent(string name, System.Action handler)
	{
		UnregisterEvent(name, (Delegate)handler);
	}

	public void UnregisterEvent<T>(string name, Action<T> handler)
	{
		UnregisterEvent(name, (Delegate)handler);
	}

	public void UnregisterEvent<T, U>(string name, Action<T, U> handler)
	{
		UnregisterEvent(name, (Delegate)handler);
	}

	public void UnregisterEvent<T, U, V>(string name, Action<T, U, V> handler)
	{
		UnregisterEvent(name, (Delegate)handler);
	}

	public void SaveResetValues()
	{
		if (defaultValues == null)
		{
			CheckForSerialization();
			defaultValues = new Dictionary<Task, Dictionary<string, object>>();
			defaultVariableValues = new Dictionary<SharedVariable, object>();
			SaveValues();
		}
		else
		{
			ResetValues();
		}
	}

	private void SaveValues()
	{
		List<SharedVariable> allVariables = mBehaviorSource.GetAllVariables();
		if (allVariables != null)
		{
			for (int i = 0; i < allVariables.Count; i++)
			{
				defaultVariableValues.Add(allVariables[i], allVariables[i].GetValue());
			}
		}
		SaveValue(mBehaviorSource.RootTask);
	}

	private void SaveValue(Task task)
	{
		if (task == null)
		{
			return;
		}
		FieldInfo[] publicFields = TaskUtility.GetPublicFields(task.GetType());
		Dictionary<string, object> dictionary = new Dictionary<string, object>();
		for (int i = 0; i < publicFields.Length; i++)
		{
			object value = publicFields[i].GetValue(task);
			if (value is SharedVariable)
			{
				SharedVariable sharedVariable = value as SharedVariable;
				if (sharedVariable.IsGlobal || sharedVariable.IsShared)
				{
					continue;
				}
			}
			dictionary.Add(publicFields[i].Name, publicFields[i].GetValue(task));
		}
		defaultValues.Add(task, dictionary);
		if (!(task is ParentTask))
		{
			return;
		}
		ParentTask parentTask = task as ParentTask;
		if (parentTask.Children != null)
		{
			for (int j = 0; j < parentTask.Children.Count; j++)
			{
				SaveValue(parentTask.Children[j]);
			}
		}
	}

	private void ResetValues()
	{
		foreach (KeyValuePair<SharedVariable, object> defaultVariableValue in defaultVariableValues)
		{
			SetVariableValue(defaultVariableValue.Key.Name, defaultVariableValue.Value);
		}
		ResetValue(mBehaviorSource.RootTask);
	}

	private void ResetValue(Task task)
	{
		if (task == null || !defaultValues.TryGetValue(task, out var value))
		{
			return;
		}
		foreach (KeyValuePair<string, object> item in value)
		{
			FieldInfo field = task.GetType().GetField(item.Key);
			if (field != null)
			{
				field.SetValue(task, item.Value);
			}
		}
		if (!(task is ParentTask))
		{
			return;
		}
		ParentTask parentTask = task as ParentTask;
		if (parentTask.Children != null)
		{
			for (int i = 0; i < parentTask.Children.Count; i++)
			{
				ResetValue(parentTask.Children[i]);
			}
		}
	}

	public override string ToString()
	{
		return mBehaviorSource.ToString();
	}

	public static BehaviorManager CreateBehaviorManager()
	{
		if (BehaviorManager.instance == null && Application.isPlaying)
		{
			return new GameObject
			{
				name = "Behavior Manager"
			}.AddComponent<BehaviorManager>();
		}
		return null;
	}

	[RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.SubsystemRegistration)]
	private static void DomainReset()
	{
		Behavior[] array = UnityEngine.Object.FindObjectsOfType<Behavior>();
		if (array != null)
		{
			for (int i = 0; i < array.Length; i++)
			{
				array[i].mBehaviorSource.HasSerialized = false;
			}
		}
	}

	int IBehavior.GetInstanceID()
	{
		return GetInstanceID();
	}
}
