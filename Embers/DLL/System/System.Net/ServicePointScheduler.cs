using System.Collections.Generic;
using System.Runtime.CompilerServices;
using System.Threading;
using System.Threading.Tasks;

namespace System.Net;

internal class ServicePointScheduler
{
	private class ConnectionGroup
	{
		[CompilerGenerated]
		private readonly string _003CName_003Ek__BackingField;

		private static int nextId;

		public readonly int ID = ++nextId;

		private LinkedList<WebConnection> connections;

		private LinkedList<WebOperation> queue;

		public ServicePointScheduler Scheduler { get; }

		public ConnectionGroup(ServicePointScheduler scheduler, string name)
		{
			Scheduler = scheduler;
			_003CName_003Ek__BackingField = name;
			connections = new LinkedList<WebConnection>();
			queue = new LinkedList<WebOperation>();
		}

		public bool IsEmpty()
		{
			if (connections.Count == 0)
			{
				return queue.Count == 0;
			}
			return false;
		}

		public void RemoveConnection(WebConnection connection)
		{
			connections.Remove(connection);
			connection.Dispose();
			Scheduler.OnConnectionClosed(connection);
		}

		public void Cleanup()
		{
			LinkedListNode<WebConnection> linkedListNode = connections.First;
			while (linkedListNode != null)
			{
				WebConnection value = linkedListNode.Value;
				LinkedListNode<WebConnection> node = linkedListNode;
				linkedListNode = linkedListNode.Next;
				if (value.Closed)
				{
					connections.Remove(node);
					Scheduler.OnConnectionClosed(value);
				}
			}
		}

		public void Close()
		{
			foreach (WebOperation item in queue)
			{
				item.Abort();
				Scheduler.RemoveOperation(item);
			}
			queue.Clear();
			foreach (WebConnection connection in connections)
			{
				connection.Dispose();
				Scheduler.OnConnectionClosed(connection);
			}
			connections.Clear();
		}

		public void EnqueueOperation(WebOperation operation)
		{
			queue.AddLast(operation);
		}

		public WebOperation GetNextOperation()
		{
			LinkedListNode<WebOperation> linkedListNode = queue.First;
			while (linkedListNode != null)
			{
				WebOperation value = linkedListNode.Value;
				LinkedListNode<WebOperation> node = linkedListNode;
				linkedListNode = linkedListNode.Next;
				if (value.Aborted)
				{
					queue.Remove(node);
					Scheduler.RemoveOperation(value);
					continue;
				}
				return value;
			}
			return null;
		}

		public WebConnection FindIdleConnection(WebOperation operation)
		{
			WebConnection webConnection = null;
			foreach (WebConnection connection in connections)
			{
				if (connection.CanReuseConnection(operation) && (webConnection == null || connection.IdleSince > webConnection.IdleSince))
				{
					webConnection = connection;
				}
			}
			if (webConnection != null && webConnection.StartOperation(operation, reused: true))
			{
				queue.Remove(operation);
				return webConnection;
			}
			foreach (WebConnection connection2 in connections)
			{
				if (connection2.StartOperation(operation, reused: true))
				{
					queue.Remove(operation);
					return connection2;
				}
			}
			return null;
		}

		public (WebConnection connection, bool created) CreateOrReuseConnection(WebOperation operation, bool force)
		{
			WebConnection webConnection = FindIdleConnection(operation);
			if (webConnection != null)
			{
				return (connection: webConnection, created: false);
			}
			if (force || Scheduler.ServicePoint.ConnectionLimit > connections.Count || connections.Count == 0)
			{
				webConnection = new WebConnection(Scheduler.ServicePoint);
				webConnection.StartOperation(operation, reused: false);
				connections.AddFirst(webConnection);
				Scheduler.OnConnectionCreated(webConnection);
				queue.Remove(operation);
				return (connection: webConnection, created: true);
			}
			return (connection: null, created: false);
		}
	}

	private class AsyncManualResetEvent
	{
		private volatile TaskCompletionSource<bool> m_tcs = new TaskCompletionSource<bool>();

		public Task<bool> WaitAsync(int millisecondTimeout)
		{
			return ServicePointScheduler.WaitAsync((Task)m_tcs.Task, millisecondTimeout);
		}

		public void Set()
		{
			TaskCompletionSource<bool> tcs = m_tcs;
			Task.Factory.StartNew((object s) => ((TaskCompletionSource<bool>)s).TrySetResult(result: true), tcs, CancellationToken.None, TaskCreationOptions.PreferFairness, TaskScheduler.Default);
			tcs.Task.Wait();
		}

		public void Reset()
		{
			TaskCompletionSource<bool> tcs;
			do
			{
				tcs = m_tcs;
			}
			while (tcs.Task.IsCompleted && Interlocked.CompareExchange(ref m_tcs, new TaskCompletionSource<bool>(), tcs) != tcs);
		}

		public AsyncManualResetEvent(bool state)
		{
			if (state)
			{
				Set();
			}
		}
	}

	private int running;

