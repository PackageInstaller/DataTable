using System;
using System.Collections;
using System.Collections.Generic;
using TrueSync;
using UnityEngine;

public class ShootBehaviour : LogicComponent
{
	private readonly List<AdventureBulletBase> _shootingBullets = new List<AdventureBulletBase>(10);

	public LogicEntity aimTarget;

	public TSVector2 aimTargetPosition;

	private AdventureActor _actor;

	public int reloadAnimClipIndex = -1;

	public bool isReloadingAmmo => _actor.attackState == ActorState.AttackReload;

	public FP reloadAmmoProgress { get; internal set; }

	public ComboClip reloadAnimClip
	{
		get
		{
			if (reloadAnimClipIndex >= 0)
			{
				ComboClip[] reloadAnimClip_Other = _actor.comboGroup.reloadAnimClip_Other;
				if (reloadAnimClip_Other != null && reloadAnimClip_Other.Length > 0)
				{
					return _actor.comboGroup.reloadAnimClip_Other[reloadAnimClipIndex];
				}
			}
			return _actor.comboGroup.reloadAnimClip;
		}
	}

	public override void OnActive()
	{
		_actor = (AdventureActor)Entity;
	}

	public AdventureWeapon Shoot(GameObject weaponPrefab, TSVector2 position = default(TSVector2), TSVector2 direction = default(TSVector2), FP positionY = default(FP), LogicEntity _target = null)
	{
		if (weaponPrefab == null)
		{
			_actor.LogError("射击时飞行道具预制体为空");
			return null;
		}
		weaponPrefab.TryGetComponent<AdventureWeapon>(out var component);
		if (component != null && component.isEquipableWeapon)
		{
			return _actor.EquipWeapon(weaponPrefab, dCheck: true);
		}
		if (component == null || !component.isShootableWeapon)
		{
			_actor.LogError("武器类型不可射击:" + weaponPrefab.name);
			return null;
		}
		AdventureWeapon adventureWeapon = ModuleController<AdventureModuleController>.Instance.SpawnWeapon<AdventureWeapon>(weaponPrefab, _actor);
		if (adventureWeapon == null)
		{
			return null;
		}
		positionY += _actor.tsTransform.PositionY;
		adventureWeapon.Setup(_actor, position, positionY, direction, _target);
		return adventureWeapon;
	}

