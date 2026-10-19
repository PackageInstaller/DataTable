using Bamboo.ECS;

namespace ACT.Battle.Configs;

public class ConfigCustomStateChange : LuminSerializedScriptableObject
{
	public class CustomStateChangeAction
	{
		public MotionState m_From;

		public MotionState m_To;

		public StateChangeActionType m_ActionType = StateChangeActionType.CurrentBehave;

		public ConfigAction[] m_Actions;
	}

	public CustomStateChangeAction[] m_CustomStateChangeActions;

	public const string AnyStateLabel = "AnyState";

	public void TriggerCustomStateChangeAction(MotionState fromState, MotionState toState, Entity entity, StateChangeActionType actionType)
	{
		if (m_CustomStateChangeActions == null)
		{
			return;
		}
		for (int i = 0; i < m_CustomStateChangeActions.Length; i++)
		{
			CustomStateChangeAction customStateChangeAction = m_CustomStateChangeActions[i];
			if ((actionType & customStateChangeAction.m_ActionType) > StateChangeActionType.None)
			{
				if (customStateChangeAction.m_From == fromState && customStateChangeAction.m_To == toState)
				{
					SystemAbility.DoActionsToSelf(entity, customStateChangeAction.m_Actions);
					break;
				}
				if (customStateChangeAction.m_From == MotionState.None && customStateChangeAction.m_To == toState)
				{
					SystemAbility.DoActionsToSelf(entity, customStateChangeAction.m_Actions);
					break;
				}
				if (customStateChangeAction.m_To == MotionState.None && customStateChangeAction.m_From == fromState)
				{
					SystemAbility.DoActionsToSelf(entity, customStateChangeAction.m_Actions);
					break;
				}
			}
		}
	}
}
