using System;
using System.Collections;
using UnityEngine;

public class CriFsRequest : CriDisposable
{
	public delegate void DoneDelegate(CriFsRequest request);

	public DoneDelegate doneDelegate { get; protected set; }

	public bool isDone { get; private set; }

	public string error { get; protected set; }

	public bool isDisposed { get; protected set; }

	public override void Dispose()
	{
		if (!isDisposed)
		{
			Dispose(disposing: true);
			isDisposed = true;
			GC.SuppressFinalize(this);
		}
	}

	public virtual void Stop()
	{
	}

	public YieldInstruction WaitForDone(MonoBehaviour mb)
	{
		return mb.StartCoroutine(CheckDone());
	}

	protected virtual void Dispose(bool disposing)
	{
	}

	public virtual void Update()
	{
	}

	protected void Done()
	{
		isDone = true;
		if (doneDelegate != null)
		{
			doneDelegate(this);
		}
	}

	private IEnumerator CheckDone()
	{
		while (!isDone)
		{
			yield return null;
		}
	}

	~CriFsRequest()
	{
		if (!isDisposed)
		{
			Dispose(disposing: false);
			isDisposed = true;
		}
	}
}
