using System;
using System.Collections.Generic;
using ACT.Event;
using ACT.Net;
using ACT.Sound.Core;
using Fundamental;
using UnityEngine;

namespace ACT.Sound.State;

public class AudioStateManager
{
	private static readonly Dictionary<Type, string> EnumToParameterMap = new Dictionary<Type, string>
	{
		{
			typeof(AudioState),
			"Game_State"
		},
		{
			typeof(BattleState),
			"Battle_State"
		},
		{
			typeof(Sex),
			"Male_Female"
		}
	};

	private readonly HashSet<AudioState> _activeStates = new HashSet<AudioState>();

	private AudioState _currentAudioState;

	public AudioStateManager()
	{
		RegisterEventListeners();
	}

	private void RegisterEventListeners()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.OnAVGPlayStateChange, OnAVGPlayStateChange);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.OnUIStateChange, OnUIStateChange);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.OnAsideStateChange, OnAsideStateChange);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.OnCGStateChange, OnCGSStateChange);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.OnGachaChange, OnGaChaChange);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.OnAVGStateChange, OnAVGStateChange);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.OnBattleStateChange, OnBattleStateChange);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.OnSexChange, OnSexChange);
	}

	private void OnSexChange(BaseEventContent content)
	{
		SexChange sexChange = (SexChange)content;
		SetParameter(sexChange.Sex);
	}

	private void OnAVGStateChange(BaseEventContent content)
	{
		AVGStateChange aVGStateChange = (AVGStateChange)content;
		AudioCore.SetGlobalParameter("AVG_Music_Change", aVGStateChange.AVGState);
	}

	private void OnAVGPlayStateChange(BaseEventContent content)
	{
		GameStateChange gameStateChange = (GameStateChange)content;
		HandleStateChange(AudioState.AVG, gameStateChange.IsInState);
	}

	private void OnUIStateChange(BaseEventContent content)
	{
		GameStateChange gameStateChange = (GameStateChange)content;
		HandleStateChange(AudioState.UI, gameStateChange.IsInState);
	}

	private void OnAsideStateChange(BaseEventContent content)
	{
		GameStateChange gameStateChange = (GameStateChange)content;
		HandleStateChange(AudioState.ASIDE, gameStateChange.IsInState);
	}

	private void OnCGSStateChange(BaseEventContent content)
	{
		GameStateChange gameStateChange = (GameStateChange)content;
		HandleStateChange(AudioState.CG, gameStateChange.IsInState);
	}

	private void OnGaChaChange(BaseEventContent content)
	{
		GameStateChange gameStateChange = (GameStateChange)content;
		HandleStateChange(AudioState.GACHA, gameStateChange.IsInState);
	}

	private void OnBattleStateChange(BaseEventContent content)
	{
		if (((GameStateChange)content).IsInState)
		{
			SetParameter(BattleState.Normal);
		}
		else
		{
			SetParameter(BattleState.None);
		}
	}

	private void HandleStateChange(AudioState targetState, bool isEntering)
	{
		if (isEntering)
		{
			_activeStates.Add(targetState);
			AudioState highestPriorityState = GetHighestPriorityState();
			if (highestPriorityState == targetState && _currentAudioState != targetState)
			{
				_currentAudioState = targetState;
				SetParameter(targetState);
				if (LuminApplication.LogEnabled)
				{
					Debug.Log($"[AudioStateManager] 进入音频状态: {targetState} (枚举值: {(int)targetState})");
				}
			}
			else if (LuminApplication.LogEnabled)
			{
				Debug.Log($"[AudioStateManager] 状态 {targetState} 已添加，但被更高优先级状态 {highestPriorityState} 覆盖");
			}
			return;
		}
		_activeStates.Remove(targetState);
		if (_currentAudioState == targetState)
		{
			AudioState audioState = (_currentAudioState = GetHighestPriorityState());
			SetParameter(audioState);
			if (LuminApplication.LogEnabled)
			{
				if (audioState == AudioState.None)
				{
					Debug.Log($"[AudioStateManager] 退出音频状态: {targetState}，重置为 None");
				}
				else
				{
					Debug.Log($"[AudioStateManager] 退出音频状态: {targetState}，切换到次高优先级状态: {audioState} (枚举值: {(int)audioState})");
				}
			}
		}
		else if (LuminApplication.LogEnabled)
		{
			Debug.Log($"[AudioStateManager] 状态 {targetState} 已移除，当前状态保持为 {_currentAudioState}");
		}
	}

	private AudioState GetHighestPriorityState()
	{
		if (_activeStates.Count == 0)
		{
			return AudioState.None;
		}
		AudioState result = AudioState.None;
		int num = int.MaxValue;
		foreach (AudioState activeState in _activeStates)
		{
			int num2 = (int)activeState;
			if (num2 != 0 && num2 < num)
			{
				num = num2;
				result = activeState;
			}
		}
		return result;
	}

	public void SetParameter<TEnum>(TEnum enumValue) where TEnum : Enum
	{
		Type typeFromHandle = typeof(TEnum);
		if (EnumToParameterMap.TryGetValue(typeFromHandle, out var value))
		{
			int num = Convert.ToInt32(enumValue);
			AudioCore.SetGlobalParameter(value, num);
			if (LuminApplication.LogEnabled)
			{
				Debug.Log($"[AudioStateManager] 设置音频参数: {value} = {num} ({enumValue})");
			}
		}
		else if (LuminApplication.LogEnabled)
		{
			Debug.LogWarning("[AudioStateManager] 未找到枚举类型 " + typeFromHandle.Name + " 对应的参数映射");
		}
	}

	public void SetParameter(string param, int value)
	{
		AudioCore.SetGlobalParameter(param, value);
		if (LuminApplication.LogEnabled)
		{
			Debug.Log($"[AudioStateManager] 设置音频参数: {param} = {value}");
		}
	}

	public string GetParameterName<TEnum>() where TEnum : Enum
	{
		Type typeFromHandle = typeof(TEnum);
		if (!EnumToParameterMap.TryGetValue(typeFromHandle, out var value))
		{
			return null;
		}
		return value;
	}

	public void RegisterParameterMapping<TEnum>(string parameterName) where TEnum : Enum
	{
		Type typeFromHandle = typeof(TEnum);
		if (EnumToParameterMap.ContainsKey(typeFromHandle) && LuminApplication.LogEnabled)
		{
			Debug.LogWarning("[AudioStateManager] 枚举类型 " + typeFromHandle.Name + " 已存在映射，将被覆盖");
		}
		EnumToParameterMap[typeFromHandle] = parameterName;
		if (LuminApplication.LogEnabled)
		{
			Debug.Log("[AudioStateManager] 注册参数映射: " + typeFromHandle.Name + " -> " + parameterName);
		}
	}
}
