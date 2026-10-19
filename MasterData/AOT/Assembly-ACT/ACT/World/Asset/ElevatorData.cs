using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.World.Behave;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class ElevatorData : StateWorldAssetData
{
	[SerializeField]
	public List<LinkagesObjects> LinkagesObjects = new List<LinkagesObjects>();

	[SerializeField]
	internal int m_initialStateId;

	public bool auto;

	public int elevatorInitialStopId;

	[SerializeField]
	public List<ElevatorInfo> stopInfos = new List<ElevatorInfo>();

	[SerializeField]
	private YooAssetReference m_AddressAssetID;

	public PushImpetusData pushImpetusConfig;

	public ElevBehaveCustomData behaveCustom;

	public override int initialStateId => m_initialStateId;

	private int lastIndex
	{
		get
		{
			if (!auto)
			{
				return stopInfos.Count - 1;
			}
			return 5;
		}
	}

	private int startIndex
	{
		get
		{
			if (!auto)
			{
				return 0;
			}
			return 2;
		}
	}

	public override YooAssetReference addressAssetID => m_AddressAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.InteractObject;

	public override void Bake(object assetComp)
	{
		LinkagesObjects.Bake(assetComp);
		stopInfos.Bake(assetComp);
	}
}
