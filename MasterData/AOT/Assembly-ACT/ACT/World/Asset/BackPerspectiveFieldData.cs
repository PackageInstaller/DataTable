using System;
using ACT.Config;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class BackPerspectiveFieldData : StateWorldAssetData
{
	[SerializeField]
	private int m_initialStateId;

	[SerializeField]
	private YooAssetReference _interactAddressAssetID;

	[SerializeField]
	private MixedBox[] _enterFields;

	[SerializeField]
	private MixedBox[] _exitField;

	[SerializeField]
	private Pos _enterPos;

	public override YooAssetReference addressAssetID => _interactAddressAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.InteractObject;

	public override int initialStateId => m_initialStateId;

	public MixedBox[] EnterFields => _enterFields;

	public MixedBox[] ExitField => _exitField;

	public Pos EnterPos => _enterPos;

	public override void Bake(object assetComp)
	{
	}
}
