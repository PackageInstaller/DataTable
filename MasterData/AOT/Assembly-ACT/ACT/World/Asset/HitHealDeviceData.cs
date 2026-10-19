using System;
using System.Collections.Generic;
using ACT.Config;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public sealed class HitHealDeviceData : StateWorldAssetData
{
	public const int CanHit = 0;

	public const int CanNotHit = 1;

	private const int SectionCount = 12;

	[SerializeField]
	private int _initialStateId;

	[SerializeField]
	private YooAssetReference _addressAssetID;

	[SerializeField]
	private float _hitInterval = 0.2f;

	[SerializeField]
	private BoxColliderParameters _hitBox;

	[SerializeField]
	private int _maxGeneratedLightPointCount = 1;

	[SerializeField]
	private HitHealDeviceSection[] _sections = new HitHealDeviceSection[12];

	[SerializeField]
	private Pos _startPos;

	[SerializeField]
	private YooAssetReference _lightPointPrefab;

	[SerializeField]
	private Vector2 _scatterDistance = new Vector2(1f, 3f);

	[SerializeField]
	private float _scatterMoveDuration = 0.375f;

	[SerializeField]
	private AnimationCurve _scatterSpeedCurve = AnimationCurve.Linear(0f, 1f, 1f, 1f);

	[SerializeField]
	private float _arrivalWaitTime = 0.5f;

	[SerializeField]
	private float _chaseMaxSpeed = 15f;

	[SerializeField]
	private float _chaseAccelerationDuration = 0.375f;

	[SerializeField]
	private AnimationCurve _chaseSpeedCurve = AnimationCurve.Linear(0f, 0f, 1f, 1f);

	[Range(0f, 1f)]
	[SerializeField]
	private float _recoverMaxHpPercent = 0.01f;

	[SerializeField]
	[Header("回血特效")]
	private YooAssetReference _recoveryEffectAsset;

	public override YooAssetReference addressAssetID => _addressAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.InteractObject;

	public override int initialStateId => _initialStateId;

	public Pos StartPos => _startPos;

	public float HitInterval => _hitInterval;

	public BoxColliderParameters HitBox => _hitBox;

	public int MaxGeneratedLightPointCount => _maxGeneratedLightPointCount;

	public IReadOnlyList<HitHealDeviceSection> Sections => _sections;

	public YooAssetReference LightPointPrefab => _lightPointPrefab;

	public Vector2 ScatterDistance => _scatterDistance;

	public float ScatterMoveDuration => _scatterMoveDuration;

	public AnimationCurve ScatterSpeedCurve => _scatterSpeedCurve;

	public float ArrivalWaitTime => _arrivalWaitTime;

	public float ChaseMaxSpeed => _chaseMaxSpeed;

	public float ChaseAccelerationDuration => _chaseAccelerationDuration;

	public AnimationCurve ChaseSpeedCurve => _chaseSpeedCurve;

	public float RecoverMaxHpPercent => _recoverMaxHpPercent;

	public YooAssetReference RecoveryEffectAsset => _recoveryEffectAsset;

	public int GetTotalLightPointCount()
	{
		int num = 0;
		HitHealDeviceSection[] sections = _sections;
		for (int i = 0; i < sections.Length; i++)
		{
			num += Mathf.Max(0, sections[i]?.LightPointCount ?? 0);
		}
		return num;
	}

	public int GetSectionIndexForPoint(int pointIndex)
	{
		for (int i = 0; i < _sections.Length; i++)
		{
			pointIndex -= Mathf.Max(0, _sections[i]?.LightPointCount ?? 0);
			if (pointIndex < 0)
			{
				return i;
			}
		}
		return 0;
	}

	public Vector3 GetRandomDirection(int sectionIndex)
	{
		float num = 30f;
		return Quaternion.AngleAxis(0f - ((float)sectionIndex * num + UnityEngine.Random.Range(0f, num)), Vector3.forward) * Vector3.up;
	}
}
