using UnityEngine;

namespace Cysharp.Threading.Tasks.Triggers;

public static class AsyncTriggerExtensions
{
	public static AsyncAwakeTrigger GetAsyncAwakeTrigger(this GameObject gameObject)
	{
		return GetOrAddComponent<AsyncAwakeTrigger>(gameObject);
	}

	public static AsyncAwakeTrigger GetAsyncAwakeTrigger(this Component component)
	{
		return component.gameObject.GetAsyncAwakeTrigger();
	}

	public static AsyncDestroyTrigger GetAsyncDestroyTrigger(this GameObject gameObject)
	{
		return GetOrAddComponent<AsyncDestroyTrigger>(gameObject);
	}

	public static AsyncDestroyTrigger GetAsyncDestroyTrigger(this Component component)
	{
		return component.gameObject.GetAsyncDestroyTrigger();
	}

	public static AsyncStartTrigger GetAsyncStartTrigger(this GameObject gameObject)
	{
		return GetOrAddComponent<AsyncStartTrigger>(gameObject);
	}

	public static AsyncStartTrigger GetAsyncStartTrigger(this Component component)
	{
		return component.gameObject.GetAsyncStartTrigger();
	}

	private static T GetOrAddComponent<T>(GameObject gameObject) where T : Component
	{
		if (!gameObject.TryGetComponent<T>(out var component))
		{
			return gameObject.AddComponent<T>();
		}
		return component;
	}

	public static UniTask OnDestroyAsync(this GameObject gameObject)
	{
		return gameObject.GetAsyncDestroyTrigger().OnDestroyAsync();
	}

	public static UniTask OnDestroyAsync(this Component component)
	{
		return component.GetAsyncDestroyTrigger().OnDestroyAsync();
	}

	public static UniTask StartAsync(this GameObject gameObject)
	{
		return gameObject.GetAsyncStartTrigger().StartAsync();
	}

	public static UniTask StartAsync(this Component component)
	{
		return component.GetAsyncStartTrigger().StartAsync();
	}

	public static UniTask AwakeAsync(this GameObject gameObject)
	{
		return gameObject.GetAsyncAwakeTrigger().AwakeAsync();
	}

	public static UniTask AwakeAsync(this Component component)
	{
		return component.GetAsyncAwakeTrigger().AwakeAsync();
	}

	public static AsyncFixedUpdateTrigger GetAsyncFixedUpdateTrigger(this GameObject gameObject)
	{
		return GetOrAddComponent<AsyncFixedUpdateTrigger>(gameObject);
	}

	public static AsyncFixedUpdateTrigger GetAsyncFixedUpdateTrigger(this Component component)
	{
		return component.gameObject.GetAsyncFixedUpdateTrigger();
	}

	public static AsyncLateUpdateTrigger GetAsyncLateUpdateTrigger(this GameObject gameObject)
	{
		return GetOrAddComponent<AsyncLateUpdateTrigger>(gameObject);
	}

	public static AsyncLateUpdateTrigger GetAsyncLateUpdateTrigger(this Component component)
	{
		return component.gameObject.GetAsyncLateUpdateTrigger();
	}

	public static AsyncAnimatorIKTrigger GetAsyncAnimatorIKTrigger(this GameObject gameObject)
	{
		return GetOrAddComponent<AsyncAnimatorIKTrigger>(gameObject);
	}

	public static AsyncAnimatorIKTrigger GetAsyncAnimatorIKTrigger(this Component component)
	{
		return component.gameObject.GetAsyncAnimatorIKTrigger();
	}

	public static AsyncAnimatorMoveTrigger GetAsyncAnimatorMoveTrigger(this GameObject gameObject)
	{
		return GetOrAddComponent<AsyncAnimatorMoveTrigger>(gameObject);
	}

	public static AsyncAnimatorMoveTrigger GetAsyncAnimatorMoveTrigger(this Component component)
	{
		return component.gameObject.GetAsyncAnimatorMoveTrigger();
	}

	public static AsyncApplicationFocusTrigger GetAsyncApplicationFocusTrigger(this GameObject gameObject)
	{
		return GetOrAddComponent<AsyncApplicationFocusTrigger>(gameObject);
	}