	public AdventureBulletBase Shoot(GameObject bulletPrefab, TSVector2? position = null, FP? positionY = null, TSVector2? direction = null, TSVector2? targetPosition = null, LogicEntity target = null, bool useShootDeviationCalcScatteringRadius = false, FP shootScatteringRadius = default(FP), AimType aimType = AimType.Default, Action<LogicEntity> onInit = null, bool targetNullUseActorTarget = true, int controlIndex = 0)
	{
		if (bulletPrefab == null)
		{
			_actor.LogError("射击时子弹预制体为空");
			return null;
		}
		TSVector2 tSVector = position.GetValueOrDefault();
		FP positionY2 = positionY.GetValueOrDefault();
		TSVector2 tSVector2 = direction.GetValueOrDefault();
		TSVector2 tSVector3 = targetPosition.GetValueOrDefault();
		if (bulletPrefab.TryGetComponent<AdventureProjectile>(out var component) && component.checkWalkableAndReachable && !CommonHelper.QueryPositionWalkableOnAllLayer(tSVector3) && !CommonHelper.QueryPositionReachableOnAllLayer(tSVector, tSVector3))
		{
			return null;
		}
		bulletPrefab.TryGetComponent<AdventureWeapon>(out var component2);
		if (component2 != null && component2.isEquipableWeapon)
		{
			_actor.EquipWeapon(bulletPrefab, dCheck: true);
			return null;
		}
		if (component2 == null || !component2.isShootableWeapon)
		{
			_actor.LogError("武器类型不可射击:" + bulletPrefab.name);
			return null;
		}
		AdventureBulletBase adventureBulletBase = ModuleController<AdventureModuleController>.Instance.SpawnWeapon<AdventureBulletBase>(bulletPrefab, _actor);
		if (adventureBulletBase == null)
		{
			return null;
		}
		if (!position.HasValue)
		{
			tSVector = _actor.tsTransform.Position;
		}
		if (!positionY.HasValue)
		{
			positionY2 = _actor.dtCollider.HeightCenter;
		}
		if (!direction.HasValue && !targetPosition.HasValue)
		{
			tSVector2 = _actor.tsTransform.Forward;
		}
		else if (tSVector2.Equals(TSVector2.zero))
		{
			tSVector2 = (tSVector3 - tSVector).normalized;
		}
		else
		{
			tSVector2.Normalize();
		}
		if (!position.HasValue)
		{
			tSVector += tSVector2 * (_actor.dtCollider.Radius + adventureBulletBase.dtCollider.Radius);
		}
		if (!targetPosition.HasValue)
		{
			tSVector3 = tSVector + tSVector2 * _actor.actorSearchTargetInfo.visionRange;
		}
		if (useShootDeviationCalcScatteringRadius && _actor.actorInfo.shootDeviation > FP.Epsilon)
		{
			FP fP = TSVector2.Distance(tSVector3, tSVector);
			shootScatteringRadius = TSMath.Tan(_actor.actorInfo.shootDeviation * FP.Deg2Rad) * fP;
		}
		if (shootScatteringRadius > FP.Epsilon)
		{
			FP fP2 = TSRandom.Range(FP.Zero, shootScatteringRadius);
			FP degrees = TSRandom.Range(FP.Zero, 360);
			tSVector3 += TSVector2.Rotate(TSVector2.up, degrees) * fP2;
			tSVector2 = (tSVector3 - tSVector).normalized;
		}
		FP targetPositionY = 0;
		if (adventureBulletBase is AdventureBezierBullet || adventureBulletBase is AdventureProjectile || adventureBulletBase is AdventureTimeBomb || adventureBulletBase is AdventureLinerBullet || adventureBulletBase is AdventureBomb || adventureBulletBase is AdventureBezier3DBullet)
		{
			if (target != null)
			{
				targetPositionY = target.tsTransform.PositionY;
			}
			else
			{
				targetPositionY = CommonHelper.GetTerrainHeight(tSVector3, _actor.tsTransform.PositionY, out var raycastHit);
				if (!raycastHit)
				{
					targetPositionY = CommonHelper.GetFlyHeight(tSVector3, _actor.tsTransform.PositionY, out var _);
				}
				if (adventureBulletBase is AdventureBezier3DBullet adventureBezier3DBullet)
				{
					targetPositionY += adventureBezier3DBullet.DefaultOffsetHeightFP;
				}
			}
		}
		if ((target == null) & targetNullUseActorTarget)
		{
			target = _actor.attackTarget;
		}
		positionY2 += _actor.tsTransform.PositionY;
		onInit?.Invoke(adventureBulletBase);
		if (adventureBulletBase is AdventureBezier3DBullet adventureBezier3DBullet2)
		{
			adventureBezier3DBullet2.BeforeSetup(controlIndex);
		}
		adventureBulletBase.Setup(_actor, tSVector, positionY2, tSVector2, target, tSVector3, targetPositionY, aimType);
		return adventureBulletBase;
	}

	public int QueryMultipleShootWaveCount(HitBox.Shape shape, AdventureWeapon.MultipleShootStyle shootStyle, int bulletCount)
	{
		return shape switch
		{
			HitBox.Shape.Rectangle => QueryRectangleMultipleShootWaveCount(shootStyle, bulletCount), 
			HitBox.Shape.Circle => QueryCircleMultipleShootWaveCount(shootStyle, bulletCount), 
			HitBox.Shape.Fan => QueryFanMultipleShootWaveCount(shootStyle, bulletCount), 
			_ => 0, 
		};
	}

