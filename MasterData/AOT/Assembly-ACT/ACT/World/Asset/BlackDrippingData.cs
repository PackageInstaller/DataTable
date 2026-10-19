using System;
using ACT.Config;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class BlackDrippingData : StateWorldAssetData, IGetBlackViscousAbDuration
{
	[SerializeField]
	private int m_initialStateId;

	[SerializeField]
	private YooAssetReference _interactAddressAssetID;

	[SerializeField]
	private float _intervalTime;

	[SerializeField]
	private float _firstDelayTime;

	[SerializeField]
	private float _dripDelayTime;

	[SerializeField]
	private float _speed;

	[SerializeField]
	private float _destroyTime;

	[SerializeField]
	private float _radius = 0.25f;

	[SerializeField]
	private float _blackViscousAbilityDuration = 1.5f;

	[SerializeField]
	private bool _creatStain;

	[SerializeField]
	private YooAssetReference _waterStainModel;

	[SerializeField]
	private Pos _waterStainPos;

	public override YooAssetReference addressAssetID => _interactAddressAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.InteractObject;

	public override int initialStateId => m_initialStateId;

	public float IntervalTime => _intervalTime;

	public float FirstDelayTime => _firstDelayTime;

	public float DripDelayTime => _dripDelayTime;

	public float Speed => _speed;

	public float DestroyTime => _destroyTime;

	public float Radius => _radius;

	public bool CreatStain => _creatStain;

	public YooAssetReference WaterStainModel => _waterStainModel;

	public Pos WaterStainPos => _waterStainPos;

	public override void Bake(object assetComp)
	{
	}

	public float GetAbilityDuration()
	{
		return _blackViscousAbilityDuration;
	}
}