	public static AsyncApplicationFocusTrigger GetAsyncApplicationFocusTrigger(this Component component)
	{
		return component.gameObject.GetAsyncApplicationFocusTrigger();
	}

	public static AsyncApplicationPauseTrigger GetAsyncApplicationPauseTrigger(this GameObject gameObject)
	{
		return GetOrAddComponent<AsyncApplicationPauseTrigger>(gameObject);
	}

	public static AsyncApplicationPauseTrigger GetAsyncApplicationPauseTrigger(this Component component)
	{
		return component.gameObject.GetAsyncApplicationPauseTrigger();
	}

	public static AsyncApplicationQuitTrigger GetAsyncApplicationQuitTrigger(this GameObject gameObject)
	{
		return GetOrAddComponent<AsyncApplicationQuitTrigger>(gameObject);
	}

	public static AsyncApplicationQuitTrigger GetAsyncApplicationQuitTrigger(this Component component)
	{
		return component.gameObject.GetAsyncApplicationQuitTrigger();
	}

	public static AsyncAudioFilterReadTrigger GetAsyncAudioFilterReadTrigger(this GameObject gameObject)
	{
		return GetOrAddComponent<AsyncAudioFilterReadTrigger>(gameObject);
	}

	public static AsyncAudioFilterReadTrigger GetAsyncAudioFilterReadTrigger(this Component component)
	{
		return component.gameObject.GetAsyncAudioFilterReadTrigger();
	}

	public static AsyncBecameInvisibleTrigger GetAsyncBecameInvisibleTrigger(this GameObject gameObject)
	{
		return GetOrAddComponent<AsyncBecameInvisibleTrigger>(gameObject);
	}

	public static AsyncBecameInvisibleTrigger GetAsyncBecameInvisibleTrigger(this Component component)
	{
		return component.gameObject.GetAsyncBecameInvisibleTrigger();
	}

	public static AsyncBecameVisibleTrigger GetAsyncBecameVisibleTrigger(this GameObject gameObject)
	{
		return GetOrAddComponent<AsyncBecameVisibleTrigger>(gameObject);
	}

	public static AsyncBecameVisibleTrigger GetAsyncBecameVisibleTrigger(this Component component)
	{
		return component.gameObject.GetAsyncBecameVisibleTrigger();
	}

	public static AsyncBeforeTransformParentChangedTrigger GetAsyncBeforeTransformParentChangedTrigger(this GameObject gameObject)
	{
		return GetOrAddComponent<AsyncBeforeTransformParentChangedTrigger>(gameObject);
	}

	public static AsyncBeforeTransformParentChangedTrigger GetAsyncBeforeTransformParentChangedTrigger(this Component component)
	{
		return component.gameObject.GetAsyncBeforeTransformParentChangedTrigger();
	}

	public static AsyncOnCanvasGroupChangedTrigger GetAsyncOnCanvasGroupChangedTrigger(this GameObject gameObject)
	{
		return GetOrAddComponent<AsyncOnCanvasGroupChangedTrigger>(gameObject);
	}

	public static AsyncOnCanvasGroupChangedTrigger GetAsyncOnCanvasGroupChangedTrigger(this Component component)
	{
		return component.gameObject.GetAsyncOnCanvasGroupChangedTrigger();
	}

	public static AsyncCollisionEnterTrigger GetAsyncCollisionEnterTrigger(this GameObject gameObject)
	{
		return GetOrAddComponent<AsyncCollisionEnterTrigger>(gameObject);
	}

	public static AsyncCollisionEnterTrigger GetAsyncCollisionEnterTrigger(this Component component)
	{
		return component.gameObject.GetAsyncCollisionEnterTrigger();
	}

	public static AsyncCollisionEnter2DTrigger GetAsyncCollisionEnter2DTrigger(this GameObject gameObject)
	{
		return GetOrAddComponent<AsyncCollisionEnter2DTrigger>(gameObject);
	}

	public static AsyncCollisionEnter2DTrigger GetAsyncCollisionEnter2DTrigger(this Component component)
	{
		return component.gameObject.GetAsyncCollisionEnter2DTrigger();
	}

