using System;
using System.Collections.Generic;
using ACT.Config;
using ACT.World.StateObject;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class LightHouseData : InteractObjectDataBase
{
	[SerializeField]
	public List<LightHouseInteracts> interactIcons = new List<LightHouseInteracts>();

	[SerializeField]
	public List<LightHouseInteracts> manualConfigInteracts = new List<LightHouseInteracts>();

	public List<int> staticNpcUid = new List<int>();

	public int unlockFogId;

	public List<int> normalUnlockFogIds;

	public int[] hiddenRoomUids;

	public bool openMapUI = true;

	[SerializeField]
	private YooAssetReference m_AddressAssetID;

	public int m_initialStateId;

	public override YooAssetReference addressAssetID => m_AddressAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.LightHouse;

	public override int initialStateId => m_initialStateId;

	public override void OnStateObjectCreate(StateObjectBase stateObject)
	{
	}

	public override void Bake(object assetComp)
	{
	}

	public bool HasUnlockFog()
	{
		if (unlockFogId == 0)
		{
			List<int> list = normalUnlockFogIds;
			if (list != null)
			{
				return list.Count > 0;
			}
			return false;
		}
		return true;
	}
}