	public void MultipleShoot(HitBox.Shape shape, GameObject bulletPrefab, int bulletCount, FP width, FP length, FP angle, FP radius, FP innerRadius, TSVector2 position, FP positionY, TSVector2 direction, FP bulletDirectionOffset, AdventureWeapon.MultipleShootStyle shootStyle, ref int waveIndex, FP duration, bool alignShoot, FP alignShootDelay, AimType aimType = AimType.Default, BulletDirectionType bulletDirectionType = BulletDirectionType.ActorToBullet, TSVector2 targetPosition = default(TSVector2), LogicEntity target = null, Action<long> onBulletBorn = null)
	{
		switch (shape)
		{
		case HitBox.Shape.Rectangle:
			RectangleMultipleShoot(bulletPrefab, bulletCount, width, length, position, positionY, direction, bulletDirectionOffset, shootStyle, ref waveIndex, aimType, bulletDirectionType, targetPosition, target, _shootingBullets, onBulletBorn);
			break;
		case HitBox.Shape.Circle:
			CircleMultipleShoot(bulletPrefab, bulletCount, radius, innerRadius, position, positionY, direction, bulletDirectionOffset, shootStyle, ref waveIndex, aimType, bulletDirectionType, targetPosition, target, _shootingBullets, onBulletBorn);
			break;
		case HitBox.Shape.Fan:
			FanMultipleShoot(bulletPrefab, bulletCount, angle, radius, innerRadius, position, positionY, direction, bulletDirectionOffset, shootStyle, ref waveIndex, aimType, bulletDirectionType, targetPosition, target, _shootingBullets, onBulletBorn);
			break;
		default:
			throw new ArgumentOutOfRangeException("shape", shape, null);
		}
		if (alignShoot)
		{
			int num = QueryMultipleShootWaveCount(shape, shootStyle, bulletCount);
			FP fP = 0f;
			if (num - 1 > 0)
			{
				fP = duration / (num - 1);
			}
			for (int i = 0; i < _shootingBullets.Count; i++)
			{
				_shootingBullets.get_Item(i).delayShoot = (num - waveIndex) * fP + alignShootDelay;
			}
		}
		_shootingBullets.Clear();
	}

	public IEnumerator MultipleShoot(HitBox.Shape shape, GameObject bulletPrefab, int bulletCount, FP width, FP length, FP angle, FP radius, FP innerRadius, TSVector2 position, FP positionY, TSVector2 direction, FP bulletDirectionOffset, AdventureWeapon.MultipleShootStyle shootStyle, FP duration, bool alignShoot, FP alignShootDelay, AimType aimType = AimType.Default, BulletDirectionType bulletDirectionType = BulletDirectionType.ActorToBullet, TSVector2 targetPosition = default(TSVector2), LogicEntity target = null, Action onComplete = null, bool useRef = false, Action<long> onBulletBorn = null, FP shootOffset = default(FP))
	{
		int waveIndex = 0;
		int waveCount = QueryMultipleShootWaveCount(shape, shootStyle, bulletCount);
		MultipleShoot(shape, bulletPrefab, bulletCount, width, length, angle, radius, innerRadius, useRef ? (_actor.tsTransform.Position + _actor.tsTransform.Forward * shootOffset) : position, positionY, useRef ? _actor.tsTransform.Forward : direction, bulletDirectionOffset, shootStyle, ref waveIndex, duration, alignShoot, alignShootDelay, aimType, bulletDirectionType, targetPosition, target, onBulletBorn);
		FP interval = 0f;
		if (waveCount - 1 > 0)
		{
			interval = duration / (waveCount - 1);
		}
		FP timer = 0f;
		while (waveIndex < waveCount)
		{
			yield return null;
			timer += _actor.LogicDeltaTime;
			if (timer >= interval)
			{
				timer -= interval;
				MultipleShoot(shape, bulletPrefab, bulletCount, width, length, angle, radius, innerRadius, useRef ? (_actor.tsTransform.Position + _actor.tsTransform.Forward * shootOffset) : position, positionY, useRef ? _actor.tsTransform.Forward : direction, bulletDirectionOffset, shootStyle, ref waveIndex, duration, alignShoot, alignShootDelay, aimType, bulletDirectionType, targetPosition, target, onBulletBorn);
			}
		}
		onComplete?.Invoke();
	}

	public int QueryRectangleMultipleShootWaveCount(AdventureWeapon.MultipleShootStyle shootStyle, int bulletCount)
	{
		return QueryFanMultipleShootWaveCount(shootStyle, bulletCount);
	}

