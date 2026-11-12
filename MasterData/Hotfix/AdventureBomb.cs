using System;
using System.Collections;
using System.Collections.Generic;
using TrueSync;
using UnityEngine;

[AddComponentMenu("游戏/冒险模块/武器/炸弹")]
public class AdventureBomb : AdventureBulletBase
{
	public GameObject muzzleFx;

	public GameObject bombFx;

	public float bombScale = 1f;

	public GameObject explosionbFx;

	public float explosionScale = 1f;

	public AdventurePlayerFeedbackEffectConfigureData explosionFeedbackEffectConfigureData;

	public GameObject hittedFx;

	public FP delayExplosionTime = 0;

	public HitBox.Shape hitBoxShape;

	public FP hitBoxWidth = 1f;

	public FP hitBoxLength = 1f;

	public FP hitBoxRadius = 1f;

	public FP hitBoxInnerRadius = 0f;

	public FP hitBoxAngle = 45f;

	private static readonly Type _bombComponentType = typeof(IBombComponent);

	private readonly List<IBombComponent> _components = new List<IBombComponent>(5);

	protected FP _delay;

	protected AdventureFXPlayer _bombFxPlayer;

	protected bool _triggerExplosion;

	protected CoroutineNode _delayCoroutine;

	public bool TraceTarget { get; set; }

	protected override void OnInit()
	{
		base.OnInit();
		ILogicComponent[] components = GetComponents<ILogicComponent>();
		foreach (ILogicComponent logicComponent in components)
		{
			if (_bombComponentType.IsInstanceOfType(logicComponent))
			{
				AddLogicComponent(logicComponent);
				_components.Add((IBombComponent)logicComponent);
			}
		}
	}

	public override void Setup(LogicEntity owner = null, TSVector2 position = default(TSVector2), FP positionY = default(FP), TSVector2 direction = default(TSVector2), LogicEntity target = null, TSVector2 targetPosition = default(TSVector2), FP targetPositionY = default(FP), AimType aimType = AimType.Default)
	{
		for (int i = 0; i < _components.Count; i++)
		{
			_components.get_Item(i).Setup();
		}
		if (bombFx != null)
		{
			_bombFxPlayer = AdventureFXPlayer.PlayFX(bombFx, (float)logicTimeScale, transform.position, transform.rotation, bombScale);
			_bombFxPlayer.Bind(gameObject);
			_bombFxPlayer.syncSlotRotation = false;
			_bombFxPlayer.syncSlotScale = false;
			_bombFxPlayer.syncNode = transform;
		}
		if (muzzleFx != null)
		{
			AdventureFXPlayer.PlayFX(muzzleFx, (float)logicTimeScale, transform.position, transform.rotation);
		}
		_delay = delayExplosionTime;
		_triggerExplosion = false;
		base.Setup(owner, position, positionY, direction, target, targetPosition, targetPositionY, aimType);
	}

	public override void Reset(LogicEntity owner = null, TSVector2 position = default(TSVector2), FP positionY = default(FP), TSVector2 direction = default(TSVector2), LogicEntity target = null, TSVector2 targetPosition = default(TSVector2), FP targetPositionY = default(FP))
	{
		base.Reset(owner, position, positionY, direction, target, targetPosition, targetPositionY);
		for (int i = 0; i < _components.Count; i++)
		{
			_components.get_Item(i).Reset(owner, position, positionY, direction, target, targetPosition, targetPositionY);
		}
		if (aimType == AimType.Target && target != null)
		{
			targetPosition = target.tsTransform.Position;
		}
		tsTransform.Position = targetPosition;
		tsTransform.PositionY = targetPositionY;
		transform.position = new Vector3((float)tsTransform.Position.x, (float)tsTransform.PositionY, (float)tsTransform.Position.y);
	}

	protected override void OnLogicUpdate()
	{
		bool flag = true;
		for (int i = 0; i < _components.Count; i++)
		{
			flag = _components.get_Item(i).KeepAlive;
			if (!flag)
			{
				break;
			}
		}
		if (!flag && !_triggerExplosion)
		{
			TriggerExplosion();
		}
	}

	protected void TriggerExplosion()
	{
		_triggerExplosion = true;
		if (_bombFxPlayer != null)
		{
			_bombFxPlayer.Stop();
		}
		if (explosionbFx != null)
		{
			AdventureFXPlayer.PlayFX(explosionbFx, (float)logicTimeScale, transform.position, transform.rotation, explosionScale);
		}
		if (delayExplosionTime > 0)
		{
			if (_delayCoroutine != null)
			{
				StopLogicCoroutine(_delayCoroutine);
			}
			_delayCoroutine = StartLogicCoroutine(DelayExplosion());
		}
		else
		{
			Explosion();
		}
	}

	protected IEnumerator DelayExplosion()
	{
		while (_delay > 0)
		{
			_delay -= LogicDeltaTime;
			yield return null;
		}
		Explosion();
	}

	protected void Explosion()
	{
		FP damageImmuneDuration = 0;
		if (useDamageImmuneDurationForMonsterWeapon)
		{
			damageImmuneDuration = damageImmuneDurationForMonsterWeapon;
		}
		int hittedCount;
		int damageCount;
		switch (hitBoxShape)
		{
		case HitBox.Shape.Rectangle:
			_hitBox.RectangleAreaHit(hitBoxWidth, hitBoxLength, tsTransform.Position, tsTransform.Rotation, out hittedCount, out damageCount, uniqueAttackId, hittedFx, isHittedEffectScale: true, -5, damageImmuneDuration);
			break;
		case HitBox.Shape.Circle:
			_hitBox.CircleAreaHit(hitBoxRadius, hitBoxInnerRadius, tsTransform.Position, out damageCount, out hittedCount, uniqueAttackId, hittedFx, isHittedEffectScale: true, -5, damageImmuneDuration);
			break;
		case HitBox.Shape.Fan:
			_hitBox.FanAreaHit(hitBoxAngle, hitBoxRadius, hitBoxInnerRadius, tsTransform.Position, tsTransform.Rotation, out hittedCount, out damageCount, uniqueAttackId, hittedFx, isHittedEffectScale: true, damageImmuneDuration);
			break;
		}
		smooth.SyncDeterministicTransform();
		if (explosionFeedbackEffectConfigureData != null)
		{
			explosionFeedbackEffectConfigureData.Play(transform.position, gameObject, GetCameraShakeSort());
		}
		Finish();
	}

	public override void Finish(bool cancel = false, bool catched = false, bool ignorFinishFX = false)
	{
		for (int i = 0; i < _components.Count; i++)
		{
			_components.get_Item(i).Finish();
		}
		base.Finish(cancel, catched, ignorFinishFX);
	}

	protected override void OnDeactive()
	{
		base.OnDeactive();
		if (_delayCoroutine != null)
		{
			StopLogicCoroutine(_delayCoroutine);
		}
		_delayCoroutine = null;
		_bombFxPlayer = null;
		_delay = 0;
		_triggerExplosion = false;
	}
}