	public static AsyncCollisionExitTrigger GetAsyncCollisionExitTrigger(this GameObject gameObject)
	{
		return GetOrAddComponent<AsyncCollisionExitTrigger>(gameObject);
	}

	public static AsyncCollisionExitTrigger GetAsyncCollisionExitTrigger(this Component component)
	{
		return component.gameObject.GetAsyncCollisionExitTrigger();
	}

	public static AsyncCollisionExit2DTrigger GetAsyncCollisionExit2DTrigger(this GameObject gameObject)
	{
		return GetOrAddComponent<AsyncCollisionExit2DTrigger>(gameObject);
	}

	public static AsyncCollisionExit2DTrigger GetAsyncCollisionExit2DTrigger(this Component component)
	{
		return component.gameObject.GetAsyncCollisionExit2DTrigger();
	}

	public static AsyncCollisionStayTrigger GetAsyncCollisionStayTrigger(this GameObject gameObject)
	{
		return GetOrAddComponent<AsyncCollisionStayTrigger>(gameObject);
	}

	public static AsyncCollisionStayTrigger GetAsyncCollisionStayTrigger(this Component component)
	{
		return component.gameObject.GetAsyncCollisionStayTrigger();
	}

	public static AsyncCollisionStay2DTrigger GetAsyncCollisionStay2DTrigger(this GameObject gameObject)
	{
		return GetOrAddComponent<AsyncCollisionStay2DTrigger>(gameObject);
	}

	public static AsyncCollisionStay2DTrigger GetAsyncCollisionStay2DTrigger(this Component component)
	{
		return component.gameObject.GetAsyncCollisionStay2DTrigger();
	}

	public static AsyncControllerColliderHitTrigger GetAsyncControllerColliderHitTrigger(this GameObject gameObject)
	{
		return GetOrAddComponent<AsyncControllerColliderHitTrigger>(gameObject);
	}

	public static AsyncControllerColliderHitTrigger GetAsyncControllerColliderHitTrigger(this Component component)
	{
		return component.gameObject.GetAsyncControllerColliderHitTrigger();
	}

	public static AsyncDisableTrigger GetAsyncDisableTrigger(this GameObject gameObject)
	{
		return GetOrAddComponent<AsyncDisableTrigger>(gameObject);
	}

	public static AsyncDisableTrigger GetAsyncDisableTrigger(this Component component)
	{
		return component.gameObject.GetAsyncDisableTrigger();
	}

	public static AsyncDrawGizmosTrigger GetAsyncDrawGizmosTrigger(this GameObject gameObject)
	{
		return GetOrAddComponent<AsyncDrawGizmosTrigger>(gameObject);
	}

	public static AsyncDrawGizmosTrigger GetAsyncDrawGizmosTrigger(this Component component)
	{
		return component.gameObject.GetAsyncDrawGizmosTrigger();
	}

	public static AsyncDrawGizmosSelectedTrigger GetAsyncDrawGizmosSelectedTrigger(this GameObject gameObject)
	{
		return GetOrAddComponent<AsyncDrawGizmosSelectedTrigger>(gameObject);
	}

	public static AsyncDrawGizmosSelectedTrigger GetAsyncDrawGizmosSelectedTrigger(this Component component)
	{
		return component.gameObject.GetAsyncDrawGizmosSelectedTrigger();
	}

	public static AsyncEnableTrigger GetAsyncEnableTrigger(this GameObject gameObject)
	{
		return GetOrAddComponent<AsyncEnableTrigger>(gameObject);
	}

	public static AsyncEnableTrigger GetAsyncEnableTrigger(this Component component)
	{
		return component.gameObject.GetAsyncEnableTrigger();
	}

	public static AsyncGUITrigger GetAsyncGUITrigger(this GameObject gameObject)
	{
		return GetOrAddComponent<AsyncGUITrigger>(gameObject);
	}

	public static AsyncGUITrigger GetAsyncGUITrigger(this Component component)
	{
		return component.gameObject.GetAsyncGUITrigger();
	}

	public static AsyncJointBreakTrigger GetAsyncJointBreakTrigger(this GameObject gameObject)
	{
		return GetOrAddComponent<AsyncJointBreakTrigger>(gameObject);
	}

