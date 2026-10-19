using System;
using ACT.Config;
using UnityEngine;
using UnityEngine.Localization;

namespace ACT.World.Asset;

[Serializable]
public class ReadObjectData : StateWorldAssetData
{
	public enum ReadType
	{
		Table
	}

	public string[] abilities;

	public ReadType type;

	[Header("Table")]
	public int id;

	public YooAssetReference modelAssetID;

	public LocalizedString localizedString = new LocalizedString();

	public int iconId;

	public int tipIcon = -1;

	[SerializeField]
	private int m_initialStateId;

	public override YooAssetReference addressAssetID => GameLoader.meta?.readObjectReferenceAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.InteractObject;

	public override int initialStateId => m_initialStateId;
}
