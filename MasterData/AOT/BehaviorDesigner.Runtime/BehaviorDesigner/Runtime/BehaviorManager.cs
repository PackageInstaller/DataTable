using System;
using System.Collections;
using System.Collections.Generic;
using System.Reflection;
using System.Threading;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace BehaviorDesigner.Runtime;

[AddComponentMenu("Behavior Designer/Behavior Manager")]
public class BehaviorManager : MonoBehaviour
{
	public enum ExecutionsPerTickType
	{
		NoDuplicates,
		Count
	}

	public delegate void BehaviorManagerHandler();

	public class BehaviorTree
	{
		public class ConditionalReevaluate
		{
			public int index;

			public TaskStatus taskStatus;

			public int compositeIndex = -1;

			public int stackIndex = -1;

			public void Initialize(int i, TaskStatus status, int stack, int composite)
			{
				index = i;
				taskStatus = status;
				stackIndex = stack;
				compositeIndex = composite;
			}
		}

		public List<Task> taskList = new List<Task>();

		public List<int> parentIndex = new List<int>();

		public List<List<int>> childrenIndex = new List<List<int>>();

		public List<int> relativeChildIndex = new List<int>();

		public List<Stack<int>> activeStack = new List<Stack<int>>();

		public List<TaskStatus> nonInstantTaskStatus = new List<TaskStatus>();

		public List<int> interruptionIndex = new List<int>();

		public List<TaskStatus> interruptionTaskStatus = new List<TaskStatus>();

		public List<ConditionalReevaluate> conditionalReevaluate = new List<ConditionalReevaluate>();

		public Dictionary<int, ConditionalReevaluate> conditionalReevaluateMap = new Dictionary<int, ConditionalReevaluate>();

		public List<int> parentReevaluate = new List<int>();

		public List<int> parentCompositeIndex = new List<int>();

		public List<List<int>> childConditionalIndex = new List<List<int>>();

		public int executionCount;

		public Behavior behavior;

		public bool destroyBehavior;

		public string errorState;

		public void Initialize(Behavior b)
		{
			behavior = b;
			for (int num = childrenIndex.Count - 1; num > -1; num--)
			{
				ObjectPool.Return(childrenIndex[num]);
			}
			for (int num2 = activeStack.Count - 1; num2 > -1; num2--)
			{
				ObjectPool.Return(activeStack[num2]);
			}
			for (int num3 = childConditionalIndex.Count - 1; num3 > -1; num3--)
			{
				ObjectPool.Return(childConditionalIndex[num3]);
			}
			taskList.Clear();
			parentIndex.Clear();
			childrenIndex.Clear();
			relativeChildIndex.Clear();
			activeStack.Clear();
			nonInstantTaskStatus.Clear();
			interruptionIndex.Clear();
			interruptionTaskStatus.Clear();
			conditionalReevaluate.Clear();
			conditionalReevaluateMap.Clear();
			parentReevaluate.Clear();
			parentCompositeIndex.Clear();
			childConditionalIndex.Clear();
		}
	}

	public enum ThirdPartyObjectType
	{
		PlayMaker,
		uScript,
		DialogueSystem,
		uSequencer
	}

	public class ThirdPartyTask
	{
		private Task task;

		private ThirdPartyObjectType thirdPartyObjectType;

		public Task Task
		{
			get
			{
				return task;
			}
			set
			{
				task = value;
			}
		}

		public ThirdPartyObjectType ThirdPartyObjectType => thirdPartyObjectType;

		public void Initialize(Task t, ThirdPartyObjectType objectType)
		{
			task = t;
			thirdPartyObjectType = objectType;
		}
	}

	public class ThirdPartyTaskComparer : IEqualityComparer<ThirdPartyTask>
	{
		public bool Equals(ThirdPartyTask a, ThirdPartyTask b)
		{
			if (a == null)
			{
				return false;
			}
			if (b == null)
			{
				return false;
			}
			return a.Task.Equals(b.Task);
		}

		public int GetHashCode(ThirdPartyTask obj)
		{
			return obj?.Task.GetHashCode() ?? 0;
		}
	}

	public class TaskAddData
	{
		public class OverrideFieldValue
		{
			private object value;

			private int depth;

			public object Value => value;

			public int Depth => depth;

			public void Initialize(object v, int d)
			{
				value = v;
				depth = d;
			}
		}

		public bool fromExternalTask;

		public ParentTask parentTask;

		public int parentIndex = -1;

		public int depth;

		public int compositeParentIndex = -1;

		public Vector2 offset;

		public Stack<Dictionary<string, OverrideFieldValue>> overridesStack;

		public int errorTask = -1;

		public string errorTaskName = "";

		public void Initialize()
		{
			fromExternalTask = false;
			parentTask = null;
			parentIndex = -1;
			depth = 0;
			compositeParentIndex = -1;
			overridesStack = new Stack<Dictionary<string, OverrideFieldValue>>();
		}

		public void Destroy()
		{
			if (overridesStack != null)
			{
				foreach (Dictionary<string, OverrideFieldValue> item in overridesStack)
				{
					foreach (KeyValuePair<string, OverrideFieldValue> item2 in item)
					{
						ObjectPool.Return(item2);
					}
				}
			}
			overridesStack = null;
		}
	}

	private class BehaviorThreadLoader
	{
		private Behavior behavior;

		private GameObject gameObject;

		private string gameObjectName;

		private Transform transform;

		private Func<Behavior, GameObject, string, Transform, BehaviorTree> loadBehaviorAction;

		private Thread thread;

		private BehaviorTree behaviorTree;

		public Behavior Behavior => behavior;

		public Thread Thread
		{
			get
			{
				return thread;
			}
			set
			{
				thread = value;
			}
		}

		public BehaviorTree BehaviorTree => behaviorTree;

		public BehaviorThreadLoader(Behavior behaviorTree, Func<Behavior, GameObject, string, Transform, BehaviorTree> action)
		{
			behavior = behaviorTree;
			gameObject = behavior.gameObject;
			gameObjectName = gameObject.name;
			transform = behavior.transform;
			loadBehaviorAction = action;
		}

		public void LoadBehavior()
		{
			behaviorTree = loadBehaviorAction(behavior, gameObject, gameObjectName, transform);
		}
	}

	public static BehaviorManager instance;

	[SerializeField]
	private UpdateIntervalType updateInterval;

	[SerializeField]
	private float updateIntervalSeconds;

	[SerializeField]
	private ExecutionsPerTickType executionsPerTick;

	[SerializeField]
	private int maxTaskExecutionsPerTick = 100;

	private WaitForSeconds updateWait;

	public BehaviorManagerHandler onEnableBehavior;

	public BehaviorManagerHandler onTaskBreakpoint;

	private static bool isPlaying;

	private UnityEngine.Object lockObject = new UnityEngine.Object();

	private List<BehaviorTree> behaviorTrees = new List<BehaviorTree>();

	private Dictionary<Behavior, BehaviorTree> pausedBehaviorTrees = new Dictionary<Behavior, BehaviorTree>();

	private Dictionary<Behavior, BehaviorTree> behaviorTreeMap = new Dictionary<Behavior, BehaviorTree>();

	private List<int> conditionalParentIndexes = new List<int>();

	private List<BehaviorThreadLoader> activeThreads;

	private IEnumerator threadLoaderCoroutine;

	private Dictionary<object, ThirdPartyTask> objectTaskMap = new Dictionary<object, ThirdPartyTask>();

	private Dictionary<ThirdPartyTask, object> taskObjectMap = new Dictionary<ThirdPartyTask, object>(new ThirdPartyTaskComparer());

	private ThirdPartyTask thirdPartyTaskCompare = new ThirdPartyTask();

	private static MethodInfo playMakerStopMethod;

	private static MethodInfo uScriptStopMethod;

	private static MethodInfo dialogueSystemStopMethod;

	private static MethodInfo uSequencerStopMethod;

	private static object[] invokeParameters;

	private Behavior breakpointTree;

	private bool dirty;

	public UpdateIntervalType UpdateInterval
	{
		get
		{
			return updateInterval;
		}
		set
		{
			updateInterval = value;
			UpdateIntervalChanged();
		}
	}

	public float UpdateIntervalSeconds
	{
		get
		{
			return updateIntervalSeconds;
		}
		set
		{
			updateIntervalSeconds = value;
			UpdateIntervalChanged();
		}
	}

	public ExecutionsPerTickType ExecutionsPerTick
	{
		get
		{
			return executionsPerTick;
		}
		set
		{
			executionsPerTick = value;
		}
	}

	public int MaxTaskExecutionsPerTick
	{
		get
		{
			return maxTaskExecutionsPerTick;
		}
		set
		{
			maxTaskExecutionsPerTick = value;
		}
	}

	public BehaviorManagerHandler OnEnableBehavior
	{
		set
		{
			onEnableBehavior = value;
		}
	}

	public BehaviorManagerHandler OnTaskBreakpoint
	{
		get
		{
			return onTaskBreakpoint;
		}
		set
		{
			onTaskBreakpoint = (BehaviorManagerHandler)Delegate.Combine(onTaskBreakpoint, value);
		}
	}

	public static bool IsPlaying
	{
		get
		{
			return isPlaying;
		}
		set
		{
			isPlaying = value;
		}
	}

	public List<BehaviorTree> BehaviorTrees => behaviorTrees;

	private static MethodInfo PlayMakerStopMethod
	{
		get
		{
			if (playMakerStopMethod == null)
			{
				playMakerStopMethod = TaskUtility.GetTypeWithinAssembly("BehaviorDesigner.Runtime.BehaviorManager_PlayMaker").GetMethod("StopPlayMaker");
			}
			return playMakerStopMethod;
		}
	}

	private static MethodInfo UScriptStopMethod
	{
		get
		{
			if (uScriptStopMethod == null)
			{
				uScriptStopMethod = TaskUtility.GetTypeWithinAssembly("BehaviorDesigner.Runtime.BehaviorManager_uScript").GetMethod("StopuScript");
			}
			return uScriptStopMethod;
		}
	}

