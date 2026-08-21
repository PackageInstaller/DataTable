using System;
using System.Threading;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.ParticleSystemJobs;

namespace Cysharp.Threading.Tasks.Triggers;

public sealed class AsyncTriggerHandler<T> : IAsyncOneShotTrigger, IUniTaskSource<T>, IUniTaskSource, ITriggerHandler<T>, IDisposable, IAsyncFixedUpdateHandler, IAsyncLateUpdateHandler, IAsyncOnAnimatorIKHandler, IAsyncOnAnimatorMoveHandler, IAsyncOnApplicationFocusHandler, IAsyncOnApplicationPauseHandler, IAsyncOnApplicationQuitHandler, IAsyncOnAudioFilterReadHandler, IAsyncOnBecameInvisibleHandler, IAsyncOnBecameVisibleHandler, IAsyncOnBeforeTransformParentChangedHandler, IAsyncOnCanvasGroupChangedHandler, IAsyncOnCollisionEnterHandler, IAsyncOnCollisionEnter2DHandler, IAsyncOnCollisionExitHandler, IAsyncOnCollisionExit2DHandler, IAsyncOnCollisionStayHandler, IAsyncOnCollisionStay2DHandler, IAsyncOnControllerColliderHitHandler, IAsyncOnDisableHandler, IAsyncOnDrawGizmosHandler, IAsyncOnDrawGizmosSelectedHandler, IAsyncOnEnableHandler, IAsyncOnGUIHandler, IAsyncOnJointBreakHandler, IAsyncOnJointBreak2DHandler, IAsyncOnParticleCollisionHandler, IAsyncOnParticleSystemStoppedHandler, IAsyncOnParticleTriggerHandler, IAsyncOnParticleUpdateJobScheduledHandler, IAsyncOnPostRenderHandler, IAsyncOnPreCullHandler, IAsyncOnPreRenderHandler, IAsyncOnRectTransformDimensionsChangeHandler, IAsyncOnRectTransformRemovedHandler, IAsyncOnRenderImageHandler, IAsyncOnRenderObjectHandler, IAsyncOnServerInitializedHandler, IAsyncOnTransformChildrenChangedHandler, IAsyncOnTransformParentChangedHandler, IAsyncOnTriggerEnterHandler, IAsyncOnTriggerEnter2DHandler, IAsyncOnTriggerExitHandler, IAsyncOnTriggerExit2DHandler, IAsyncOnTriggerStayHandler, IAsyncOnTriggerStay2DHandler, IAsyncOnValidateHandler, IAsyncOnWillRenderObjectHandler, IAsyncResetHandler, IAsyncUpdateHandler, IAsyncOnBeginDragHandler, IAsyncOnCancelHandler, IAsyncOnDeselectHandler, IAsyncOnDragHandler, IAsyncOnDropHandler, IAsyncOnEndDragHandler, IAsyncOnInitializePotentialDragHandler, IAsyncOnMoveHandler, IAsyncOnPointerClickHandler, IAsyncOnPointerDownHandler, IAsyncOnPointerEnterHandler, IAsyncOnPointerExitHandler, IAsyncOnPointerUpHandler, IAsyncOnScrollHandler, IAsyncOnSelectHandler, IAsyncOnSubmitHandler, IAsyncOnUpdateSelectedHandler
{
	private static Action<object> cancellationCallback = CancellationCallback;

	private readonly AsyncTriggerBase<T> trigger;

	private CancellationToken cancellationToken;

	private CancellationTokenRegistration registration;

	private bool isDisposed;

	private bool callOnce;

	private UniTaskCompletionSourceCore<T> core;

	internal CancellationToken CancellationToken => cancellationToken;

	ITriggerHandler<T> ITriggerHandler<T>.Prev { get; set; }

	ITriggerHandler<T> ITriggerHandler<T>.Next { get; set; }

	UniTask IAsyncOneShotTrigger.OneShotAsync()
	{
		core.Reset();
		return new UniTask(this, core.Version);
	}

	internal AsyncTriggerHandler(AsyncTriggerBase<T> trigger, bool callOnce)
	{
		if (cancellationToken.IsCancellationRequested)
		{
			isDisposed = true;
			return;
		}
		this.trigger = trigger;
		cancellationToken = default(CancellationToken);
		registration = default(CancellationTokenRegistration);
		this.callOnce = callOnce;
		trigger.AddHandler(this);
	}

