using System;
using System.Collections.Generic;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

public class GamePlayerInput
{
	private static readonly Dictionary<string, int> _actionToInputBitType = new Dictionary<string, int>
	{
		{ "Player/Move", 0 },
		{ "Player/Dodge", 2 },
		{ "Player/RegularAttack", 3 },
		{ "Player/SkillAttack", 4 },
		{ "Player/Jump", 5 },
		{ "Player/Vibrate", 6 },
		{ "Player/ShortCut", 8 },
		{ "Player/Switch1Character", 9 },
		{ "Player/Switch2Character", 10 },
		{ "Player/Switch3Character", 11 },
		{ "UI/Interact", 12 },
		{ "UI/SwitchInteract", 13 }
	};

	private static PlayerEntityStateUpload _stateUpload;

	private static GamePlayerInput _currentPlayerInput;

	private Entity _lastEntity;

	private float[] _pressedTickTimes;

	private bool[] _pressedMarks;

	private int[] _pressStates;

	private float[] _inputs;

	private bool _IsInitialized;

	private const float Action_Press_Threshold = 0.2f;

	private const float ButtonPressed = 1f;

	private const float ButtonReleased = 0f;

	public static GamePlayerInput GetCurrent()
	{
		return _currentPlayerInput ?? (_currentPlayerInput = new GamePlayerInput());
	}

	private GamePlayerInput()
	{
		if (_stateUpload == null)
		{
			_stateUpload = new PlayerEntityStateUpload();
		}
		Singleton<GameInputActionManager>.instance.onInputStateChanged += OnInputStateChanged;
		ResetAllMarks(0);
	}

	private void OnInputStateChanged(GameInputState state)
	{
		if (!Singleton<GameInputActionManager>.instance.CheckInputStateActive(GameInputState.Battle))
		{
			ResetAll(_lastEntity);
		}
	}

	private bool CheckActionDisabled(string actionPath)
	{
		return Singleton<GameInputActionManager>.instance.GetActionDisabled(actionPath);
	}

	public void ResetInputAction(string actionPath)
	{
		if (_IsInitialized && _actionToInputBitType.TryGetValue(actionPath, out var value))
		{
			if (actionPath == "Player/Move")
			{
				_inputs[0] = 0f;
				_inputs[1] = 0f;
			}
			else
			{
				_inputs[value] = 0f;
			}
		}
	}

	private bool CantUpdate(Entity entity)
	{
		if (_IsInitialized && entity.IsValid && entity.IsLogicAvailable())
		{
			return !entity.HasCompTime();
		}
		return true;
	}

	public void FixedUpdate(Entity entity)
	{
		if (!CantUpdate(entity))
		{
			float fixedTimeDelta = entity.GetCompTime().fixedDeltaTime;
			RefreshEntityState(in _inputs, in _pressStates, in _pressedMarks, entity);
			_lastEntity = entity;
			TickPressStates(ref _pressStates, ref _pressedTickTimes, in _pressedMarks, in fixedTimeDelta);
		}
	}

	private void RefreshEntityState(in float[] inputs, in int[] states, in bool[] marks, Entity entity)
	{
		if (entity.IsValid && _IsInitialized && entity.IsLogicAvailable())
		{
			_stateUpload?.UploadState(inputs, states, marks, entity, entity.GetCompTime().fixedDeltaTime);
		}
	}

	private void ResetAllMarks(int clearFlag)
	{
		if (_pressedTickTimes == null)
		{
			_pressedTickTimes = new float[14];
		}
		if (_pressStates == null)
		{
			_pressStates = new int[14];
		}
		if (_inputs == null)
		{
			_inputs = new float[14];
		}
		if (_pressedMarks == null)
		{
			_pressedMarks = new bool[14];
		}
		Array.Fill(_pressedTickTimes, 0f);
		Array.Fill(_pressStates, clearFlag);
		Array.Fill(_inputs, 0f);
		Array.Fill(_pressedMarks, value: false);
	}