	public void RectangleMultipleShoot(GameObject bulletPrefab, int bulletCount, FP width, FP length, TSVector2 position, FP positionY, TSVector2 direction, FP bulletDirectionOffset, AdventureWeapon.MultipleShootStyle shootStyle, ref int waveIndex, AimType aimType, BulletDirectionType bulletDirectionType, TSVector2 targetPosition, LogicEntity target, List<AdventureBulletBase> bullets = null, Action<long> onBulletBorn = null)
	{
		if (direction.Equals(TSVector2.zero))
		{
			direction = _actor.tsTransform.Forward;
		}
		switch (shootStyle)
		{
		case AdventureWeapon.MultipleShootStyle.FromCenterToSide:
			CenterToSidesStyleRectangleMultipleShoot(bulletPrefab, bulletCount, width, length, position, positionY, direction, bulletDirectionOffset, forward: true, ref waveIndex, aimType, bulletDirectionType, targetPosition, target, bullets, onBulletBorn);
			break;
		case AdventureWeapon.MultipleShootStyle.FromSideToCenter:
			CenterToSidesStyleRectangleMultipleShoot(bulletPrefab, bulletCount, width, length, position, positionY, direction, bulletDirectionOffset, forward: false, ref waveIndex, aimType, bulletDirectionType, targetPosition, target, bullets, onBulletBorn);
			break;
		case AdventureWeapon.MultipleShootStyle.FromLeftToRight:
			SideToAnotherSideStyleRectangleMultipleShoot(bulletPrefab, bulletCount, width, length, position, positionY, direction, bulletDirectionOffset, forward: true, ref waveIndex, aimType, bulletDirectionType, targetPosition, target, bullets, onBulletBorn);
			break;
		case AdventureWeapon.MultipleShootStyle.FromRightToLeft:
			SideToAnotherSideStyleRectangleMultipleShoot(bulletPrefab, bulletCount, width, length, position, positionY, direction, bulletDirectionOffset, forward: false, ref waveIndex, aimType, bulletDirectionType, targetPosition, target, bullets, onBulletBorn);
			break;
		case AdventureWeapon.MultipleShootStyle.RandomDirection:
			RandomStyleRectangleMultipleShoot(bulletPrefab, bulletCount, width, length, position, positionY, direction, bulletDirectionOffset, ref waveIndex, aimType, bulletDirectionType, targetPosition, target, bullets, onBulletBorn);
			break;
		default:
			throw new ArgumentOutOfRangeException("shootStyle", shootStyle, null);
		case AdventureWeapon.MultipleShootStyle.OneShot:
			break;
		}
	}

	protected void CenterToSidesStyleRectangleMultipleShoot(GameObject bulletPrefab, int bulletCount, FP width, FP length, TSVector2 position, FP positionY, TSVector2 direction, FP bulletDirectionOffset, bool forward, ref int waveIndex, AimType aimType, BulletDirectionType bulletDirectionType, TSVector2 targetPosition, LogicEntity target, List<AdventureBulletBase> bullets = null, Action<long> onBulletBorn = null)
	{
		if (bulletCount <= 0)
		{
			return;
		}
		int num = bulletCount / 2;
		int num2 = bulletCount % 2;
		int num3 = num + num2;
		FP fP = width / bulletCount;
		FP fP2 = FP.Zero;
		int num4 = (forward ? waveIndex : (num3 - waveIndex - 1));
		AdventureBulletBase adventureBulletBase;
		if (num2 == 0)
		{
			fP2 = fP * 0.5f;
		}
		else if (num4 == 0)
		{
			adventureBulletBase = RectangleMultipleShoot_Internal(bulletPrefab, position, positionY, direction, 0f, length, bulletDirectionOffset, aimType, bulletDirectionType, targetPosition, target);
			onBulletBorn?.Invoke((adventureBulletBase != null) ? adventureBulletBase.Id : 0);
			if (adventureBulletBase != null)
			{
				bullets?.Add(adventureBulletBase);
			}
			waveIndex++;
			return;
		}
		FP fP3 = fP2 + fP * num4;
		adventureBulletBase = RectangleMultipleShoot_Internal(bulletPrefab, position, positionY, direction, fP3, length, bulletDirectionOffset, aimType, bulletDirectionType, targetPosition, target);
		onBulletBorn?.Invoke((adventureBulletBase != null) ? adventureBulletBase.Id : 0);
		if (adventureBulletBase != null)
		{
			bullets?.Add(adventureBulletBase);
		}
		adventureBulletBase = RectangleMultipleShoot_Internal(bulletPrefab, position, positionY, direction, -fP3, length, bulletDirectionOffset, aimType, bulletDirectionType, targetPosition, target);
		onBulletBorn?.Invoke((adventureBulletBase != null) ? adventureBulletBase.Id : 0);
		if (adventureBulletBase != null)
		{
			bullets?.Add(adventureBulletBase);
		}
		waveIndex++;
	}