	internal AsyncTriggerHandler(AsyncTriggerBase<T> trigger, CancellationToken cancellationToken, bool callOnce)
	{
		if (cancellationToken.IsCancellationRequested)
		{
			isDisposed = true;
			return;
		}
		this.trigger = trigger;
		this.cancellationToken = cancellationToken;
		this.callOnce = callOnce;
		trigger.AddHandler(this);
		if (cancellationToken.CanBeCanceled)
		{
			registration = cancellationToken.RegisterWithoutCaptureExecutionContext(cancellationCallback, this);
		}
	}

	private static void CancellationCallback(object state)
	{
		AsyncTriggerHandler<T> asyncTriggerHandler = (AsyncTriggerHandler<T>)state;
		asyncTriggerHandler.Dispose();
		asyncTriggerHandler.core.TrySetCanceled(asyncTriggerHandler.cancellationToken);
	}

	public void Dispose()
	{
		if (!isDisposed)
		{
			isDisposed = true;
			registration.Dispose();
			trigger.RemoveHandler(this);
		}
	}

	T IUniTaskSource<T>.GetResult(short token)
	{
		try
		{
			return core.GetResult(token);
		}
		finally
		{
			if (callOnce)
			{
				Dispose();
			}
		}
	}

	void ITriggerHandler<T>.OnNext(T value)
	{
		core.TrySetResult(value);
	}

	void ITriggerHandler<T>.OnCanceled(CancellationToken cancellationToken)
	{
		core.TrySetCanceled(cancellationToken);
	}

	void ITriggerHandler<T>.OnCompleted()
	{
		core.TrySetCanceled(CancellationToken.None);
	}

	void ITriggerHandler<T>.OnError(Exception ex)
	{
		core.TrySetException(ex);
	}

	void IUniTaskSource.GetResult(short token)
	{
		((IUniTaskSource<T>)this).GetResult(token);
	}

	UniTaskStatus IUniTaskSource.GetStatus(short token)
	{
		return core.GetStatus(token);
	}

	UniTaskStatus IUniTaskSource.UnsafeGetStatus()
	{
		return core.UnsafeGetStatus();
	}

	void IUniTaskSource.OnCompleted(Action<object> continuation, object state, short token)
	{
		core.OnCompleted(continuation, state, token);
	}

	UniTask IAsyncFixedUpdateHandler.FixedUpdateAsync()
	{
		core.Reset();
		return new UniTask(this, core.Version);
	}

	UniTask IAsyncLateUpdateHandler.LateUpdateAsync()
	{
		core.Reset();
		return new UniTask(this, core.Version);
	}

	UniTask<int> IAsyncOnAnimatorIKHandler.OnAnimatorIKAsync()
	{
		core.Reset();
		return new UniTask<int>((IUniTaskSource<int>)(object)this, core.Version);
	}

	UniTask IAsyncOnAnimatorMoveHandler.OnAnimatorMoveAsync()
	{
		core.Reset();
		return new UniTask(this, core.Version);
	}

	UniTask<bool> IAsyncOnApplicationFocusHandler.OnApplicationFocusAsync()
	{
		core.Reset();
		return new UniTask<bool>((IUniTaskSource<bool>)(object)this, core.Version);
	}

	UniTask<bool> IAsyncOnApplicationPauseHandler.OnApplicationPauseAsync()
	{
		core.Reset();
		return new UniTask<bool>((IUniTaskSource<bool>)(object)this, core.Version);
	}

	UniTask IAsyncOnApplicationQuitHandler.OnApplicationQuitAsync()
	{
		core.Reset();
		return new UniTask(this, core.Version);
	}

	UniTask<(float[] data, int channels)> IAsyncOnAudioFilterReadHandler.OnAudioFilterReadAsync()
	{
		core.Reset();
		return new UniTask<(float[], int)>((IUniTaskSource<(float[], int)>)(object)this, core.Version);
	}

	UniTask IAsyncOnBecameInvisibleHandler.OnBecameInvisibleAsync()
	{
		core.Reset();
		return new UniTask(this, core.Version);
	}