	private int maxIdleTime = 100000;

	private AsyncManualResetEvent schedulerEvent;

	private ConnectionGroup defaultGroup;

	private Dictionary<string, ConnectionGroup> groups;

	private LinkedList<(ConnectionGroup, WebOperation)> operations;

	private LinkedList<(ConnectionGroup, WebConnection, Task)> idleConnections;

	private int currentConnections;

	private int connectionLimit;

	private DateTime idleSince;

	private static int nextId;

	public readonly int ID = ++nextId;

	private ServicePoint ServicePoint { get; set; }

	public int MaxIdleTime => maxIdleTime;

	public ServicePointScheduler(ServicePoint servicePoint, int connectionLimit, int maxIdleTime)
	{
		ServicePoint = servicePoint;
		this.connectionLimit = connectionLimit;
		this.maxIdleTime = maxIdleTime;
		schedulerEvent = new AsyncManualResetEvent(state: false);
		defaultGroup = new ConnectionGroup(this, string.Empty);
		operations = new LinkedList<(ConnectionGroup, WebOperation)>();
		idleConnections = new LinkedList<(ConnectionGroup, WebConnection, Task)>();
		idleSince = DateTime.UtcNow;
	}

	public void Run()
	{
		if (Interlocked.CompareExchange(ref running, 1, 0) == 0)
		{
			Task.Run(() => RunScheduler());
		}
		schedulerEvent.Set();
	}

	private async Task RunScheduler()
	{
		idleSince = DateTime.UtcNow + TimeSpan.FromDays(3650.0);
		while (true)
		{
			List<Task> taskList = new List<Task>();
			bool finalCleanup = false;
			(ConnectionGroup, WebOperation)[] operationArray;
			(ConnectionGroup, WebConnection, Task)[] idleArray;
			Task<bool> schedulerTask;
			lock (ServicePoint)
			{
				Cleanup();
				operationArray = new(ConnectionGroup, WebOperation)[operations.Count];
				operations.CopyTo(operationArray, 0);
				idleArray = new(ConnectionGroup, WebConnection, Task)[idleConnections.Count];
				idleConnections.CopyTo(idleArray, 0);
				schedulerTask = schedulerEvent.WaitAsync(maxIdleTime);
				taskList.Add(schedulerTask);
				if (groups == null && defaultGroup.IsEmpty() && operations.Count == 0 && idleConnections.Count == 0)
				{
					idleSince = DateTime.UtcNow;
					finalCleanup = true;
				}
				else
				{
					(ConnectionGroup, WebOperation)[] array = operationArray;
					for (int i = 0; i < array.Length; i++)
					{
						(ConnectionGroup, WebOperation) tuple = array[i];
						taskList.Add(tuple.Item2.Finished.Task);
					}
					(ConnectionGroup, WebConnection, Task)[] array2 = idleArray;
					for (int i = 0; i < array2.Length; i++)
					{
						(ConnectionGroup, WebConnection, Task) tuple2 = array2[i];
						taskList.Add(tuple2.Item3);
					}
				}
			}
			Task task = await Task.WhenAny(taskList).ConfigureAwait(continueOnCapturedContext: false);
			lock (ServicePoint)
			{
				bool flag = false;
				if (finalCleanup)
				{
					if (!schedulerTask.Result)
					{
						FinalCleanup();
						break;
					}
					flag = true;
				}
				else if (task == taskList[0])
				{
					flag = true;
				}
				for (int j = 0; j < operationArray.Length; j++)
				{
					(ConnectionGroup, WebOperation) value = operationArray[j];
					if (value.Item2.Finished.CurrentResult != null)
					{
						operations.Remove(value);
						bool flag2 = OperationCompleted(value.Item1, value.Item2);
						flag |= flag2;
					}
				}
				if (flag)
				{
					RunSchedulerIteration();
				}
				int num = -1;
				for (int k = 0; k < idleArray.Length; k++)
				{
					if (task == taskList[k + 1 + operationArray.Length])
					{
						num = k;
						break;
					}
				}
				if (num >= 0)
				{
					(ConnectionGroup, WebConnection, Task) value2 = idleArray[num];
					idleConnections.Remove(value2);
					CloseIdleConnection(value2.Item1, value2.Item2);
				}
			}
			operationArray = null;
			idleArray = null;
			schedulerTask = null;
		}
	}

	private void Cleanup()
	{
		if (groups == null)
		{
			return;
		}
		string[] array = new string[groups.Count];
		groups.Keys.CopyTo(array, 0);
		string[] array2 = array;
		foreach (string key in array2)
		{
			if (groups.ContainsKey(key) && groups[key].IsEmpty())
			{
				groups.Remove(key);
			}
		}
		if (groups.Count == 0)
		{
			groups = null;
		}
	}

	private void RunSchedulerIteration()
	{
		schedulerEvent.Reset();
		bool flag;
		do
		{
			flag = SchedulerIteration(defaultGroup);
			if (groups == null)
			{
				continue;
			}
			foreach (KeyValuePair<string, ConnectionGroup> group in groups)
			{
				flag |= SchedulerIteration(group.Value);
			}
		}
		while (flag);
	}

