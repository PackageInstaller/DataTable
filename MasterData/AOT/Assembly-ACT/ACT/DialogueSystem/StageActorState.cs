using UnityEngine;

namespace ACT.DialogueSystem;

public struct StageActorState
{
	public int actor;

	public string actorAnimName;

	public string actorFaceName;

	public UIConversationScene.StageActorLookAtType lookAtType;

	public Vector3 positionOffset;

	public float rotationYOffset;

	public float scaleOffset;

	public int emoji;
}