	UniTask IAsyncOnBecameVisibleHandler.OnBecameVisibleAsync()
	{
		core.Reset();
		return new UniTask(this, core.Version);
	}

	UniTask IAsyncOnBeforeTransformParentChangedHandler.OnBeforeTransformParentChangedAsync()
	{
		core.Reset();
		return new UniTask(this, core.Version);
	}

	UniTask IAsyncOnCanvasGroupChangedHandler.OnCanvasGroupChangedAsync()
	{
		core.Reset();
		return new UniTask(this, core.Version);
	}

	UniTask<Collision> IAsyncOnCollisionEnterHandler.OnCollisionEnterAsync()
	{
		core.Reset();
		return new UniTask<Collision>((IUniTaskSource<Collision>)(object)this, core.Version);
	}

	UniTask<Collision2D> IAsyncOnCollisionEnter2DHandler.OnCollisionEnter2DAsync()
	{
		core.Reset();
		return new UniTask<Collision2D>((IUniTaskSource<Collision2D>)(object)this, core.Version);
	}

	UniTask<Collision> IAsyncOnCollisionExitHandler.OnCollisionExitAsync()
	{
		core.Reset();
		return new UniTask<Collision>((IUniTaskSource<Collision>)(object)this, core.Version);
	}

	UniTask<Collision2D> IAsyncOnCollisionExit2DHandler.OnCollisionExit2DAsync()
	{
		core.Reset();
		return new UniTask<Collision2D>((IUniTaskSource<Collision2D>)(object)this, core.Version);
	}

	UniTask<Collision> IAsyncOnCollisionStayHandler.OnCollisionStayAsync()
	{
		core.Reset();
		return new UniTask<Collision>((IUniTaskSource<Collision>)(object)this, core.Version);
	}

	UniTask<Collision2D> IAsyncOnCollisionStay2DHandler.OnCollisionStay2DAsync()
	{
		core.Reset();
		return new UniTask<Collision2D>((IUniTaskSource<Collision2D>)(object)this, core.Version);
	}

	UniTask<ControllerColliderHit> IAsyncOnControllerColliderHitHandler.OnControllerColliderHitAsync()
	{
		core.Reset();
		return new UniTask<ControllerColliderHit>((IUniTaskSource<ControllerColliderHit>)(object)this, core.Version);
	}

	UniTask IAsyncOnDisableHandler.OnDisableAsync()
	{
		core.Reset();
		return new UniTask(this, core.Version);
	}

	UniTask IAsyncOnDrawGizmosHandler.OnDrawGizmosAsync()
	{
		core.Reset();
		return new UniTask(this, core.Version);
	}

	UniTask IAsyncOnDrawGizmosSelectedHandler.OnDrawGizmosSelectedAsync()
	{
		core.Reset();
		return new UniTask(this, core.Version);
	}

	UniTask IAsyncOnEnableHandler.OnEnableAsync()
	{
		core.Reset();
		return new UniTask(this, core.Version);
	}

	UniTask IAsyncOnGUIHandler.OnGUIAsync()
	{
		core.Reset();
		return new UniTask(this, core.Version);
	}

	UniTask<float> IAsyncOnJointBreakHandler.OnJointBreakAsync()
	{
		core.Reset();
		return new UniTask<float>((IUniTaskSource<float>)(object)this, core.Version);
	}

	UniTask<Joint2D> IAsyncOnJointBreak2DHandler.OnJointBreak2DAsync()
	{
		core.Reset();
		return new UniTask<Joint2D>((IUniTaskSource<Joint2D>)(object)this, core.Version);
	}

	UniTask<GameObject> IAsyncOnParticleCollisionHandler.OnParticleCollisionAsync()
	{
		core.Reset();
		return new UniTask<GameObject>((IUniTaskSource<GameObject>)(object)this, core.Version);
	}

	UniTask IAsyncOnParticleSystemStoppedHandler.OnParticleSystemStoppedAsync()
	{
		core.Reset();
		return new UniTask(this, core.Version);
	}

	UniTask IAsyncOnParticleTriggerHandler.OnParticleTriggerAsync()
	{
		core.Reset();
		return new UniTask(this, core.Version);
	}