	private static MethodInfo DialogueSystemStopMethod
	{
		get
		{
			if (dialogueSystemStopMethod == null)
			{
				dialogueSystemStopMethod = TaskUtility.GetTypeWithinAssembly("BehaviorDesigner.Runtime.BehaviorManager_DialogueSystem").GetMethod("StopDialogueSystem");
			}
			return dialogueSystemStopMethod;
		}
	}

	private static MethodInfo USequencerStopMethod
	{
		get
		{
			if (uSequencerStopMethod == null)
			{
				uSequencerStopMethod = TaskUtility.GetTypeWithinAssembly("BehaviorDesigner.Runtime.BehaviorManager_uSequencer").GetMethod("StopuSequencer");
			}
			return uSequencerStopMethod;
		}
	}

	public Behavior BreakpointTree
	{
		get
		{
			return breakpointTree;
		}
		set
		{
			breakpointTree = value;
		}
	}

	public bool Dirty
	{
		get
		{
			return dirty;
		}
		set
		{
			dirty = value;
		}
	}

	public void Awake()
	{
		instance = this;
		isPlaying = true;
		UpdateIntervalChanged();
	}

	private void UpdateIntervalChanged()
	{
		StopCoroutine("CoroutineUpdate");
		if (updateInterval == UpdateIntervalType.EveryFrame)
		{
			enabled = true;
		}
		else if (updateInterval == UpdateIntervalType.SpecifySeconds)
		{
			if (Application.isPlaying)
			{
				updateWait = new WaitForSeconds(updateIntervalSeconds);
				StartCoroutine("CoroutineUpdate");
			}
			enabled = false;
		}
		else
		{
			enabled = false;
		}
	}

	public void OnDestroy()
	{
		for (int num = behaviorTrees.Count - 1; num > -1; num--)
		{
			DisableBehavior(behaviorTrees[num].behavior);
		}
		ObjectPool.Clear();
		instance = null;
		isPlaying = false;
	}

	public void OnApplicationQuit()
	{
		for (int num = behaviorTrees.Count - 1; num > -1; num--)
		{
			DisableBehavior(behaviorTrees[num].behavior);
		}
	}

	public void EnableBehavior(Behavior behavior)
	{
		if (behavior.IsAsyncLoading)
		{
			Debug.LogWarning("Warning: Unable to enable behavior tree when the tree is already being loaded.");
		}
		else
		{
			if (IsBehaviorEnabled(behavior))
			{
				return;
			}
			if (pausedBehaviorTrees.TryGetValue(behavior, out var value))
			{
				behaviorTrees.Add(value);
				pausedBehaviorTrees.Remove(behavior);
				behavior.ExecutionStatus = TaskStatus.Running;
				for (int i = 0; i < value.taskList.Count; i++)
				{
					value.taskList[i].OnPause(paused: false);
				}
			}
			else if (behavior.AsynchronousLoad)
			{
				BehaviorThreadLoader behaviorThreadLoader = new BehaviorThreadLoader(behavior, LoadBehavior);
				Thread thread = (behaviorThreadLoader.Thread = new Thread(behaviorThreadLoader.LoadBehavior));
				behavior.IsAsyncLoading = true;
				thread.Start();
				if (activeThreads == null)
				{
					activeThreads = new List<BehaviorThreadLoader>();
				}
				activeThreads.Add(behaviorThreadLoader);
				if (threadLoaderCoroutine == null)
				{
					threadLoaderCoroutine = CheckThreadLoaders();
					StartCoroutine(threadLoaderCoroutine);
				}
			}
			else
			{
				value = LoadBehavior(behavior, behavior.gameObject, behavior.gameObject.name, behavior.transform);
				LoadBehaviorComplete(behavior, value);
			}
		}
	}

	private IEnumerator CheckThreadLoaders()
	{
		WaitForEndOfFrame endOfFrame = new WaitForEndOfFrame();
		while (activeThreads.Count > 0)
		{
			for (int num = activeThreads.Count - 1; num >= 0; num--)
			{
				if (!activeThreads[num].Thread.IsAlive)
				{
					LoadBehaviorComplete(activeThreads[num].Behavior, activeThreads[num].BehaviorTree);
					activeThreads.RemoveAt(num);
				}
			}
			yield return endOfFrame;
		}
		threadLoaderCoroutine = null;
	}

	private BehaviorTree LoadBehavior(Behavior behavior, GameObject behaviorGameObject, string gameObjectName, Transform behaviorTransform)
	{
		BehaviorTree behaviorTree = ObjectPool.Get<BehaviorTree>();
		lock (lockObject)
		{
			behavior.CheckForSerialization(forceSerialization: false, isPlaying: true);
		}
		Task rootTask = behavior.GetBehaviorSource().RootTask;
		if (rootTask == null)
		{
			behaviorTree.errorState = $"The behavior \"{behavior.GetBehaviorSource().behaviorName}\" on GameObject \"{gameObjectName}\" contains no root task. This behavior will be disabled.";
			return behaviorTree;
		}
		behaviorTree.Initialize(behavior);
		behaviorTree.parentIndex.Add(-1);
		behaviorTree.relativeChildIndex.Add(-1);
		behaviorTree.parentCompositeIndex.Add(-1);
		TaskAddData taskAddData = ObjectPool.Get<TaskAddData>();
		taskAddData.Initialize();
		bool hasExternalBehavior = behavior.ExternalBehavior != null;
		switch (AddToTaskList(behaviorTree, rootTask, behaviorGameObject, behaviorTransform, ref hasExternalBehavior, taskAddData))
		{
		case -1:
			behaviorTree.errorState = $"The behavior \"{behavior.GetBehaviorSource().behaviorName}\" on GameObject \"{gameObjectName}\" contains a parent task ({taskAddData.errorTaskName} (index {taskAddData.errorTask})) with no children. This behavior will be disabled.";
			break;
		case -2:
			behaviorTree.errorState = $"The behavior \"{behavior.GetBehaviorSource().behaviorName}\" on GameObject \"{gameObjectName}\" cannot find the referenced external task. This behavior will be disabled.";
			break;
		case -3:
			behaviorTree.errorState = $"The behavior \"{behavior.GetBehaviorSource().behaviorName}\" on GameObject \"{gameObjectName}\" contains a null task (referenced from parent task {taskAddData.errorTaskName} (index {taskAddData.errorTask})). This behavior will be disabled.";
			break;
		case -4:
			behaviorTree.errorState = $"The behavior \"{behavior.GetBehaviorSource().behaviorName}\" on GameObject \"{behaviorGameObject.name}\" contains multiple external behavior trees at the root task or as a child of a parent task which cannot contain so many children (such as a decorator task). This behavior will be disabled.";
			break;
		case -5:
			behaviorTree.errorState = $"The behavior \"{behavior.GetBehaviorSource().behaviorName}\" on GameObject \"{gameObjectName}\" contains a Behavior Tree Reference task ({taskAddData.errorTaskName} (index {taskAddData.errorTask})) that which has an element with a null value in the externalBehaviors array. This behavior will be disabled.";
			break;
		case -6:
			behaviorTree.errorState = $"The behavior \"{behavior.GetBehaviorSource().behaviorName}\" on GameObject \"{gameObjectName}\" contains a root task which is disabled. This behavior will be disabled.";
			break;
		}
		taskAddData.Destroy();
		ObjectPool.Return(taskAddData);
		return behaviorTree;
	}

	private void LoadBehaviorComplete(Behavior behavior, BehaviorTree behaviorTree)
	{
		if (behavior == null || behaviorTree == null)
		{
			return;
		}
		if (!string.IsNullOrEmpty(behaviorTree.errorState))
		{
			Debug.LogError(behaviorTree.errorState);
			return;
		}
		behavior.IsAsyncLoading = false;
		dirty = true;
		if (behavior.ExternalBehavior != null)
		{
			behavior.GetBehaviorSource().EntryTask = behavior.ExternalBehavior.BehaviorSource.EntryTask;
		}
		behavior.GetBehaviorSource().RootTask = behaviorTree.taskList[0];
		if (behavior.ResetValuesOnRestart)
		{
			behavior.SaveResetValues();
		}
		Stack<int> stack = ObjectPool.Get<Stack<int>>();
		stack.Clear();
		behaviorTree.activeStack.Add(stack);
		behaviorTree.interruptionIndex.Add(-1);
		behaviorTree.interruptionTaskStatus.Add(TaskStatus.Failure);
		behaviorTree.nonInstantTaskStatus.Add(TaskStatus.Inactive);
		if (behaviorTree.behavior.LogTaskChanges)
		{
			for (int i = 0; i < behaviorTree.taskList.Count; i++)
			{
				Debug.Log($"{RoundedTime()}: Task {behaviorTree.taskList[i].FriendlyName} ({behaviorTree.taskList[i].GetType()}, index {i}) {behaviorTree.taskList[i].GetHashCode()}");
			}
		}
		for (int j = 0; j < behaviorTree.taskList.Count; j++)
		{
			behaviorTree.taskList[j].OnAwake();
		}
		behaviorTrees.Add(behaviorTree);
		behaviorTreeMap.Add(behavior, behaviorTree);
		if (onEnableBehavior != null)
		{
			onEnableBehavior();
		}
		if (!behaviorTree.taskList[0].Disabled)
		{
			behavior.OnBehaviorStarted();
			behavior.ExecutionStatus = TaskStatus.Running;
			PushTask(behaviorTree, 0, 0);
		}
	}

