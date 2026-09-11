using System;

[Serializable]
public struct QWorldContext
{
	public bool IsInStory;

	public QWInteractionModeEnum InteractMode;

	public void ChangeInteractionMode(QWInteractionModeEnum mode)
	{
		QWChangeInteractionModeAction qWChangeInteractionModeAction = QWAgentActionFactory.Create(QWAgentAction.E_Type.ChangeInteractionMode) as QWChangeInteractionModeAction;
		qWChangeInteractionModeAction.mode = mode;
		QWorldScene.Scene.Agent.Blackboard.ActionAdd(qWChangeInteractionModeAction);
		InteractMode = mode;
	}
}
