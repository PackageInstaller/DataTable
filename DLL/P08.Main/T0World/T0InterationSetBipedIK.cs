using System;

namespace T0World;

[Serializable]
public class T0InterationSetBipedIK : T0InterationFunctionDataBase
{
	public float spineWeight = 0.03f;

	public float aimWeight = 0.145f;

	public float lookAtWeight = 1f;

	public float lookBodyWeight = 0.243f;

	public float lookHeadWeight = 0.68f;

	public float lookeyesWeight = 0.2f;

	public float leftFootWeight;

	public float rightFootWeight;

	public float rightHandWeight;

	public float leftHandWeight;

	public float pelvisWeight;

	public override void StartEvent(T0WorldInteractionBehavior behaviour)
	{
		T0WorldScene.Scene.agentManager.CharacteraAgent.CharacterBoard.ikBehavior.SetWeightData(this);
		base.IsFinish = true;
	}
}