	private bool OperationCompleted(ConnectionGroup group, WebOperation operation)
	{
		WebCompletionSource<(bool, WebOperation)>.Result currentResult = operation.Finished.CurrentResult;
		bool flag;
		WebOperation webOperation;
		if (currentResult.Success)
		{
			(flag, webOperation) = currentResult.Argument;
		}
		else
		{
			flag = false;
			webOperation = null;
		}
		if (!flag || !operation.Connection.Continue(webOperation))
		{
			group.RemoveConnection(operation.Connection);
			if (webOperation == null)
			{
				return true;
			}
			flag = false;
		}
		if (webOperation == null)
		{
			if (flag)
			{
				Task item = Task.Delay(MaxIdleTime);
				idleConnections.AddLast((group, operation.Connection, item));
			}
			return true;
		}
		operations.AddLast((group, webOperation));
		if (flag)
		{
			RemoveIdleConnection(operation.Connection);
			return false;
		}
		group.Cleanup();
		group.CreateOrReuseConnection(webOperation, force: true);
		return false;
	}

	private void CloseIdleConnection(ConnectionGroup group, WebConnection connection)
	{
		group.RemoveConnection(connection);
		RemoveIdleConnection(connection);
	}

	private bool SchedulerIteration(ConnectionGroup group)
	{
		group.Cleanup();
		WebOperation nextOperation = group.GetNextOperation();
		if (nextOperation == null)
		{
			return false;
		}
		WebConnection item = group.CreateOrReuseConnection(nextOperation, force: false).connection;
		if (item == null)
		{
			return false;
		}
		operations.AddLast((group, nextOperation));
		RemoveIdleConnection(item);
		return true;
	}

	private void RemoveOperation(WebOperation operation)
	{
		LinkedListNode<(ConnectionGroup, WebOperation)> linkedListNode = operations.First;
		while (linkedListNode != null)
		{
			LinkedListNode<(ConnectionGroup, WebOperation)> linkedListNode2 = linkedListNode;
			linkedListNode = linkedListNode.Next;
			if (linkedListNode2.Value.Item2 == operation)
			{
				operations.Remove(linkedListNode2);
			}
		}
	}

	private void RemoveIdleConnection(WebConnection connection)
	{
		LinkedListNode<(ConnectionGroup, WebConnection, Task)> linkedListNode = idleConnections.First;
		while (linkedListNode != null)
		{
			LinkedListNode<(ConnectionGroup, WebConnection, Task)> linkedListNode2 = linkedListNode;
			linkedListNode = linkedListNode.Next;
			if (linkedListNode2.Value.Item2 == connection)
			{
				idleConnections.Remove(linkedListNode2);
			}
		}
	}

	private void FinalCleanup()
	{
		groups = null;
		operations = null;
		idleConnections = null;
		defaultGroup = null;
		ServicePoint.FreeServicePoint();
		ServicePointManager.RemoveServicePoint(ServicePoint);
		ServicePoint = null;
	}

	public void SendRequest(WebOperation operation, string groupName)
	{
		lock (ServicePoint)
		{
			GetConnectionGroup(groupName).EnqueueOperation(operation);
			Run();
		}
	}

	public bool CloseConnectionGroup(string groupName)
	{
		ConnectionGroup value;
		if (string.IsNullOrEmpty(groupName))
		{
			value = defaultGroup;
		}
		else if (groups == null || !groups.TryGetValue(groupName, out value))
		{
			return false;
		}
		if (value != defaultGroup)
		{
			groups.Remove(groupName);
			if (groups.Count == 0)
			{
				groups = null;
			}
		}
		value.Close();
		Run();
		return true;
	}

	private ConnectionGroup GetConnectionGroup(string name)
	{
		lock (ServicePoint)
		{
			if (string.IsNullOrEmpty(name))
			{
				return defaultGroup;
			}
			if (groups == null)
			{
				groups = new Dictionary<string, ConnectionGroup>();
			}
			if (groups.TryGetValue(name, out var value))
			{
				return value;
			}
			value = new ConnectionGroup(this, name);
			groups.Add(name, value);
			return value;
		}
	}

	private void OnConnectionCreated(WebConnection connection)
	{
		Interlocked.Increment(ref currentConnections);
	}

	private void OnConnectionClosed(WebConnection connection)
	{
		RemoveIdleConnection(connection);
		Interlocked.Decrement(ref currentConnections);
	}

	public static async Task<bool> WaitAsync(Task workerTask, int millisecondTimeout)
	{
		CancellationTokenSource cts = new CancellationTokenSource();
		try
		{
			Task timeoutTask = Task.Delay(millisecondTimeout, cts.Token);
			return await Task.WhenAny(workerTask, timeoutTask).ConfigureAwait(continueOnCapturedContext: false) != timeoutTask;
		}
		finally
		{
			cts.Cancel();
			cts.Dispose();
		}
	}
}