	private int AddToTaskList(BehaviorTree behaviorTree, Task task, GameObject behaviorGameObject, Transform behaviorTransform, ref bool hasExternalBehavior, TaskAddData data)
	{
		if (task == null)
		{
			return -3;
		}
		task.GameObject = behaviorGameObject;
		task.Transform = behaviorTransform;
		task.Owner = behaviorTree.behavior;
		if (task is BehaviorReference)
		{
			BehaviorSource[] array = null;
			if (!(task is BehaviorReference behaviorReference))
			{
				return -2;
			}
			ExternalBehavior[] array2 = null;
			if ((array2 = behaviorReference.GetExternalBehaviors()) == null)
			{
				return -2;
			}
			array = new BehaviorSource[array2.Length];
			for (int i = 0; i < array2.Length; i++)
			{
				if (array2[i] == null)
				{
					data.errorTask = behaviorTree.taskList.Count;
					data.errorTaskName = ((!string.IsNullOrEmpty(task.FriendlyName)) ? task.FriendlyName : task.GetType().ToString());
					return -5;
				}
				array[i] = array2[i].BehaviorSource;
				array[i].Owner = array2[i];
			}
			if (array == null)
			{
				return -2;
			}
			ParentTask parentTask = data.parentTask;
			int parentIndex = data.parentIndex;
			int compositeParentIndex = data.compositeParentIndex;
			data.offset = task.NodeData.Offset;
			data.depth++;
			Dictionary<string, TaskAddData.OverrideFieldValue> dictionary = ObjectPool.Get<Dictionary<string, TaskAddData.OverrideFieldValue>>();
			dictionary.Clear();
			data.overridesStack.Push(dictionary);
			for (int j = 0; j < array.Length; j++)
			{
				BehaviorSource behaviorSource = ObjectPool.Get<BehaviorSource>();
				behaviorSource.Initialize(array[j].Owner);
				lock (lockObject)
				{
					array[j].CheckForSerialization(force: true, behaviorSource, isPlaying: true);
				}
				Task rootTask = behaviorSource.RootTask;
				if (rootTask != null)
				{
					if (rootTask is ParentTask)
					{
						rootTask.NodeData.Collapsed = (task as BehaviorReference).collapsed;
					}
					rootTask.Disabled = task.Disabled;
					if (behaviorReference.variables != null)
					{
						for (int k = 0; k < behaviorReference.variables.Length; k++)
						{
							if (behaviorReference.variables[k] != null)
							{
								TaskAddData.OverrideFieldValue overrideFieldValue = ObjectPool.Get<TaskAddData.OverrideFieldValue>();
								overrideFieldValue.Initialize(behaviorReference.variables[k].Value, data.depth);
								dictionary[behaviorReference.variables[k].Value.name] = overrideFieldValue;
							}
						}
					}
					if (behaviorSource.Variables != null)
					{
						for (int l = 0; l < behaviorSource.Variables.Count; l++)
						{
							if (behaviorSource.Variables[l] != null)
							{
								SharedVariable sharedVariable = null;
								if ((sharedVariable = behaviorTree.behavior.GetVariable(behaviorSource.Variables[l].Name)) == null)
								{
									sharedVariable = behaviorSource.Variables[l];
									behaviorTree.behavior.SetVariable(sharedVariable.Name, sharedVariable);
								}
								else
								{
									behaviorSource.Variables[l].SetValue(sharedVariable.GetValue());
								}
								if (!dictionary.ContainsKey(sharedVariable.Name))
								{
									TaskAddData.OverrideFieldValue overrideFieldValue2 = ObjectPool.Get<TaskAddData.OverrideFieldValue>();
									overrideFieldValue2.Initialize(sharedVariable, data.depth);
									dictionary.Add(sharedVariable.Name, overrideFieldValue2);
								}
							}
						}
					}
					ObjectPool.Return(behaviorSource);
					if (j > 0)
					{
						data.parentTask = parentTask;
						data.parentIndex = parentIndex;
						data.compositeParentIndex = compositeParentIndex;
						if (data.parentTask == null || j >= data.parentTask.MaxChildren())
						{
							return -4;
						}
						behaviorTree.parentIndex.Add(data.parentIndex);
						behaviorTree.relativeChildIndex.Add(data.parentTask.Children.Count);
						behaviorTree.parentCompositeIndex.Add(data.compositeParentIndex);
						behaviorTree.childrenIndex[data.parentIndex].Add(behaviorTree.taskList.Count);
						data.parentTask.AddChild(rootTask, data.parentTask.Children.Count);
					}
					hasExternalBehavior = true;
					bool fromExternalTask = data.fromExternalTask;
					data.fromExternalTask = true;
					int num = 0;
					if ((num = AddToTaskList(behaviorTree, rootTask, behaviorGameObject, behaviorTransform, ref hasExternalBehavior, data)) < 0)
					{
						return num;
					}
					data.fromExternalTask = fromExternalTask;
					continue;
				}
				ObjectPool.Return(behaviorSource);
				return -2;
			}
			dictionary.Clear();
			ObjectPool.Return(dictionary);
			data.overridesStack.Pop();
			data.depth--;
		}
		else
		{
			if (behaviorTree.taskList.Count == 0 && task.Disabled)
			{
				return -6;
			}
			task.ReferenceID = behaviorTree.taskList.Count;
			behaviorTree.taskList.Add(task);
			OverrideFields(behaviorTree, data, task);
			if (data.fromExternalTask)
			{
				if (data.parentTask == null)
				{
					task.NodeData.Offset = behaviorTree.behavior.GetBehaviorSource().RootTask.NodeData.Offset;
				}
				else
				{
					int index = behaviorTree.relativeChildIndex[behaviorTree.relativeChildIndex.Count - 1];
					data.parentTask.ReplaceAddChild(task, index);
					if (data.offset != Vector2.zero)
					{
						task.NodeData.Offset = data.offset;
						data.offset = Vector2.zero;
					}
				}
			}
			if (task is ParentTask)
			{
				ParentTask parentTask2 = task as ParentTask;
				if (parentTask2.Children == null || parentTask2.Children.Count == 0)
				{
					data.errorTask = behaviorTree.taskList.Count - 1;
					data.errorTaskName = ((!string.IsNullOrEmpty(behaviorTree.taskList[data.errorTask].FriendlyName)) ? behaviorTree.taskList[data.errorTask].FriendlyName : behaviorTree.taskList[data.errorTask].GetType().ToString());
					return -1;
				}
				int num2 = behaviorTree.taskList.Count - 1;
				List<int> list = ObjectPool.Get<List<int>>();
				list.Clear();
				behaviorTree.childrenIndex.Add(list);
				list = ObjectPool.Get<List<int>>();
				list.Clear();
				behaviorTree.childConditionalIndex.Add(list);
				int count = parentTask2.Children.Count;
				for (int m = 0; m < count; m++)
				{
					behaviorTree.parentIndex.Add(num2);
					behaviorTree.relativeChildIndex.Add(m);
					behaviorTree.childrenIndex[num2].Add(behaviorTree.taskList.Count);
					data.parentTask = task as ParentTask;
					data.parentIndex = num2;
					if (task is Composite)
					{
						data.compositeParentIndex = num2;
					}
					behaviorTree.parentCompositeIndex.Add(data.compositeParentIndex);
					int num3;
					if ((num3 = AddToTaskList(behaviorTree, parentTask2.Children[m], behaviorGameObject, behaviorTransform, ref hasExternalBehavior, data)) < 0)
					{
						if (num3 == -3)
						{
							data.errorTask = num2;
							data.errorTaskName = ((!string.IsNullOrEmpty(behaviorTree.taskList[data.errorTask].FriendlyName)) ? behaviorTree.taskList[data.errorTask].FriendlyName : behaviorTree.taskList[data.errorTask].GetType().ToString());
						}
						return num3;
					}
				}
			}
			else
			{
				behaviorTree.childrenIndex.Add(null);
				behaviorTree.childConditionalIndex.Add(null);
				if (task is Conditional)
				{
					int num4 = behaviorTree.taskList.Count - 1;
					int num5 = behaviorTree.parentCompositeIndex[num4];
					if (num5 != -1)
					{
						behaviorTree.childConditionalIndex[num5].Add(num4);
					}
				}
			}
		}
		return 0;
	}

	private void OverrideFields(BehaviorTree behaviorTree, TaskAddData data, object obj)
	{
		if (obj == null || object.Equals(obj, null))
		{
			return;
		}
		FieldInfo[] serializableFields = TaskUtility.GetSerializableFields(obj.GetType());
		for (int i = 0; i < serializableFields.Length; i++)
		{
			object value = serializableFields[i].GetValue(obj);
			if (value == null)
			{
				continue;
			}
			if (typeof(SharedVariable).IsAssignableFrom(serializableFields[i].FieldType))
			{
				SharedVariable sharedVariable = OverrideSharedVariable(behaviorTree, data, serializableFields[i].FieldType, value as SharedVariable);
				if (sharedVariable != null)
				{
					serializableFields[i].SetValue(obj, sharedVariable);
				}
			}
			else if (typeof(IList).IsAssignableFrom(serializableFields[i].FieldType))
			{
				Type fieldType;
				if ((typeof(SharedVariable).IsAssignableFrom(fieldType = serializableFields[i].FieldType.GetElementType()) || (serializableFields[i].FieldType.IsGenericType && typeof(SharedVariable).IsAssignableFrom(fieldType = serializableFields[i].FieldType.GetGenericArguments()[0]))) && value is IList list)
				{
					for (int j = 0; j < list.Count; j++)
					{
						SharedVariable sharedVariable2 = OverrideSharedVariable(behaviorTree, data, fieldType, list[j] as SharedVariable);
						if (sharedVariable2 != null)
						{
							list[j] = sharedVariable2;
						}
					}
				}
			}
			else if (serializableFields[i].FieldType.IsClass && !serializableFields[i].FieldType.Equals(typeof(Type)) && !typeof(Delegate).IsAssignableFrom(serializableFields[i].FieldType))
			{
				OverrideFields(behaviorTree, data, value);
			}
			if (!TaskUtility.HasAttribute(serializableFields[i], typeof(InspectTaskAttribute)))
			{
				continue;
			}
			if (typeof(IList).IsAssignableFrom(serializableFields[i].FieldType))
			{
				Type elementType;
				if (typeof(Task).IsAssignableFrom(elementType = serializableFields[i].FieldType.GetElementType()) && value is IList list2)
				{
					for (int k = 0; k < list2.Count; k++)
					{
						OverrideFields(behaviorTree, data, list2[k] as Task);
					}
				}
			}
			else if (typeof(Task).IsAssignableFrom(serializableFields[i].FieldType))
			{
				OverrideFields(behaviorTree, data, value);
			}
		}
	}

