using System;

namespace ACT.Battle;

[Serializable]
public class AIBehaviourData
{
	public string name;

	public string comment;

	public bool needFace2HatredTarget;

	public AIBodyMovePolicy movePolicy;

	public SubTaskParameterFlag parameterFlag;

	public float waitTime;

	public float cd;

	public float lastTime;

	public float weight;

	public float verticalUpDistance;

	public float verticalDownDistance;

	public float minFrontDistance;

	public float maxFrontDistance;

	public float minBackDistance;

	public float maxBackDistance;

	public BTConditionNode condition;

	public BTDecoratorNode decoratorCondition;
}
