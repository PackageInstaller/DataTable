using System;
using ACT.Config;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class ClawData : StateWorldAssetData
{
	[Flags]
	public enum Direction
	{
		Up = 1,
		Down = 2,
		Left = 4,
		Right = 8
	}

	public string[] abilities;

	public Collider collider;

	public bool needInvert;

	[Range(-180f, 180f)]
	public float leftAngle = -180f;

	[Range(-180f, 180f)]
	public float rightAngle = 180f;

	public ClawColliderPoint clawCollider;

	public float cd = 1.5f;

	public float showRange;

	[SerializeField]
	private int m_initialStateId;

	public override YooAssetReference addressAssetID => GameLoader.meta.clawReferenceAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.InteractObject;

	public override int initialStateId => m_initialStateId;

	public override void Bake(object assetComp)
	{
		if (collider == null && clawCollider != null)
		{
			SphereCollider sphereCollider = (assetComp as ClawComp).gameObject.AddComponent<SphereCollider>();
			sphereCollider.center = clawCollider.center;
			sphereCollider.radius = clawCollider.radius;
			collider = sphereCollider;
		}
		clawCollider.Bake(collider);
	}
}
