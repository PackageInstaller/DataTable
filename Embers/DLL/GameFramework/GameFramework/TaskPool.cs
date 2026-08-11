using System.Collections.Generic;

namespace GameFramework;

internal sealed class TaskPool<T> where T : TaskBase
{
	private readonly Stack<ITaskAgent<T>> m_FreeAgents;

	private readonly GameFrameworkLinkedList<ITaskAgent<T>> m_WorkingAgents;

	private readonly GameFrameworkLinkedList<T> m_WaitingTasks;

	private bool m_Paused;

	public bool Paused
	{
		get
		{
			return m_Paused;
		}
		set
		{
			m_Paused = value;
		}
	}

	public int TotalAgentCount => FreeAgentCount + WorkingAgentCount;

	public int FreeAgentCount => m_FreeAgents.Count;

	public int WorkingAgentCount => m_WorkingAgents.Count;

	public int WaitingTaskCount => m_WaitingTasks.Count;

	public TaskPool()
	{
		m_FreeAgents = new Stack<ITaskAgent<T>>();
		m_WorkingAgents = new GameFrameworkLinkedList<ITaskAgent<T>>();
		m_WaitingTasks = new GameFrameworkLinkedList<T>();
		m_Paused = false;
	}

	public void Update(float elapseSeconds, float realElapseSeconds)
	{
		if (!m_Paused)
		{
			ProcessRunningTasks(elapseSeconds, realElapseSeconds);
			ProcessWaitingTasks(elapseSeconds, realElapseSeconds);
		}
	}

	public void Shutdown()
	{
		RemoveAllTasks();
		while (FreeAgentCount > 0)
		{
			m_FreeAgents.Pop().Shutdown();
		}
	}

	public void AddAgent(ITaskAgent<T> agent)
	{
		if (agent == null)
		{
			throw new GameFrameworkException("Task agent is invalid.");
		}
		agent.Initialize();
		m_FreeAgents.Push(agent);
	}

	public TaskInfo GetTaskInfo(int serialId)
	{
		foreach (ITaskAgent<T> workingAgent in m_WorkingAgents)
		{
			T task = workingAgent.Task;
			if (task.SerialId == serialId)
			{
				return new TaskInfo(task.SerialId, task.Tag, task.Priority, task.UserData, (!task.Done) ? TaskStatus.Doing : TaskStatus.Done, task.Description);
			}
		}
		foreach (T waitingTask in m_WaitingTasks)
		{
			if (waitingTask.SerialId == serialId)
			{
				return new TaskInfo(waitingTask.SerialId, waitingTask.Tag, waitingTask.Priority, waitingTask.UserData, TaskStatus.Todo, waitingTask.Description);
			}
		}
		return default(TaskInfo);
	}

	public TaskInfo[] GetTaskInfos(string tag)
	{
		List<TaskInfo> list = new List<TaskInfo>();
		GetTaskInfos(tag, list);
		return list.ToArray();
	}

	public void GetTaskInfos(string tag, List<TaskInfo> results)
	{
		if (results == null)
		{
			throw new GameFrameworkException("Results is invalid.");
		}
		results.Clear();
		foreach (ITaskAgent<T> workingAgent in m_WorkingAgents)
		{
			T task = workingAgent.Task;
			if (task.Tag == tag)
			{
				results.Add(new TaskInfo(task.SerialId, task.Tag, task.Priority, task.UserData, (!task.Done) ? TaskStatus.Doing : TaskStatus.Done, task.Description));
			}
		}
		foreach (T waitingTask in m_WaitingTasks)
		{
			if (waitingTask.Tag == tag)
			{
				results.Add(new TaskInfo(waitingTask.SerialId, waitingTask.Tag, waitingTask.Priority, waitingTask.UserData, TaskStatus.Todo, waitingTask.Description));
			}
		}
	}

	public TaskInfo[] GetAllTaskInfos()
	{
		int num = 0;
		TaskInfo[] array = new TaskInfo[m_WorkingAgents.Count + m_WaitingTasks.Count];
		foreach (ITaskAgent<T> workingAgent in m_WorkingAgents)
		{
			T task = workingAgent.Task;
			array[num++] = new TaskInfo(task.SerialId, task.Tag, task.Priority, task.UserData, (!task.Done) ? TaskStatus.Doing : TaskStatus.Done, task.Description);
		}
		foreach (T waitingTask in m_WaitingTasks)
		{
			array[num++] = new TaskInfo(waitingTask.SerialId, waitingTask.Tag, waitingTask.Priority, waitingTask.UserData, TaskStatus.Todo, waitingTask.Description);
		}
		return array;
	}

	public void GetAllTaskInfos(List<TaskInfo> results)
	{
		if (results == null)
		{
			throw new GameFrameworkException("Results is invalid.");
		}
		results.Clear();
		foreach (ITaskAgent<T> workingAgent in m_WorkingAgents)
		{
			T task = workingAgent.Task;
			results.Add(new TaskInfo(task.SerialId, task.Tag, task.Priority, task.UserData, (!task.Done) ? TaskStatus.Doing : TaskStatus.Done, task.Description));
		}
		foreach (T waitingTask in m_WaitingTasks)
		{
			results.Add(new TaskInfo(waitingTask.SerialId, waitingTask.Tag, waitingTask.Priority, waitingTask.UserData, TaskStatus.Todo, waitingTask.Description));
		}
	}

