using System;
using ACT.Config;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class FoldingLadderData : StateWorldAssetData
{
	[SerializeField]
	private int m_initialStateId;

	[SerializeField]
	private YooAssetReference _interactAddressAssetID;

	[SerializeField]
	private YooAssetReference _ladderUnitModelAssetID;

	[SerializeField]
	private int _ladderUnitCount;

	[SerializeField]
	private float _ladderUnitLength;

	public override YooAssetReference addressAssetID => _interactAddressAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.InteractObject;

	public override int initialStateId => m_initialStateId;

	public YooAssetReference LadderUnitModelAssetID => _ladderUnitModelAssetID;

	public int LadderUnitCount => _ladderUnitCount;

	public float LadderUnitLength => _ladderUnitLength;

	public override void Bake(object assetComp)
	{
	}
}
