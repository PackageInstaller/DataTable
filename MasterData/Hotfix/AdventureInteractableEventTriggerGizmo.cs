using System;
using UnityEngine;

[AddComponentMenu("Game/Adventure/Gizmo/Interactable Event Trigger")]
public class AdventureInteractableEventTriggerGizmo : AdventureTriggerGizmo
{
	public int attributeId;

	protected bool _triggered;

	protected Action _onComplete;

	public bool isActived => ModuleController<AdventureModuleController>.Instance.activedInteractableEventTriggerGizmo == this;

	public int activedCount { get; protected set; }

	public override void Initialize()
	{
	}

	public override void Initialize(int x, int y)
	{
		base.Initialize(x, y);
	}

	protected override void TriggerStay(GameObject playerAgent)
	{
		if (!_triggered)
		{
			_triggered = Active();
		}
	}

	protected override void TriggerExit(GameObject playerAgent)
	{
		_triggered = false;
	}

	public bool Active(bool uniqueness = true, Action onComplete = null, GameObject owner = null)
	{
		if (isActived)
		{
			return false;
		}
		if (!uniqueness || ModuleController<AdventureModuleController>.Instance.activedInteractableEventTriggerGizmo == null)
		{
			Log("触发器激活");
			activedCount++;
			_onComplete = onComplete;
			ModuleController<AdventureModuleController>.Instance.ExecuteInteractableEventTrigger(this, uniqueness, OnComplete);
			return true;
		}
		return false;
	}

	protected void OnComplete()
	{
		Log("事件触发完毕");
		_onComplete?.Invoke();
	}

	protected override void OnActive()
	{
	}

	protected override void OnDeactive()
	{
	}
}
