using System;
using ACT.Config;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class TempleEnterData : StateWorldAssetData
{
	public string[] abilities;

	public YooAssetReference modelAssetID;

	public int id;

	[SerializeField]
	private int m_initialStateId;

	public override YooAssetReference addressAssetID => GameLoader.meta.raidEnterReferenceAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.InteractObject;

	public override int initialStateId => m_initialStateId;
}