	private SharedVariable OverrideSharedVariable(BehaviorTree behaviorTree, TaskAddData data, Type fieldType, SharedVariable sharedVariable)
	{
		SharedVariable sharedVariable2 = sharedVariable;
		if (sharedVariable is SharedGenericVariable)
		{
			sharedVariable = ((sharedVariable as SharedGenericVariable).GetValue() as GenericVariable).value;
		}
		else if (sharedVariable is SharedNamedVariable)
		{
			sharedVariable = ((sharedVariable as SharedNamedVariable).GetValue() as NamedVariable).value;
		}
		if (sharedVariable == null)
		{
			return null;
		}
		SharedVariable sharedVariable3 = null;
		if (!string.IsNullOrEmpty(sharedVariable.Name))
		{
			foreach (Dictionary<string, TaskAddData.OverrideFieldValue> item in data.overridesStack)
			{
				string text = ((sharedVariable3 != null) ? sharedVariable3.Name : sharedVariable.Name);
				if (string.IsNullOrEmpty(text) || !item.TryGetValue(text, out var value))
				{
					continue;
				}
				SharedVariable sharedVariable4;
				if (value.Value is SharedVariable)
				{
					sharedVariable4 = value.Value as SharedVariable;
				}
				else if (value.Value is NamedVariable)
				{
					sharedVariable4 = (value.Value as NamedVariable).value;
					if (sharedVariable4.IsGlobal)
					{
						sharedVariable4 = GlobalVariables.Instance.GetVariable(sharedVariable4.Name);
					}
					else if (sharedVariable4.IsShared)
					{
						sharedVariable4 = behaviorTree.behavior.GetVariable(sharedVariable4.Name);
					}
				}
				else if (value.Value is GenericVariable)
				{
					sharedVariable4 = (value.Value as GenericVariable).value;
					if (sharedVariable4.IsGlobal)
					{
						sharedVariable4 = GlobalVariables.Instance.GetVariable(sharedVariable4.Name);
					}
					else if (sharedVariable4.IsShared)
					{
						sharedVariable4 = behaviorTree.behavior.GetVariable(sharedVariable4.Name);
					}
				}
				else
				{
					sharedVariable4 = null;
				}
				sharedVariable3 = sharedVariable4;
			}
		}
		if (!string.IsNullOrEmpty(sharedVariable.Name) && sharedVariable3 != null)
		{
			if (sharedVariable2 is SharedNamedVariable || sharedVariable2 is SharedGenericVariable)
			{
				if (fieldType.Equals(typeof(SharedVariable)) || sharedVariable3.GetType().Equals(sharedVariable.GetType()))
				{
					if (sharedVariable2 is SharedNamedVariable)
					{
						(sharedVariable2 as SharedNamedVariable).Value.value = sharedVariable3;
					}
					else if (sharedVariable2 is SharedGenericVariable)
					{
						(sharedVariable2 as SharedGenericVariable).Value.value = sharedVariable3;
					}
					behaviorTree.behavior.SetVariableValue(sharedVariable.Name, sharedVariable3.GetValue());
				}
			}
			else if (sharedVariable3 != null)
			{
				return sharedVariable3;
			}
		}
		return null;
	}

	public void DisableBehavior(Behavior behavior)
	{
		DisableBehavior(behavior, paused: false);
	}

	public void DisableBehavior(Behavior behavior, bool paused)
	{
		DisableBehavior(behavior, paused, TaskStatus.Success);
	}

	public void DisableBehavior(Behavior behavior, bool paused, TaskStatus executionStatus)
	{
		if (!IsBehaviorEnabled(behavior))
		{
			if (!pausedBehaviorTrees.ContainsKey(behavior) || paused)
			{
				if (activeThreads == null || activeThreads.Count <= 0)
				{
					return;
				}
				for (int i = 0; i < activeThreads.Count; i++)
				{
					if (activeThreads[i].Behavior == behavior)
					{
						activeThreads[i].Thread.Abort();
						activeThreads.RemoveAt(i);
						break;
					}
				}
				return;
			}
			EnableBehavior(behavior);
		}
		if (behavior.LogTaskChanges)
		{
			Debug.Log(string.Format("{0}: {1} {2}", RoundedTime(), paused ? "Pausing" : "Disabling", behavior.ToString()));
		}
		if (paused)
		{
			if (behaviorTreeMap.TryGetValue(behavior, out var value) && !pausedBehaviorTrees.ContainsKey(behavior))
			{
				pausedBehaviorTrees.Add(behavior, value);
				behavior.ExecutionStatus = TaskStatus.Inactive;
				for (int j = 0; j < value.taskList.Count; j++)
				{
					value.taskList[j].OnPause(paused: true);
				}
				behaviorTrees.Remove(value);
			}
		}
		else
		{
			DestroyBehavior(behavior, executionStatus);
		}
	}

	public void DestroyBehavior(Behavior behavior)
	{
		DestroyBehavior(behavior, TaskStatus.Success);
	}

	public void DestroyBehavior(Behavior behavior, TaskStatus executionStatus)
	{
		if (!behaviorTreeMap.TryGetValue(behavior, out var value) || value.destroyBehavior)
		{
			return;
		}
		value.destroyBehavior = true;
		if (pausedBehaviorTrees.ContainsKey(behavior))
		{
			pausedBehaviorTrees.Remove(behavior);
			for (int i = 0; i < value.taskList.Count; i++)
			{
				value.taskList[i].OnPause(paused: false);
			}
			behavior.ExecutionStatus = TaskStatus.Running;
		}
		TaskStatus status = executionStatus;
		for (int num = value.activeStack.Count - 1; num > -1; num--)
		{
			while (value.activeStack[num].Count > 0)
			{
				int count = value.activeStack[num].Count;
				PopTask(value, value.activeStack[num].Peek(), num, ref status, popChildren: true, notifyOnEmptyStack: false);
				if (count == 1)
				{
					break;
				}
			}
		}
		RemoveChildConditionalReevaluate(value, -1);
		for (int j = 0; j < value.taskList.Count; j++)
		{
			value.taskList[j].OnBehaviorComplete();
		}
		behaviorTreeMap.Remove(behavior);
		behaviorTrees.Remove(value);
		value.destroyBehavior = false;
		ObjectPool.Return(value);
		behavior.ExecutionStatus = status;
		behavior.OnBehaviorEnded();
	}

	public void RestartBehavior(Behavior behavior)
	{
		if (!IsBehaviorEnabled(behavior))
		{
			return;
		}
		BehaviorTree behaviorTree = behaviorTreeMap[behavior];
		TaskStatus status = TaskStatus.Success;
		for (int num = behaviorTree.activeStack.Count - 1; num > -1; num--)
		{
			while (behaviorTree.activeStack[num].Count > 0)
			{
				int count = behaviorTree.activeStack[num].Count;
				PopTask(behaviorTree, behaviorTree.activeStack[num].Peek(), num, ref status, popChildren: true, notifyOnEmptyStack: false);
				if (count == 1)
				{
					break;
				}
			}
		}
		Restart(behaviorTree);
	}

	public bool IsBehaviorEnabled(Behavior behavior)
	{
		if (behaviorTreeMap != null && behaviorTreeMap.Count > 0 && behavior != null)
		{
			return behavior.ExecutionStatus == TaskStatus.Running;
		}
		return false;
	}

	public void Update()
	{
		Tick();
	}

	public void LateUpdate()
	{
		for (int i = 0; i < behaviorTrees.Count; i++)
		{
			if (behaviorTrees[i].behavior.HasEvent[9])
			{
				for (int num = behaviorTrees[i].activeStack.Count - 1; num > -1; num--)
				{
					int index = behaviorTrees[i].activeStack[num].Peek();
					behaviorTrees[i].taskList[index].OnLateUpdate();
				}
			}
		}
	}

	public void FixedUpdate()
	{
		for (int i = 0; i < behaviorTrees.Count; i++)
		{
			if (behaviorTrees[i].behavior.HasEvent[10])
			{
				FixedTick(behaviorTrees[i]);
			}
		}
	}

	private void FixedTick(BehaviorTree behaviorTree)
	{
		for (int num = behaviorTree.activeStack.Count - 1; num > -1; num--)
		{
			int index = behaviorTree.activeStack[num].Peek();
			behaviorTree.taskList[index].OnFixedUpdate();
		}
	}

	private IEnumerator CoroutineUpdate()
	{
		while (true)
		{
			Tick();
			yield return updateWait;
		}
	}

	public void Tick()
	{
		for (int i = 0; i < behaviorTrees.Count; i++)
		{
			Tick(behaviorTrees[i]);
		}
	}

	public void Tick(Behavior behavior)
	{
		if (!(behavior == null) && IsBehaviorEnabled(behavior))
		{
			Tick(behaviorTreeMap[behavior]);
		}
	}

	public void FixedTick(Behavior behavior)
	{
		if (!(behavior == null) && IsBehaviorEnabled(behavior))
		{
			FixedTick(behaviorTreeMap[behavior]);
		}
	}