	public static AsyncJointBreakTrigger GetAsyncJointBreakTrigger(this Component component)
	{
		return component.gameObject.GetAsyncJointBreakTrigger();
	}

	public static AsyncJointBreak2DTrigger GetAsyncJointBreak2DTrigger(this GameObject gameObject)
	{
		return GetOrAddComponent<AsyncJointBreak2DTrigger>(gameObject);
	}

	public static AsyncJointBreak2DTrigger GetAsyncJointBreak2DTrigger(this Component component)
	{
		return component.gameObject.GetAsyncJointBreak2DTrigger();
	}

	public static AsyncParticleCollisionTrigger GetAsyncParticleCollisionTrigger(this GameObject gameObject)
	{
		return GetOrAddComponent<AsyncParticleCollisionTrigger>(gameObject);
	}

	public static AsyncParticleCollisionTrigger GetAsyncParticleCollisionTrigger(this Component component)
	{
		return component.gameObject.GetAsyncParticleCollisionTrigger();
	}

	public static AsyncParticleSystemStoppedTrigger GetAsyncParticleSystemStoppedTrigger(this GameObject gameObject)
	{
		return GetOrAddComponent<AsyncParticleSystemStoppedTrigger>(gameObject);
	}

	public static AsyncParticleSystemStoppedTrigger GetAsyncParticleSystemStoppedTrigger(this Component component)
	{
		return component.gameObject.GetAsyncParticleSystemStoppedTrigger();
	}

	public static AsyncParticleTriggerTrigger GetAsyncParticleTriggerTrigger(this GameObject gameObject)
	{
		return GetOrAddComponent<AsyncParticleTriggerTrigger>(gameObject);
	}

	public static AsyncParticleTriggerTrigger GetAsyncParticleTriggerTrigger(this Component component)
	{
		return component.gameObject.GetAsyncParticleTriggerTrigger();
	}

	public static AsyncParticleUpdateJobScheduledTrigger GetAsyncParticleUpdateJobScheduledTrigger(this GameObject gameObject)
	{
		return GetOrAddComponent<AsyncParticleUpdateJobScheduledTrigger>(gameObject);
	}

	public static AsyncParticleUpdateJobScheduledTrigger GetAsyncParticleUpdateJobScheduledTrigger(this Component component)
	{
		return component.gameObject.GetAsyncParticleUpdateJobScheduledTrigger();
	}

	public static AsyncPostRenderTrigger GetAsyncPostRenderTrigger(this GameObject gameObject)
	{
		return GetOrAddComponent<AsyncPostRenderTrigger>(gameObject);
	}

	public static AsyncPostRenderTrigger GetAsyncPostRenderTrigger(this Component component)
	{
		return component.gameObject.GetAsyncPostRenderTrigger();
	}

	public static AsyncPreCullTrigger GetAsyncPreCullTrigger(this GameObject gameObject)
	{
		return GetOrAddComponent<AsyncPreCullTrigger>(gameObject);
	}

	public static AsyncPreCullTrigger GetAsyncPreCullTrigger(this Component component)
	{
		return component.gameObject.GetAsyncPreCullTrigger();
	}

	public static AsyncPreRenderTrigger GetAsyncPreRenderTrigger(this GameObject gameObject)
	{
		return GetOrAddComponent<AsyncPreRenderTrigger>(gameObject);
	}

	public static AsyncPreRenderTrigger GetAsyncPreRenderTrigger(this Component component)
	{
		return component.gameObject.GetAsyncPreRenderTrigger();
	}

	public static AsyncRectTransformDimensionsChangeTrigger GetAsyncRectTransformDimensionsChangeTrigger(this GameObject gameObject)
	{
		return GetOrAddComponent<AsyncRectTransformDimensionsChangeTrigger>(gameObject);
	}

	public static AsyncRectTransformDimensionsChangeTrigger GetAsyncRectTransformDimensionsChangeTrigger(this Component component)
	{
		return component.gameObject.GetAsyncRectTransformDimensionsChangeTrigger();
	}

	public static AsyncRectTransformRemovedTrigger GetAsyncRectTransformRemovedTrigger(this GameObject gameObject)
	{
		return GetOrAddComponent<AsyncRectTransformRemovedTrigger>(gameObject);
	}

