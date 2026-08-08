using UnityEngine;
using UnityEngine.Playables;

public class QTEControlNode : PlayableAsset
{
	public enum ENodeType
	{
		Marker,
		Activator,
		Processor
	}

	public ENodeType nodeType;

	public string markerName = "";

	[Tooltip("是否激活子物体")]
	public bool isActiveSubGameObject;

	[Tooltip("需要激活的子物体名")]
	public string activeSubGameObjectName = "";

	[Tooltip("每帧比较qte状态,成立的话,会执行后续逻辑")]
	public EQTECompare compareType;

	[Tooltip("每帧比较qte状态,成立的话,会执行后续逻辑")]
	public EQTEStatus compareToStatus;

	[Tooltip("当状态比较成立时,是否能跳转")]
	public bool canJump;

	public EJumpType jumpType;

	public float timeToJumpto;

	public int frameToJumpto;

	public string markerToJumpto;

	[Tooltip("当状态比较成立时,是否禁用子物体")]
	public bool isInactiveSubGameObject;

	[Tooltip("需要禁用的子物体名")]
	public string inactiveSubGameObjectName = "";

	[Tooltip("当状态比较成立时,是否激活子物体")]
	public bool isActiveSubGameObjectWhenPass;

	[Tooltip("需要激活的子物体名")]
	public string activeSubGameObjectNameWhenPass = "";

	public override Playable CreatePlayable(PlayableGraph graph, GameObject owner)
	{
		ScriptPlayable<QTEControlNodeBehaviour> scriptPlayable = ScriptPlayable<QTEControlNodeBehaviour>.Create(graph);
		QTEControlNodeBehaviour behaviour = scriptPlayable.GetBehaviour();
		behaviour.isActiveSubGameObject = isActiveSubGameObject;
		behaviour.activeSubGameObjectName = activeSubGameObjectName;
		behaviour.canJump = canJump;
		behaviour.nodeType = nodeType;
		behaviour.markerName = markerName;
		behaviour.compareType = compareType;
		behaviour.compareToStatus = compareToStatus;
		behaviour.jumpType = jumpType;
		behaviour.timeToJumpto = timeToJumpto;
		behaviour.frameToJumpto = frameToJumpto;
		behaviour.markerToJumpto = markerToJumpto;
		behaviour.markerToJumpto = markerToJumpto;
		behaviour.isInactiveSubGameObject = isInactiveSubGameObject;
		behaviour.inactiveSubGameObjectName = inactiveSubGameObjectName;
		behaviour.isActiveSubGameObjectWhenPass = isActiveSubGameObjectWhenPass;
		behaviour.activeSubGameObjectNameWhenPass = activeSubGameObjectNameWhenPass;
		return scriptPlayable;
	}
}
