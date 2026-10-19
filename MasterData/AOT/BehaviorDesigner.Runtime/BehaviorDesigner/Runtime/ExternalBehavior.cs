using System;
using System.Collections.Generic;
using BehaviorDesigner.Runtime.Tasks;
using UnityEngine;

namespace BehaviorDesigner.Runtime;

[Serializable]
public abstract class ExternalBehavior : ScriptableObject, IBehavior
{
	[SerializeField]
	private BehaviorSource mBehaviorSource;

	private bool mInitialized;

	public BehaviorSource BehaviorSource
	{
		get
		{
			return mBehaviorSource;
		}
		set
		{
			mBehaviorSource = value;
		}
	}

	public bool Initialized => mInitialized;

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
		return name;
	}

	public void Init()
	{
		CheckForSerialization();
		mInitialized = true;
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
		GetVariable(name)?.SetValue(value);
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

	private void CheckForSerialization()
	{
		mBehaviorSource.Owner = this;
		mBehaviorSource.CheckForSerialization(force: false);
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

	int IBehavior.GetInstanceID()
	{
		return GetInstanceID();
	}
}