	public void ResetAll(Entity entity)
	{
		ResetAllMarks(1);
		_IsInitialized = true;
		FixedUpdate(entity);
		ResetAllMarks(0);
	}

	public void ClearEntityState(Entity entity)
	{
		int[] states = new int[14];
		float[] inputs = new float[14];
		bool[] marks = new bool[14];
		Array.Fill(states, 0);
		Array.Fill(inputs, 0f);
		Array.Fill(marks, value: false);
		RefreshEntityState(in inputs, in states, in marks, entity);
		if (LuminApplication.LogEnabled)
		{
			Debug.Log($"---------ClearEntityState--entity uid:{entity}");
		}
	}

	private void TickPressStates(ref int[] states, ref float[] pressedTicks, in bool[] pressedMarks, in float fixedTimeDelta)
	{
		int num = 14;
		for (int i = 0; i < num; i++)
		{
			if (!pressedMarks[i])
			{
				pressedTicks[i] = 0f;
			}
			else
			{
				pressedTicks[i] += fixedTimeDelta;
			}
		}
		for (int j = 0; j < num; j++)
		{
			UpdateSinglePressState(ref states[j], in pressedMarks[j], in pressedTicks[j]);
		}
	}

	private void FireSinglePressState(ref int state, in bool isPressed, in float pressedTick, Action<int, Entity> uploadCallback)
	{
		UpdateSinglePressState(ref state, in isPressed, in pressedTick);
		if (uploadCallback != null && !CantUpdate(_lastEntity))
		{
			uploadCallback(state, _lastEntity);
			UpdateSinglePressState(ref state, in isPressed, in pressedTick);
		}
	}

	private void FireSinglePressState<T>(ref int state, in bool isPressed, in float pressedTick, T value, Action<T, bool, Entity, float> uploadCallback) where T : struct
	{
		UpdateSinglePressState(ref state, in isPressed, in pressedTick);
		if (uploadCallback != null && !CantUpdate(_lastEntity))
		{
			uploadCallback(value, isPressed, _lastEntity, pressedTick);
			UpdateSinglePressState(ref state, in isPressed, in pressedTick);
		}
	}

	private void UpdateSinglePressState(ref int state, in bool isPressed, in float pressedTick)
	{
		if (isPressed)
		{
			if (state < 3)
			{
				state = 3;
			}
			else if (pressedTick >= 0.2f)
			{
				state = ((state == 4) ? 5 : 6);
			}
			else
			{
				state = 4;
			}
		}
		else if (state == 3 || state == 4)
		{
			state = 2;
		}
		else if (state == 6 || state == 5)
		{
			state = 1;
		}
		else
		{
			state = 0;
		}
	}

	public void OnStateObjectMove(Vector2 dir)
	{
		OnPlayerMove(dir);
	}

	public void OnPlayerMove(Vector2 dir)
	{
		if (!CheckActionDisabled("Player/Move"))
		{
			_inputs[0] = dir.x;
			_inputs[1] = dir.y;
			bool isPressed = !dir.Equals(Vector2.zero);
			_pressedMarks[0] = isPressed;
			FireSinglePressState(ref _pressStates[0], in isPressed, in _pressedTickTimes[0], dir, _stateUpload.UploadMove);
		}
	}

	public void OnPlayerDodge(bool pressed)
	{
		if (!CheckActionDisabled("Player/Dodge"))
		{
			_inputs[2] = (pressed ? 1f : 0f);
			_pressedMarks[2] = pressed;
			FireSinglePressState(ref _pressStates[2], in pressed, in _pressedTickTimes[2], _stateUpload.UploadDodge);
		}
	}

	public void OnPlayerRegularAttack(bool pressed)
	{
		if (!CheckActionDisabled("Player/RegularAttack"))
		{
			_inputs[3] = (pressed ? 1f : 0f);
			_pressedMarks[3] = pressed;
			FireSinglePressState(ref _pressStates[3], in pressed, in _pressedTickTimes[3], _stateUpload.UploadRegularAttack);
		}
	}

