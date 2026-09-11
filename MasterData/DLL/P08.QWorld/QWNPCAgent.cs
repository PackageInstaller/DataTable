using UnityEngine;

[RequireComponent(typeof(QWNPCBlackboard))]
public class QWNPCAgent : QWAgent
{
	public float talkActionRadius;

	public QWNPCBlackboard NpcBlackBoard => base.Blackboard as QWNPCBlackboard;

	public override QWAgentLayer GetAgentLayer()
	{
		return QWAgentLayer.NPC;
	}

	public override void Initialize()
	{
		base.Initialize();
	}
}
