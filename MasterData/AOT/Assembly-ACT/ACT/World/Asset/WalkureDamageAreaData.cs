using System;
using ACT.Config;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class WalkureDamageAreaData : StateWorldAssetData
{
	[SerializeField]
	private YooAssetReference _addressAssetID;

	[SerializeField]
	private int _initialStateId;

	[SerializeField]
	[Range(0f, 2f)]
	[Tooltip("持续时间不应该超过特效的生命周期，喷发时间为2秒")]
	private float _damageAbilityDuration = 1f;

	[SerializeField]
	private MixedBox[] _fields;

	[SerializeField]
	private int _initIndex;

	[SerializeField]
	private WalkureAreaState[] _states;

	[SerializeField]
	private YooAssetReference _effectPrefabAssetID;

	[SerializeField]
	private YooAssetReference _attackEntityWrapAssetID;

	[SerializeField]
	private Pos _effectPosition;

	public override YooAssetReference addressAssetID => _addressAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.InteractObject;

	public override int initialStateId => _initialStateId;

	public float DamageAbilityDuration => _damageAbilityDuration;

	public MixedBox[] Fields => _fields;

	private int _endIndex
	{
		get
		{
			if (States.Length == 0)
			{
				return 0;
			}
			return States.Length - 1;
		}
	}

	public int InitIndex => _initIndex;

	public WalkureAreaState[] States => _states;

	public YooAssetReference EffectPrefabAssetID => _effectPrefabAssetID;

	public YooAssetReference AttackEntityWrapAssetID => _attackEntityWrapAssetID;

	public Pos EffectPosition => _effectPosition;
}
