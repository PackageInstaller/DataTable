using System.Collections.Generic;
using AdventureBehaviour;
using Drawing;
using TrueSync;
using UnityEngine;

[AddComponentMenu("游戏/冒险模块/武器/特效跟踪子弹")]
public class AdventureFbxFollowBullet : AdventureBullet
{
	[Space]
	public FP traceRotateSpeed = 360f;

	public int reboundTime;

	public List<int> hitDmgs;

	public int reboundRange;

	public bool EnableMainCtrTargetFirst;

	public bool EnableReboundMainCtr = true;

	public bool reboundMainCtrCost;

	public bool reSearchWhenTargetMiss;

	[Space]
	public BulletBlockFilter bulletBlockFilter = BulletBlockFilter.All;

	private int curReboundTime;

	private TSVector2 lastPos;

	private LogicEntity _atkTarget;

	private Dictionary<long, int> shootCache = new Dictionary<long, int>();

	private HitBox.FeatureFlag orginfeatureFlags;

	private LogicEntity lastAtkTarget;

	private LogicEntity atkTarget
	{
		get
		{
			if (_atkTarget == null)
			{
				return null;
			}
			if (_atkTarget is AdventureActor adventureActor)
			{
				if (!adventureActor.isSneak && !adventureActor.isPenetrate && adventureActor.actorHealthInfo.isAlive)
				{
					return _atkTarget;
				}
				return null;
			}
			return null;
		}
		set
		{
			_atkTarget = value;
		}
	}

	private bool hasTarget => atkTarget != null;

	private PlayerAdventureActor mainCtrActor => SceneSingleton<AdventurePlayerController>.Instance.ActivedPlayerActor;

	public override void Reset(LogicEntity owner = null, TSVector2 position = default(TSVector2), FP positionY = default(FP), TSVector2 direction = default(TSVector2), LogicEntity target = null, TSVector2 targetPosition = default(TSVector2), FP targetPositionY = default(FP))
	{
		base.Reset(owner, position, positionY, direction, target, targetPosition, targetPositionY);
		curReboundTime = 0;
		_atkTarget = target;
		shootCache.Clear();
		orginfeatureFlags = hitBox.featureFlags;
		if (_atkTarget != null)
		{
			lastPos = _atkTarget.tsTransform.Position;
		}
		lastAtkTarget = _atkTarget;
		EnableMainCtrTargetFirst = false;
	}

