using System;
using ACT.Config;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class BreakableByBloodThunderPlatformData : StateWorldAssetData
{
	[SerializeField]
	private int m_initialStateId;

	[SerializeField]
	private YooAssetReference _interactAddressAssetID;

	[SerializeField]
	private float _recoverTime;

	[SerializeField]
	[Tooltip("如果不能复原，那么会在状态0被打时切换到状态1")]
	private bool _canRecover;

	[SerializeField]
	private string[] _abilityName;

	public override YooAssetReference addressAssetID => _interactAddressAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.InteractObject;

	public override int initialStateId => m_initialStateId;

	public float RecoverTime => _recoverTime;

	public bool CanRecover => _canRecover;

	public string[] AbilityName => _abilityName;
}
