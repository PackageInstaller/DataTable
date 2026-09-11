using UnityEngine;

public class QWFurniturePlayEffectAction : QWAgentAction
{
	public bool playEffect;

	public string attachPoint;

	public string efxPath;

	public Vector3 offset;

	public Quaternion rotation;

	public Vector3 scale;

	public float duration;

	public int target;

	public QWFurniturePlayEffectAction()
		: base(E_Type.Furniture_PlayEffect)
	{
	}

	public override void Reset()
	{
		base.Reset();
	}
}