	public static AsyncRectTransformRemovedTrigger GetAsyncRectTransformRemovedTrigger(this Component component)
	{
		return component.gameObject.GetAsyncRectTransformRemovedTrigger();
	}

	public static AsyncRenderImageTrigger GetAsyncRenderImageTrigger(this GameObject gameObject)
	{
		return GetOrAddComponent<AsyncRenderImageTrigger>(gameObject);
	}

	public static AsyncRenderImageTrigger GetAsyncRenderImageTrigger(this Component component)
	{
		return component.gameObject.GetAsyncRenderImageTrigger();
	}

	public static AsyncRenderObjectTrigger GetAsyncRenderObjectTrigger(this GameObject gameObject)
	{
		return GetOrAddComponent<AsyncRenderObjectTrigger>(gameObject);
	}

	public static AsyncRenderObjectTrigger GetAsyncRenderObjectTrigger(this Component component)
	{
		return component.gameObject.GetAsyncRenderObjectTrigger();
	}

	public static AsyncServerInitializedTrigger GetAsyncServerInitializedTrigger(this GameObject gameObject)
	{
		return GetOrAddComponent<AsyncServerInitializedTrigger>(gameObject);
	}

	public static AsyncServerInitializedTrigger GetAsyncServerInitializedTrigger(this Component component)
	{
		return component.gameObject.GetAsyncServerInitializedTrigger();
	}

	public static AsyncTransformChildrenChangedTrigger GetAsyncTransformChildrenChangedTrigger(this GameObject gameObject)
	{
		return GetOrAddComponent<AsyncTransformChildrenChangedTrigger>(gameObject);
	}

	public static AsyncTransformChildrenChangedTrigger GetAsyncTransformChildrenChangedTrigger(this Component component)
	{
		return component.gameObject.GetAsyncTransformChildrenChangedTrigger();
	}

	public static AsyncTransformParentChangedTrigger GetAsyncTransformParentChangedTrigger(this GameObject gameObject)
	{
		return GetOrAddComponent<AsyncTransformParentChangedTrigger>(gameObject);
	}

	public static AsyncTransformParentChangedTrigger GetAsyncTransformParentChangedTrigger(this Component component)
	{
		return component.gameObject.GetAsyncTransformParentChangedTrigger();
	}

	public static AsyncTriggerEnterTrigger GetAsyncTriggerEnterTrigger(this GameObject gameObject)
	{
		return GetOrAddComponent<AsyncTriggerEnterTrigger>(gameObject);
	}

	public static AsyncTriggerEnterTrigger GetAsyncTriggerEnterTrigger(this Component component)
	{
		return component.gameObject.GetAsyncTriggerEnterTrigger();
	}

	public static AsyncTriggerEnter2DTrigger GetAsyncTriggerEnter2DTrigger(this GameObject gameObject)
	{
		return GetOrAddComponent<AsyncTriggerEnter2DTrigger>(gameObject);
	}

	public static AsyncTriggerEnter2DTrigger GetAsyncTriggerEnter2DTrigger(this Component component)
	{
		return component.gameObject.GetAsyncTriggerEnter2DTrigger();
	}

	public static AsyncTriggerExitTrigger GetAsyncTriggerExitTrigger(this GameObject gameObject)
	{
		return GetOrAddComponent<AsyncTriggerExitTrigger>(gameObject);
	}

	public static AsyncTriggerExitTrigger GetAsyncTriggerExitTrigger(this Component component)
	{
		return component.gameObject.GetAsyncTriggerExitTrigger();
	}

	public static AsyncTriggerExit2DTrigger GetAsyncTriggerExit2DTrigger(this GameObject gameObject)
	{
		return GetOrAddComponent<AsyncTriggerExit2DTrigger>(gameObject);
	}

	public static AsyncTriggerExit2DTrigger GetAsyncTriggerExit2DTrigger(this Component component)
	{
		return component.gameObject.GetAsyncTriggerExit2DTrigger();
	}

	public static AsyncTriggerStayTrigger GetAsyncTriggerStayTrigger(this GameObject gameObject)
	{
		return GetOrAddComponent<AsyncTriggerStayTrigger>(gameObject);
	}

