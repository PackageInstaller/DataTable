using System;
using ACT.Config;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class BloodThunderTrapData : StateWorldAssetData
{
	[SerializeField]
	private int m_initialStateId;

	[SerializeField]
	private YooAssetReference _interactAddressAssetID;

	[SerializeField]
	[Header("每个交互物只有一个，不能存在异形区域")]
	private MixedBox _field;

	[SerializeField]
	[Header("角色首次进入区域后的等待时间，避免角色在边缘反复横跳")]
	private float _firstIntervalTime;

	[SerializeField]
	private bool _controlRandomTrapRounds;

	[SerializeField]
	private RandomTrapRound[] _randomTrapRounds;

	[SerializeReference]
	private TrapRound[] _rounds;

	[SerializeField]
	private float _yMin;

	[SerializeField]
	private float _yMax;

	[SerializeField]
	private float _bulletConstZ;

	public override YooAssetReference addressAssetID => _interactAddressAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.InteractObject;

	public override int initialStateId => m_initialStateId;

	public MixedBox Field => _field;

	public float FirstIntervalTime => _firstIntervalTime;

	public bool ControlRandomTrapRounds => _controlRandomTrapRounds;

	public RandomTrapRound[] RandomTrapRounds => _randomTrapRounds;

	public TrapRound[] Rounds => _rounds;

	public float YMin => _yMin;

	public float YMax => _yMax;

	public float BulletConstZ => _bulletConstZ;

	public override void Bake(object assetComp)
	{
	}
}
