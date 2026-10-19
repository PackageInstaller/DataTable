using System;
using System.Collections.Generic;
using ACT.Battle.Configs;
using ACT.Utility;
using Bamboo.Collections;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle;

public class RuntimeGeneralTrajectory : RuntimeTrajectory
{
	public const float EvCollisionThresholds = 0.005f;

	public TrajectoryMovementRunner movementRunner;

	public TrajectoryHitPattern hitPattern;

	public TrajectoryLifePattern lifePattern;

	private bool hasEnvironmentHitPoint;

	private Vector3 environmentHitPoint;

	private bool useRaycast;

	private bool staticHitCheckEnvironmentOcclusion;

	internal void ClearEnvironmentHitPoint()
	{
		hasEnvironmentHitPoint = false;
		environmentHitPoint = default;
	}

	internal void SetEnvironmentHitPoint(Vector3 point)
	{
		environmentHitPoint = point;
		hasEnvironmentHitPoint = true;
	}

	internal bool TryGetEnvironmentHitPoint(out Vector3 point)
	{
		point = environmentHitPoint;
		return hasEnvironmentHitPoint;
	}

	public void Create(GeneralTrajectory config, Entity abilityEntity, Ability ability)
	{
		hitPattern = config.hitPattern;
		if (config.movementPattern != null)
		{
			movementRunner = config.movementPattern.Create(abilityEntity, this, ability);
		}
		if (config.clearHitCache)
		{
			abilityEntity.GetCompAbility().ClearHited();
		}
		lifePattern = config.lifePattern;
		lifePattern?.Init(abilityEntity, ability);
		useRaycast = config.useRaycast;
		staticHitCheckEnvironmentOcclusion = config.staticHitCheckEnvironmentOcclusion;
	}

	public void Create(TrajectoryMovementPattern movementPattern, TrajectoryHitPattern hitPattern, TrajectoryLifePattern lifePattern, bool clearHitCache, bool useRaycast, bool staticHitCheckEnvironmentOcclusion, Entity abilityEntity, Ability ability)
	{
		this.hitPattern = hitPattern;
		if (movementPattern != null)
		{
			movementRunner = movementPattern.Create(abilityEntity, this, ability);
		}
		if (clearHitCache)
		{
			abilityEntity.GetCompAbility().ClearHited();
		}
		this.lifePattern = lifePattern;
		lifePattern?.Init(abilityEntity, ability);
		this.useRaycast = useRaycast;
		this.staticHitCheckEnvironmentOcclusion = staticHitCheckEnvironmentOcclusion;
	}

	public WhereTargets CreateWhereTargets(Entity bullet, bool canBeAttack = false)
	{
		return hitPattern?.CreateWhereTargets(bullet, canBeAttack) ?? new WhereTargets
		{
			alliance = bullet.GetAlliance().GetOp(),
			canBeAttack = canBeAttack
		};
	}

	public override void FixedUpdateBehave(Entity behave, float dt)
	{
		if (behave.GetCompAbility().alive)
		{
			dt = behave.GetCompTime().fixedDeltaTime;
			if (!behave.GetCompTrajectory().lifeEnd)
			{
				movementRunner?.FixedUpdate(dt);
			}
			CompTransform compTransform = behave.GetCompTransform();
			lifePattern?.FixedUpdate(behave, dt);
			Vector3 forward = Vector3.ProjectOnPlane(compTransform.rotation * Vector3.forward, Vector3.up);
			if (forward.magnitude > 1E-05f)
			{
				Quaternion faceRotation = (compTransform.PathRotation = Quaternion.LookRotation(forward, Vector3.up));
				compTransform.FaceRotation = faceRotation;
			}
			else
			{
				Quaternion faceRotation = (compTransform.PathRotation = Quaternion.identity);
				compTransform.FaceRotation = faceRotation;
			}
		}
	}

	public override void UpdateBehave(Entity behave, float dt)
	{
		if (movementRunner != null)
		{
			movementRunner.Update(dt);
			return;
		}
		Transform rootTransform = behave.GetRootTransform();
		CompTransform compTransform = behave.GetCompTransform();
		rootTransform.position = Vector3.Lerp(compTransform.lastPhysicsPosition, compTransform.physicsPosition, (Time.time - Time.fixedTime) / Time.fixedDeltaTime);
		rootTransform.rotation = compTransform.rotation;
		compTransform.UpdatePosition(compTransform.physicsPosition);
	}

	public override void SetLifeEnd(Entity behave)
	{
		CompTrajectory? compTrajectory = behave.GetCompTrajectory();
		compTrajectory.lifeEnd = true;
		compTrajectory.currentFrameLifeEnd = true;
	}

