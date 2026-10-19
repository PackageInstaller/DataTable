using System;
using ACT.Config;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class BlackMixLaserData : StateWorldAssetData
{
	public const int HIDDEN_STATE_ID = -1;

	public const int IDLE_STATE_ID = 0;

	[SerializeField]
	private int m_initialStateId;

	[SerializeField]
	private YooAssetReference _interactAddressAssetID;

	[SerializeField]
	private YooAssetReference _laserEffectAsset;

	[SerializeField]
	private Pos[] _laserTrans;

	[SerializeField]
	private float _speed;

	[SerializeField]
	private BlackMixLaserStateConfig[] _stateConfigs;

	public override YooAssetReference addressAssetID => _interactAddressAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.InteractObject;

	public override int initialStateId => m_initialStateId;

	public YooAssetReference LaserEffectAsset => _laserEffectAsset;

	public Pos[] LaserTrans => _laserTrans;

	public float Speed => _speed;

	public BlackMixLaserStateConfig[] StateConfigs => _stateConfigs;

	public override void Bake(object assetComp)
	{
	}

	public int[] GetActiveLaserIndices(int stateId)
	{
		if (_stateConfigs == null)
		{
			return Array.Empty<int>();
		}
		BlackMixLaserStateConfig[] stateConfigs = _stateConfigs;
		foreach (BlackMixLaserStateConfig blackMixLaserStateConfig in stateConfigs)
		{
			if (blackMixLaserStateConfig.StateId == stateId)
			{
				return blackMixLaserStateConfig.ActiveLaserIndices ?? Array.Empty<int>();
			}
		}
		return Array.Empty<int>();
	}
}
