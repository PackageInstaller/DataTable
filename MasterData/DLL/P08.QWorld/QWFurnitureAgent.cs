using UnityEngine;

[RequireComponent(typeof(QWFurnitureBlackboard))]
public class QWFurnitureAgent : QWAgent
{
	private QWFurnitureBlackboard fboard;

	public override QWAgentLayer GetAgentLayer()
	{
		return QWAgentLayer.Furniture;
	}

	public override void Initialize()
	{
		base.Initialize();
		fboard = base.Blackboard as QWFurnitureBlackboard;
	}
}
