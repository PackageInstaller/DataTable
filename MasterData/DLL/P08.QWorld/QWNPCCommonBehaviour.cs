using System;

public class QWNPCCommonBehaviour : QWAgentBehaviour
{
	private QWNPCBlackboard npcBoard;

	public override void Initialize()
	{
		base.Initialize();
		npcBoard = base.mAgent.Blackboard as QWNPCBlackboard;
		QWBlackboard blackboard = base.mAgent.Blackboard;
		blackboard.ActionHandler = (QWBlackboard.AgentActionHandler)Delegate.Combine(blackboard.ActionHandler, new QWBlackboard.AgentActionHandler(OnCommonAction));
	}

	private void OnCommonAction(QWAgentAction action)
	{
		if (action.Type == QWAgentAction.E_Type.AddToStage)
		{
			QWOnAddToSatgeAction qWOnAddToSatgeAction = action as QWOnAddToSatgeAction;
			if (qWOnAddToSatgeAction.isFirstAdd)
			{
				OnFirstAddToStage(qWOnAddToSatgeAction);
			}
		}
	}

	private void OnFirstAddToStage(QWOnAddToSatgeAction action)
	{
		npcBoard.lookAtType = action.lookAtType;
		npcBoard.lookAtEntityId = action.lookAtEntityId;
		npcBoard.lookAtPos = action.lookAtPos;
		if (action.lookAtType != QworldEntityLookAtType.NotLookAt)
		{
			QWLookAtAction qWLookAtAction = QWAgentActionFactory.Create(QWAgentAction.E_Type.LookAt) as QWLookAtAction;
			qWLookAtAction.npcForce = true;
			qWLookAtAction.duration = 0f;
			npcBoard.ActionAdd(qWLookAtAction);
		}
	}
}
