using System.Collections;
using System.Collections.Generic;
using MessagePack;
using NodeCanvas.Framework;
using ParadoxNotion.Services;
using UnityEngine;

namespace FlowCanvas.Nodes;

public abstract class LatentActionNodeBase : SimplexNode
{
	public enum InvocationMode
	{
		QueueCalls,
		FilterCalls
	}

	public InvocationMode invocationMode;

	private FlowOutput outFlow;

	private FlowOutput doing;

	private FlowOutput done;

	private Queue<IEnumerator> enumeratorQueue;

	private Queue<Flow> flowQueue;

	private Coroutine currentCoroutine;

	private bool graphStoped;

	private bool graphPaused;

	public override string name
	{
		get
		{
			if (enumeratorQueue == null || enumeratorQueue.Count <= 0)
			{
				return base.name;
			}
			return $"{base.name} [{enumeratorQueue.Count.ToString()}]";
		}
	}

	public virtual bool exposeRoutineControls => true;

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		base.OnSerializeHandler(ref writer, options);
		writer.Write((int)invocationMode);
	}

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		base.OnDeserializeHandler(ref reader, options);
		invocationMode = (InvocationMode)reader.ReadInt32();
	}

	public sealed override void OnGraphStarted()
	{
		graphStoped = false;
	}

	public sealed override void OnGraphStoped()
	{
		graphStoped = true;
		Break();
	}

	public sealed override void OnGraphPaused()
	{
		graphPaused = true;
	}

	public sealed override void OnGraphUnpaused()
	{
		graphPaused = false;
	}

	protected void Begin(IEnumerator enumerator, Flow f)
	{
		if (enumeratorQueue == null)
		{
			enumeratorQueue = new Queue<IEnumerator>();
		}
		if (flowQueue == null)
		{
			flowQueue = new Queue<Flow>();
		}
		if (exposeRoutineControls && invocationMode == InvocationMode.QueueCalls && !enumeratorQueue.Contains(enumerator))
		{
			enumeratorQueue.Enqueue(enumerator);
			flowQueue.Enqueue(f);
		}
		if (currentCoroutine == null)
		{
			currentCoroutine = MonoManager.current.StartCoroutine(InternalCoroutine(enumerator, f));
		}
	}

	protected void Break()
	{
		if (currentCoroutine != null)
		{
			MonoManager.current.StopCoroutine(currentCoroutine);
			enumeratorQueue = new Queue<IEnumerator>();
			flowQueue = new Queue<Flow>();
			currentCoroutine = null;
			done.parent.SetStatus(Status.Resting);
			OnBreak();
			if (!graphStoped)
			{
				done.Call(default(Flow));
			}
		}
	}

	private IEnumerator InternalCoroutine(IEnumerator enumerator, Flow f)
	{
		base.parentNode.SetStatus(Status.Running);
		if (outFlow != null)
		{
			outFlow.Call(f);
		}
		f.breakCall = Break;
		while (enumerator.MoveNext())
		{
			while (graphPaused)
			{
				yield return null;
			}
			if (doing != null)
			{
				doing.Call(f);
			}
			yield return enumerator.Current;
		}
		f.breakCall = null;
		base.parentNode.SetStatus(Status.Resting);
		done.Call(f);
		currentCoroutine = null;
		if (enumeratorQueue.Count > 0)
		{
			enumeratorQueue.Dequeue();
			flowQueue.Dequeue();
			if (enumeratorQueue.Count > 0)
			{
				Begin(enumeratorQueue.Peek(), flowQueue.Peek());
			}
		}
	}

	protected override void OnRegisterPorts(FlowNode node)
	{
		if (exposeRoutineControls)
		{
			outFlow = node.AddFlowOutput("Start", "Out");
			doing = node.AddFlowOutput("Update", "Doing");
		}
		done = node.AddFlowOutput("Finish", "Done");
		OnRegisterDerivedPorts(node);
		if (exposeRoutineControls)
		{
			node.AddFlowInput("Break", delegate
			{
				Break();
			});
		}
	}

	protected abstract void OnRegisterDerivedPorts(FlowNode node);

	public virtual void OnBreak()
	{
	}
}