	UniTask<ParticleSystemJobData> IAsyncOnParticleUpdateJobScheduledHandler.OnParticleUpdateJobScheduledAsync()
	{
		core.Reset();
		return new UniTask<ParticleSystemJobData>((IUniTaskSource<ParticleSystemJobData>)(object)this, core.Version);
	}

	UniTask IAsyncOnPostRenderHandler.OnPostRenderAsync()
	{
		core.Reset();
		return new UniTask(this, core.Version);
	}

	UniTask IAsyncOnPreCullHandler.OnPreCullAsync()
	{
		core.Reset();
		return new UniTask(this, core.Version);
	}

	UniTask IAsyncOnPreRenderHandler.OnPreRenderAsync()
	{
		core.Reset();
		return new UniTask(this, core.Version);
	}

	UniTask IAsyncOnRectTransformDimensionsChangeHandler.OnRectTransformDimensionsChangeAsync()
	{
		core.Reset();
		return new UniTask(this, core.Version);
	}

	UniTask IAsyncOnRectTransformRemovedHandler.OnRectTransformRemovedAsync()
	{
		core.Reset();
		return new UniTask(this, core.Version);
	}

	UniTask<(RenderTexture source, RenderTexture destination)> IAsyncOnRenderImageHandler.OnRenderImageAsync()
	{
		core.Reset();
		return new UniTask<(RenderTexture, RenderTexture)>((IUniTaskSource<(RenderTexture, RenderTexture)>)(object)this, core.Version);
	}

	UniTask IAsyncOnRenderObjectHandler.OnRenderObjectAsync()
	{
		core.Reset();
		return new UniTask(this, core.Version);
	}

	UniTask IAsyncOnServerInitializedHandler.OnServerInitializedAsync()
	{
		core.Reset();
		return new UniTask(this, core.Version);
	}

	UniTask IAsyncOnTransformChildrenChangedHandler.OnTransformChildrenChangedAsync()
	{
		core.Reset();
		return new UniTask(this, core.Version);
	}

	UniTask IAsyncOnTransformParentChangedHandler.OnTransformParentChangedAsync()
	{
		core.Reset();
		return new UniTask(this, core.Version);
	}

	UniTask<Collider> IAsyncOnTriggerEnterHandler.OnTriggerEnterAsync()
	{
		core.Reset();
		return new UniTask<Collider>((IUniTaskSource<Collider>)(object)this, core.Version);
	}

	UniTask<Collider2D> IAsyncOnTriggerEnter2DHandler.OnTriggerEnter2DAsync()
	{
		core.Reset();
		return new UniTask<Collider2D>((IUniTaskSource<Collider2D>)(object)this, core.Version);
	}

	UniTask<Collider> IAsyncOnTriggerExitHandler.OnTriggerExitAsync()
	{
		core.Reset();
		return new UniTask<Collider>((IUniTaskSource<Collider>)(object)this, core.Version);
	}

	UniTask<Collider2D> IAsyncOnTriggerExit2DHandler.OnTriggerExit2DAsync()
	{
		core.Reset();
		return new UniTask<Collider2D>((IUniTaskSource<Collider2D>)(object)this, core.Version);
	}

	UniTask<Collider> IAsyncOnTriggerStayHandler.OnTriggerStayAsync()
	{
		core.Reset();
		return new UniTask<Collider>((IUniTaskSource<Collider>)(object)this, core.Version);
	}

	UniTask<Collider2D> IAsyncOnTriggerStay2DHandler.OnTriggerStay2DAsync()
	{
		core.Reset();
		return new UniTask<Collider2D>((IUniTaskSource<Collider2D>)(object)this, core.Version);
	}

	UniTask IAsyncOnValidateHandler.OnValidateAsync()
	{
		core.Reset();
		return new UniTask(this, core.Version);
	}

	UniTask IAsyncOnWillRenderObjectHandler.OnWillRenderObjectAsync()
	{
		core.Reset();
		return new UniTask(this, core.Version);
	}

	UniTask IAsyncResetHandler.ResetAsync()
	{
		core.Reset();
		return new UniTask(this, core.Version);
	}

	UniTask IAsyncUpdateHandler.UpdateAsync()
	{
		core.Reset();
		return new UniTask(this, core.Version);
	}