	private void Tick(BehaviorTree behaviorTree)
	{
		behaviorTree.executionCount = 0;
		ReevaluateParentTasks(behaviorTree);
		ReevaluateConditionalTasks(behaviorTree);
		int count = behaviorTree.activeStack.Count;
		for (int i = 0; i < count; i++)
		{
			TaskStatus status = TaskStatus.Running;
			if (i < behaviorTree.interruptionTaskStatus.Count)
			{
				status = behaviorTree.interruptionTaskStatus[i];
				int num;
				if (i < behaviorTree.interruptionIndex.Count && (num = behaviorTree.interruptionIndex[i]) != -1)
				{
					behaviorTree.interruptionIndex[i] = -1;
					while (behaviorTree.activeStack[i].Peek() != num)
					{
						int count2 = behaviorTree.activeStack[i].Count;
						PopTask(behaviorTree, behaviorTree.activeStack[i].Peek(), i, ref status, popChildren: true);
						if (count2 == 1)
						{
							break;
						}
					}
					if (i < behaviorTree.activeStack.Count && behaviorTree.activeStack[i].Count > 0 && behaviorTree.taskList[num] == behaviorTree.taskList[behaviorTree.activeStack[i].Peek()])
					{
						if (behaviorTree.taskList[num] is ParentTask)
						{
							status = (behaviorTree.taskList[num] as ParentTask).OverrideStatus();
						}
						PopTask(behaviorTree, num, i, ref status, popChildren: true);
					}
				}
			}
			int num2 = -1;
			while (status != TaskStatus.Running && i < behaviorTree.activeStack.Count && behaviorTree.activeStack[i].Count > 0)
			{
				int num3 = behaviorTree.activeStack[i].Peek();
				if ((i < behaviorTree.activeStack.Count && behaviorTree.activeStack[i].Count > 0 && num2 == behaviorTree.activeStack[i].Peek()) || !IsBehaviorEnabled(behaviorTree.behavior))
				{
					break;
				}
				num2 = num3;
				status = RunTask(behaviorTree, num3, i, status);
			}
		}
	}

	private void ReevaluateConditionalTasks(BehaviorTree behaviorTree)
	{
		for (int i = 0; i < behaviorTree.conditionalReevaluate.Count; i++)
		{
			if (behaviorTree.conditionalReevaluate[i].compositeIndex == -1)
			{
				continue;
			}
			int index = behaviorTree.conditionalReevaluate[i].index;
			TaskStatus taskStatus = behaviorTree.taskList[index].OnUpdate();
			if (taskStatus == behaviorTree.conditionalReevaluate[i].taskStatus)
			{
				continue;
			}
			if (behaviorTree.behavior.LogTaskChanges)
			{
				int num = behaviorTree.parentCompositeIndex[index];
				MonoBehaviour.print($"{RoundedTime()}: {behaviorTree.behavior.ToString()}: Conditional abort with task {behaviorTree.taskList[num].FriendlyName} ({behaviorTree.taskList[num].GetType()}, index {num}) because of conditional task {behaviorTree.taskList[index].FriendlyName} ({behaviorTree.taskList[index].GetType()}, index {index}) with status {taskStatus}");
			}
			int compositeIndex = behaviorTree.conditionalReevaluate[i].compositeIndex;
			for (int num2 = behaviorTree.activeStack.Count - 1; num2 > -1; num2--)
			{
				if (behaviorTree.activeStack[num2].Count > 0)
				{
					int num3 = behaviorTree.activeStack[num2].Peek();
					int num4 = FindLCA(behaviorTree, index, num3);
					if (IsChild(behaviorTree, num4, compositeIndex))
					{
						int count = behaviorTree.activeStack.Count;
						while (num3 != -1 && num3 != num4 && behaviorTree.activeStack.Count == count)
						{
							TaskStatus status = TaskStatus.Failure;
							behaviorTree.taskList[num3].OnConditionalAbort();
							PopTask(behaviorTree, num3, num2, ref status, popChildren: false);
							num3 = behaviorTree.parentIndex[num3];
						}
					}
				}
			}
			for (int num5 = behaviorTree.conditionalReevaluate.Count - 1; num5 > i - 1; num5--)
			{
				BehaviorTree.ConditionalReevaluate conditionalReevaluate = behaviorTree.conditionalReevaluate[num5];
				if (FindLCA(behaviorTree, compositeIndex, conditionalReevaluate.index) == compositeIndex)
				{
					behaviorTree.taskList[behaviorTree.conditionalReevaluate[num5].index].NodeData.IsReevaluating = false;
					ObjectPool.Return(behaviorTree.conditionalReevaluate[num5]);
					behaviorTree.conditionalReevaluateMap.Remove(behaviorTree.conditionalReevaluate[num5].index);
					behaviorTree.conditionalReevaluate.RemoveAt(num5);
				}
			}
			Composite composite = behaviorTree.taskList[behaviorTree.parentCompositeIndex[index]] as Composite;
			for (int num6 = i - 1; num6 > -1; num6--)
			{
				BehaviorTree.ConditionalReevaluate conditionalReevaluate2 = behaviorTree.conditionalReevaluate[num6];
				if (composite.AbortType == AbortType.LowerPriority && behaviorTree.parentCompositeIndex[conditionalReevaluate2.index] == behaviorTree.parentCompositeIndex[index])
				{
					behaviorTree.taskList[behaviorTree.conditionalReevaluate[num6].index].NodeData.IsReevaluating = false;
					behaviorTree.conditionalReevaluate[num6].compositeIndex = -1;
				}
				else if (behaviorTree.parentCompositeIndex[conditionalReevaluate2.index] == behaviorTree.parentCompositeIndex[index])
				{
					for (int j = 0; j < behaviorTree.childrenIndex[compositeIndex].Count; j++)
					{
						if (IsParentTask(behaviorTree, behaviorTree.childrenIndex[compositeIndex][j], conditionalReevaluate2.index))
						{
							int num7 = behaviorTree.childrenIndex[compositeIndex][j];
							while (!(behaviorTree.taskList[num7] is Composite) && behaviorTree.childrenIndex[num7] != null)
							{
								num7 = behaviorTree.childrenIndex[num7][0];
							}
							if (behaviorTree.taskList[num7] is Composite)
							{
								conditionalReevaluate2.compositeIndex = num7;
							}
							break;
						}
					}
				}
			}
			conditionalParentIndexes.Clear();
			for (int num8 = behaviorTree.parentIndex[index]; num8 != compositeIndex; num8 = behaviorTree.parentIndex[num8])
			{
				conditionalParentIndexes.Add(num8);
			}
			if (conditionalParentIndexes.Count == 0)
			{
				conditionalParentIndexes.Add(behaviorTree.parentIndex[index]);
			}
			ParentTask parentTask = behaviorTree.taskList[compositeIndex] as ParentTask;
			parentTask.OnConditionalAbort(behaviorTree.relativeChildIndex[conditionalParentIndexes[conditionalParentIndexes.Count - 1]]);
			for (int num9 = conditionalParentIndexes.Count - 1; num9 > -1; num9--)
			{
				parentTask = behaviorTree.taskList[conditionalParentIndexes[num9]] as ParentTask;
				if (num9 == 0)
				{
					parentTask.OnConditionalAbort(behaviorTree.relativeChildIndex[index]);
				}
				else
				{
					parentTask.OnConditionalAbort(behaviorTree.relativeChildIndex[conditionalParentIndexes[num9 - 1]]);
				}
			}
			behaviorTree.taskList[index].NodeData.InterruptTime = Time.realtimeSinceStartup;
		}
	}

	private void ReevaluateParentTasks(BehaviorTree behaviorTree)
	{
		for (int num = behaviorTree.parentReevaluate.Count - 1; num > -1; num--)
		{
			int num2 = behaviorTree.parentReevaluate[num];
			if (behaviorTree.taskList[num2] is Decorator)
			{
				if (behaviorTree.taskList[num2].OnUpdate() == TaskStatus.Failure)
				{
					Interrupt(behaviorTree.behavior, behaviorTree.taskList[num2], TaskStatus.Inactive);
				}
			}
			else if (behaviorTree.taskList[num2] is Composite)
			{
				Composite composite = behaviorTree.taskList[num2] as Composite;
				if (composite.OnReevaluationStarted())
				{
					int stackIndex = 0;
					TaskStatus status = RunParentTask(behaviorTree, num2, ref stackIndex, TaskStatus.Inactive);
					composite.OnReevaluationEnded(status);
				}
			}
		}
	}

	private TaskStatus RunTask(BehaviorTree behaviorTree, int taskIndex, int stackIndex, TaskStatus previousStatus)
	{
		Task task = behaviorTree.taskList[taskIndex];
		if (task == null)
		{
			return previousStatus;
		}
		if (task.Disabled)
		{
			if (behaviorTree.behavior.LogTaskChanges)
			{
				MonoBehaviour.print($"{RoundedTime()}: {behaviorTree.behavior.ToString()}: Skip task {behaviorTree.taskList[taskIndex].FriendlyName} ({behaviorTree.taskList[taskIndex].GetType()}, index {taskIndex}) at stack index {stackIndex} (task disabled)");
			}
			if (behaviorTree.parentIndex[taskIndex] != -1)
			{
				ParentTask parentTask = behaviorTree.taskList[behaviorTree.parentIndex[taskIndex]] as ParentTask;
				if (!parentTask.CanRunParallelChildren())
				{
					parentTask.OnChildExecuted(TaskStatus.Inactive);
				}
				else
				{
					parentTask.OnChildExecuted(behaviorTree.relativeChildIndex[taskIndex], TaskStatus.Inactive);
					RemoveStack(behaviorTree, stackIndex);
				}
			}
			return previousStatus;
		}
		TaskStatus status = previousStatus;
		if (!task.IsInstant && (behaviorTree.nonInstantTaskStatus[stackIndex] == TaskStatus.Failure || behaviorTree.nonInstantTaskStatus[stackIndex] == TaskStatus.Success))
		{
			status = behaviorTree.nonInstantTaskStatus[stackIndex];
			PopTask(behaviorTree, taskIndex, stackIndex, ref status, popChildren: true);
			return status;
		}
		PushTask(behaviorTree, taskIndex, stackIndex);
		if (breakpointTree != null)
		{
			return TaskStatus.Running;
		}
		if (task is ParentTask)
		{
			ParentTask obj = task as ParentTask;
			status = RunParentTask(behaviorTree, taskIndex, ref stackIndex, status);
			status = obj.OverrideStatus(status);
		}
		else
		{
			status = task.OnUpdate();
		}
		if (status != TaskStatus.Running)
		{
			if (task.IsInstant)
			{
				PopTask(behaviorTree, taskIndex, stackIndex, ref status, popChildren: true);
			}
			else
			{
				behaviorTree.nonInstantTaskStatus[stackIndex] = status;
			}
		}
		return status;
	}

