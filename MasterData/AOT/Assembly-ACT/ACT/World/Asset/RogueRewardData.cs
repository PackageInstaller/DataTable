using System;
using System.Collections.Generic;
using ACT.Config;
using UnityEngine;
using UnityEngine.Localization;

namespace ACT.World.Asset;

[Serializable]
public class RogueRewardData : StateWorldAssetData
{
	[SerializeField]
	private int m_initialStateId;

	[SerializeField]
	private YooAssetReference _interactAddressAssetID;

	public List<RogueComp> OtherComps;

	public int weight;

	public LocalizedString name;

	public int uniqueIndex = -1;

	public bool isneedreplace;

	public int iconId;

	public override YooAssetReference addressAssetID => _interactAddressAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.InteractObject;

	public override int initialStateId => m_initialStateId;

	public override bool IsServiceSaveState(int stateId)
	{
		return false;
	}
}
