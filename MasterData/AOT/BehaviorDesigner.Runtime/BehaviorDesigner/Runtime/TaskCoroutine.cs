using System.Collections;
using UnityEngine;

namespace BehaviorDesigner.Runtime;

public class TaskCoroutine
{
	private IEnumerator mCoroutineEnumerator;

	private Coroutine mCoroutine;

	private Behavior mParent;

	private string mCoroutineName;

	private bool mStop;

	public Coroutine Coroutine => mCoroutine;

	public void Stop()
	{
		mStop = true;
	}

	public TaskCoroutine(Behavior parent, IEnumerator coroutine, string coroutineName)
	{
		mParent = parent;
		mCoroutineEnumerator = coroutine;
		mCoroutineName = coroutineName;
		mCoroutine = parent.StartCoroutine(RunCoroutine());
	}

	public IEnumerator RunCoroutine()
	{
		while (!mStop && mCoroutineEnumerator != null && mCoroutineEnumerator.MoveNext())
		{
			yield return mCoroutineEnumerator.Current;
		}
		mParent.TaskCoroutineEnded(this, mCoroutineName);
	}
}
