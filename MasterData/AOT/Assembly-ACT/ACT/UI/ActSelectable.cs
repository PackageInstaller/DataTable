using System;
using ACT.UI.InputController;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ACT.UI;

public class ActSelectable<TParams> : Selectable, IPointerClickHandler, IEventSystemHandler, ISubmitHandler where TParams : ActSelectableParams
{
	[SerializeField]
	protected TParams _params;

	[SerializeField]
	protected BetterAnimation _animation;

	protected SelectionState _state;

	protected bool _isPointerInside;

	protected bool _isPointerDown;

	protected bool _isSelected;

	public ActSelectableState CurrentState => (ActSelectableState)_state;

	public event Action<ActSelectableState> OnStateChanged;

	protected override void OnEnable()
	{
		base.OnEnable();
		if ((bool)EventSystemHelper.Shared && EventSystemHelper.CurrentSelected == gameObject)
		{
			_isSelected = true;
		}
		_isPointerDown = false;
		_state = GetCurState();
		if (_animation == null)
		{
			_animation = GetComponent<BetterAnimation>();
		}
		PlayStateTransition();
		OnStateChanged?.Invoke((ActSelectableState)_state);
		OnEnableImp();
	}

	protected virtual void OnEnableImp()
	{
	}

	public bool Interactable(bool active)
	{
		if (interactable == active)
		{
			return false;
		}
		interactable = active;
		SetState();
		return true;
	}

	protected void SetState()
	{
		if (IsActive())
		{
			SelectionState curState = GetCurState();
			if (_state != curState)
			{
				_state = curState;
				PlayStateTransition();
				OnStateChanged?.Invoke((ActSelectableState)_state);
			}
		}
	}

	protected override void DoStateTransition(SelectionState state, bool instant)
	{
		base.DoStateTransition(state, instant);
		SelectionState curState = GetCurState();
		if (_state != curState)
		{
			_state = curState;
			OnStateChanged?.Invoke((ActSelectableState)_state);
		}
	}

	protected virtual SelectionState GetCurState()
	{
		if (!IsInteractable())
		{
			return SelectionState.Disabled;
		}
		if (_isPointerDown && _isPointerInside)
		{
			return SelectionState.Pressed;
		}
		if (_isSelected && _isPointerInside)
		{
			return SelectionState.Selected;
		}
		if (_isPointerInside)
		{
			return SelectionState.Highlighted;
		}
		return SelectionState.Normal;
	}

	protected override void InstantClearState()
	{
		_isPointerInside = false;
		_isPointerDown = false;
		_isSelected = false;
	}

	private void PlayStateTransition()
	{
		switch (transition)
		{
		case Transition.ColorTint:
			PlayStateColorTween();
			break;
		case Transition.SpriteSwap:
			PlayStateSpriteSwap();
			break;
		case Transition.Animation:
			PlayStateAnimation();
			break;
		}
	}

	private void PlayStateAnimation()
	{
		if (!string.IsNullOrEmpty(GetAnimationName(_state)))
		{
			PlayAnimation(GetAnimationName(_state));
		}
	}

	protected void PlayAnimation(string animationName)
	{
		if (!string.IsNullOrEmpty(animationName) && !(_animation == null) && !CurrentAnimationPlaying(_animation))
		{
			_animation.GetSequence(animationName)?.Play();
		}
	}

	protected virtual string GetAnimationName(SelectionState state)
	{
		return state switch
		{
			SelectionState.Locked => animationTriggers.disabledTrigger, 
			SelectionState.Disabled => animationTriggers.disabledTrigger, 
			SelectionState.Pressed => animationTriggers.pressedTrigger, 
			SelectionState.Selected => animationTriggers.selectedTrigger, 
			SelectionState.Highlighted => animationTriggers.highlightedTrigger, 
			SelectionState.Normal => animationTriggers.normalTrigger, 
			_ => throw new ArgumentOutOfRangeException(), 
		};
	}