	public void OnPlayerSkillAttack(bool pressed)
	{
		if (!CheckActionDisabled("Player/SkillAttack"))
		{
			_inputs[4] = (pressed ? 1f : 0f);
			_pressedMarks[4] = pressed;
			FireSinglePressState(ref _pressStates[4], in pressed, in _pressedTickTimes[4], _stateUpload.UploadSkillAttack);
		}
	}

	public void OnPlayerJump(bool pressed)
	{
		if (!CheckActionDisabled("Player/Jump"))
		{
			_inputs[5] = (pressed ? 1f : 0f);
			_pressedMarks[5] = pressed;
			FireSinglePressState(ref _pressStates[5], in pressed, in _pressedTickTimes[5], _stateUpload.UploadJump);
		}
	}

	public void OnPlayerVibrate(bool pressed)
	{
		if (!CheckActionDisabled("Player/Vibrate"))
		{
			_inputs[6] = (pressed ? 1f : 0f);
			_pressedMarks[6] = pressed;
			FireSinglePressState(ref _pressStates[6], in pressed, in _pressedTickTimes[6], _stateUpload.UploadVibrate);
		}
	}

	public void OnPlayerItemShortcut(bool pressed)
	{
		if (!CheckActionDisabled("Player/ShortCut"))
		{
			_inputs[8] = (pressed ? 1f : 0f);
			_pressedMarks[8] = pressed;
			FireSinglePressState(ref _pressStates[8], in pressed, in _pressedTickTimes[8], _stateUpload.UploadItemShortcut);
		}
	}

	public void OnPlayerClaw(bool pressed)
	{
		if (!CheckActionDisabled("Player/Claw"))
		{
			_inputs[7] = (pressed ? 1f : 0f);
			_pressedMarks[7] = pressed;
			FireSinglePressState(ref _pressStates[7], in pressed, in _pressedTickTimes[7], _stateUpload.UploadClaw);
		}
	}

	public void OnPlayerSwitchCharacter1(bool pressed)
	{
		if (!CheckActionDisabled("Player/Switch1Character"))
		{
			_inputs[9] = (pressed ? 1f : 0f);
			_pressedMarks[9] = pressed;
			FireSinglePressState(ref _pressStates[9], in pressed, in _pressedTickTimes[9], _stateUpload.UploadChangeCharacter_1);
		}
	}

	public void OnPlayerSwitchCharacter2(bool pressed)
	{
		if (!CheckActionDisabled("Player/Switch2Character"))
		{
			_inputs[10] = (pressed ? 1f : 0f);
			_pressedMarks[10] = pressed;
			FireSinglePressState(ref _pressStates[10], in pressed, in _pressedTickTimes[10], _stateUpload.UploadChangeCharacter_2);
		}
	}

	public void OnPlayerSwitchCharacter3(bool pressed)
	{
		if (!CheckActionDisabled("Player/Switch3Character"))
		{
			_inputs[11] = (pressed ? 1f : 0f);
			_pressedMarks[11] = pressed;
			FireSinglePressState(ref _pressStates[11], in pressed, in _pressedTickTimes[11], _stateUpload.UploadChangeCharacter_3);
		}
	}

	public void OnPlayerInteract(bool pressed)
	{
		if (!CheckActionDisabled("UI/Interact"))
		{
			_inputs[12] = (pressed ? 1f : 0f);
			_pressedMarks[12] = pressed;
			FireSinglePressState(ref _pressStates[12], in pressed, in _pressedTickTimes[12], _stateUpload.UploadInteract);
		}
	}

	public void OnPlayerInteractSwitch(bool pressed)
	{
		if (!CheckActionDisabled("UI/SwitchInteract"))
		{
			_inputs[13] = (pressed ? 1f : 0f);
			_pressedMarks[13] = pressed;
			FireSinglePressState(ref _pressStates[13], in pressed, in _pressedTickTimes[13], _stateUpload.UploadInteractSwitch);
		}
	}
}