	public static AsyncTriggerStayTrigger GetAsyncTriggerStayTrigger(this Component component)
	{
		return component.gameObject.GetAsyncTriggerStayTrigger();
	}

	public static AsyncTriggerStay2DTrigger GetAsyncTriggerStay2DTrigger(this GameObject gameObject)
	{
		return GetOrAddComponent<AsyncTriggerStay2DTrigger>(gameObject);
	}

	public static AsyncTriggerStay2DTrigger GetAsyncTriggerStay2DTrigger(this Component component)
	{
		return component.gameObject.GetAsyncTriggerStay2DTrigger();
	}

	public static AsyncValidateTrigger GetAsyncValidateTrigger(this GameObject gameObject)
	{
		return GetOrAddComponent<AsyncValidateTrigger>(gameObject);
	}

	public static AsyncValidateTrigger GetAsyncValidateTrigger(this Component component)
	{
		return component.gameObject.GetAsyncValidateTrigger();
	}

	public static AsyncWillRenderObjectTrigger GetAsyncWillRenderObjectTrigger(this GameObject gameObject)
	{
		return GetOrAddComponent<AsyncWillRenderObjectTrigger>(gameObject);
	}

	public static AsyncWillRenderObjectTrigger GetAsyncWillRenderObjectTrigger(this Component component)
	{
		return component.gameObject.GetAsyncWillRenderObjectTrigger();
	}

	public static AsyncResetTrigger GetAsyncResetTrigger(this GameObject gameObject)
	{
		return GetOrAddComponent<AsyncResetTrigger>(gameObject);
	}

	public static AsyncResetTrigger GetAsyncResetTrigger(this Component component)
	{
		return component.gameObject.GetAsyncResetTrigger();
	}

	public static AsyncUpdateTrigger GetAsyncUpdateTrigger(this GameObject gameObject)
	{
		return GetOrAddComponent<AsyncUpdateTrigger>(gameObject);
	}

	public static AsyncUpdateTrigger GetAsyncUpdateTrigger(this Component component)
	{
		return component.gameObject.GetAsyncUpdateTrigger();
	}

	public static AsyncBeginDragTrigger GetAsyncBeginDragTrigger(this GameObject gameObject)
	{
		return GetOrAddComponent<AsyncBeginDragTrigger>(gameObject);
	}

	public static AsyncBeginDragTrigger GetAsyncBeginDragTrigger(this Component component)
	{
		return component.gameObject.GetAsyncBeginDragTrigger();
	}

	public static AsyncCancelTrigger GetAsyncCancelTrigger(this GameObject gameObject)
	{
		return GetOrAddComponent<AsyncCancelTrigger>(gameObject);
	}

	public static AsyncCancelTrigger GetAsyncCancelTrigger(this Component component)
	{
		return component.gameObject.GetAsyncCancelTrigger();
	}

	public static AsyncDeselectTrigger GetAsyncDeselectTrigger(this GameObject gameObject)
	{
		return GetOrAddComponent<AsyncDeselectTrigger>(gameObject);
	}

	public static AsyncDeselectTrigger GetAsyncDeselectTrigger(this Component component)
	{
		return component.gameObject.GetAsyncDeselectTrigger();
	}

	public static AsyncDragTrigger GetAsyncDragTrigger(this GameObject gameObject)
	{
		return GetOrAddComponent<AsyncDragTrigger>(gameObject);
	}

	public static AsyncDragTrigger GetAsyncDragTrigger(this Component component)
	{
		return component.gameObject.GetAsyncDragTrigger();
	}

	public static AsyncDropTrigger GetAsyncDropTrigger(this GameObject gameObject)
	{
		return GetOrAddComponent<AsyncDropTrigger>(gameObject);
	}

	public static AsyncDropTrigger GetAsyncDropTrigger(this Component component)
	{
		return component.gameObject.GetAsyncDropTrigger();
	}

	public static AsyncEndDragTrigger GetAsyncEndDragTrigger(this GameObject gameObject)
	{
		return GetOrAddComponent<AsyncEndDragTrigger>(gameObject);
	}

	public static AsyncEndDragTrigger GetAsyncEndDragTrigger(this Component component)
	{
		return component.gameObject.GetAsyncEndDragTrigger();
	}