	protected void SideToAnotherSideStyleRectangleMultipleShoot(GameObject bulletPrefab, int bulletCount, FP width, FP length, TSVector2 position, FP positionY, TSVector2 direction, FP bulletDirectionOffset, bool forward, ref int waveIndex, AimType aimType, BulletDirectionType bulletDirectionType, TSVector2 targetPosition, LogicEntity target, List<AdventureBulletBase> bullets = null, Action<long> onBulletBorn = null)
	{
		if (bulletCount > 0)
		{
			FP fP = ((bulletCount > 1) ? (-width / (bulletCount - 1)) : FP.Zero);
			int num = (forward ? waveIndex : (bulletCount - waveIndex - 1));
			FP sideWidth = width / 2f;
			sideWidth += fP * num;
			AdventureBulletBase adventureBulletBase = RectangleMultipleShoot_Internal(bulletPrefab, position, positionY, direction, sideWidth, length, bulletDirectionOffset, aimType, bulletDirectionType, targetPosition, target);
			onBulletBorn?.Invoke((adventureBulletBase != null) ? adventureBulletBase.Id : 0);
			if (adventureBulletBase != null)
			{
				bullets?.Add(adventureBulletBase);
			}
			waveIndex++;
		}
	}

	protected void RandomStyleRectangleMultipleShoot(GameObject bulletPrefab, int bulletCount, FP width, FP length, TSVector2 position, FP positionY, TSVector2 direction, FP bulletDirectionOffset, ref int waveIndex, AimType aimType, BulletDirectionType bulletDirectionType, TSVector2 targetPosition, LogicEntity target, List<AdventureBulletBase> bullets = null, Action<long> onBulletBorn = null)
	{
		if (bulletCount > 0)
		{
			FP sideWidth = TSRandom.Range(-width, width) / 2f;
			FP distance = TSRandom.Range(FP.Zero, length);
			AdventureBulletBase adventureBulletBase = RectangleMultipleShoot_Internal(bulletPrefab, position, positionY, direction, sideWidth, distance, bulletDirectionOffset, aimType, bulletDirectionType, targetPosition, target);
			onBulletBorn?.Invoke((adventureBulletBase != null) ? adventureBulletBase.Id : 0);
			if (adventureBulletBase != null)
			{
				bullets?.Add(adventureBulletBase);
			}
			waveIndex++;
		}
	}

	protected AdventureBulletBase RectangleMultipleShoot_Internal(GameObject bulletPrefab, TSVector2 position, FP positionY, TSVector2 direction, FP sideWidth, FP distance, FP bulletDirectionOffset, AimType aimType, BulletDirectionType bulletDirectionType, TSVector2 targetPosition, LogicEntity target)
	{
		TSVector2 normalized = TSVector2.Rotate(direction, 90f).normalized;
		TSVector2 tSVector = position + normalized * sideWidth;
		TSVector2 tSVector2 = direction.normalized;
		if (TSMath.Abs(bulletDirectionOffset) > FP.Epsilon)
		{
			tSVector2 = TSVector2.Rotate(tSVector2, bulletDirectionOffset);
		}
		TSVector2 value = tSVector + tSVector2 * distance;
		switch (aimType)
		{
		case AimType.Position:
			tSVector2 = bulletDirectionType switch
			{
				BulletDirectionType.BulletToTarget => (targetPosition - tSVector).normalized, 
				BulletDirectionType.ActorToBullet => (tSVector - _actor.tsTransform.Position).normalized, 
				_ => throw new ArgumentOutOfRangeException("bulletDirectionType", bulletDirectionType, null), 
			};
			value = targetPosition;
			break;
		case AimType.Target:
			if (target == null)
			{
				Debug.LogError("瞄准模式为'攻击目标'时，目标不能为空");
				return null;
			}
			tSVector2 = bulletDirectionType switch
			{
				BulletDirectionType.BulletToTarget => (target.tsTransform.Position - tSVector).normalized, 
				BulletDirectionType.ActorToBullet => (tSVector - _actor.tsTransform.Position).normalized, 
				_ => throw new ArgumentOutOfRangeException("bulletDirectionType", bulletDirectionType, null), 
			};
			value = target.tsTransform.Position;
			break;
		default:
			throw new ArgumentOutOfRangeException("aimType", aimType, null);
		case AimType.Default:
			break;
		}
		return Shoot(bulletPrefab, tSVector, positionY, tSVector2, value, target, useShootDeviationCalcScatteringRadius: false, default, aimType);
	}

	public int QueryCircleMultipleShootWaveCount(AdventureWeapon.MultipleShootStyle shootStyle, int bulletCount)
	{
		return QueryFanMultipleShootWaveCount(shootStyle, bulletCount);
	}

