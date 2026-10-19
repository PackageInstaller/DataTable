using System;
using System.Collections.Generic;
using ACT.Config;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class InteractCoreData : StateWorldAssetData
{
	[SerializeField]
	[Range(0f, 1f)]
	private int m_initialStateId;

	public YooAssetReference coreWrapAssetID;

	public YooAssetReference headPrefabAssetID;

	public YooAssetReference bodyPrefabAssetID;

	public float speed = 13f;

	public float delayTime = 0.1f;

	public int length = 2;

	public List<Vector3> pos;

	public Vector3 scale = Vector3.one;

	public override YooAssetReference addressAssetID => coreWrapAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.InteractObject;

	public override int initialStateId => m_initialStateId;
}
