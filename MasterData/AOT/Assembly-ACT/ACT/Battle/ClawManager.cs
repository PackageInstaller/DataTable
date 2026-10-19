using System;
using System.Collections.Generic;
using ACT.Event;
using ACT.World.Asset;
using ACT.World.StateObject;
using Bamboo.ECS;
using Fundamental;

namespace ACT.Battle;

public class ClawManager : GameSubManager
{
	private enum ClawSearchState
	{
		Inactive,
		Disabled,
		WaitingForAvailable,
		Searching
	}

	private readonly List<InteractClaw> _interactClaws = new List<InteractClaw>();

	private ClawSearchState _searchState;

	private bool _disableClaw;

	private bool _isUIEnabled;

	private InteractClaw _selectedClaw;

	private bool _hasClawAction;

	private Action<Entity> _onClawAction;

	public static bool ShowClawGuideEffect { get; private set; }

	public static bool ClawIsUnlock => Singleton<SystemUnlockManager>.instance.IsUnlock(103101);

	public bool CanFinfClaw { get; set; }

	public override ContextType ContextType => ContextType.WORLD;

	protected override void Init()
	{
		if (_onClawAction == null)
		{
			_onClawAction = OnClawAction;
		}
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.System_Open, OnSystemOpen);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.AfterLeaveWorld, OnLeaveWorld);
	}

	protected override void UnInit()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.System_Open, OnSystemOpen);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.AfterLeaveWorld, OnLeaveWorld);
		ResetClawState();
	}

	protected override void Update()
	{
		MonoECS instance = MonoECS.instance;
		if (instance == null || !instance.isStartWorld)
		{
			return;
		}
		RemoveInvalidClaws();
		if (instance.mainEntity == null)
		{
			HideGuideEffectsExcept(null);
			_interactClaws.Clear();
			SetSearchState(ClawSearchState.Inactive);
		}
		else if (_disableClaw)
		{
			SetSearchState(ClawSearchState.Disabled);
		}
		else if (_interactClaws.Count == 0)
		{
			SetSearchState(ClawSearchState.Inactive);
		}
		else if (!CanFinfClaw)
		{
			SetSearchState(ClawSearchState.WaitingForAvailable);
			if (!instance.mainEntity.GetCompPhysics().CantHook)
			{
				CanFinfClaw = true;
			}
		}
		else
		{
			SetSearchState(ClawSearchState.Searching);
			RefreshFinalClaw(instance);
		}
	}

	public void AddInteractClaw(InteractClaw claw)
	{
		if (claw != null && !_interactClaws.Contains(claw))
		{
			_interactClaws.Add(claw);
		}
	}

	public void RemoveInteractClaw(InteractClaw claw)
	{
		if (claw != null)
		{
			_interactClaws.Remove(claw);
			return;
		}
		_interactClaws.RemoveAll((InteractClaw item) => item == null);
	}

	public void RefreshClaw(bool disableClaw)
	{
		_disableClaw = disableClaw;
	}

	private void OnSystemOpen(BaseEventContent obj)
	{
		if (obj is SystemOpenEvt { systemId: 103101 })
		{
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_ClawUnlock, null);
			if (!_disableClaw && _interactClaws.Count > 0)
			{
				SetClawUIState(canUse: true);
			}
		}
	}

	private void OnLeaveWorld(BaseEventContent obj)
	{
		ResetClawState();
	}

	private void ResetClawState()
	{
		HideGuideEffectsExcept(null);
		_interactClaws.Clear();
		CanFinfClaw = false;
		SetSearchState(ClawSearchState.Inactive, force: true);
	}

	private void SetSearchState(ClawSearchState state, bool force = false)
	{
		if (force || _searchState != state)
		{
			_searchState = state;
			switch (state)
			{
			case ClawSearchState.Searching:
				SetClawUIState(canUse: true);
				break;
			case ClawSearchState.WaitingForAvailable:
				SetClawAction(null);
				HideGuideEffectsExcept(GetCurrentGuideClaw());
				SetClawUIState(canUse: true);
				break;
			case ClawSearchState.Inactive:
			case ClawSearchState.Disabled:
				SetClawAction(null);
				HideGuideEffectsExcept(null);
				SetClawUIState(canUse: false);
				break;
			}
		}
	}

	private void SetClawUIState(bool canUse)
	{
		canUse &= !_disableClaw && ClawIsUnlock && _interactClaws.Count > 0;
		ShowClawGuideEffect = canUse;
		if (_isUIEnabled != canUse)
		{
			_isUIEnabled = canUse;
			ClawStateEvt evt = Singleton<EventManager>.instance.GetEvt<ClawStateEvt>();
			evt.canUse = canUse;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_ClawStateChange, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
		}
	}

	private void RefreshFinalClaw(MonoECS ecs)
	{
		InteractClaw interactClaw = FindFinalClaw(ecs);
		bool flag = interactClaw != null && ClawIsUnlock;
		if (_selectedClaw != interactClaw || _hasClawAction != flag)
		{
			SetClawAction(interactClaw);
			HideGuideEffectsExcept(interactClaw);
			if (flag)
			{
				interactClaw.ShowGuideEffect(state: true);
			}
		}
	}

	private InteractClaw FindFinalClaw(MonoECS ecs)
	{
		InteractClaw interactClaw = _interactClaws[0];
		InteractClaw interactClaw2 = null;
		float num = float.MaxValue;
		float num2 = float.MaxValue;
		for (int i = 0; i < _interactClaws.Count; i++)
		{
			InteractClaw interactClaw3 = _interactClaws[i];
			if (!(interactClaw3 == null))
			{
				if (interactClaw3.distance < num)
				{
					num = interactClaw3.distance;
					interactClaw = interactClaw3;
				}
				if (ecs.mainEntity.IsValid && (((interactClaw3.faceDirect & ClawData.Direction.Left) > (ClawData.Direction)0 && ecs.mainEntity.IsFaceRight()) || ((interactClaw3.faceDirect & ClawData.Direction.Right) > (ClawData.Direction)0 && ecs.mainEntity.IsFaceLeft())) && interactClaw3.distance < num2)
				{
					num2 = interactClaw3.distance;
					interactClaw2 = interactClaw3;
				}
			}
		}
		return interactClaw2 ?? interactClaw;
	}

	private void SetClawAction(InteractClaw claw)
	{
		bool flag = claw != null && ClawIsUnlock;
		if (_selectedClaw == claw && _hasClawAction == flag)
		{
			return;
		}
		_selectedClaw = claw;
		_hasClawAction = flag;
		MonoECS instance = MonoECS.instance;
		if (!(instance == null))
		{
			instance.onClawAction = null;
			if (flag)
			{
				instance.onClawAction = (Action<Entity>)Delegate.Combine(instance.onClawAction, _onClawAction);
			}
		}
	}

	private void OnClawAction(Entity playerEntity)
	{
		if (playerEntity.IsValid && !playerEntity.GetMotionBool("MotionForbidDodgeAndGrab"))
		{
			InteractClaw selectedClaw = _selectedClaw;
			if (!(selectedClaw == null))
			{
				selectedClaw.OnInteract(playerEntity);
			}
		}
	}

	private void RemoveInvalidClaws()
	{
		for (int num = _interactClaws.Count - 1; num >= 0; num--)
		{
			if (_interactClaws[num] == null)
			{
				_interactClaws.RemoveAt(num);
			}
		}
	}

	private InteractClaw GetCurrentGuideClaw()
	{
		foreach (InteractClaw interactClaw in _interactClaws)
		{
			if (interactClaw != null && interactClaw.guideEffect != null && interactClaw.guideEffect.activeSelf)
			{
				return interactClaw;
			}
		}
		return null;
	}

	private void HideGuideEffectsExcept(InteractClaw retainedClaw)
	{
		foreach (InteractClaw interactClaw in _interactClaws)
		{
			if (interactClaw != null && interactClaw != retainedClaw)
			{
				interactClaw.ShowGuideEffect(state: false);
			}
		}
	}
}
