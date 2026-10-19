using System;
using System.Collections.Generic;
using ACT.Config;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class RotateCompData : StateWorldAssetData
{
	public Vector3 initRotation;

	public List<Vector3> rotations;

	[SerializeField]
	private int m_initialStateId;

	public YooAssetReference wrapAssetID;

	public override YooAssetReference addressAssetID => wrapAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.InteractObject;

	public override int initialStateId => m_initialStateId;
}
