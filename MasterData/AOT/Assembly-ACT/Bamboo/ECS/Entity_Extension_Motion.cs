using ACT;
using ACT.Battle;
using ACT.Battle.Configs;
using ACT.Utility;
using UnityEngine;

namespace Bamboo.ECS;

public static class Entity_Extension_Motion
{
	private const int NOT_CONTROLLER_MOVE = -1073741825;

	public static void OnFalling(this Entity entity)
	{
	}

	public static void OnWalking(this Entity entity)
	{
		entity.GetCompMotion().RecoverMotionCount();
	}

	public static void ClimbCompensate(this Entity entity)
	{
		entity.SetTrigger("ClimbCompensate");
	}

	public static void SetTrigger(this Entity entity, string value)
	{
		if (entity.TryGetCompMotion(out CompMotion component))
		{
			component.SetTrigger(value);
		}
	}

	public static void ResetTrigger(this Entity entity, string v)
	{
		if (entity.TryGetCompMotion(out CompMotion component))
		{
			component?.ResetTrigger(v);
		}
	}

	public static void SetBool(this Entity entity, string key, bool value)
	{
		if (entity.TryGetCompMotion(out CompMotion component))
		{
			component.SetBool(key, value);
		}
	}

	public static void SetInt(this Entity entity, string key, int value)
	{
		if (entity.TryGetCompMotion(out CompMotion component))
		{
			component.SetInt(key, value);
		}
	}

	public static void SetFloat(this Entity entity, string key, float value)
	{
		if (entity.TryGetCompMotion(out CompMotion component))
		{
			component.SetFloat(key, value);
		}
	}

	public static bool GetMotionBool(this Entity entity, string v)
	{
		if (entity.TryGetCompMotion(out CompMotion component) && component.parameters.TryGetValue(v, out var value))
		{
			return value.defaultBool;
		}
		if (LuminApplication.LogEnabled)
		{
			Debug.LogError("parameter'" + v + "' not exist!!!!!!!!!!!!");
		}
		return false;
	}

	public static float GetMotionFloat(this Entity entity, string v)
	{
		if (entity.TryGetCompMotion(out CompMotion component) && component.parameters.TryGetValue(v, out var value))
		{
			return value.defaultFloat;
		}
		if (LuminApplication.LogEnabled)
		{
			Debug.LogError("parameter'" + v + "' not exist!!!!!!!!!!!!");
		}
		return 0f;
	}

	public static float GetMotionInt(this Entity entity, string v)
	{
		if (entity.TryGetCompMotion(out CompMotion component) && component.parameters.TryGetValue(v, out var value))
		{
			return value.defaultInt;
		}
		if (LuminApplication.LogEnabled)
		{
			Debug.LogError("parameter'" + v + "' not exist!!!!!!!!!!!!");
		}
		return 0f;
	}

	public static State GetState(this Entity entity, int index)
	{
		int num = (index & -1073741824) >> 30;
		int num2 = index & 0x3FFFFFFF;
		State result = null;
		if (entity.IsValid && entity.TryGetCompMotion(out CompMotion component))
		{
			ConfigCharacter config = entity.GetConfig();
			result = ((num != 0) ? component.attackController.statesDic[config.attackFSM.states[num2].name] : component.moveController.statesDic[config.moveFSM.states[num2].name]);
		}
		return result;
	}

	public static ConfigMotion GetConfigMotion(this Entity entity, FSMRuntimeState rState)
	{
		ConfigMotion configMotion = entity.GetConfigMotion(rState.state);
		if (configMotion != null)
		{
			rState.actualMotion = configMotion;
			rState.runtimeClip = CharacterSkinRuntimeUtility.ResolveBattleClip(entity, rState.state, configMotion);
			return configMotion;
		}
		return null;
	}

	public static ConfigMotion GetConfigMotion(this Entity entity, State state)
	{
		ConfigCharacter config = entity.GetConfig();
		int num = 1073741824;
		if ((state.index & num) == 0)
		{
			return config.moveMotions[state.index].motion;
		}
		return config.attackMotions[state.index & -1073741825].motion;
	}
}