	public bool CurrentAnimationPlaying(BetterAnimation animation)
	{
		string text = _animation.CurrentAnimationName();
		if (string.IsNullOrEmpty(text))
		{
			return false;
		}
		if (animationTriggers.disabledTrigger == text || animationTriggers.pressedTrigger == text || animationTriggers.selectedTrigger == text || animationTriggers.highlightedTrigger == text || animationTriggers.normalTrigger == text)
		{
			return false;
		}
		return animation.CurrentAnimationPlaying();
	}

	private void PlayStateColorTween()
	{
		if (!(targetGraphic == null))
		{
			Color color = _state switch
			{
				SelectionState.Locked => colors.disabledColor, 
				SelectionState.Disabled => colors.disabledColor, 
				SelectionState.Pressed => colors.pressedColor, 
				SelectionState.Selected => colors.selectedColor, 
				SelectionState.Highlighted => colors.highlightedColor, 
				SelectionState.Normal => colors.normalColor, 
				_ => throw new ArgumentOutOfRangeException(), 
			};
			targetGraphic.CrossFadeColor(color * colors.colorMultiplier, colors.fadeDuration, ignoreTimeScale: true, useAlpha: true);
		}
	}

	private void PlayStateSpriteSwap()
	{
		if (!(image == null))
		{
			Sprite overrideSprite = _state switch
			{
				SelectionState.Locked => spriteState.disabledSprite, 
				SelectionState.Disabled => spriteState.disabledSprite, 
				SelectionState.Pressed => spriteState.pressedSprite, 
				SelectionState.Selected => spriteState.selectedSprite, 
				SelectionState.Highlighted => spriteState.highlightedSprite, 
				SelectionState.Normal => null, 
				_ => throw new ArgumentOutOfRangeException(), 
			};
			image.overrideSprite = overrideSprite;
		}
	}

	protected override void Awake()
	{
		base.Awake();
		AwakeImply();
	}

	protected virtual void AwakeImply()
	{
	}

	protected override void OnDestroy()
	{
		OnDestroyImp();
		base.OnDestroy();
	}

	protected virtual void OnDestroyImp()
	{
	}

	protected override void OnDisable()
	{
		OnDisableImp();
		base.OnDisable();
	}

	protected virtual void OnDisableImp()
	{
	}

	public override void OnPointerEnter(PointerEventData eventData)
	{
		if (IsInteractable())
		{
			_isPointerInside = true;
			OnEnterImp();
			SetState();
		}
		else
		{
			OnUnInteractableEnterImp();
		}
	}

	protected virtual void OnEnterImp()
	{
	}

	protected virtual void OnUnInteractableEnterImp()
	{
	}

	public override void OnPointerExit(PointerEventData eventData)
	{
		InstantClearState();
		OnExitImp();
		SetState();
	}

	protected virtual void OnExitImp()
	{
	}

	public override void OnPointerDown(PointerEventData eventData)
	{
		if (eventData.button == PointerEventData.InputButton.Left)
		{
			if (IsInteractable())
			{
				_isPointerDown = true;
				OnDownImp();
				SetState();
			}
			else
			{
				OnUnInteractableDownImp();
			}
		}
	}

	protected virtual void OnDownImp()
	{
	}

	protected virtual void OnUnInteractableDownImp()
	{
	}

	public override void OnPointerUp(PointerEventData eventData)
	{
		if (eventData.button == PointerEventData.InputButton.Left)
		{
			_isPointerDown = false;
			OnUpImp();
			SetState();
		}
	}

	protected virtual void OnUpImp()
	{
	}

	public virtual void OnPointerClick(PointerEventData eventData)
	{
		if (eventData.button == PointerEventData.InputButton.Left)
		{
			if (IsInteractable())
			{
				OnClickImp();
			}
			else
			{
				OnUnInteractableClickImp();
			}
		}
	}

	protected virtual void OnClickImp()
	{
	}

	protected virtual void OnUnInteractableClickImp()
	{
	}

	public void OnSubmit(BaseEventData eventData)
	{
		OnSubmitImp();
	}

	protected virtual void OnSubmitImp()
	{
	}

	public override void OnSelect(BaseEventData eventData)
	{
		base.OnSelect(eventData);
		_isSelected = true;
		SetState();
	}

	public override void OnDeselect(BaseEventData eventData)
	{
		base.OnDeselect(eventData);
		_isSelected = false;
		SetState();
	}
}