	protected override void OnLogicUpdate()
	{
		if (isValid)
		{
			CommonHelper.UpdateWeaponFeature(features);
		}
		if (CheckFinishByWeaponFeature())
		{
			Finish(cancel: true);
		}
		else
		{
			if (!DelayShootUpdate())
			{
				return;
			}
			if (_waitMoveToHitPoint)
			{
				if (reboundTime > 0 && curReboundTime < reboundTime)
				{
					Rebound();
				}
				else
				{
					Finish();
				}
				return;
			}
			bool flag = true;
			FP logicDeltaTime = LogicDeltaTime;
			_lifeTimer += logicDeltaTime;
			if (_delayTimer > 0f)
			{
				_delayTimer -= logicDeltaTime;
			}
			bool flag2 = _delayTimer <= 0f;
			bool flag3 = false;
			if (LiftTime > 0f && _lifeTimer >= LiftTime)
			{
				flag = false;
				flag3 = true;
			}
			else
			{
				TSVector2 origin = tsTransform.Position;
				TSVector2 direction = velocityDirection;
				bool flag4 = false;
				if (SceneSingleton<AdventureModuleDebugHelper>.Instance.BulletGizmo | flag4)
				{
					CommandBuilder ingame = Draw.ingame;
					Transform transform = base.transform;
					float num = (float)dtCollider.Radius;
					Vector3 normalized = new Vector3((float)direction.x, 0f, (float)direction.y).normalized;
					float num2 = (float)(velocitySpeed * logicDeltaTime);
					Vector3 vector = new Vector3((float)origin.x, transform.position.y, (float)origin.y);
					Vector3 vector2 = vector + num2 * 0.5f * normalized;
					Quaternion quaternion2 = Quaternion.LookRotation(normalized, Vector3.up);
					Vector2 vector3 = new Vector2(num * 2f, num2 + num * 2f);
					using (ingame.WithColor(Color.red))
					{
						using (ingame.WithDuration(0.1f))
						{
							ingame.WireRectangle(vector2, quaternion2, vector3);
							ingame.Circle(vector, Vector3.up, num);
							ingame.ArrowheadArc(vector, normalized, num + 0.1f);
						}
					}
				}
				flag = true;
				if (hasTarget)
				{
					if (SceneSingleton<DeterministicCollisionManager>.Instance.SphereCast(ref origin, ref direction, out var hitInfo, flag2 ? (velocitySpeed * logicDeltaTime) : ((FP)0f), dtCollider.Radius, hitableLayerMask))
					{
						LogicEntity entity = hitInfo.collider.Entity;
						if (_atkTarget != null && atkTarget.Id == entity.Id)
						{
							flag = false;
							bool damaged = false;
							flag = _hitBox.HitSingleTarget(uniqueAttackId, hitInfo.collider, out var _, out damaged, ref hitInfo, hittedPrefab, isHittedEffectScale: true, damageImmuneDuration, 1, !effectTimeScale);
							if (!flag && hitInfo.collider.layer == 8)
							{
								FP fP = TSVector2.Distance(tsTransform.Position, hitInfo.point);
								FP fP2 = velocitySpeed * logicDeltaTime;
								_keepMoveToHitPointTime = fP / fP2 * logicDeltaTime;
							}
							if (damaged)
							{
								Vector3 vector4 = new Vector3((float)hitInfo.point.x, base.transform.position.y, (float)hitInfo.point.y);
								Vector3 forward = new Vector3((float)hitInfo.normal.x, (-base.transform.forward).y, (float)hitInfo.normal.y);
								forward.Normalize();
								Quaternion spawnRotation = Quaternion.LookRotation(forward, Vector3.up);
								if (hitPrefab != null)
								{
									AdventureFXPlayer.PlayFX(hitPrefab, (float)logicTimeScale, vector4, spawnRotation, base.transform.localScale.x).ownerActor = owner as AdventureActor;
								}
								if (hitFeedbackEffectConfigureData != null)
								{
									hitFeedbackEffectConfigureData.Play(vector4, gameObject, GetCameraShakeSort());
								}
							}
						}
					}
				}
				else if (reSearchWhenTargetMiss)
				{
					List<LogicEntity> list = ILRuntimeAPI.SearchByRangeAndPosition(owner as AdventureActor, tsTransform.Position, reboundRange, null, isConfront: true);
					if (list.Count > 0)
					{
						_atkTarget = list.get_Item(0);
						target = _atkTarget;
						flag = true;
					}
					else
					{
						flag = true;
					}
				}
				else
				{
					FP fP3 = velocitySpeed * logicDeltaTime;
					flag = TSVector2.Distance(lastPos, tsTransform.Position) > fP3;
				}
			}
			if (flag3)
			{
				Finish();
			}
			else if (flag)
			{
				if (flag2)
				{
					Move(logicDeltaTime);
				}
			}
			else if (reboundTime > 0 && curReboundTime < reboundTime)
			{
				if (_keepMoveToHitPointTime <= 0)
				{
					Rebound();
					return;
				}
				Move(_keepMoveToHitPointTime);
				_waitMoveToHitPoint = true;
			}
			else if (_keepMoveToHitPointTime <= 0)
			{
				Finish();
			}
			else
			{
				Move(_keepMoveToHitPointTime);
				_waitMoveToHitPoint = true;
			}
		}
	}