	public static AsyncInitializePotentialDragTrigger GetAsyncInitializePotentialDragTrigger(this GameObject gameObject)
	{
		return GetOrAddComponent<AsyncInitializePotentialDragTrigger>(gameObject);
	}

	public static AsyncInitializePotentialDragTrigger GetAsyncInitializePotentialDragTrigger(this Component component)
	{
		return component.gameObject.GetAsyncInitializePotentialDragTrigger();
	}

	public static AsyncMoveTrigger GetAsyncMoveTrigger(this GameObject gameObject)
	{
		return GetOrAddComponent<AsyncMoveTrigger>(gameObject);
	}

	public static AsyncMoveTrigger GetAsyncMoveTrigger(this Component component)
	{
		return component.gameObject.GetAsyncMoveTrigger();
	}

	public static AsyncPointerClickTrigger GetAsyncPointerClickTrigger(this GameObject gameObject)
	{
		return GetOrAddComponent<AsyncPointerClickTrigger>(gameObject);
	}

	public static AsyncPointerClickTrigger GetAsyncPointerClickTrigger(this Component component)
	{
		return component.gameObject.GetAsyncPointerClickTrigger();
	}

	public static AsyncPointerDownTrigger GetAsyncPointerDownTrigger(this GameObject gameObject)
	{
		return GetOrAddComponent<AsyncPointerDownTrigger>(gameObject);
	}

	public static AsyncPointerDownTrigger GetAsyncPointerDownTrigger(this Component component)
	{
		return component.gameObject.GetAsyncPointerDownTrigger();
	}

	public static AsyncPointerEnterTrigger GetAsyncPointerEnterTrigger(this GameObject gameObject)
	{
		return GetOrAddComponent<AsyncPointerEnterTrigger>(gameObject);
	}

	public static AsyncPointerEnterTrigger GetAsyncPointerEnterTrigger(this Component component)
	{
		return component.gameObject.GetAsyncPointerEnterTrigger();
	}

	public static AsyncPointerExitTrigger GetAsyncPointerExitTrigger(this GameObject gameObject)
	{
		return GetOrAddComponent<AsyncPointerExitTrigger>(gameObject);
	}

	public static AsyncPointerExitTrigger GetAsyncPointerExitTrigger(this Component component)
	{
		return component.gameObject.GetAsyncPointerExitTrigger();
	}

	public static AsyncPointerUpTrigger GetAsyncPointerUpTrigger(this GameObject gameObject)
	{
		return GetOrAddComponent<AsyncPointerUpTrigger>(gameObject);
	}

	public static AsyncPointerUpTrigger GetAsyncPointerUpTrigger(this Component component)
	{
		return component.gameObject.GetAsyncPointerUpTrigger();
	}

	public static AsyncScrollTrigger GetAsyncScrollTrigger(this GameObject gameObject)
	{
		return GetOrAddComponent<AsyncScrollTrigger>(gameObject);
	}

	public static AsyncScrollTrigger GetAsyncScrollTrigger(this Component component)
	{
		return component.gameObject.GetAsyncScrollTrigger();
	}

	public static AsyncSelectTrigger GetAsyncSelectTrigger(this GameObject gameObject)
	{
		return GetOrAddComponent<AsyncSelectTrigger>(gameObject);
	}

	public static AsyncSelectTrigger GetAsyncSelectTrigger(this Component component)
	{
		return component.gameObject.GetAsyncSelectTrigger();
	}

	public static AsyncSubmitTrigger GetAsyncSubmitTrigger(this GameObject gameObject)
	{
		return GetOrAddComponent<AsyncSubmitTrigger>(gameObject);
	}

	public static AsyncSubmitTrigger GetAsyncSubmitTrigger(this Component component)
	{
		return component.gameObject.GetAsyncSubmitTrigger();
	}

	public static AsyncUpdateSelectedTrigger GetAsyncUpdateSelectedTrigger(this GameObject gameObject)
	{
		return GetOrAddComponent<AsyncUpdateSelectedTrigger>(gameObject);
	}

	public static AsyncUpdateSelectedTrigger GetAsyncUpdateSelectedTrigger(this Component component)
	{
		return component.gameObject.GetAsyncUpdateSelectedTrigger();
	}
}
