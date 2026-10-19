using System;
using ACT.Battle;
using ACT.Config;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class MechanismTrapData : StateWorldAssetData
{
	public YooAssetReference m_addressAssetID;

	public YooAssetReference MechanismEntityAssetID;

	public int entityNeutralId;

	public Alliance alliance;

	public int defaultStateId;

	public float[] stateStartTimes;

	[HideInInspector]
	public string stateParameter = "state";

	[HideInInspector]
	public Vector3 scale;

	public override YooAssetReference addressAssetID => m_addressAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.InteractObject;

	public override int initialStateId => defaultStateId;

	public override bool IsWaitInit => true;

	public override void Bake(object assetComp)
	{
		MechanismTrapComp mechanismTrapComp = assetComp as MechanismTrapComp;
		scale = mechanismTrapComp.transform.lossyScale;
		base.Bake(assetComp);
	}
}