	public override void HandleDie(Entity behave)
	{
		lifePattern?.OnHandleDie(behave);
	}

	public override void Reset()
	{
		movementRunner?.Reset();
		movementRunner = null;
		hitPattern = null;
		lifePattern = null;
		ClearEnvironmentHitPoint();
	}

	public void Evaluate(in (Entity behave, Ability ability, float timePassed) message, in (Vector3 velocity, Vector3 position, Quaternion rotation) state, out (Vector3 velocity, Vector3 position, Quaternion rotation) nextState)
	{
		nextState = state;
		Vector3 vector = state.velocity * message.timePassed;
		nextState.position = state.position + vector;
		var (entity, _, _) = message;
		if (hitPattern == null)
		{
			return;
		}
		CompTrajectory compTrajectory = entity.GetCompTrajectory();
		Shape shape = compTrajectory.shape;
		Vector3 vector2 = state.rotation * entity.GetCompTransform().center;
		Vector3 vector3 = compTrajectory.size / 2f;
		bool flag = hitPattern.VirtualPlanes == null || hitPattern.VirtualPlanes.Length == 0;
		BArray<Plane> bArray = null;
		if (!flag)
		{
			bArray = BArrayPool<Plane>.Default.Get(hitPattern.VirtualPlanes.Length);
			ActionMemory memory = new ActionMemory(entity.GetCompProduct().actionSource, entity, FindTargetResult.EntityOnly(entity), null, message.ability);
			for (int i = 0; i < bArray.Length; i++)
			{
				GeneralHitPattern.VirtualPlane obj = hitPattern.VirtualPlanes[i];
				Vector3 vector4 = obj.normalVector.Return(memory);
				float distance = Mathf.Abs(Vector3.Dot(obj.originPoint.Return(memory), vector4));
				bArray[i] = new Plane
				{
					normal = vector4,
					distance = distance
				};
			}
			if (shape switch
			{
				Shape.Box => PhysicsUtility.VirtualPlaneOverlapBoxNonAlloc(state.position + vector2, vector3, bArray, state.rotation), 
				Shape.Sphere => PhysicsUtility.VirtualPlaneOverlapSphereNonAlloc(state.position + vector2, compTrajectory.size.x, bArray), 
				Shape.Custom => PhysicsUtility.VirtualPlaneOverlapCustomNonAlloc(compTrajectory.customColliders, state.position + vector2, state.rotation, bArray), 
				Shape.CustomPart => false, 
				_ => throw new ArgumentOutOfRangeException(), 
			})
			{
				hitPattern.OnHitVirtualPanel(entity, message.ability);
			}
		}
		BSet<FindTargetResult> set = BSetPool<FindTargetResult>.Default.Get();
		WhereTargets whereTargets = CreateWhereTargets(entity);
		if (state.velocity.sqrMagnitude < 1E-06f && !compTrajectory.lifeEnd)
		{
			Collider[] cacheColliders = PhysicsUtility.cacheColliders;
			int num = 0;
			bool flag2 = false;
			Collider collider = null;
			if (shape == Shape.Custom && compTrajectory.customColliders != null)
			{
				Collider[] customColliders = compTrajectory.customColliders;
				foreach (Collider collider2 in customColliders)
				{
					if (collider2 == null)
					{
						continue;
					}
					int num2 = PhysicsUtility.OverlapCustomCollider(collider2, state.position + vector2, state.rotation, cacheColliders, BattleConsts.enviromentMask | BattleConsts.hitMask);
					for (int k = 0; k < num2; k++)
					{
						Collider collider3 = cacheColliders[k];
						if (collider3 == null || compTrajectory.ShouldIgnoreEnvironmentCollision(collider3))
						{
							continue;
						}
						if (IsTargetCollider(collider3))
						{
							if (ProcessTargetCollider(collider3, state.position, entity, whereTargets, message.ability))
							{
								goto end_IL_02fc;
							}
							continue;
						}
						flag2 = true;
						if ((object)collider == null)
						{
							collider = collider3;
						}
					}
					continue;
					end_IL_02fc:
					break;
				}
			}
			else
			{
				int j;
				switch (shape)
				{
				case Shape.CustomPart:
				{
					MonoCustomBulletCollider monoCustomBulletCollider = entity.GetRootTransform()?.GetComponentInChildren<MonoCustomBulletCollider>();
					if (!(monoCustomBulletCollider != null) || monoCustomBulletCollider.touches == null || monoCustomBulletCollider.touches.Count <= 0)
					{
						break;
					}
					foreach (Collider touch in monoCustomBulletCollider.touches)
					{
						if (touch == null)
						{
							continue;
						}
						if (IsTargetCollider(touch))
						{
							if (ProcessTargetCollider(touch, state.position, entity, whereTargets, message.ability))
							{
								break;
							}
							continue;
						}
						flag2 = true;
						if ((object)collider == null)
						{
							collider = touch;
						}
					}
					break;
				}
				case Shape.Sphere:
					j = Physics.OverlapSphereNonAlloc(state.position + vector2, compTrajectory.size.x, cacheColliders, BattleConsts.enviromentMask | BattleConsts.hitMask, QueryTriggerInteraction.Collide);
					goto IL_0442;
				case Shape.Box:
					j = Physics.OverlapBoxNonAlloc(state.position + vector2, vector3, cacheColliders, state.rotation, BattleConsts.enviromentMask | BattleConsts.hitMask, QueryTriggerInteraction.Collide);
					goto IL_0442;
				case Shape.Custom:
					j = 0;
					goto IL_0442;
				default:
					{
						throw new ArgumentOutOfRangeException();
					}
					IL_0442:
					num = j;
					for (int l = 0; l < num; l++)
					{
						Collider collider4 = cacheColliders[l];
						if (collider4 == null || compTrajectory.ShouldIgnoreEnvironmentCollision(collider4))
						{
							continue;
						}
						if (collider4.CompareTag("DestoryBullet"))
						{
							flag2 = true;
							collider = collider4;
						}
						else
						{
							if (collider4.isTrigger)
							{
								continue;
							}
							if (IsTargetCollider(collider4))
							{
								if (ProcessTargetCollider(collider4, state.position, entity, whereTargets, message.ability))
								{
									break;
								}
								continue;
							}
							flag2 = true;
							if ((object)collider == null)
							{
								collider = collider4;
							}
						}
					}
					break;
				}
			}
			if (flag2 && !hitPattern.IgnoreEnvironment(entity))
			{
				RuntimeGeneralTrajectory runtimeGeneralTrajectory = compTrajectory.trajectory as RuntimeGeneralTrajectory;
				runtimeGeneralTrajectory?.ClearEnvironmentHitPoint();
				Vector3 vector5 = ((collider != null) ? collider.ClosestPoint(state.position + vector2) : (state.position + vector2));
				hitPattern.OnHitEnvironment(entity, message.ability, collider, Vector3.zero);
				if (compTrajectory.lifeEnd && compTrajectory.trajectory == runtimeGeneralTrajectory)
				{
					runtimeGeneralTrajectory?.SetEnvironmentHitPoint(vector5);
				}
			}
			PhysicsUtility.Release(cacheColliders);
			BSetPool<FindTargetResult>.Default.Recycle(set);
		}
		if (!compTrajectory.lifeEnd)
		{
			if (!flag)
			{
				float hitDis = 0f;
				if (shape switch
				{
					Shape.Box => PhysicsUtility.VirtualPlaneBoxCastNonAlloc(state.position + vector2, vector3, state.velocity.normalized, bArray, state.rotation, vector.magnitude, out hitDis), 
					Shape.Sphere => PhysicsUtility.VirtualPlaneSphereCastNonAlloc(state.position + vector2, compTrajectory.size.x, state.velocity.normalized, bArray, vector.magnitude, out hitDis), 
					Shape.Custom => PhysicsUtility.VirtualPlaneCustomCastNonAlloc(compTrajectory.customColliders, state.position + vector2, state.rotation, state.velocity.normalized, bArray, vector.magnitude, out hitDis), 
					Shape.CustomPart => false, 
					_ => throw new ArgumentOutOfRangeException(), 
				})
				{
					hitPattern.OnHitVirtualPanel(entity, message.ability);
					Vector3 vector6 = nextState.velocity.normalized * hitDis;
					nextState.position = state.position + vector6;
					entity.GetCompTransform().UpdatePosition(nextState.position);
				}
			}
			RaycastHit[] cacheHits = PhysicsUtility.cacheHits;
			int num3 = 0;
			if (shape == Shape.Custom && compTrajectory.customColliders != null)
			{
				List<RaycastHit> list = new List<RaycastHit>();
				Collider[] customColliders = compTrajectory.customColliders;
				foreach (Collider collider5 in customColliders)
				{
					if (!(collider5 == null))
					{
						int num4 = PhysicsUtility.CastCustomCollider(collider5, state.position + vector2, state.rotation, state.velocity.normalized, cacheHits, vector.magnitude, BattleConsts.enviromentMask | BattleConsts.hitMask);
						for (int m = 0; m < num4; m++)
						{
							list.Add(cacheHits[m]);
						}
					}
				}
				if (list.Count > 0)
				{
					list.Sort(PhysicsUtility.RaycastHitComparer);
					num3 = Mathf.Min(list.Count, cacheHits.Length);
					for (int n = 0; n < num3; n++)
					{
						cacheHits[n] = list[n];
					}
				}
			}
			else
			{
				int j;
				switch (shape)
				{
				case Shape.CustomPart:
				{
					MonoCustomBulletCollider monoCustomBulletCollider2 = entity.GetRootTransform()?.GetComponentInChildren<MonoCustomBulletCollider>();
					if (monoCustomBulletCollider2 != null && monoCustomBulletCollider2.touches != null && monoCustomBulletCollider2.touches.Count > 0)
					{
						List<(Collider, float)> list2 = new List<(Collider, float)>(monoCustomBulletCollider2.touches.Count);
						for (int num5 = 0; num5 < monoCustomBulletCollider2.touches.Count; num5++)
						{
							Collider collider6 = monoCustomBulletCollider2.touches[num5];
							if (!(collider6 == null))
							{
								Vector3 b = collider6.ClosestPoint(state.position + vector2);
								float item = Vector3.Distance(state.position + vector2, b);
								list2.Add((collider6, item));
							}
						}
						list2.Sort(((Collider col, float dist) a, (Collider col, float dist) tuple4) => a.dist.CompareTo(tuple4.dist));
						CompAbility compAbility = entity.GetCompAbility();
						CompTransform compTransform = entity.GetCompTransform();
						for (int num6 = 0; num6 < list2.Count; num6++)
						{
							Collider item2 = list2[num6].Item1;
							float item3 = list2[num6].Item2;
							if (item2 == null)
							{
								continue;
							}
							if (BattleConsts.hitMask == (BattleConsts.hitMask | (1 << item2.gameObject.layer)))
							{
								var (flag3, findTargetResult) = BaseFindTargetsByArea.GetResult(state.position, item2, Vector3.zero);
								if (flag3 && whereTargets.FindTarget(findTargetResult, entity))
								{
									if (compAbility.IsHited(findTargetResult, null))
									{
										continue;
									}
									Vector3 vector7 = nextState.velocity.normalized * item3;
									nextState.position = state.position + vector7;
									compTransform.UpdatePosition(nextState.position - compTransform.center);
									hitPattern.OnHitEntity(entity, findTargetResult, message.ability);
								}
							}
							else if (!hitPattern.IgnoreEnvironment(entity))
							{
								Vector3 vector8 = nextState.velocity.normalized * (item3 - 0.005f);
								nextState.position = state.position + vector8;
								compTransform.UpdatePosition(nextState.position);
								RuntimeGeneralTrajectory runtimeGeneralTrajectory2 = compTrajectory.trajectory as RuntimeGeneralTrajectory;
								runtimeGeneralTrajectory2?.ClearEnvironmentHitPoint();
								Vector3 vector9 = item2.ClosestPoint(state.position + vector2);
								hitPattern.OnHitEnvironment(entity, message.ability, item2, Vector3.zero);
								if (compTrajectory.lifeEnd && compTrajectory.trajectory == runtimeGeneralTrajectory2)
								{
									runtimeGeneralTrajectory2?.SetEnvironmentHitPoint(vector9);
								}
								break;
							}
							if (compTrajectory.lifeEnd)
							{
								break;
							}
						}
					}
					num3 = 0;
					break;
				}
				case Shape.Sphere:
					j = Physics.SphereCastNonAlloc(state.position + vector2, compTrajectory.size.x, state.velocity.normalized, cacheHits, vector.magnitude, BattleConsts.enviromentMask | BattleConsts.hitMask, QueryTriggerInteraction.Collide);
					goto IL_0b23;
				case Shape.Box:
					j = Physics.BoxCastNonAlloc(state.position + vector2, vector3, state.velocity.normalized, cacheHits, state.rotation, vector.magnitude, BattleConsts.enviromentMask | BattleConsts.hitMask, QueryTriggerInteraction.Collide);
					goto IL_0b23;
				case Shape.Custom:
					j = 0;
					goto IL_0b23;
				default:
					{
						throw new ArgumentOutOfRangeException();
					}
					IL_0b23:
					num3 = j;
					break;
				}
			}
			if (useRaycast && shape != Shape.CustomPart)
			{
				num3 = Physics.RaycastNonAlloc(state.position + vector2, state.velocity.normalized, cacheHits, vector.magnitude, BattleConsts.enviromentMask | BattleConsts.hitMask);
			}
			if (num3 > 0)
			{
				Array.Sort(cacheHits, 0, num3, PhysicsUtility.RaycastHitComparer);
				CompAbility compAbility2 = entity.GetCompAbility();
				CompTransform compTransform2 = entity.GetCompTransform();
				for (int num7 = 0; num7 < num3; num7++)
				{
					RaycastHit raycastHit = cacheHits[num7];
					if (raycastHit.collider == null || compTrajectory.ShouldIgnoreEnvironmentCollision(raycastHit.collider) || (raycastHit.collider.isTrigger && !raycastHit.collider.CompareTag("DestoryBullet")))
					{
						continue;
					}
					if (BattleConsts.hitMask == (BattleConsts.hitMask | (1 << raycastHit.collider.gameObject.layer)))
					{
						var (flag4, findTargetResult2) = BaseFindTargetsByArea.GetResult(state.position, raycastHit.collider, Vector3.zero);
						if (flag4 && whereTargets.FindTarget(findTargetResult2, entity))
						{
							if (compAbility2.IsHited(findTargetResult2, null))
							{
								continue;
							}
							Vector3 vector10 = nextState.velocity.normalized * raycastHit.distance;
							nextState.position = state.position + vector10;
							compTransform2.UpdatePosition(nextState.position - compTransform2.center);
							hitPattern.OnHitEntity(entity, findTargetResult2, message.ability);
						}
					}
					else if (!hitPattern.IgnoreEnvironment(entity))
					{
						Vector3 vector11 = nextState.velocity.normalized * (raycastHit.distance - 0.005f);
						nextState.position = state.position + vector11;
						compTransform2.UpdatePosition(nextState.position);
						RuntimeGeneralTrajectory runtimeGeneralTrajectory3 = compTrajectory.trajectory as RuntimeGeneralTrajectory;
						runtimeGeneralTrajectory3?.ClearEnvironmentHitPoint();
						hitPattern.OnHitEnvironment(entity, message.ability, raycastHit.collider, raycastHit.normal);
						if (compTrajectory.lifeEnd && compTrajectory.trajectory == runtimeGeneralTrajectory3)
						{
							runtimeGeneralTrajectory3?.SetEnvironmentHitPoint(raycastHit.point);
						}
						break;
					}
					if (compTrajectory.lifeEnd)
					{
						break;
					}
				}
			}
			PhysicsUtility.Release(cacheHits);
		}
		BArrayPool<Plane>.Default.Recycle(bArray);
	}