	private TaskStatus RunParentTask(BehaviorTree behaviorTree, int taskIndex, ref int stackIndex, TaskStatus status)
	{
		ParentTask parentTask = behaviorTree.taskList[taskIndex] as ParentTask;
		if (!parentTask.CanRunParallelChildren() || parentTask.OverrideStatus(TaskStatus.Running) != TaskStatus.Running)
		{
			TaskStatus taskStatus = TaskStatus.Inactive;
			int num = stackIndex;
			int num2 = -1;
			Behavior behavior = behaviorTree.behavior;
			while (parentTask.CanExecute() && (taskStatus != TaskStatus.Running || parentTask.CanRunParallelChildren()) && IsBehaviorEnabled(behavior) && behaviorTree.childrenIndex.Count > taskIndex)
			{
				List<int> list = behaviorTree.childrenIndex[taskIndex];
				int num3 = parentTask.CurrentChildIndex();
				if (num3 == -1)
				{
					status = (taskStatus = TaskStatus.Running);
					continue;
				}
				if ((executionsPerTick == ExecutionsPerTickType.NoDuplicates && num3 == num2) || (executionsPerTick == ExecutionsPerTickType.Count && behaviorTree.executionCount >= maxTaskExecutionsPerTick))
				{
					if (executionsPerTick == ExecutionsPerTickType.Count)
					{
						Debug.LogWarning($"{RoundedTime()}: {behaviorTree.behavior.ToString()}: More than the specified number of task executions per tick ({maxTaskExecutionsPerTick}) have executed, returning early.");
					}
					status = TaskStatus.Running;
					break;
				}
				num2 = num3;
				if (parentTask.CanRunParallelChildren())
				{
					behaviorTree.activeStack.Add(ObjectPool.Get<Stack<int>>());
					behaviorTree.interruptionIndex.Add(-1);
					behaviorTree.interruptionTaskStatus.Add(TaskStatus.Failure);
					behaviorTree.nonInstantTaskStatus.Add(TaskStatus.Inactive);
					stackIndex = behaviorTree.activeStack.Count - 1;
					parentTask.OnChildStarted(num3);
				}
				else
				{
					parentTask.OnChildStarted();
				}
				status = (taskStatus = RunTask(behaviorTree, list[num3], stackIndex, status));
			}
			stackIndex = num;
		}
		return status;
	}

	private void PushTask(BehaviorTree behaviorTree, int taskIndex, int stackIndex)
	{
		if (!IsBehaviorEnabled(behaviorTree.behavior) || stackIndex >= behaviorTree.activeStack.Count)
		{
			return;
		}
		Stack<int> stack = behaviorTree.activeStack[stackIndex];
		if (stack.Count == 0 || stack.Peek() != taskIndex)
		{
			stack.Push(taskIndex);
			behaviorTree.nonInstantTaskStatus[stackIndex] = TaskStatus.Running;
			behaviorTree.executionCount++;
			Task task = behaviorTree.taskList[taskIndex];
			task.NodeData.PushTime = Time.realtimeSinceStartup;
			task.NodeData.ExecutionStatus = TaskStatus.Running;
			if (task.NodeData.IsBreakpoint && onTaskBreakpoint != null)
			{
				breakpointTree = behaviorTree.behavior;
				onTaskBreakpoint();
			}
			if (behaviorTree.behavior.LogTaskChanges)
			{
				MonoBehaviour.print($"{RoundedTime()}: {behaviorTree.behavior.ToString()}: Push task {task.FriendlyName} ({task.GetType()}, index {taskIndex}) at stack index {stackIndex}");
			}
			task.OnStart();
			if (task is ParentTask && (task as ParentTask).CanReevaluate())
			{
				behaviorTree.parentReevaluate.Add(taskIndex);
			}
		}
	}

	private void PopTask(BehaviorTree behaviorTree, int taskIndex, int stackIndex, ref TaskStatus status, bool popChildren)
	{
		PopTask(behaviorTree, taskIndex, stackIndex, ref status, popChildren, notifyOnEmptyStack: true);
	}

	private void PopTask(BehaviorTree behaviorTree, int taskIndex, int stackIndex, ref TaskStatus status, bool popChildren, bool notifyOnEmptyStack)
	{
		if (!IsBehaviorEnabled(behaviorTree.behavior) || stackIndex >= behaviorTree.activeStack.Count || behaviorTree.activeStack[stackIndex].Count == 0 || taskIndex != behaviorTree.activeStack[stackIndex].Peek())
		{
			return;
		}
		behaviorTree.activeStack[stackIndex].Pop();
		behaviorTree.nonInstantTaskStatus[stackIndex] = TaskStatus.Inactive;
		StopThirdPartyTask(behaviorTree, taskIndex);
		Task task = behaviorTree.taskList[taskIndex];
		task.OnEnd();
		int num = behaviorTree.parentIndex[taskIndex];
		task.NodeData.PushTime = -1f;
		task.NodeData.PopTime = Time.realtimeSinceStartup;
		task.NodeData.ExecutionStatus = status;
		if (behaviorTree.behavior.LogTaskChanges)
		{
			MonoBehaviour.print($"{RoundedTime()}: {behaviorTree.behavior.ToString()}: Pop task {task.FriendlyName} ({task.GetType()}, index {taskIndex}) at stack index {stackIndex} with status {status}");
		}
		if (num != -1)
		{
			if (task is Conditional)
			{
				int num2 = behaviorTree.parentCompositeIndex[taskIndex];
				if (num2 != -1)
				{
					Composite composite = behaviorTree.taskList[num2] as Composite;
					if (composite.AbortType != AbortType.None)
					{
						if (behaviorTree.conditionalReevaluateMap.TryGetValue(taskIndex, out var value))
						{
							value.compositeIndex = ((composite.AbortType != AbortType.LowerPriority) ? num2 : (-1));
							value.taskStatus = status;
							task.NodeData.IsReevaluating = composite.AbortType != AbortType.LowerPriority;
						}
						else
						{
							BehaviorTree.ConditionalReevaluate conditionalReevaluate = ObjectPool.Get<BehaviorTree.ConditionalReevaluate>();
							conditionalReevaluate.Initialize(taskIndex, status, stackIndex, (composite.AbortType != AbortType.LowerPriority) ? num2 : (-1));
							behaviorTree.conditionalReevaluate.Add(conditionalReevaluate);
							behaviorTree.conditionalReevaluateMap.Add(taskIndex, conditionalReevaluate);
							task.NodeData.IsReevaluating = composite.AbortType == AbortType.Self || composite.AbortType == AbortType.Both;
						}
					}
				}
			}
			ParentTask parentTask = behaviorTree.taskList[num] as ParentTask;
			if (!parentTask.CanRunParallelChildren())
			{
				parentTask.OnChildExecuted(status);
				status = parentTask.Decorate(status);
			}
			else
			{
				parentTask.OnChildExecuted(behaviorTree.relativeChildIndex[taskIndex], status);
			}
		}
		if (task is ParentTask)
		{
			ParentTask parentTask2 = task as ParentTask;
			if (parentTask2.CanReevaluate())
			{
				for (int num3 = behaviorTree.parentReevaluate.Count - 1; num3 > -1; num3--)
				{
					if (behaviorTree.parentReevaluate[num3] == taskIndex)
					{
						behaviorTree.parentReevaluate.RemoveAt(num3);
						break;
					}
				}
			}
			if (parentTask2 is Composite)
			{
				Composite composite2 = parentTask2 as Composite;
				if (composite2.AbortType == AbortType.Self || composite2.AbortType == AbortType.None || behaviorTree.activeStack[stackIndex].Count == 0)
				{
					RemoveChildConditionalReevaluate(behaviorTree, taskIndex);
				}
				else if (composite2.AbortType == AbortType.LowerPriority || composite2.AbortType == AbortType.Both)
				{
					int num4 = behaviorTree.parentCompositeIndex[taskIndex];
					if (num4 != -1)
					{
						if (!(behaviorTree.taskList[num4] as ParentTask).CanRunParallelChildren())
						{
							for (int i = 0; i < behaviorTree.childConditionalIndex[taskIndex].Count; i++)
							{
								int num5 = behaviorTree.childConditionalIndex[taskIndex][i];
								if (!behaviorTree.conditionalReevaluateMap.TryGetValue(num5, out var value2))
								{
									continue;
								}
								if (!(behaviorTree.taskList[num4] as ParentTask).CanRunParallelChildren())
								{
									value2.compositeIndex = behaviorTree.parentCompositeIndex[taskIndex];
									behaviorTree.taskList[num5].NodeData.IsReevaluating = true;
									continue;
								}
								for (int num6 = behaviorTree.conditionalReevaluate.Count - 1; num6 > i - 1; num6--)
								{
									BehaviorTree.ConditionalReevaluate conditionalReevaluate2 = behaviorTree.conditionalReevaluate[num6];
									if (FindLCA(behaviorTree, num4, conditionalReevaluate2.index) == num4)
									{
										behaviorTree.taskList[behaviorTree.conditionalReevaluate[num6].index].NodeData.IsReevaluating = false;
										ObjectPool.Return(behaviorTree.conditionalReevaluate[num6]);
										behaviorTree.conditionalReevaluateMap.Remove(behaviorTree.conditionalReevaluate[num6].index);
										behaviorTree.conditionalReevaluate.RemoveAt(num6);
									}
								}
							}
						}
						else
						{
							RemoveChildConditionalReevaluate(behaviorTree, taskIndex);
						}
					}
					for (int j = 0; j < behaviorTree.conditionalReevaluate.Count; j++)
					{
						if (behaviorTree.conditionalReevaluate[j].compositeIndex == taskIndex)
						{
							behaviorTree.conditionalReevaluate[j].compositeIndex = behaviorTree.parentCompositeIndex[taskIndex];
						}
					}
				}
			}
		}
		if (popChildren)
		{
			for (int num7 = behaviorTree.activeStack.Count - 1; num7 > stackIndex; num7--)
			{
				if (behaviorTree.activeStack[num7].Count > 0 && IsParentTask(behaviorTree, taskIndex, behaviorTree.activeStack[num7].Peek()))
				{
					TaskStatus status2 = TaskStatus.Failure;
					for (int num8 = behaviorTree.activeStack[num7].Count; num8 > 0; num8--)
					{
						PopTask(behaviorTree, behaviorTree.activeStack[num7].Peek(), num7, ref status2, popChildren: false, notifyOnEmptyStack);
					}
				}
			}
		}
		if (stackIndex >= behaviorTree.activeStack.Count || behaviorTree.activeStack[stackIndex].Count != 0)
		{
			return;
		}
		if (stackIndex == 0)
		{
			if (notifyOnEmptyStack)
			{
				if (behaviorTree.behavior.RestartWhenComplete)
				{
					Restart(behaviorTree);
				}
				else
				{
					DisableBehavior(behaviorTree.behavior, paused: false, status);
				}
			}
			status = TaskStatus.Inactive;
		}
		else
		{
			RemoveStack(behaviorTree, stackIndex);
			status = TaskStatus.Running;
		}
	}

