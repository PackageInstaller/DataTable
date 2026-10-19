using System;
using ACT.Battle;
using ACT.UI.InputController;
using ACT.ViewControl;
using Bamboo.Chronos;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT;

public static class ContinuousNavigateUtility
{
	public static MoveDirection DetermineMoveDirection(float x, float y, float deadZone)
	{
		if (new Vector2(x, y).sqrMagnitude < deadZone * deadZone)
		{
			return MoveDirection.None;
		}
		if (Mathf.Abs(x) > Mathf.Abs(y))
		{
			if (!(x > 0f))
			{
				return MoveDirection.Left;
			}
			return MoveDirection.Right;
		}
		if (!(y > 0f))
		{
			return MoveDirection.Down;
		}
		return MoveDirection.Up;
	}

	public static void StartContinuousNavigate(Vector2 input, ref ContinuousNavigateData stateData, Action<MoveDirection> onTriggerNav, float currentTime = -1f)
	{
		if (stateData == null)
		{
			stateData = new ContinuousNavigateData();
		}
		if (currentTime < 0f)
		{
			currentTime = Time.unscaledTime;
		}
		stateData.currentInput = input;
		float deadZone = ((stateData.lastDirection == MoveDirection.None) ? GameLoader.meta.deadZoneOnEnter : GameLoader.meta.deadZoneOnRepeat);
		MoveDirection moveDirection = DetermineMoveDirection(input.x, input.y, deadZone);
		if (moveDirection == MoveDirection.None)
		{
			stateData.Reset();
		}
		else
		{
			if (moveDirection == stateData.lastDirection)
			{
				return;
			}
			stateData.lastDirection = moveDirection;
			stateData.holdStartTime = currentTime;
			stateData.lastTriggerTime = currentTime;
			stateData.enteredRepeat = false;
			stateData.BeginContinuousNavigate(onTriggerNav, ResolveInputMode(), ResolveFocusLayer());
			ContinuousNavigateData data = stateData;
			if (!stateData.repeatLooper.IsValid())
			{
				stateData.repeatLooper = UpdateTimer.Default.LoopFrame(1, () =>
				{
					if (!data.IsContextValid())
					{
						data.Reset();
					}
					else
					{
						float unscaledTime = Time.unscaledTime;
						float deadZone2 = ((data.lastDirection == MoveDirection.None) ? GameLoader.meta.deadZoneOnEnter : GameLoader.meta.deadZoneOnRepeat);
						MoveDirection moveDirection2 = DetermineMoveDirection(data.currentInput.x, data.currentInput.y, deadZone2);
						if (moveDirection2 == MoveDirection.None)
						{
							data.Reset();
						}
						else if (moveDirection2 == data.lastDirection)
						{
							if (!data.enteredRepeat)
							{
								if (unscaledTime - data.holdStartTime >= GameLoader.meta.enterRepeatDelay)
								{
									data.enteredRepeat = true;
									data.lastTriggerTime = unscaledTime;
								}
							}
							else if (unscaledTime - data.lastTriggerTime >= GameLoader.meta.repeatInterval)
							{
								data.lastTriggerTime = unscaledTime;
								data.InvokeTrigger(moveDirection2);
							}
						}
					}
				});
			}
			stateData.InvokeTrigger(moveDirection);
		}
	}

	private static DeviceInputMode ResolveInputMode()
	{
		MonoECS instance = MonoECS.instance;
		if (!(instance != null))
		{
			return DeviceInputMode.Unknown;
		}
		return instance.InputMode;
	}

	private static ViewControlLayer ResolveFocusLayer()
	{
		GameObject gameObject = (EventSystemHelper.Available ? EventSystemHelper.CurrentSelected : null);
		if (gameObject == null)
		{
			return null;
		}
		SelectableEx componentInParent = gameObject.GetComponentInParent<SelectableEx>(includeInactive: true);
		if (!(componentInParent != null))
		{
			return null;
		}
		return componentInParent.Layer;
	}
}
