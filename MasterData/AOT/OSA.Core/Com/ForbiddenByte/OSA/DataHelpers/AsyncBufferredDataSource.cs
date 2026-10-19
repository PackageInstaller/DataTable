using System;
using System.Collections.Generic;
using UnityEngine;

namespace Com.ForbiddenByte.OSA.DataHelpers;

public class AsyncBufferredDataSource<T> where T : new()
{
	public delegate void Loader(T[] intoExistingValues, int firstItemIndex, int countToRead, Action onDone);

	public class LoadingTask
	{
		public readonly int FirstItemIndex;

		public readonly int CountToRead;

		public readonly T[] Buffer;

		private readonly Loader _Loader;

		private readonly Action<LoadingTask> _OnFinished;

		public int LastItemIndexExcl => FirstItemIndex + CountToRead;

		public LoadingTask(T[] intoExistingModels, int firstItemIndex, int countToRead, Loader loaderFunction, Action<LoadingTask> onFinished)
		{
			Buffer = intoExistingModels;
			FirstItemIndex = firstItemIndex;
			CountToRead = countToRead;
			_Loader = loaderFunction;
			_OnFinished = onFinished;
		}

		public void Start()
		{
			_Loader(Buffer, FirstItemIndex, CountToRead, OnFinishedLoadingOperation);
		}

		private void OnFinishedLoadingOperation()
		{
			if (_OnFinished != null)
			{
				_OnFinished(this);
			}
		}

		public override string ToString()
		{
			string[] array = new string[6] { "[", null, null, null, null, null };
			int firstItemIndex = FirstItemIndex;
			array[1] = firstItemIndex.ToString();
			array[2] = ", ";
			array[3] = LastItemIndexExcl.ToString();
			array[4] = "): ";
			firstItemIndex = CountToRead;
			array[5] = firstItemIndex.ToString();
			return string.Concat(array);
		}
	}

	private readonly BufferredDataSource<T> _DataSource;

	private readonly Loader _Loader;

	private readonly HashSet<LoadingTask> _CurrentlyLoadingTasks = new HashSet<LoadingTask>();

	private Queue<T[]> _BuffersPool = new Queue<T[]>(50);

	private int _ChunkBufferSize;

	public int Count => _DataSource.Count;

	public bool ShowLogs { get; set; }

	public int CurrentlyLoadingTasksCount => _CurrentlyLoadingTasks.Count;

	public event Action LoadingSessionStarted;

	public event Action<LoadingTask> SingleTaskFinished;

	public event Action LoadingSessionEnded;

	public AsyncBufferredDataSource(int count, int chunkBufferSize, Loader loader)
	{
		_Loader = loader;
		_ChunkBufferSize = chunkBufferSize;
		_DataSource = new BufferredDataSource<T>(count, ChunkReader, _ChunkBufferSize, expectManualBufferUpdates: true);
	}

	public T GetValue(int index)
	{
		return _DataSource[index];
	}

	public void ClearAllRunningTasks()
	{
		_CurrentlyLoadingTasks.Clear();
	}

	private void ChunkReader(T[] into, int firstItemIndex, int countToRead)
	{
		LoadingTask task = new LoadingTask(GetPooledBuffer(), firstItemIndex, countToRead, _Loader, OnFinishedOneTask);
		StartTask(task);
	}

	private void StartTask(LoadingTask task)
	{
		if (_CurrentlyLoadingTasks.Count == 0 && LoadingSessionStarted != null)
		{
			LoadingSessionStarted();
		}
		_CurrentlyLoadingTasks.Add(task);
		if (ShowLogs)
		{
			Debug.Log("Starting loading task '" + task?.ToString() + "'. numLoadingTasks now is " + _CurrentlyLoadingTasks.Count);
		}
		task.Start();
	}

	private void OnFinishedOneTask(LoadingTask task)
	{
		if (!_CurrentlyLoadingTasks.Remove(task))
		{
			if (ShowLogs)
			{
				Debug.Log("Finished loading task '" + task?.ToString() + "', but the task list was invalidated meanwhile. numLoadingTasks is " + _CurrentlyLoadingTasks.Count);
			}
			return;
		}
		_DataSource.ManuallyUpdateCreatedValues(task.FirstItemIndex, task.Buffer, 0, task.CountToRead);
		_BuffersPool.Enqueue(task.Buffer);
		bool flag = _CurrentlyLoadingTasks.Count == 0;
		if (ShowLogs)
		{
			Debug.Log("Finished loading task '" + task?.ToString() + "'. numLoadingTasks now is " + _CurrentlyLoadingTasks.Count);
		}
		if (SingleTaskFinished != null)
		{
			SingleTaskFinished(task);
		}
		if (flag && LoadingSessionEnded != null)
		{
			LoadingSessionEnded();
		}
	}

	private T[] GetPooledBuffer()
	{
		if (_BuffersPool.Count == 0)
		{
			return new T[_ChunkBufferSize];
		}
		return _BuffersPool.Dequeue();
	}
}
