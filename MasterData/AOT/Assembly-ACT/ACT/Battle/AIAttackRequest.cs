using UnityEngine;

namespace ACT.Battle;

public struct AIAttackRequest
{
	public bool isValid;

	public string behaviourName;

	public AIBodyMovePolicy movePolicy;

	public bool needFace2HatredTarget;

	public float waitTime;

	public string requestSource;

	public int priority;

	public float requestTime;

	public AIAttackRequest(AIBehaviourData behaviour, string requestSource, int priority)
	{
		behaviourName = behaviour?.name ?? string.Empty;
		movePolicy = behaviour?.movePolicy ?? AIBodyMovePolicy.NoMove;
		needFace2HatredTarget = behaviour?.needFace2HatredTarget ?? true;
		waitTime = behaviour?.waitTime ?? 0f;
		this.requestSource = requestSource ?? string.Empty;
		this.priority = priority;
		requestTime = Time.time;
		isValid = !string.IsNullOrEmpty(behaviourName);
	}
}
