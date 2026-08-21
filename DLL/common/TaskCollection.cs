using System;
using System.Collections.Generic;

public sealed class TaskCollection
{
	public struct TaskPerformanceMetrics(TaskScheduleBase task)
	{
		public bool IsRunning = task.IsRunning;

		public bool IsWaiting = task.IsWaiting;

		public string Name = task.ToString();

		public string Type = task.GetType().Name;

		public DateTime StartedAt = task.StartedAt;

		public DateTime LastRunAt = task.LastRun;

		public TimeSpan LastJobTime = task.LastRuntime;

		public TimeSpan JobHighwater = task.RuntimeHighwater;

		public int TaskID = task.TaskID;
	}

	private object mLockObject = new object();

	private int mMaxTasks;

	private Dictionary<int, TaskScheduleBase> mRegisteredTasks;

	public int Count
	{
		get
		{
			lock (mLockObject)
			{
				return mRegisteredTasks.Count;
			}
		}
	}

	public TaskCollection(int maxTasks)
	{
		mMaxTasks = maxTasks;
		mRegisteredTasks = new Dictionary<int, TaskScheduleBase>(mMaxTasks);
	}

	public bool AddToCollection(TaskScheduleBase task)
	{
		lock (mLockObject)
		{
			if (Count >= mMaxTasks || task == null)
			{
				return false;
			}
			mRegisteredTasks.Add(task.TaskID, task);
			return true;
		}
	}

	public void Clear()
	{
		Clear(100);
	}

	public void Clear(int joinTimeout)
	{
		lock (mLockObject)
		{
			List<int> list = new List<int>(mRegisteredTasks.Count);
			foreach (int key in mRegisteredTasks.Keys)
			{
				list.Add(key);
			}
			for (int i = 0; i < list.Count; i++)
			{
				TaskScheduleBase taskScheduleBase = mRegisteredTasks[list[i]];
				try
				{
					TerminateTask(taskScheduleBase, joinTimeout);
				}
				catch (Exception ex)
				{
					XLogger.Error("Failed to shutdown task {0} due to exception '{1}'", new object[2] { taskScheduleBase.Name, ex });
				}
			}
		}
	}

	public bool ContainsTask(TaskScheduleBase task)
	{
		lock (mLockObject)
		{
			return mRegisteredTasks.ContainsKey(task.TaskID);
		}
	}

	public IEnumerable<TaskPerformanceMetrics> GetPerformanceMetrics()
	{
		lock (mLockObject)
		{
			TaskPerformanceMetrics[] array = new TaskPerformanceMetrics[Count];
			int num = 0;
			foreach (KeyValuePair<int, TaskScheduleBase> mRegisteredTask in mRegisteredTasks)
			{
				array[num++] = new TaskPerformanceMetrics(mRegisteredTask.Value);
			}
			return array;
		}
	}

	public TaskScheduleBase GetTask(int taskID)
	{
		TaskScheduleBase value = null;
		lock (mLockObject)
		{
			if (!mRegisteredTasks.TryGetValue(taskID, out value))
			{
				value = null;
			}
		}
		return value;
	}

	public TaskScheduleBase GetTaskUnSafe(int taskID)
	{
		TaskScheduleBase value = null;
		if (!mRegisteredTasks.TryGetValue(taskID, out value))
		{
			value = null;
		}
		return value;
	}

	public void StartTask(TaskScheduleBase task)
	{
		lock (mLockObject)
		{
			mRegisteredTasks[task.TaskID] = task;
			task.StartThread();
		}
	}

	public bool StopTask(TaskScheduleBase task, int joinPeriod)
	{
		lock (mLockObject)
		{
			if (!mRegisteredTasks.ContainsKey(task.TaskID))
			{
				throw new InvalidOperationException($"Attempted to stop task {task} but it doesn't exist in the thread collection!");
			}
			task.TerminateThread(joinPeriod);
			return !task.IsRunning;
		}
	}

	public bool TerminateTask(TaskScheduleBase task, int joinPeriod)
	{
		if (task == null)
		{
			return true;
		}
		lock (mLockObject)
		{
			if (!mRegisteredTasks.ContainsKey(task.TaskID))
			{
				throw new InvalidOperationException($"Attempted to stop task {task} but it doesn't exist in the thread collection!");
			}
			task.TerminateThread(joinPeriod);
			mRegisteredTasks.Remove(task.TaskID);
			return !task.IsRunning;
		}
	}
}