	private bool IsTargetCollider(Collider collider)
	{
		return BattleConsts.hitMask == (BattleConsts.hitMask | (1 << collider.gameObject.layer));
	}

	private bool ProcessTargetCollider(Collider collider, Vector3 position, Entity bullet, WhereTargets where, Ability ability)
	{
		if (IsStaticHitOccludedByEnvironment(bullet, collider, position))
		{
			return false;
		}
		var (flag, findTargetResult) = BaseFindTargetsByArea.GetResult(position, collider, Vector3.zero);
		if (flag && where.FindTarget(findTargetResult, bullet))
		{
			if (bullet.GetCompAbility().IsHited(findTargetResult, null))
			{
				return false;
			}
			hitPattern.OnHitEntity(bullet, findTargetResult, ability);
			return bullet.GetCompTrajectory().lifeEnd;
		}
		return false;
	}

	private bool IsStaticHitOccludedByEnvironment(Entity bullet, Collider collider, Vector3 position)
	{
		if (!staticHitCheckEnvironmentOcclusion)
		{
			return false;
		}
		Vector3 vector = collider.ClosestPoint(position);
		if ((vector - position).sqrMagnitude <= Mathf.Epsilon)
		{
			return false;
		}
		CompTrajectory compTrajectory = bullet.GetCompTrajectory();
		if (!compTrajectory.hasIgnoreEnvironmentCollisionTag)
		{
			return Physics.Linecast(position, vector, BattleConsts.enviromentMask);
		}
		Vector3 vector2 = vector - position;
		RaycastHit[] cacheHits = PhysicsUtility.cacheHits;
		int num = Physics.RaycastNonAlloc(position, vector2.normalized, cacheHits, vector2.magnitude, BattleConsts.enviromentMask);
		bool result = false;
		if (num > 0)
		{
			Array.Sort(cacheHits, 0, num, PhysicsUtility.RaycastHitComparer);
			for (int i = 0; i < num; i++)
			{
				Collider collider2 = cacheHits[i].collider;
				if (!(collider2 == null) && !compTrajectory.ShouldIgnoreEnvironmentCollision(collider2))
				{
					result = true;
					break;
				}
			}
		}
		PhysicsUtility.Release(cacheHits);
		return result;
	}
}
