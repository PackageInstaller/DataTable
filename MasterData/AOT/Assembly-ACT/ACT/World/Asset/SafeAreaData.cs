using System;
using ACT.Battle;
using ACT.Config;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class SafeAreaData : StateWorldAssetData
{
	[SerializeField]
	private YooAssetReference m_AddressAssetID;

	[SerializeField]
	private int m_initialStateId;

	public float cdTime;

	public float duration;

	public float shineTime;

	public Alliance alliance;

	public string[] abilities;

	[Header("受击盒大小")]
	public BoxColliderParameters box;

	public override YooAssetReference addressAssetID => m_AddressAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.InteractObject;

	public override int initialStateId => m_initialStateId;
}
