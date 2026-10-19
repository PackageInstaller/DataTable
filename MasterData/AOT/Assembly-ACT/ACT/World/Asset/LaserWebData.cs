using System;
using ACT.Battle;
using ACT.Config;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class LaserWebData : InteractObjectDataBase
{
	public Pos[] transforms;

	public PosConnect[] connects;

	public int entityNeutralId;

	public Alliance alliance;

	public YooAssetReference boltAssetID;

	public YooAssetReference laserAssetID;

	public YooAssetReference interactAddressAssetID;

	[SerializeField]
	private int m_initialStateId;

	public override YooAssetReference addressAssetID => interactAddressAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.InteractObject;

	public override int initialStateId => m_initialStateId;

	public override void Bake(object assetComp)
	{
	}
}
