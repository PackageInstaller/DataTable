using UnityEngine;

namespace ACT.Battle.Configs;

public class TransformConfigCompositeMove : ConfigCompositeMove
{
	public ConfigCompositeMove parentMove;

	public Vector3 localPosition;

	public Vector3 localEulerAngles;

	public ConfigCompositeMove childMove;

	public override CompositeMoveBase CreateInstance()
	{
		return new TransformCompositeMove(this);
	}
}