	private void Rebound()
	{
		_waitMoveToHitPoint = false;
		_keepMoveToHitPointTime = 0;
		_lifeTimer = 0;
		_delayTimer = delayMove;
		TSVector2 tSVector = _atkTarget?.tsTransform.Position ?? tsTransform.Position;
		_atkTarget = GetReboundTarget(tSVector);
		target = _atkTarget;
		if (_atkTarget == null || _atkTarget == lastAtkTarget)
		{
			Finish();
			return;
		}
		lastAtkTarget = _atkTarget;
		lastPos = _atkTarget.tsTransform.Position;
		TSVector2 tSVector2 = TSVector2.Normalize(_atkTarget.tsTransform.Position - tSVector);
		velocityDirection = tSVector2;
		tsTransform.Forward = velocityDirection;
		if (_atkTarget != mainCtrActor)
		{
			_hitBox.hitDamageId = hitDamageId;
			if (hitDmgs != null)
			{
				if (curReboundTime < hitDmgs.Count)
				{
					_hitBox.hitDamageId = hitDmgs.get_Item(curReboundTime);
				}
				else
				{
					Debug.LogError($"{name} 当前反弹次数:{curReboundTime},未配置对应反弹伤害");
				}
			}
			curReboundTime++;
			_hitBox.featureFlags = orginfeatureFlags;
		}
		else
		{
			_hitBox.hitDamageId = 1000001;
			_hitBox.featureFlags |= HitBox.FeatureFlag.NoDiffDamage;
			if (reboundMainCtrCost)
			{
				curReboundTime++;
			}
		}
	}

	public override void Move(FP dt)
	{
		if (hasTarget)
		{
			TSVector2 to = TSVector2.Normalize(atkTarget.tsTransform.Position - tsTransform.Position);
			velocityDirection = TrueSyncExtensions.RotateTowards(velocityDirection, to, traceRotateSpeed * LogicDeltaTime);
			lastPos = atkTarget.tsTransform.Position;
		}
		else if (!reSearchWhenTargetMiss)
		{
			TSVector2 to2 = TSVector2.Normalize(lastPos - tsTransform.Position);
			velocityDirection = TrueSyncExtensions.RotateTowards(velocityDirection, to2, traceRotateSpeed * LogicDeltaTime);
		}
		TSVector2 tSVector = velocity * dt;
		tsTransform.Position += tSVector;
		tsTransform.Forward = velocityDirection;
		if (!AdventureModuleController.sceneLimitZone.Contains(tsTransform.Position))
		{
			Finish(cancel: true);
		}
		else if (acceleratedVelocity != 0f)
		{
			velocitySpeed += acceleratedVelocity * dt;
			if ((acceleratedVelocity > 0f && velocitySpeed > borderVelocitySpeed) || (acceleratedVelocity < 0f && velocitySpeed < borderVelocitySpeed))
			{
				velocitySpeed = borderVelocitySpeed;
			}
		}
	}