	private void RemoveChildConditionalReevaluate(BehaviorTree behaviorTree, int compositeIndex)
	{
		for (int num = behaviorTree.conditionalReevaluate.Count - 1; num > -1; num--)
		{
			if (behaviorTree.conditionalReevaluate[num].compositeIndex == compositeIndex)
			{
				ObjectPool.Return(behaviorTree.conditionalReevaluate[num]);
				int index = behaviorTree.conditionalReevaluate[num].index;
				behaviorTree.conditionalReevaluateMap.Remove(index);
				behaviorTree.conditionalReevaluate.RemoveAt(num);
				behaviorTree.taskList[index].NodeData.IsReevaluating = false;
			}
		}
	}

	private void Restart(BehaviorTree behaviorTree)
	{
		if (behaviorTree.behavior.LogTaskChanges)
		{
			Debug.Log($"{RoundedTime()}: Restarting {behaviorTree.behavior.ToString()}");
		}
		RemoveChildConditionalReevaluate(behaviorTree, -1);
		if (behaviorTree.behavior.ResetValuesOnRestart)
		{
			behaviorTree.behavior.SaveResetValues();
		}
		for (int i = 0; i < behaviorTree.taskList.Count; i++)
		{
			behaviorTree.taskList[i].OnBehaviorRestart();
		}
		behaviorTree.behavior.OnBehaviorRestarted();
		PushTask(behaviorTree, 0, 0);
	}

	private bool IsParentTask(BehaviorTree behaviorTree, int possibleParent, int possibleChild)
	{
		int num = 0;
		for (int num2 = possibleChild; num2 != -1; num2 = num)
		{
			num = behaviorTree.parentIndex[num2];
			if (num == possibleParent)
			{
				return true;
			}
		}
		return false;
	}

	public void Interrupt(Behavior behavior, Task task, TaskStatus interruptTaskStatus = TaskStatus.Failure)
	{
		Interrupt(behavior, task, task, interruptTaskStatus);
	}

	public void Interrupt(Behavior behavior, Task task, Task interruptionTask, TaskStatus interruptTaskStatus = TaskStatus.Failure)
	{
		if (!IsBehaviorEnabled(behavior))
		{
			return;
		}
		int num = -1;
		BehaviorTree behaviorTree = behaviorTreeMap[behavior];
		for (int i = 0; i < behaviorTree.taskList.Count; i++)
		{
			if (behaviorTree.taskList[i].ReferenceID == task.ReferenceID)
			{
				num = i;
				break;
			}
		}
		if (num <= -1)
		{
			return;
		}
		for (int j = 0; j < behaviorTree.activeStack.Count; j++)
		{
			if (behaviorTree.activeStack[j].Count <= 0)
			{
				continue;
			}
			for (int num2 = behaviorTree.activeStack[j].Peek(); num2 != -1; num2 = behaviorTree.parentIndex[num2])
			{
				if (num2 == num)
				{
					behaviorTree.interruptionIndex[j] = num;
					behaviorTree.interruptionTaskStatus[j] = interruptTaskStatus;
					if (behavior.LogTaskChanges)
					{
						Debug.Log($"{RoundedTime()}: {behaviorTree.behavior.ToString()}: Interrupt task {task.FriendlyName} ({task.GetType().ToString()}) with index {num} at stack index {j}");
					}
					interruptionTask.NodeData.InterruptTime = Time.realtimeSinceStartup;
					break;
				}
			}
		}
	}

	public void StopThirdPartyTask(BehaviorTree behaviorTree, int taskIndex)
	{
		thirdPartyTaskCompare.Task = behaviorTree.taskList[taskIndex];
		if (taskObjectMap.TryGetValue(thirdPartyTaskCompare, out var value))
		{
			ThirdPartyObjectType thirdPartyObjectType = objectTaskMap[value].ThirdPartyObjectType;
			if (invokeParameters == null)
			{
				invokeParameters = new object[1];
			}
			invokeParameters[0] = behaviorTree.taskList[taskIndex];
			switch (thirdPartyObjectType)
			{
			case ThirdPartyObjectType.PlayMaker:
				PlayMakerStopMethod.Invoke(null, invokeParameters);
				break;
			case ThirdPartyObjectType.uScript:
				UScriptStopMethod.Invoke(null, invokeParameters);
				break;
			case ThirdPartyObjectType.DialogueSystem:
				DialogueSystemStopMethod.Invoke(null, invokeParameters);
				break;
			case ThirdPartyObjectType.uSequencer:
				USequencerStopMethod.Invoke(null, invokeParameters);
				break;
			}
			RemoveActiveThirdPartyTask(behaviorTree.taskList[taskIndex]);
		}
	}

	public void RemoveActiveThirdPartyTask(Task task)
	{
		thirdPartyTaskCompare.Task = task;
		if (taskObjectMap.TryGetValue(thirdPartyTaskCompare, out var value))
		{
			ObjectPool.Return(value);
			taskObjectMap.Remove(thirdPartyTaskCompare);
			objectTaskMap.Remove(value);
		}
	}

	private void RemoveStack(BehaviorTree behaviorTree, int stackIndex)
	{
		Stack<int> stack = behaviorTree.activeStack[stackIndex];
		stack.Clear();
		ObjectPool.Return(stack);
		behaviorTree.activeStack.RemoveAt(stackIndex);
		behaviorTree.interruptionIndex.RemoveAt(stackIndex);
		behaviorTree.nonInstantTaskStatus.RemoveAt(stackIndex);
	}

	private int FindLCA(BehaviorTree behaviorTree, int taskIndex1, int taskIndex2)
	{
		HashSet<int> hashSet = ObjectPool.Get<HashSet<int>>();
		hashSet.Clear();
		int num;
		for (num = taskIndex1; num != -1; num = behaviorTree.parentIndex[num])
		{
			hashSet.Add(num);
		}
		num = taskIndex2;
		while (!hashSet.Contains(num))
		{
			num = behaviorTree.parentIndex[num];
		}
		ObjectPool.Return(hashSet);
		return num;
	}

	private bool IsChild(BehaviorTree behaviorTree, int taskIndex1, int taskIndex2)
	{
		for (int num = taskIndex1; num != -1; num = behaviorTree.parentIndex[num])
		{
			if (num == taskIndex2)
			{
				return true;
			}
		}
		return false;
	}

	public List<Task> GetActiveTasks(Behavior behavior)
	{
		if (!IsBehaviorEnabled(behavior))
		{
			return null;
		}
		List<Task> list = new List<Task>();
		BehaviorTree behaviorTree = behaviorTreeMap[behavior];
		for (int i = 0; i < behaviorTree.activeStack.Count; i++)
		{
			Task task = behaviorTree.taskList[behaviorTree.activeStack[i].Peek()];
			if (task is BehaviorDesigner.Runtime.Tasks.Action)
			{
				list.Add(task);
			}
		}
		return list;
	}

	public void BehaviorOnCollisionEnter(Collision collision, Behavior behavior)
	{
		if (!IsBehaviorEnabled(behavior))
		{
			return;
		}
		BehaviorTree behaviorTree = behaviorTreeMap[behavior];
		for (int i = 0; i < behaviorTree.activeStack.Count; i++)
		{
			if (behaviorTree.activeStack[i].Count != 0)
			{
				int num = behaviorTree.activeStack[i].Peek();
				while (num != -1 && !behaviorTree.taskList[num].Disabled)
				{
					behaviorTree.taskList[num].OnCollisionEnter(collision);
					num = behaviorTree.parentIndex[num];
				}
			}
		}
		for (int j = 0; j < behaviorTree.conditionalReevaluate.Count; j++)
		{
			int num = behaviorTree.conditionalReevaluate[j].index;
			if (!behaviorTree.taskList[num].Disabled && behaviorTree.conditionalReevaluate[j].compositeIndex != -1)
			{
				behaviorTree.taskList[num].OnCollisionEnter(collision);
			}
		}
	}

	public void BehaviorOnCollisionExit(Collision collision, Behavior behavior)
	{
		if (!IsBehaviorEnabled(behavior))
		{
			return;
		}
		BehaviorTree behaviorTree = behaviorTreeMap[behavior];
		for (int i = 0; i < behaviorTree.activeStack.Count; i++)
		{
			if (behaviorTree.activeStack[i].Count != 0)
			{
				int num = behaviorTree.activeStack[i].Peek();
				while (num != -1 && !behaviorTree.taskList[num].Disabled)
				{
					behaviorTree.taskList[num].OnCollisionExit(collision);
					num = behaviorTree.parentIndex[num];
				}
			}
		}
		for (int j = 0; j < behaviorTree.conditionalReevaluate.Count; j++)
		{
			int num = behaviorTree.conditionalReevaluate[j].index;
			if (!behaviorTree.taskList[num].Disabled && behaviorTree.conditionalReevaluate[j].compositeIndex != -1)
			{
				behaviorTree.taskList[num].OnCollisionExit(collision);
			}
		}
	}

