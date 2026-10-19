using System;
using ACT.Config;
using UnityEngine;
using UnityEngine.Localization;

namespace ACT.World.Asset;

[Serializable]
public class CollectReadObjectData : StateWorldAssetData
{
	public int id;

	public LocalizedString localizedString = new LocalizedString();

	public int iconId;

	public int tipIcon = -1;

	[SerializeField]
	private int m_initialStateId;

	public override YooAssetReference addressAssetID => GameLoader.meta?.collectReadObjectReferenceAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.InteractObject;

	public override int initialStateId => m_initialStateId;
}