	public void CircleMultipleShoot(GameObject bulletPrefab, int bulletCount, FP radius, FP innerRadius, TSVector2 position, FP positionY, TSVector2 direction, FP bulletDirectionOffset, AdventureWeapon.MultipleShootStyle shootStyle, ref int waveIndex, AimType aimType, BulletDirectionType bulletDirectionType, TSVector2 targetPosition, LogicEntity target, List<AdventureBulletBase> bullets = null, Action<long> onBulletBorn = null)
	{
		FanMultipleShoot(bulletPrefab, bulletCount, 360f, radius, innerRadius, position, positionY, direction, bulletDirectionOffset, shootStyle, ref waveIndex, aimType, bulletDirectionType, targetPosition, target, bullets, onBulletBorn);
	}

	public int QueryFanMultipleShootWaveCount(AdventureWeapon.MultipleShootStyle shootStyle, int bulletCount)
	{
		switch (shootStyle)
		{
		case AdventureWeapon.MultipleShootStyle.FromCenterToSide:
		case AdventureWeapon.MultipleShootStyle.FromSideToCenter:
		{
			int num = bulletCount / 2;
			int num2 = bulletCount % 2;
			return num + num2;
		}
		case AdventureWeapon.MultipleShootStyle.FromLeftToRight:
		case AdventureWeapon.MultipleShootStyle.FromRightToLeft:
		case AdventureWeapon.MultipleShootStyle.RandomDirection:
			return bulletCount;
		default:
			throw new ArgumentOutOfRangeException("shootStyle", shootStyle, null);
		case AdventureWeapon.MultipleShootStyle.OneShot:
			return 0;
		}
	}

	public void FanMultipleShoot(GameObject bulletPrefab, int bulletCount, FP angle, FP radius, FP innerRadius, TSVector2 position, FP positionY, TSVector2 direction, FP bulletDirectionOffset, AdventureWeapon.MultipleShootStyle shootStyle, ref int waveIndex, AimType aimType, BulletDirectionType bulletDirectionType, TSVector2 targetPosition, LogicEntity target, List<AdventureBulletBase> bullets = null, Action<long> onBulletBorn = null)
	{
		if (direction.Equals(TSVector2.zero))
		{
			direction = _actor.tsTransform.Forward;
		}
		switch (shootStyle)
		{
		case AdventureWeapon.MultipleShootStyle.FromCenterToSide:
			CenterToSidesStyleFanMultipleShoot(bulletPrefab, bulletCount, angle, radius, innerRadius, position, positionY, direction, bulletDirectionOffset, forward: true, ref waveIndex, aimType, bulletDirectionType, targetPosition, target, bullets, onBulletBorn);
			break;
		case AdventureWeapon.MultipleShootStyle.FromSideToCenter:
			CenterToSidesStyleFanMultipleShoot(bulletPrefab, bulletCount, angle, radius, innerRadius, position, positionY, direction, bulletDirectionOffset, forward: false, ref waveIndex, aimType, bulletDirectionType, targetPosition, target, bullets, onBulletBorn);
			break;
		case AdventureWeapon.MultipleShootStyle.FromLeftToRight:
			SideToAnotherSideStyleFanMultipleShoot(bulletPrefab, bulletCount, angle, radius, innerRadius, position, positionY, direction, bulletDirectionOffset, forward: true, ref waveIndex, aimType, bulletDirectionType, targetPosition, target, bullets, onBulletBorn);
			break;
		case AdventureWeapon.MultipleShootStyle.FromRightToLeft:
			SideToAnotherSideStyleFanMultipleShoot(bulletPrefab, bulletCount, angle, radius, innerRadius, position, positionY, direction, bulletDirectionOffset, forward: false, ref waveIndex, aimType, bulletDirectionType, targetPosition, target, bullets, onBulletBorn);
			break;
		case AdventureWeapon.MultipleShootStyle.RandomDirection:
			RandomStyleFanMultipleShoot(bulletPrefab, bulletCount, angle, radius, innerRadius, position, positionY, direction, bulletDirectionOffset, ref waveIndex, aimType, bulletDirectionType, targetPosition, target, bullets, onBulletBorn);
			break;
		default:
			throw new ArgumentOutOfRangeException("shootStyle", shootStyle, null);
		case AdventureWeapon.MultipleShootStyle.OneShot:
			break;
		}
	}

