using System;

namespace UnityEngine.InputSystem.LowLevel;

internal static class InputUpdate
{
	[Serializable]
	public struct UpdateStepCount
	{
		private bool m_WasUpdated;

		public uint value { get; private set; }

		public void OnBeforeUpdate()
		{
			m_WasUpdated = true;
			value++;
		}

		public void OnUpdate()
		{
			if (!m_WasUpdated)
			{
				value++;
			}
			m_WasUpdated = false;
		}
	}

	[Serializable]
	public struct SerializedState
	{
		public InputUpdateType lastUpdateType;

		public UpdateStepCount playerUpdateStepCount;
	}

	public static uint s_UpdateStepCount;

	public static InputUpdateType s_LatestUpdateType;

	public static UpdateStepCount s_PlayerUpdateStepCount;

	internal static void OnBeforeUpdate(InputUpdateType type)
	{
		s_LatestUpdateType = type;
		if ((uint)(type - 1) <= 1u || type == InputUpdateType.Manual)
		{
			s_PlayerUpdateStepCount.OnBeforeUpdate();
			s_UpdateStepCount = s_PlayerUpdateStepCount.value;
		}
	}

	internal static void OnUpdate(InputUpdateType type)
	{
		s_LatestUpdateType = type;
		if ((uint)(type - 1) <= 1u || type == InputUpdateType.Manual)
		{
			s_PlayerUpdateStepCount.OnUpdate();
			s_UpdateStepCount = s_PlayerUpdateStepCount.value;
		}
	}

	public static SerializedState Save()
	{
		return new SerializedState
		{
			lastUpdateType = s_LatestUpdateType,
			playerUpdateStepCount = s_PlayerUpdateStepCount
		};
	}

	public static void Restore(SerializedState state)
	{
		s_LatestUpdateType = state.lastUpdateType;
		s_PlayerUpdateStepCount = state.playerUpdateStepCount;
		InputUpdateType inputUpdateType = s_LatestUpdateType;
		if ((uint)(inputUpdateType - 1) <= 1u || inputUpdateType == InputUpdateType.Manual)
		{
			s_UpdateStepCount = s_PlayerUpdateStepCount.value;
		}
		else
		{
			s_UpdateStepCount = 0u;
		}
	}

	public static InputUpdateType GetUpdateTypeForPlayer(this InputUpdateType mask)
	{
		if ((mask & InputUpdateType.Manual) != InputUpdateType.None)
		{
			return InputUpdateType.Manual;
		}
		if ((mask & InputUpdateType.Dynamic) != InputUpdateType.None)
		{
			return InputUpdateType.Dynamic;
		}
		if ((mask & InputUpdateType.Fixed) != InputUpdateType.None)
		{
			return InputUpdateType.Fixed;
		}
		return InputUpdateType.None;
	}

	public static bool IsPlayerUpdate(this InputUpdateType updateType)
	{
		if (updateType == InputUpdateType.Editor)
		{
			return false;
		}
		return updateType != InputUpdateType.None;
	}
}
