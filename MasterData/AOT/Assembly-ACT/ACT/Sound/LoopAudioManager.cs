using System;
using System.Collections.Generic;
using ACT.Battle;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.Sound;

public class LoopAudioManager : Singleton<LoopAudioManager>
{
	private readonly Dictionary<Entity, Dictionary<string, uint>> _loopSoundInstances = new Dictionary<Entity, Dictionary<string, uint>>();

	public override ContextType ContextType => ContextType.GAME;

	public override void Init()
	{
		_loopSoundInstances.Clear();
	}

	public override void UnInit()
	{
		StopAll();
		_loopSoundInstances.Clear();
	}

	public uint PlayLoop(Entity behave, string eventPath, AudioPlayOptions options = default(AudioPlayOptions))
	{
		if (behave == null || string.IsNullOrEmpty(eventPath))
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogWarning("[LoopAudioManager] PlayLoop failed: behave or eventPath is null");
			}
			return 0u;
		}
		if (IsPlaying(behave, eventPath))
		{
			Stop(behave, eventPath);
		}
		options.IsLoop = true;
		uint num = Singleton<GameManager>.instance.audioManager.PlaySound(eventPath, options);
		if (num != 0)
		{
			if (!_loopSoundInstances.ContainsKey(behave))
			{
				_loopSoundInstances[behave] = new Dictionary<string, uint>();
			}
			_loopSoundInstances[behave][eventPath] = num;
			if (behave.TryGetCompAbility(out CompAbility component))
			{
				component.onDie -= (Action<Entity>)((Entity eb) =>
				{
					OnEntityDie(eb, eventPath);
				});
				component.onDie += (Action<Entity>)((Entity eb) =>
				{
					OnEntityDie(eb, eventPath);
				});
			}
		}
		return num;
	}

	public uint PlayLoop(Entity behave, string eventPath, Transform attachTarget = null)
	{
		return PlayLoop(behave, eventPath, new AudioPlayOptions
		{
			attachTarget = (attachTarget ?? behave.GetRootTransform()),
			IsLoop = true
		});
	}

	public void Stop(Entity behave, string eventPath, bool fade = true)
	{
		if (!(behave == null) && !string.IsNullOrEmpty(eventPath) && _loopSoundInstances.TryGetValue(behave, out var value) && value.TryGetValue(eventPath, out var value2))
		{
			Singleton<GameManager>.instance.audioManager.Stop(value2, fade);
			value.Remove(eventPath);
			if (value.Count == 0)
			{
				_loopSoundInstances.Remove(behave);
			}
		}
	}

	public void StopAll(Entity behave, bool fade = true)
	{
		if (behave == null || !_loopSoundInstances.TryGetValue(behave, out var value))
		{
			return;
		}
		foreach (uint value2 in value.Values)
		{
			Singleton<GameManager>.instance.audioManager.Stop(value2, fade);
		}
		_loopSoundInstances.Remove(behave);
	}

	public void StopAll(bool fade = true)
	{
		foreach (Dictionary<string, uint> value in _loopSoundInstances.Values)
		{
			foreach (uint value2 in value.Values)
			{
				Singleton<GameManager>.instance.audioManager.Stop(value2, fade);
			}
		}
		_loopSoundInstances.Clear();
	}

	public bool IsPlaying(Entity behave, string eventPath)
	{
		if (behave == null || string.IsNullOrEmpty(eventPath))
		{
			return false;
		}
		if (_loopSoundInstances.TryGetValue(behave, out var value))
		{
			return value.ContainsKey(eventPath);
		}
		return false;
	}

	public uint GetInstanceId(Entity behave, string eventPath)
	{
		if (behave == null || string.IsNullOrEmpty(eventPath))
		{
			return 0u;
		}
		if (_loopSoundInstances.TryGetValue(behave, out var value) && value.TryGetValue(eventPath, out var value2))
		{
			return value2;
		}
		return 0u;
	}

	public void SetSoundState(Entity behave, string eventPath, string parameterName, float value)
	{
		uint instanceId = GetInstanceId(behave, eventPath);
		if (instanceId != 0)
		{
			Singleton<GameManager>.instance.audioManager.SetParameter(instanceId, parameterName, value);
		}
	}

	private void OnEntityDie(Entity behave, string eventPath)
	{
		Stop(behave, eventPath);
	}

	public void Update()
	{
		List<Entity> list = null;
		foreach (KeyValuePair<Entity, Dictionary<string, uint>> loopSoundInstance in _loopSoundInstances)
		{
			Entity key = loopSoundInstance.Key;
			if (key.IsValid && key.IsLogicAvailable())
			{
				CompAbility compAbility = key.GetCompAbility();
				if (compAbility != null && compAbility.alive)
				{
					continue;
				}
			}
			if (list == null)
			{
				list = new List<Entity>();
			}
			list.Add(key);
		}
		if (list == null)
		{
			return;
		}
		foreach (Entity item in list)
		{
			StopAll(item);
		}
	}
}