	protected void CenterToSidesStyleFanMultipleShoot(GameObject bulletPrefab, int bulletCount, FP angle, FP radius, FP innerRadius, TSVector2 position, FP positionY, TSVector2 direction, FP bulletDirectionOffset, bool forward, ref int waveIndex, AimType aimType, BulletDirectionType bulletDirectionType, TSVector2 targetPosition, LogicEntity target, List<AdventureBulletBase> bullets = null, Action<long> onBulletBorn = null)
	{
		if (bulletCount <= 0)
		{
			return;
		}
		int num = bulletCount / 2;
		int num2 = bulletCount % 2;
		int num3 = num + num2;
		FP fP;
		if (angle % 360f == 0f)
		{
			fP = ((bulletCount > 1) ? (-angle / bulletCount) : FP.Zero);
		}
		else
		{
			fP = ((bulletCount > 1) ? (-angle / (bulletCount - 1)) : FP.Zero);
		}
		FP fP2 = FP.Zero;
		int num4 = (forward ? waveIndex : (num3 - waveIndex - 1));
		AdventureBulletBase adventureBulletBase;
		if (num2 == 0)
		{
			fP2 = fP * 0.5f;
		}
		else if (num4 == 0)
		{
			adventureBulletBase = FanMultipleShoot_Internal(bulletPrefab, position, positionY, direction, 0f, radius, innerRadius, bulletDirectionOffset, aimType, bulletDirectionType, targetPosition, target);
			onBulletBorn?.Invoke((adventureBulletBase != null) ? adventureBulletBase.Id : 0);
			if (adventureBulletBase != null)
			{
				bullets?.Add(adventureBulletBase);
			}
			waveIndex++;
			return;
		}
		FP fP3 = fP2 + fP * num4;
		adventureBulletBase = FanMultipleShoot_Internal(bulletPrefab, position, positionY, direction, fP3, radius, innerRadius, bulletDirectionOffset, aimType, bulletDirectionType, targetPosition, target);
		onBulletBorn?.Invoke((adventureBulletBase != null) ? adventureBulletBase.Id : 0);
		if (adventureBulletBase != null)
		{
			bullets?.Add(adventureBulletBase);
		}
		adventureBulletBase = FanMultipleShoot_Internal(bulletPrefab, position, positionY, direction, -fP3, radius, innerRadius, bulletDirectionOffset, aimType, bulletDirectionType, targetPosition, target);
		onBulletBorn?.Invoke((adventureBulletBase != null) ? adventureBulletBase.Id : 0);
		if (adventureBulletBase != null)
		{
			bullets?.Add(adventureBulletBase);
		}
		waveIndex++;
	}

	protected void SideToAnotherSideStyleFanMultipleShoot(GameObject bulletPrefab, int bulletCount, FP angle, FP radius, FP innerRadius, TSVector2 position, FP positionY, TSVector2 direction, FP bulletDirectionOffset, bool forward, ref int waveIndex, AimType aimType, BulletDirectionType bulletDirectionType, TSVector2 targetPosition, LogicEntity target, List<AdventureBulletBase> bullets = null, Action<long> onBulletBorn = null)
	{
		if (bulletCount > 0)
		{
			FP fP;
			if (angle % 360f == 0f)
			{
				fP = ((bulletCount > 1) ? (-angle / bulletCount) : FP.Zero);
			}
			else
			{
				fP = ((bulletCount > 1) ? (-angle / (bulletCount - 1)) : FP.Zero);
			}
			FP sideAngle = angle / 2f;
			int num = (forward ? waveIndex : (bulletCount - waveIndex - 1));
			sideAngle += fP * num;
			AdventureBulletBase adventureBulletBase = FanMultipleShoot_Internal(bulletPrefab, position, positionY, direction, sideAngle, radius, innerRadius, bulletDirectionOffset, aimType, bulletDirectionType, targetPosition, target);
			onBulletBorn?.Invoke((adventureBulletBase != null) ? adventureBulletBase.Id : 0);
			if (adventureBulletBase != null)
			{
				bullets?.Add(adventureBulletBase);
			}
			waveIndex++;
		}
	}

