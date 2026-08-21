using System.ComponentModel;
using UnityEngine;
using UnityEngine.Playables;

[DisplayName("QTE UI 单击")]
public class QTEUINode_SingleClick : QTEUINode
{
	public override QTEConditionType conditionType => QTEConditionType.Click;

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<QTEUINode_SingleClick_Behaviour> scriptPlayable = ScriptPlayable<QTEUINode_SingleClick_Behaviour>.Create(graph);
		scriptPlayable.GetBehaviour().conditionType = conditionType;
		scriptPlayable.GetBehaviour().path = path;
		scriptPlayable.GetBehaviour().parent = parent;
		scriptPlayable.GetBehaviour().uiPos = uiPos;
		scriptPlayable.GetBehaviour().uiAnchor = uiAnchor;
		return scriptPlayable;
	}
}
