using System;
using ACT.Config;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class OrbitTrapAreaData : StateWorldAssetData
{
	[SerializeField]
	private YooAssetReference m_AddressAssetID;

	[SerializeField]
	private int m_initialStateId;

	public YooAssetReference attackEntityWrapAssetID;

	public MixedBox[] fields;

	public string[] abilities;

	[SerializeField]
	private float _aimTime = 2f;

	[SerializeField]
	private float _warningTime = 0.5f;

	[SerializeField]
	private float _attackTime = 1f;

	public override YooAssetReference addressAssetID => m_AddressAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.InteractObject;

	public override int initialStateId => m_initialStateId;

	public float AimTime => _aimTime;

	public float WarningTime => _warningTime;

	public float AttackTime => _attackTime;
}
