using System;
using System.Collections.Generic;
using TrueSync;
using UnityEngine;

[AddComponentMenu("游戏/冒险模块/武器/区域激光型子弹")]
public class AdventureAreaLaser : AdventureBulletBase
{
	[Space]
	public FP hitTestInterval = 0f;

	public List<LaserLevelConfig> levelConfigs;

	protected Vector3 _endPointPosition3D;

	protected Vector3 _startPointPosition3D;

	protected AdventureFXPlayer _linkFx;

	protected GameObject _hittedPrefab;

	protected FP _laserWidth;

	protected FP _laserLength;

	protected bool _configValid;

	protected TSVector2 _localDirection;

	protected TSVector2 _localStartPosition;

	protected Action<AdventureActor> hitCallback;

	private TSVector2 offset;

	private LaserLevelConfig config;

	private AdventureActor lastTarget;

	public override void Setup(LogicEntity owner = null, TSVector2 position = default(TSVector2), FP positionY = default(FP), TSVector2 direction = default(TSVector2), LogicEntity target = null, TSVector2 targetPosition = default(TSVector2), FP targetPositionY = default(FP), AimType aimType = AimType.Default)
	{
		base.Setup(owner, position, positionY, direction, target, targetPosition, targetPositionY, aimType);
		DeterministicCollider deterministicCollider = SceneSingleton<DeterministicCollisionManager>.Instance.CheckPointInterior(ref position, 151808);
		if (deterministicCollider != null && owner != null)
		{
			TSVector2 origin = owner.tsTransform.Position;
			if (deterministicCollider.Raycast(ref origin, ref direction, out var hitInfo, TSVector2.Distance(position, origin)))
			{
				position = hitInfo.point - direction * dtCollider.Radius;
			}
		}
		if (owner != null)
		{
			_localDirection = TSVector2.Rotate(TSVector2.up, TSVector2.SignedAngle(direction, owner.tsTransform.Forward));
		}
		offset = tsTransform.TransformWorldPointToLocalSpace(position);
		SetLaserLevel();
	}

	public override void Reset(LogicEntity owner = null, TSVector2 position = default(TSVector2), FP positionY = default(FP), TSVector2 direction = default(TSVector2), LogicEntity target = null, TSVector2 targetPosition = default(TSVector2), FP targetPositionY = default(FP))
	{
		base.Reset(owner, position, positionY, direction, target, targetPosition, targetPositionY);
		SyncWithOwner();
		_localStartPosition = tsTransform.TransformWorldPointToLocalSpace(position);
	}

	public void SetLaserLevel(int level = 1)
	{
		for (int i = 0; i < levelConfigs.Count; i++)
		{
			if (levelConfigs.get_Item(i).level == level)
			{
				config = levelConfigs.get_Item(i);
				break;
			}
		}
		if (config != null)
		{
			_linkFx?.Stop();
			if (config.linkFxPrefab != null)
			{
				SyncWithOwner();
				TSVector2 tSVector = tsTransform.TransformLocalPointToWorldSpace(offset);
				_linkFx = AdventureFXPlayer.PlayFX(spawnPosition: new Vector3(tSVector.x.AsFloat(), transform.position.y, tSVector.y.AsFloat()), fxPrefab: config.linkFxPrefab.gameObject, playbackSpeed: (float)logicTimeScale, spawnRotation: transform.rotation, spawnSize: config.scale);
				_linkFx.sizeScale = owner.transform.localScale.x;
				AdventureActor component = owner.GetComponent<AdventureActor>();
				if (component != null)
				{
					if (component.playingCombo != null)
					{
						_linkFx.Bind(component.gameObject, null, ActorState.Null, component.playingCombo);
					}
					else
					{
						_linkFx.Bind(component.gameObject, null, component.state);
					}
				}
			}
			_linkFx.Visible();
			_hitBox.hitDamageId = config.hitDamgeId;
			_hittedPrefab = config.hittedPrefab;
			_laserWidth = config.laserWidth;
			_laserLength = config.laserLength;
			_configValid = true;
		}
		else
		{
			Debug.LogError("激光子弹须配置等级信息");
			_configValid = false;
		}
	}

	protected void SyncWithOwner()
	{
		tsTransform.Position = owner.tsTransform.Position;
		tsTransform.Forward = owner.tsTransform.Forward;
	}

	public void RegisterHitAction(Action<AdventureActor> cb)
	{
		hitCallback = cb;
	}

	protected override void OnLogicUpdate()
	{
		base.OnLogicUpdate();
		if (_configValid && DelayShootUpdate())
		{
			SyncWithOwner();
			TSVector2 tSVector = tsTransform.TransformLocalPointToWorldSpace(_localStartPosition);
			TSVector2 tSVector2 = tsTransform.TransformLocalPointToWorldSpace(_localStartPosition + _localDirection * _laserLength);
			if (useDamageImmuneDurationForMonsterWeapon)
			{
				hitTestInterval = damageImmuneDurationForMonsterWeapon;
			}
			_hitBox.RectangleAreaHit(_laserWidth, _laserLength, tsTransform.TransformLocalPointToWorldSpace(_localStartPosition + _localDirection * _laserLength / 2), (tSVector2 - tSVector).GetAngle(), out var hittedCount, out var _, uniqueAttackId, _hittedPrefab, isHittedEffectScale: true, -5, hitTestInterval, randomHit: false, (AdventureActor hitTarget) =>
			{
				lastTarget = hitTarget;
				hitCallback?.Invoke(hitTarget);
			});
			if (hittedCount > 0 && config?.hitFeedbackEffectConfigureData != null && lastTarget != null)
			{
				config.hitFeedbackEffectConfigureData.Play(lastTarget.transform.position, gameObject, GetCameraShakeSort());
			}
		}
	}

	public override void Finish(bool cancel = false, bool catched = false, bool ignorFinishFX = false)
	{
		base.Finish(cancel, catched, ignorFinishFX);
		_linkFx?.Stop();
	}
}