	UniTask<PointerEventData> IAsyncOnBeginDragHandler.OnBeginDragAsync()
	{
		core.Reset();
		return new UniTask<PointerEventData>((IUniTaskSource<PointerEventData>)(object)this, core.Version);
	}

	UniTask<BaseEventData> IAsyncOnCancelHandler.OnCancelAsync()
	{
		core.Reset();
		return new UniTask<BaseEventData>((IUniTaskSource<BaseEventData>)(object)this, core.Version);
	}

	UniTask<BaseEventData> IAsyncOnDeselectHandler.OnDeselectAsync()
	{
		core.Reset();
		return new UniTask<BaseEventData>((IUniTaskSource<BaseEventData>)(object)this, core.Version);
	}

	UniTask<PointerEventData> IAsyncOnDragHandler.OnDragAsync()
	{
		core.Reset();
		return new UniTask<PointerEventData>((IUniTaskSource<PointerEventData>)(object)this, core.Version);
	}

	UniTask<PointerEventData> IAsyncOnDropHandler.OnDropAsync()
	{
		core.Reset();
		return new UniTask<PointerEventData>((IUniTaskSource<PointerEventData>)(object)this, core.Version);
	}

	UniTask<PointerEventData> IAsyncOnEndDragHandler.OnEndDragAsync()
	{
		core.Reset();
		return new UniTask<PointerEventData>((IUniTaskSource<PointerEventData>)(object)this, core.Version);
	}

	UniTask<PointerEventData> IAsyncOnInitializePotentialDragHandler.OnInitializePotentialDragAsync()
	{
		core.Reset();
		return new UniTask<PointerEventData>((IUniTaskSource<PointerEventData>)(object)this, core.Version);
	}

	UniTask<AxisEventData> IAsyncOnMoveHandler.OnMoveAsync()
	{
		core.Reset();
		return new UniTask<AxisEventData>((IUniTaskSource<AxisEventData>)(object)this, core.Version);
	}

	UniTask<PointerEventData> IAsyncOnPointerClickHandler.OnPointerClickAsync()
	{
		core.Reset();
		return new UniTask<PointerEventData>((IUniTaskSource<PointerEventData>)(object)this, core.Version);
	}

	UniTask<PointerEventData> IAsyncOnPointerDownHandler.OnPointerDownAsync()
	{
		core.Reset();
		return new UniTask<PointerEventData>((IUniTaskSource<PointerEventData>)(object)this, core.Version);
	}

	UniTask<PointerEventData> IAsyncOnPointerEnterHandler.OnPointerEnterAsync()
	{
		core.Reset();
		return new UniTask<PointerEventData>((IUniTaskSource<PointerEventData>)(object)this, core.Version);
	}

	UniTask<PointerEventData> IAsyncOnPointerExitHandler.OnPointerExitAsync()
	{
		core.Reset();
		return new UniTask<PointerEventData>((IUniTaskSource<PointerEventData>)(object)this, core.Version);
	}

	UniTask<PointerEventData> IAsyncOnPointerUpHandler.OnPointerUpAsync()
	{
		core.Reset();
		return new UniTask<PointerEventData>((IUniTaskSource<PointerEventData>)(object)this, core.Version);
	}

	UniTask<PointerEventData> IAsyncOnScrollHandler.OnScrollAsync()
	{
		core.Reset();
		return new UniTask<PointerEventData>((IUniTaskSource<PointerEventData>)(object)this, core.Version);
	}

	UniTask<BaseEventData> IAsyncOnSelectHandler.OnSelectAsync()
	{
		core.Reset();
		return new UniTask<BaseEventData>((IUniTaskSource<BaseEventData>)(object)this, core.Version);
	}

	UniTask<BaseEventData> IAsyncOnSubmitHandler.OnSubmitAsync()
	{
		core.Reset();
		return new UniTask<BaseEventData>((IUniTaskSource<BaseEventData>)(object)this, core.Version);
	}

	UniTask<BaseEventData> IAsyncOnUpdateSelectedHandler.OnUpdateSelectedAsync()
	{
		core.Reset();
		return new UniTask<BaseEventData>((IUniTaskSource<BaseEventData>)(object)this, core.Version);
	}
}
