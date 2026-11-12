using System;
using Nova.Hotfix;
using UnityEngine;

public class DormFurObjFSM_Interactive : DormFurObjFSM
{
	private DormInteractionAnimationHandler _handler;

	private DormActor _sessionActor;

	private DormFurObjInteractivePoint _sessionPoint;

	private Action _onComplete;

	public DormFurObjFSM_Interactive(DormFurObj furObj, int state)
		: base(furObj, state)
	{
	}

	public override void OnEnter(object data = null)
	{
		base.OnEnter(data);
		furObj.SetAllInteractivePointVisible(bVisible: false);
	}

	public override void OnUpdate()
	{
		base.OnUpdate();
		if (!furObj.HasAnyOccupiedInteractivePoint)
		{
			furObj.SwitchToIdle();
		}
	}

	public override void OnLateUpdate()
	{
		base.OnLateUpdate();
		_handler?.Update();
	}

	public override void OnExit()
	{
		InterruptInteraction();
		base.OnExit();
	}

	public void StartInteraction(DormActor actor, DormFurObjInteractivePoint point, Action onComplete)
	{
		if (_handler != null && _handler.isPlaying && _sessionActor != null)
		{
			FinishInteraction();
		}
		_sessionActor = actor;
		_sessionPoint = point;
		_onComplete = onComplete;
		furObj.PlaceActorAtPointStart(actor, point);
		DormInteractive dormInteractive = furObj.MatchInteractiveData(actor);
		if (dormInteractive == null || string.IsNullOrEmpty(dormInteractive.AnimationConfig))
		{
			Debug.LogError($"[DormFurObjFSM_Interactive] 家具[{furObj.FurId}]未配置与角色[{actor.SkinId}]的交互动画演出资源路径");
			FinishInteraction();
			return;
		}
		DormInteractionAnimationConfigData dormInteractionAnimationConfigData = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Any, dormInteractive.AnimationConfig, typeof(DormInteractionAnimationConfigData)) as DormInteractionAnimationConfigData;
		if (dormInteractionAnimationConfigData == null)
		{
			Debug.LogError("[DormFurObjFSM_Interactive] 未找到交互动画演出资源, 路径:" + dormInteractive.AnimationConfig);
			FinishInteraction();
			return;
		}
		furObj.ApplyInteractionNaviCut(bEnable: true);
		if (_handler == null)
		{
			_handler = new DormInteractionAnimationHandler();
		}
		_handler.Play(dormInteractionAnimationConfigData, actor, furObj, FinishInteraction);
	}

	private void FinishInteraction()
	{
		DormActor sessionActor = _sessionActor;
		DormFurObjInteractivePoint sessionPoint = _sessionPoint;
		Action onComplete = _onComplete;
		_sessionActor = null;
		_sessionPoint = null;
		_onComplete = null;
		furObj.PlaceActorAtPointEnd(sessionActor, sessionPoint);
		if (sessionActor != null)
		{
			sessionActor.InterWithObjeComplete();
		}
		onComplete?.Invoke();
	}

	public void InterruptInteraction()
	{
		_sessionActor = null;
		_sessionPoint = null;
		_onComplete = null;
		_handler?.Stop();
		furObj.ApplyInteractionNaviCut(bEnable: false);
	}
}
