using UnityEngine;
using UnityEngine.Playables;

public class QTEUINode_Drag : QTEUINode
{
	public float timeLimit = 5f;

	[Tooltip("只计算方向, 不计算距离")]
	public Vector2 dragDir;

	public float dragDistance = 235f;

	public override QTEConditionType conditionType => QTEConditionType.Drag;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<QTEUINode_Drag_Behaviour> scriptPlayable = ScriptPlayable<QTEUINode_Drag_Behaviour>.Create(graph);
		scriptPlayable.GetBehaviour().conditionType = conditionType;
		scriptPlayable.GetBehaviour().path = path;
		scriptPlayable.GetBehaviour().parent = parent;
		scriptPlayable.GetBehaviour().dragDir = dragDir.normalized * dragDistance;
		scriptPlayable.GetBehaviour().uiPos = uiPos;
		scriptPlayable.GetBehaviour().uiAnchor = uiAnchor;
		scriptPlayable.GetBehaviour().timeLimit = timeLimit;
		return scriptPlayable;
	}
}