	public void AddTask(T task)
	{
		LinkedListNode<T> linkedListNode = m_WaitingTasks.Last;
		while (linkedListNode != null && task.Priority > linkedListNode.Value.Priority)
		{
			linkedListNode = linkedListNode.Previous;
		}
		if (linkedListNode != null)
		{
			m_WaitingTasks.AddAfter(linkedListNode, task);
		}
		else
		{
			m_WaitingTasks.AddFirst(task);
		}
	}

	public bool RemoveTask(int serialId)
	{
		foreach (T waitingTask in m_WaitingTasks)
		{
			if (waitingTask.SerialId == serialId)
			{
				m_WaitingTasks.Remove(waitingTask);
				ReferencePool.Release(waitingTask);
				return true;
			}
		}
		LinkedListNode<ITaskAgent<T>> linkedListNode = m_WorkingAgents.First;
		while (linkedListNode != null)
		{
			LinkedListNode<ITaskAgent<T>> next = linkedListNode.Next;
			ITaskAgent<T> value = linkedListNode.Value;
			T task = value.Task;
			if (task.SerialId == serialId)
			{
				value.Reset();
				m_FreeAgents.Push(value);
				m_WorkingAgents.Remove(linkedListNode);
				ReferencePool.Release(task);
				return true;
			}
			linkedListNode = next;
		}
		return false;
	}

	public int RemoveTasks(string tag)
	{
		int num = 0;
		LinkedListNode<T> linkedListNode = m_WaitingTasks.First;
		while (linkedListNode != null)
		{
			LinkedListNode<T> next = linkedListNode.Next;
			T value = linkedListNode.Value;
			if (value.Tag == tag)
			{
				m_WaitingTasks.Remove(linkedListNode);
				ReferencePool.Release(value);
				num++;
			}
			linkedListNode = next;
		}
		LinkedListNode<ITaskAgent<T>> linkedListNode2 = m_WorkingAgents.First;
		while (linkedListNode2 != null)
		{
			LinkedListNode<ITaskAgent<T>> next2 = linkedListNode2.Next;
			ITaskAgent<T> value2 = linkedListNode2.Value;
			T task = value2.Task;
			if (task.Tag == tag)
			{
				value2.Reset();
				m_FreeAgents.Push(value2);
				m_WorkingAgents.Remove(linkedListNode2);
				ReferencePool.Release(task);
				num++;
			}
			linkedListNode2 = next2;
		}
		return num;
	}

	public int RemoveAllTasks()
	{
		int result = m_WaitingTasks.Count + m_WorkingAgents.Count;
		foreach (T waitingTask in m_WaitingTasks)
		{
			ReferencePool.Release(waitingTask);
		}
		m_WaitingTasks.Clear();
		foreach (ITaskAgent<T> workingAgent in m_WorkingAgents)
		{
			T task = workingAgent.Task;
			workingAgent.Reset();
			m_FreeAgents.Push(workingAgent);
			ReferencePool.Release(task);
		}
		m_WorkingAgents.Clear();
		return result;
	}

	private void ProcessRunningTasks(float elapseSeconds, float realElapseSeconds)
	{
		LinkedListNode<ITaskAgent<T>> linkedListNode = m_WorkingAgents.First;
		while (linkedListNode != null)
		{
			T task = linkedListNode.Value.Task;
			if (!task.Done)
			{
				linkedListNode.Value.Update(elapseSeconds, realElapseSeconds);
				linkedListNode = linkedListNode.Next;
				continue;
			}
			LinkedListNode<ITaskAgent<T>> next = linkedListNode.Next;
			linkedListNode.Value.Reset();
			m_FreeAgents.Push(linkedListNode.Value);
			m_WorkingAgents.Remove(linkedListNode);
			ReferencePool.Release(task);
			linkedListNode = next;
		}
	}

	private void ProcessWaitingTasks(float elapseSeconds, float realElapseSeconds)
	{
		LinkedListNode<T> linkedListNode = m_WaitingTasks.First;
		while (linkedListNode != null && FreeAgentCount > 0)
		{
			ITaskAgent<T> taskAgent = m_FreeAgents.Pop();
			LinkedListNode<ITaskAgent<T>> node = m_WorkingAgents.AddLast(taskAgent);
			T value = linkedListNode.Value;
			LinkedListNode<T> next = linkedListNode.Next;
			StartTaskStatus startTaskStatus = taskAgent.Start(value);
			if (startTaskStatus == StartTaskStatus.Done || startTaskStatus == StartTaskStatus.HasToWait || startTaskStatus == StartTaskStatus.UnknownError)
			{
				taskAgent.Reset();
				m_FreeAgents.Push(taskAgent);
				m_WorkingAgents.Remove(node);
			}
			if (startTaskStatus == StartTaskStatus.Done || startTaskStatus == StartTaskStatus.CanResume || startTaskStatus == StartTaskStatus.UnknownError)
			{
				m_WaitingTasks.Remove(linkedListNode);
			}
			if (startTaskStatus == StartTaskStatus.Done || startTaskStatus == StartTaskStatus.UnknownError)
			{
				ReferencePool.Release(value);
			}
			linkedListNode = next;
		}
	}
}
