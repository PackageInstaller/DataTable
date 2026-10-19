using System;
using ACT.Config;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class MovableTrapData : StateWorldAssetData
{
	public StateRoute[] stateRoutes;

	[SerializeField]
	private YooAssetReference m_AddressAssetID;

	[SerializeField]
	[Tooltip("初始状态")]
	private int m_InitialStateId;

	public override YooAssetReference addressAssetID => m_AddressAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.InteractObject;

	public override int initialStateId => m_InitialStateId;

	public override bool IsWaitInit => true;

	public override void Bake(object assetComp)
	{
		stateRoutes.Bake(assetComp);
	}
}
