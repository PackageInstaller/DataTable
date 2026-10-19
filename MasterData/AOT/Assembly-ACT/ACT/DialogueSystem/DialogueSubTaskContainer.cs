using System;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using UnityEngine;
using UnityEngine.Pool;

namespace ACT.DialogueSystem;

public class DialogueSubTaskContainer
{
	private readonly List<DialogueSubTaskRuntime> m_Tasks = new List<DialogueSubTaskRuntime>();

	public bool Flushing { get; private set; }

	public void Run(DialogueSubTask task)
	{
		DialogueSubTaskRuntime dialogueSubTaskRuntime = new DialogueSubTaskRuntime(task);
		m_Tasks.Add(dialogueSubTaskRuntime);
		RunInternal(task.Task, dialogueSubTaskRuntime).Forget();
	}

	public async UniTask FlushToEnd()
	{
		if (m_Tasks.Count == 0)
		{
			return;
		}
		Flushing = true;
		try
		{
			while (true)
			{
				SkipToEnd();
				RemoveFinished();
				if (m_Tasks.Count == 0)
				{
					break;
				}
				List<UniTask> tasks = CollectionPool<List<UniTask>, UniTask>.Get();
				try
				{
					for (int i = 0; i < m_Tasks.Count; i++)
					{
						tasks.Add(m_Tasks[i].CompletionSource.Task);
					}
					await UniTask.WhenAll(tasks).SuppressCancellationThrow();
				}
				finally
				{
					CollectionPool<List<UniTask>, UniTask>.Release(tasks);
				}
			}
		}
		finally
		{
			Flushing = false;
		}
	}

	private async UniTaskVoid RunInternal(UniTask task, DialogueSubTaskRuntime runtime)
	{
		try
		{
			await task.SuppressCancellationThrow();
		}
		catch (Exception message)
		{
			Debug.LogError(message);
		}
		finally
		{
			runtime.Finished = true;
			runtime.CompletionSource.TrySetResult();
			if (!Flushing)
			{
				m_Tasks.Remove(runtime);
			}
		}
	}

	private void RemoveFinished()
	{
		for (int num = m_Tasks.Count - 1; num >= 0; num--)
		{
			if (m_Tasks[num].Finished)
			{
				m_Tasks.RemoveAt(num);
			}
		}
	}

	private void SkipToEnd()
	{
		for (int i = 0; i < m_Tasks.Count; i++)
		{
			m_Tasks[i].SkipToEnd();
		}
	}
}
