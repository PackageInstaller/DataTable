using UnityEngine;
using UnityEngine.Playables;

public class QTEControlNodeBehaviour : PlayableBehaviour
{
	public QTEControlNode.ENodeType nodeType;

	public string markerName;

	public bool isActiveSubGameObject;

	public string activeSubGameObjectName;

	public EQTECompare compareType;

	public EQTEStatus compareToStatus;

	public bool canJump;

	public EJumpType jumpType;

	public float timeToJumpto;

	public int frameToJumpto;

	public string markerToJumpto;

	public bool isInactiveSubGameObject;

	public string inactiveSubGameObjectName = "";

	public bool isActiveSubGameObjectWhenPass;

	public string activeSubGameObjectNameWhenPass = "";

	public GameObject subTimelineCache;
}
