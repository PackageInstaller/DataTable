using System;
using System.Threading;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.Drama;

public class BaseEvent
{
	public enum EventTime
	{
		Before,
		Start,
		End
	}

	protected bool complete;

	[NonSerialized]
	public EventTime eventTime;

	public float delayTime;

	[Tooltip("跳过时必须执行的事件勾上")]
	public bool mustDo;

	public object Context { get; set; }

	public virtual void Init(object context)
	{
		Context = context;
	}

	public virtual async UniTask DoEvent(CancellationToken cancellationToken = default(CancellationToken))
	{
		await UniTask.Delay((int)delayTime * 1000, ignoreTimeScale: false, PlayerLoopTiming.Update, cancellationToken);
	}
}