	protected void RandomStyleFanMultipleShoot(GameObject bulletPrefab, int bulletCount, FP angle, FP radius, FP innerRadius, TSVector2 position, FP positionY, TSVector2 direction, FP bulletDirectionOffset, ref int waveIndex, AimType aimType, BulletDirectionType bulletDirectionType, TSVector2 targetPosition, LogicEntity target, List<AdventureBulletBase> bullets = null, Action<long> onBulletBorn = null)
	{
		if (bulletCount > 0)
		{
			FP sideAngle = TSRandom.Range(-angle / 2f, angle / 2f);
			FP distance = TSRandom.Range(innerRadius, radius);
			AdventureBulletBase adventureBulletBase = FanMultipleShoot_Internal(bulletPrefab, position, positionY, direction, sideAngle, distance, innerRadius, bulletDirectionOffset, aimType, bulletDirectionType, targetPosition, target);
			onBulletBorn?.Invoke((adventureBulletBase != null) ? adventureBulletBase.Id : 0);
			if (adventureBulletBase != null)
			{
				bullets?.Add(adventureBulletBase);
			}
			waveIndex++;
		}
	}

	protected AdventureBulletBase FanMultipleShoot_Internal(GameObject bulletPrefab, TSVector2 position, FP positionY, TSVector2 direction, FP sideAngle, FP distance, FP innerRadius, FP bulletDirectionOffset, AimType aimType, BulletDirectionType bulletDirectionType, TSVector2 targetPosition, LogicEntity target)
	{
		TSVector2 tSVector = TSVector2.Rotate(direction, sideAngle).normalized;
		TSVector2 tSVector2 = position + tSVector * innerRadius;
		if (TSMath.Abs(bulletDirectionOffset) > FP.Epsilon)
		{
			tSVector = TSVector2.Rotate(tSVector, bulletDirectionOffset);
		}
		TSVector2 value = tSVector2 + tSVector * (distance - innerRadius);
		switch (aimType)
		{
		case AimType.Position:
			tSVector = bulletDirectionType switch
			{
				BulletDirectionType.BulletToTarget => (targetPosition - tSVector2).normalized, 
				BulletDirectionType.ActorToBullet => (!(innerRadius >= 0)) ? (_actor.tsTransform.Position - tSVector2).normalized : (tSVector2 - _actor.tsTransform.Position).normalized, 
				_ => throw new ArgumentOutOfRangeException("bulletDirectionType", bulletDirectionType, null), 
			};
			value = targetPosition;
			break;
		case AimType.Target:
			if (target == null)
			{
				Debug.LogError("瞄准模式为'攻击目标'时，目标不能为空");
				return null;
			}
			tSVector = bulletDirectionType switch
			{
				BulletDirectionType.BulletToTarget => (target.tsTransform.Position - tSVector2).normalized, 
				BulletDirectionType.ActorToBullet => (!(innerRadius >= 0)) ? (_actor.tsTransform.Position - tSVector2).normalized : (tSVector2 - _actor.tsTransform.Position).normalized, 
				_ => throw new ArgumentOutOfRangeException("bulletDirectionType", bulletDirectionType, null), 
			};
			value = target.tsTransform.Position;
			break;
		default:
			throw new ArgumentOutOfRangeException("aimType", aimType, null);
		case AimType.Default:
			break;
		}
		return Shoot(bulletPrefab, tSVector2, positionY, tSVector, value, target, useShootDeviationCalcScatteringRadius: false, default, aimType);
	}

	public bool ReloadAmmo(Action onComplete = null)
	{
		if (_actor.forceControl)
		{
			return false;
		}
		if (_actor is PlayerAdventureActor { enableReload: false })
		{
			return false;
		}
		if (reloadAnimClip == null)
		{
			_actor.LogError(_actor.name + "的\"弹药重装\"动作数据未配置");
			return false;
		}
		if (_actor.InterruptAttack())
		{
			return _actor.attackFSM.SwitchState(16, onComplete);
		}
		return false;
	}

	public List<AdventureWeapon> QueryOwnedAliveWeapons()
	{
		List<AdventureWeapon> list = new List<AdventureWeapon>(10);
		List<LogicEntity> weapons = ModuleController<AdventureModuleController>.Instance.weapons;
		for (int i = 0; i < weapons.Count; i++)
		{
			AdventureWeapon adventureWeapon = weapons.get_Item(i) as AdventureWeapon;
			if (!(adventureWeapon == null) && !(adventureWeapon.owner != _actor) && adventureWeapon.ownerId == _actor.Id)
			{
				list.Add(adventureWeapon);
			}
		}
		return list;
	}
}
