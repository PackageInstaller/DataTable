using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.World.Behave;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class DarkCoreStoneData : StateWorldAssetData
{
	public RecallPoint recallPoint = new RecallPoint();

	[SerializeField]
	internal int m_initialStateId;

	[SerializeField]
	public List<StoneStopInfo> stopInfos = new List<StoneStopInfo>();

	[SerializeField]
	private YooAssetReference m_AddressAssetID;

	public PushImpetusData pushImpetusConfig;

	public ElevBehaveCustomData behaveCustom;

	private int lastIndex => stopInfos.Count - 1;

	private int startIndex => 0;

	public override int initialStateId => m_initialStateId;

	public override YooAssetReference addressAssetID => m_AddressAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.InteractObject;

	public override void Bake(object assetComp)
	{
		recallPoint.Bake(assetComp);
		stopInfos.Bake(assetComp);
	}
}
