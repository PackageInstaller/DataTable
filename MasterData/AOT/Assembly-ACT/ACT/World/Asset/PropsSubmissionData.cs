using System;
using ACT.Config;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class PropsSubmissionData : InteractObjectDataBase
{
	public int missionId;

	[SerializeField]
	private YooAssetReference _addressAssetID;

	[SerializeField]
	private int _initialStateId;

	public override YooAssetReference addressAssetID => _addressAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.InteractObject;

	public override int initialStateId => _initialStateId;

	public override void Bake(object baker)
	{
	}
}
