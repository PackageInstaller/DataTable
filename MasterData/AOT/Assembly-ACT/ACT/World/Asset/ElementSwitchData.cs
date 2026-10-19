using System;
using ACT.Config;
using ACT.Core;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class ElementSwitchData : StateWorldAssetData
{
	[SerializeField]
	private int m_initialStateId;

	[SerializeField]
	private YooAssetReference m_AddressAssetID;

	public ElementBitmask elementType;

	public LinkObjComp[] linkObjComps;

	public float cdTime;

	public YooAssetReference linkAddressAssetID;

	public Pos linkPos;

	public bool toFinalState;

	public MixedBox finalBoxTrigger;

	public override YooAssetReference addressAssetID => m_AddressAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.InteractObject;

	public override int initialStateId => m_initialStateId;

	public override bool IsServiceSaveState(int stateId)
	{
		if (stateId != 0)
		{
			return stateId == -1;
		}
		return true;
	}
}
