using System;
using System.Collections.Generic;
using ACT.Battle.Configs;
using ACT.Core;
using ACT.Event;
using ACT.Game.Data;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

public class MonoDestinyEffect : MonoBehaviour
{
	private const int MaxDestinyCount = 8;

	public DestinyEffectConfig[] effectConfigs;

	private Entity _entity;

	private ICharacterSource _characterSource;

	private bool _enabled;

	public void Binding(Entity entity)
	{
		try
		{
			_entity = entity;
			_characterSource = entity.GetCompCharacter().characterSource;
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.OnCharcterNtf, CharacterChange);
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.BattleCharacterChange, TeamCharacterChange);
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.Motion_MotionStateChange, OnMotionStateChange);
			RefreshEffect();
		}
		catch (Exception e)
		{
			LogBindingException(e);
		}
	}

	public void Binding(ICharacterSource characterSource)
	{
		try
		{
			_characterSource = characterSource;
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.OnCharcterNtf, CharacterChange);
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.BattleCharacterChange, TeamCharacterChange);
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.Motion_MotionStateChange, OnMotionStateChange);
			RefreshEffect();
		}
		catch (Exception e)
		{
			LogBindingException(e);
		}
	}

	private void CharacterChange(BaseEventContent content)
	{
		foreach (Character characterChange in (content as CharacterNtfEvt).characterChanges)
		{
			if (characterChange.Id == _characterSource.Id() && characterChange.ConstellationEnabledStatus.Count != 0)
			{
				RefreshEffect();
				break;
			}
		}
	}

	private void RefreshEffect()
	{
		List<int> list = ListPool<int>.Get();
		_characterSource.GetConstellationStates(list);
		if (list.Count >= 8)
		{
			if (!_enabled)
			{
				EnableEffect();
			}
		}
		else if (_enabled)
		{
			DisableEffect();
		}
	}

	private void TeamCharacterChange(BaseEventContent content)
	{
		if (content is BattleCharacterChangeEvt battleCharacterChangeEvt)
		{
			CompCharacter component2;
			if (battleCharacterChangeEvt.lastEb.TryGetCompCharacter(out CompCharacter component) && component.characterSource.Id() == _characterSource.Id())
			{
				TeamChangeRefreshEffect();
			}
			else if (battleCharacterChangeEvt.newEb.TryGetCompCharacter(out component2) && component2.characterSource.Id() == _characterSource.Id())
			{
				RefreshEffect();
			}
		}
	}

	private void OnMotionStateChange(BaseEventContent eventContent)
	{
		if (!(eventContent is MotionStateChangeEvt motionStateChangeEvt) || !motionStateChangeEvt.entity.IsValid || !motionStateChangeEvt.entity.IsCharacter())
		{
			return;
		}
		if (motionStateChangeEvt.beforeState == MotionState.BackTrace)
		{
			List<int> list = ListPool<int>.Get();
			_characterSource.GetConstellationStates(list);
			if (list.Count >= 8 && !_enabled)
			{
				EnableEffect();
			}
		}
		if (motionStateChangeEvt.curState == MotionState.BackTrace)
		{
			DisableEffect();
		}
	}

	private void TeamChangeRefreshEffect()
	{
		List<int> list = ListPool<int>.Get();
		_characterSource.GetConstellationStates(list);
		bool flag = !_entity.IsValid || _entity.IsAlive();
		if ((list.Count >= 8) & flag)
		{
			if (!_enabled)
			{
				EnableEffect();
			}
		}
		else if (_enabled)
		{
			DisableEffect();
		}
	}

	public void SetVisible(bool visible)
	{
		if (!visible)
		{
			DisableEffect();
		}
		else if (_characterSource != null)
		{
			RefreshEffect();
		}
	}

	private void EnableEffect()
	{
		_enabled = true;
		if (effectConfigs == null)
		{
			return;
		}
		DestinyEffectConfig[] array = effectConfigs;
		foreach (DestinyEffectConfig destinyEffectConfig in array)
		{
			try
			{
				destinyEffectConfig?.EnableEffect();
			}
			catch (Exception exception)
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.LogException(exception);
				}
			}
		}
	}

	private void DisableEffect()
	{
		_enabled = false;
		if (effectConfigs == null)
		{
			return;
		}
		DestinyEffectConfig[] array = effectConfigs;
		foreach (DestinyEffectConfig destinyEffectConfig in array)
		{
			try
			{
				destinyEffectConfig?.DisableEffect();
			}
			catch (Exception exception)
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.LogException(exception);
				}
			}
		}
	}

	private void OnDestroy()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.OnCharcterNtf, CharacterChange);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.BattleCharacterChange, TeamCharacterChange);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Motion_MotionStateChange, OnMotionStateChange);
		if (effectConfigs == null)
		{
			return;
		}
		DestinyEffectConfig[] array = effectConfigs;
		foreach (DestinyEffectConfig destinyEffectConfig in array)
		{
			try
			{
				destinyEffectConfig?.Dispose();
			}
			catch (Exception exception)
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.LogException(exception);
				}
			}
		}
	}

	private static void LogBindingException(Exception e)
	{
		if (LuminApplication.LogEnabled)
		{
			Debug.LogError("满命特效绑定失败，已跳过以免打断角色生成");
			Debug.LogException(e);
		}
	}
}
