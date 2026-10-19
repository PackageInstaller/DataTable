using System;
using ACT.Battle;
using ACT.Config;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class PoisonousFogData : StateWorldAssetData
{
	[SerializeField]
	private int m_initialStateId;

	[SerializeField]
	private YooAssetReference m_AddressAssetID;

	private YooAssetReference _attackEntityWrapAssetID;

	public YooAssetReference AttackEntityWrapAssetID;

	[SerializeField]
	private Alliance _alliance;

	[SerializeField]
	private int _attackId;

	[SerializeField]
	private string[] _abilities;

	[SerializeField]
	private YooAssetReference _planeBackPrefabAssetID;

	public YooAssetReference PlaneBackPrefabAssetID;

	[SerializeField]
	private YooAssetReference _PlaneFrontPrefabAssetID;

	public YooAssetReference PlaneFrontPrefabAssetID;

	[SerializeField]
	private BoxColliderParameters _field;

	public override YooAssetReference addressAssetID => m_AddressAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.InteractObject;

	public override int initialStateId => m_initialStateId;

	public Alliance Alliance => _alliance;

	public int AttackId => _attackId;

	public string[] Abilities => _abilities;

	public BoxColliderParameters Field => _field;

	public override void Bake(object assetComp)
	{
	}
}
