using System;
using ACT.Battle;
using ACT.Config;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class DamageAreaData : StateWorldAssetData
{
	[SerializeField]
	private YooAssetReference m_AddressAssetID;

	[SerializeField]
	private int m_initialStateId;

	public BoxColliderParameters field;

	public int initIndex;

	public AreaState[] states;

	public YooAssetReference planePrefabAssetID;

	public YooAssetReference attackEntityWrapAssetID;

	public Alliance alliance;

	public int attackId;

	public string[] abilities;

	public override YooAssetReference addressAssetID => m_AddressAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.InteractObject;

	public override int initialStateId => m_initialStateId;

	private int m_EndIndex => states.Length - 1;
}