	public void BehaviorOnTriggerEnter(Collider other, Behavior behavior)
	{
		if (!IsBehaviorEnabled(behavior))
		{
			return;
		}
		BehaviorTree behaviorTree = behaviorTreeMap[behavior];
		for (int i = 0; i < behaviorTree.activeStack.Count; i++)
		{
			if (behaviorTree.activeStack[i].Count != 0)
			{
				int num = behaviorTree.activeStack[i].Peek();
				while (num != -1 && !behaviorTree.taskList[num].Disabled)
				{
					behaviorTree.taskList[num].OnTriggerEnter(other);
					num = behaviorTree.parentIndex[num];
				}
			}
		}
		for (int j = 0; j < behaviorTree.conditionalReevaluate.Count; j++)
		{
			int num = behaviorTree.conditionalReevaluate[j].index;
			if (!behaviorTree.taskList[num].Disabled && behaviorTree.conditionalReevaluate[j].compositeIndex != -1)
			{
				behaviorTree.taskList[num].OnTriggerEnter(other);
			}
		}
	}

	public void BehaviorOnTriggerExit(Collider other, Behavior behavior)
	{
		if (!IsBehaviorEnabled(behavior))
		{
			return;
		}
		BehaviorTree behaviorTree = behaviorTreeMap[behavior];
		for (int i = 0; i < behaviorTree.activeStack.Count; i++)
		{
			if (behaviorTree.activeStack[i].Count != 0)
			{
				int num = behaviorTree.activeStack[i].Peek();
				while (num != -1 && !behaviorTree.taskList[num].Disabled)
				{
					behaviorTree.taskList[num].OnTriggerExit(other);
					num = behaviorTree.parentIndex[num];
				}
			}
		}
		for (int j = 0; j < behaviorTree.conditionalReevaluate.Count; j++)
		{
			int num = behaviorTree.conditionalReevaluate[j].index;
			if (!behaviorTree.taskList[num].Disabled && behaviorTree.conditionalReevaluate[j].compositeIndex != -1)
			{
				behaviorTree.taskList[num].OnTriggerExit(other);
			}
		}
	}

	public void BehaviorOnCollisionEnter2D(Collision2D collision, Behavior behavior)
	{
		if (!IsBehaviorEnabled(behavior))
		{
			return;
		}
		BehaviorTree behaviorTree = behaviorTreeMap[behavior];
		for (int i = 0; i < behaviorTree.activeStack.Count; i++)
		{
			if (behaviorTree.activeStack[i].Count != 0)
			{
				int num = behaviorTree.activeStack[i].Peek();
				while (num != -1 && !behaviorTree.taskList[num].Disabled)
				{
					behaviorTree.taskList[num].OnCollisionEnter2D(collision);
					num = behaviorTree.parentIndex[num];
				}
			}
		}
		for (int j = 0; j < behaviorTree.conditionalReevaluate.Count; j++)
		{
			int num = behaviorTree.conditionalReevaluate[j].index;
			if (!behaviorTree.taskList[num].Disabled && behaviorTree.conditionalReevaluate[j].compositeIndex != -1)
			{
				behaviorTree.taskList[num].OnCollisionEnter2D(collision);
			}
		}
	}

	public void BehaviorOnCollisionExit2D(Collision2D collision, Behavior behavior)
	{
		if (!IsBehaviorEnabled(behavior))
		{
			return;
		}
		BehaviorTree behaviorTree = behaviorTreeMap[behavior];
		for (int i = 0; i < behaviorTree.activeStack.Count; i++)
		{
			if (behaviorTree.activeStack[i].Count != 0)
			{
				int num = behaviorTree.activeStack[i].Peek();
				while (num != -1 && !behaviorTree.taskList[num].Disabled)
				{
					behaviorTree.taskList[num].OnCollisionExit2D(collision);
					num = behaviorTree.parentIndex[num];
				}
			}
		}
		for (int j = 0; j < behaviorTree.conditionalReevaluate.Count; j++)
		{
			int num = behaviorTree.conditionalReevaluate[j].index;
			if (!behaviorTree.taskList[num].Disabled && behaviorTree.conditionalReevaluate[j].compositeIndex != -1)
			{
				behaviorTree.taskList[num].OnCollisionExit2D(collision);
			}
		}
	}

	public void BehaviorOnTriggerEnter2D(Collider2D other, Behavior behavior)
	{
		if (!IsBehaviorEnabled(behavior))
		{
			return;
		}
		BehaviorTree behaviorTree = behaviorTreeMap[behavior];
		for (int i = 0; i < behaviorTree.activeStack.Count; i++)
		{
			if (behaviorTree.activeStack[i].Count != 0)
			{
				int num = behaviorTree.activeStack[i].Peek();
				while (num != -1 && !behaviorTree.taskList[num].Disabled)
				{
					behaviorTree.taskList[num].OnTriggerEnter2D(other);
					num = behaviorTree.parentIndex[num];
				}
			}
		}
		for (int j = 0; j < behaviorTree.conditionalReevaluate.Count; j++)
		{
			int num = behaviorTree.conditionalReevaluate[j].index;
			if (!behaviorTree.taskList[num].Disabled && behaviorTree.conditionalReevaluate[j].compositeIndex != -1)
			{
				behaviorTree.taskList[num].OnTriggerEnter2D(other);
			}
		}
	}

	public void BehaviorOnTriggerExit2D(Collider2D other, Behavior behavior)
	{
		if (!IsBehaviorEnabled(behavior))
		{
			return;
		}
		BehaviorTree behaviorTree = behaviorTreeMap[behavior];
		for (int i = 0; i < behaviorTree.activeStack.Count; i++)
		{
			if (behaviorTree.activeStack[i].Count != 0)
			{
				int num = behaviorTree.activeStack[i].Peek();
				while (num != -1 && !behaviorTree.taskList[num].Disabled)
				{
					behaviorTree.taskList[num].OnTriggerExit2D(other);
					num = behaviorTree.parentIndex[num];
				}
			}
		}
		for (int j = 0; j < behaviorTree.conditionalReevaluate.Count; j++)
		{
			int num = behaviorTree.conditionalReevaluate[j].index;
			if (!behaviorTree.taskList[num].Disabled && behaviorTree.conditionalReevaluate[j].compositeIndex != -1)
			{
				behaviorTree.taskList[num].OnTriggerExit2D(other);
			}
		}
	}

	public void BehaviorOnControllerColliderHit(ControllerColliderHit hit, Behavior behavior)
	{
		if (!IsBehaviorEnabled(behavior))
		{
			return;
		}
		BehaviorTree behaviorTree = behaviorTreeMap[behavior];
		for (int i = 0; i < behaviorTree.activeStack.Count; i++)
		{
			if (behaviorTree.activeStack[i].Count != 0)
			{
				int num = behaviorTree.activeStack[i].Peek();
				while (num != -1 && !behaviorTree.taskList[num].Disabled)
				{
					behaviorTree.taskList[num].OnControllerColliderHit(hit);
					num = behaviorTree.parentIndex[num];
				}
			}
		}
		for (int j = 0; j < behaviorTree.conditionalReevaluate.Count; j++)
		{
			int num = behaviorTree.conditionalReevaluate[j].index;
			if (!behaviorTree.taskList[num].Disabled && behaviorTree.conditionalReevaluate[j].compositeIndex != -1)
			{
				behaviorTree.taskList[num].OnControllerColliderHit(hit);
			}
		}
	}

	public void BehaviorOnAnimatorIK(Behavior behavior)
	{
		if (!IsBehaviorEnabled(behavior))
		{
			return;
		}
		BehaviorTree behaviorTree = behaviorTreeMap[behavior];
		for (int i = 0; i < behaviorTree.activeStack.Count; i++)
		{
			if (behaviorTree.activeStack[i].Count != 0)
			{
				int num = behaviorTree.activeStack[i].Peek();
				while (num != -1 && !behaviorTree.taskList[num].Disabled)
				{
					behaviorTree.taskList[num].OnAnimatorIK();
					num = behaviorTree.parentIndex[num];
				}
			}
		}
		for (int j = 0; j < behaviorTree.conditionalReevaluate.Count; j++)
		{
			int num = behaviorTree.conditionalReevaluate[j].index;
			if (!behaviorTree.taskList[num].Disabled && behaviorTree.conditionalReevaluate[j].compositeIndex != -1)
			{
				behaviorTree.taskList[num].OnAnimatorIK();
			}
		}
	}

	public bool MapObjectToTask(object objectKey, Task task, ThirdPartyObjectType objectType)
	{
		if (objectTaskMap.ContainsKey(objectKey))
		{
			string arg = "";
			switch (objectType)
			{
			case ThirdPartyObjectType.PlayMaker:
				arg = "PlayMaker FSM";
				break;
			case ThirdPartyObjectType.uScript:
				arg = "uScript Graph";
				break;
			case ThirdPartyObjectType.DialogueSystem:
				arg = "Dialogue System";
				break;
			case ThirdPartyObjectType.uSequencer:
				arg = "uSequencer sequence";
				break;
			}
			Debug.LogError($"Only one behavior can be mapped to the same instance of the {arg}.");
			return false;
		}
		ThirdPartyTask thirdPartyTask = ObjectPool.Get<ThirdPartyTask>();
		thirdPartyTask.Initialize(task, objectType);
		objectTaskMap.Add(objectKey, thirdPartyTask);
		taskObjectMap.Add(thirdPartyTask, objectKey);
		return true;
	}

	public Task TaskForObject(object objectKey)
	{
		if (!objectTaskMap.TryGetValue(objectKey, out var value))
		{
			return null;
		}
		return value.Task;
	}

	private decimal RoundedTime()
	{
		return Math.Round((decimal)Time.time, 5, MidpointRounding.AwayFromZero);
	}

	public List<Task> GetTaskList(Behavior behavior)
	{
		if (!IsBehaviorEnabled(behavior))
		{
			return null;
		}
		return behaviorTreeMap[behavior].taskList;
	}

	[RuntimeInitializeOnLoadMethod(RuntimeInitializeLoadType.SubsystemRegistration)]
	private static void DomainReset()
	{
		instance = null;
	}
}
