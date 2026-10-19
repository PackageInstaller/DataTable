using System;
using ACT.Config;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class BlackViscousCoreData : StateWorldAssetData
{
	[SerializeField]
	private int m_initialStateId;

	[SerializeField]
	private YooAssetReference _interactAddressAssetID;

	[SerializeField]
	[Header("核心相关联的黑质")]
	private StateWorldUid[] _linkObjects;

	[SerializeField]
	private MixedBox _mixedBox;

	[SerializeField]
	private YooAssetReference _pointToLinkAssetId;

	[SerializeField]
	private Pos[] _pointToLinks;

	public override YooAssetReference addressAssetID => _interactAddressAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.InteractObject;

	public override int initialStateId => m_initialStateId;

	public StateWorldUid[] LinkObjects => _linkObjects;

	public MixedBox MixedBox => _mixedBox;

	public YooAssetReference PointToLinkAssetId => _pointToLinkAssetId;

	public Pos[] PointToLinks => _pointToLinks;

	public override void Bake(object assetComp)
	{
	}
}