	private LogicEntity GetReboundTarget(TSVector2 center)
	{
		List<long> list = new List<long>();
		foreach (KeyValuePair<long, int> item in shootCache)
		{
			LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(item.Key);
			if (logicEntity != null && logicEntity is AdventureActor adventureActor)
			{
				if (adventureActor.isSneak || adventureActor.isPenetrate || !adventureActor.actorHealthInfo.isAlive)
				{
					list.Add(item.Key);
				}
			}
			else
			{
				list.Add(item.Key);
			}
		}
		for (int i = 0; i < list.Count; i++)
		{
			shootCache.Remove(list.get_Item(i));
		}
		if (EnableMainCtrTargetFirst && mainCtrActor != null && mainCtrActor.attackTarget != null && lastAtkTarget != mainCtrActor.attackTarget)
		{
			long id = mainCtrActor.attackTarget.Id;
			if (!shootCache.TryGetValue(id, out var _))
			{
				shootCache.Add(id, 1);
			}
			else
			{
				shootCache.get_Item(id)++;
			}
			return mainCtrActor.attackTarget;
		}
		List<LogicEntity> list2 = ILRuntimeAPI.SearchByRangeAndPosition(owner as AdventureActor, center, reboundRange, null, isConfront: true, onlyAlive: true, includeSelf: false, (LogicEntity entity) => entity.tsTransform.Position != center);
		if (list2.Count > 0)
		{
			LogicEntity logicEntity2 = null;
			for (int num = 0; num < list2.Count; num++)
			{
				if (!shootCache.TryGetValue(list2.get_Item(num).Id, out var _))
				{
					shootCache.Add(list2.get_Item(num).Id, 1);
					logicEntity2 = list2.get_Item(num);
					break;
				}
			}
			if (logicEntity2 == null)
			{
				list2.Sort((LogicEntity x, LogicEntity y) =>
				{
					int num2 = shootCache.get_Item(x.Id);
					int num3 = shootCache.get_Item(y.Id);
					return num2 - num3;
				});
				logicEntity2 = list2.get_Item(0);
				shootCache.get_Item(logicEntity2.Id)++;
			}
			return logicEntity2;
		}
		if (EnableReboundMainCtr && TSVector2.Distance(mainCtrActor.tsTransform.Position, center) < reboundRange)
		{
			return mainCtrActor;
		}
		return null;
	}

	private bool CheckBulletBlockFlag(AdventureActor act, BulletBlockFilter flag)
	{
		if (flag == BulletBlockFilter.All)
		{
			return act.IsNotBlockBullet;
		}
		if ((flag & BulletBlockFilter.IsCloseBlock) != 0 && act.isCloseBlock)
		{
			return true;
		}
		if ((flag & BulletBlockFilter.IsHideModel) != 0 && act.isHideModel)
		{
			return true;
		}
		if ((flag & BulletBlockFilter.IsSneak) != 0 && act.isSneak)
		{
			return true;
		}
		if ((flag & BulletBlockFilter.IsHideOut) != 0 && act.isHideOut)
		{
			return true;
		}
		if ((flag & BulletBlockFilter.IsPenetrate) != 0 && act.isPenetrate)
		{
			return true;
		}
		return false;
	}

	public override bool OnHitActor(HitBox hitBox, int uniqueAttackId, int onceAttackTargetCount, LogicEntity actor, ref DeterministicRaycastHit raycastHit, out bool damaged, GameObject hurtEffectPrefab, bool isHittedEffectScale = true, bool effectIgnoreTimeScale = true)
	{
		damaged = false;
		if (!isValid)
		{
			return false;
		}
		if (!actor.GetLogicComponent<ActorHealthInfo>().isAlive)
		{
			return true;
		}
		bool flag = false;
		bool flag2 = true;
		for (int num = features.Count - 1; num >= 0; num--)
		{
			WeaponFeature weaponFeature = features.get_Item(num);
			if (weaponFeature is WeaponFeatureCertainActorHitted)
			{
				flag2 = weaponFeature.OnHitActor(actor, ref raycastHit);
			}
			else if (weaponFeature.OnHitActor(actor, ref raycastHit))
			{
				flag = true;
			}
		}
		AdventureActor component = actor.GetComponent<AdventureActor>();
		if (CheckBulletBlockFlag(component, bulletBlockFilter))
		{
			flag = true;
		}
		if (component.state == ActorState.Spawn)
		{
			flag = true;
		}
		if (flag2)
		{
			(bool, long, bool) tuple = component.Damage(this, uniqueAttackId, onceAttackTargetCount, hitBox.hitDamageId, hurtEffectPrefab, hitBox, isHittedEffectScale, showHud: true, effectIgnoreTimeScale);
			(damaged, _, _) = tuple;
			if (tuple.Item3)
			{
				flag = true;
			}
		}
		else
		{
			flag = true;
		}
		if (!flag)
		{
			_finishReason = BulletFinishReason.HitActor;
		}
		return flag;
	}
}
