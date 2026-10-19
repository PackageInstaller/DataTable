using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Battle.Configs;
using ACT.Event;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;
using UnityEngine.Pool;

namespace ACT.DebugGUI;

public class HitBoxMonitor : EntityBehaveHitBoxAbMonitor
{
	public class AttackGizmo
	{
		public enum GizmosShapeType
		{
			Cube,
			SectorCylinder
		}

		public struct HitBoxGizmo
		{
			public readonly GizmosShapeType shapeType;

			private bool m_IsCompensation;

			public DebugGizmoCube box { get; }

			public HitBoxGizmo(Color color, bool isWire, bool isCompensation = false, GizmosShapeType shapeType = GizmosShapeType.Cube)
			{
				this.shapeType = shapeType;
				if (isWire)
				{
					if (shapeType == GizmosShapeType.SectorCylinder)
					{
						box = new DebugGizmoWireSectorCylinder
						{
							color = color
						};
					}
					else
					{
						box = new DebugGizmoWireCube
						{
							color = color
						};
					}
				}
				else if (shapeType == GizmosShapeType.SectorCylinder)
				{
					box = new DebugGizmoSectorCylinder
					{
						color = color
					};
				}
				else
				{
					box = new DebugGizmoCube
					{
						color = color
					};
				}
				m_IsCompensation = isCompensation;
			}

			public void SetActive(Bounds bounds, Quaternion quaternion)
			{
				SetActive(box, bounds, quaternion);
			}

			public void SetActive(DebugGizmoCube gizmo, Bounds bounds, Quaternion quaternion)
			{
				gizmo.bounds = bounds;
				gizmo.quaternion = quaternion;
				gizmo.color.a = (m_IsCompensation ? DebugWindowManager.instance.comA : DebugWindowManager.instance.hitA);
			}

			public void Update()
			{
				if (m_IsCompensation)
				{
					box.color.a -= DebugWindowManager.instance.comA / DebugWindowManager.instance.comDuration * DebugWindowManager.DT;
				}
				else
				{
					box.color.a -= DebugWindowManager.instance.hitA / DebugWindowManager.instance.hitDuration * DebugWindowManager.DT;
				}
			}
		}

		public struct HitAnchorGizmo(Color color)
		{
			public DebugGizmoPoint anchor { get; } = new DebugGizmoPoint
			{
				color = color
			};

			public void SetActive(Vector3 pos)
			{
				anchor.pos = pos;
				anchor.color.a = DebugWindowManager.instance.hitA;
			}

			public void Update()
			{
				anchor.color.a -= DebugWindowManager.instance.hitA / DebugWindowManager.instance.hitDuration * DebugWindowManager.DT;
			}
		}

		protected Entity entity;

		public FSMRuntimeState runtimeState;

		public HitBoxGizmo comBox;

		public HitBoxGizmo atkBox;

		public HitAnchorGizmo hitPoint;

		public HitBoxGizmo atkHitBox;

		public HitBoxGizmo atk2Box;

		public HitBoxGizmo atk2HitBox;

		public HitAnchorGizmo hit2Point;

		public List<Vector3> lastPos;

		public HitBoxGizmo tractionBox;

		public ConfigMotion configMotion
		{
			get
			{
				int num = 1073741824;
				if ((runtimeState.state.index & num) == 0)
				{
					return entity.GetConfig().moveMotions[runtimeState.state.index].motion;
				}
				return entity.GetConfig().attackMotions[runtimeState.state.index & ~num].motion;
			}
		}

		public AttackGizmo(float z, float thickness, Entity eb)
		{
			comBox = new HitBoxGizmo(Color.blue, isWire: false);
			atkBox = new HitBoxGizmo(Color.green, isWire: true);
			atkHitBox = new HitBoxGizmo(Color.red, isWire: false);
			hitPoint = new HitAnchorGizmo(Color.red);
			atk2Box = new HitBoxGizmo(Color.green, isWire: true);
			atk2HitBox = new HitBoxGizmo(Color.red, isWire: false);
			hit2Point = new HitAnchorGizmo(Color.red);
			tractionBox = new HitBoxGizmo(Color.magenta, isWire: false);
			entity = eb;
		}

		public void Attack(DebugWindowManager manager, Entity eb, WhereTargets where, AreaAttackPattern areaAttack)
		{
			BaseFindTargets findTargets = areaAttack._findTargets;
			Bounds bounds;
			Quaternion quaternion;
			Vector3 anchor;
			if (findTargets is ConfigFindRangeTargets configFindRangeTargets)
			{
				BaseFindTargetsByArea.TargetBoundsLocalToWorld(eb, configFindRangeTargets.targetBounds, out bounds, out quaternion, out anchor);
			}
			else if (findTargets is ConfigFindRangeSectorTargets configFindRangeSectorTargets)
			{
				BaseFindTargetsByArea.TargetBoundsLocalToWorld(eb, configFindRangeSectorTargets.targetSectorBounds, out bounds, out quaternion, out anchor);
			}
			else if (findTargets is ConfigFindFlexibleAreaTargets configFindFlexibleAreaTargets)
			{
				BaseFindTargetsByArea.TargetBoundsLocalToWorld(eb, configFindFlexibleAreaTargets.configFindRange.targetBounds, out bounds, out quaternion, out anchor);
			}
			else if (findTargets is ConfigFindRectInRectTargets configFindRectInRectTargets)
			{
				ConfigFindRectInRectTargets configFindRectInRectTargets2 = findTargets as ConfigFindRectInRectTargets;
				BaseFindTargetsByArea.TargetBoundsLocalToWorld(eb, configFindRectInRectTargets.bounds1, out bounds, out quaternion, out anchor);
				List<FindTargetResult> list = ListPool<FindTargetResult>.Get();
				BaseFindTargetsByArea.FindBoundsTargets(eb, configFindRectInRectTargets2.bounds1, BattleConsts.hitMask, list);
				where.FindTargets(list, default);
				if (list.Count != 0)
				{
					BaseFindTargetsByArea.TargetBoundsLocalToWorld(list[0].entity, configFindRectInRectTargets.bounds2, out var bounds2, out var quaternion2, out var anchor2);
					atk2HitBox.SetActive(bounds2, quaternion2);
					atk2Box.SetActive(bounds2, quaternion2);
					hit2Point.SetActive(anchor2);
				}
				ListPool<FindTargetResult>.Release(list);
			}
			else if (findTargets is ConfigFindWeaponAreaTargets configFindWeaponAreaTargets)
			{
				MonoWeaponPart[] monoWeaponParts = eb.GetMono().GetWeaponPart(configFindWeaponAreaTargets.weaponAreaName).monoWeaponParts;
				bounds = new Bounds(monoWeaponParts[0].transform.position, Vector2.one);
				quaternion = monoWeaponParts[0].transform.rotation;
				anchor = monoWeaponParts[0].transform.position;
				if (Enumerable.Count(lastPos) == 0)
				{
					for (int i = 0; i < monoWeaponParts.Count(); i++)
					{
						Vector2 vector = monoWeaponParts[i].transform.position;
						lastPos.Add(vector);
					}
				}
				else
				{
					for (int j = 0; j < monoWeaponParts.Count(); j++)
					{
						Vector2 vector2 = monoWeaponParts[j].transform.position;
						Debug.DrawLine(vector2, lastPos[j], new Vector4(1f, 0.92f, 0.016f, manager.hitA), manager.hitDuration * 10f);
						lastPos[j] = vector2;
					}
				}
			}
			else
			{
				if (!(findTargets is ConfigFindRayCastTargets configFindRayCastTargets))
				{
					if (findTargets is ConfigFindRayCastRangeTargets)
					{
						return;
					}
					throw new Exception($"Gizmos显示了 {findTargets} 不支持的攻击盒类型,不阻断，也不算bug");
				}
				MonoEntity mono = eb.GetMono();
				Transform rootTransform = eb.GetRootTransform();
				if (!string.IsNullOrEmpty(configFindRayCastTargets.attachPoint))
				{
					AttachPoint attachPointAll = eb.GetMono().GetAttachPointAll(configFindRayCastTargets.attachPoint);
					Vector3 pos = attachPointAll.GetPos();
					bounds = new Bounds(pos, Vector2.one);
					quaternion = attachPointAll.GetRotation();
					anchor = pos + quaternion * configFindRayCastTargets.anchorOffest;
				}
				else
				{
					if (!(configFindRayCastTargets.offset != Vector3.zero))
					{
						return;
					}
					Vector3 vector3 = mono.transform.TransformPoint(configFindRayCastTargets.offset);
					Vector3 vector4 = mono.transform.position + vector3;
					bounds = new Bounds(vector4, Vector2.one);
					quaternion = rootTransform.rotation;
					anchor = vector4 + quaternion * configFindRayCastTargets.anchorOffest;
				}
			}
			atkHitBox.SetActive(bounds, quaternion);
			atkBox.SetActive(bounds, quaternion);
			hitPoint.SetActive(anchor);
		}

		public void Update(DebugWindowManager manager)
		{
			comBox.Update();
			tractionBox.Update();
			atkHitBox.Update();
			hitPoint.Update();
			atk2HitBox.Update();
			hit2Point.Update();
		}

		public bool CheckDie()
		{
			if (atkBox.box.color.a < 0f && comBox.box.color.a < 0f)
			{
				return atkHitBox.box.color.a < 0f;
			}
			return false;
		}

		public void CompensationCompensation(DebugWindowManager manager, Entity eb, CompensationPattern compsation)
		{
			ConfigFindRangeTargets configFindRangeTargets = null;
			TargetBounds targetBounds = default;
			if (compsation is RoleCompensationPattern)
			{
				RoleCompensationPattern obj = compsation as RoleCompensationPattern;
				configFindRangeTargets = obj.roleCompensationRange;
				targetBounds = obj.enemyTractionBounds;
			}
			else if (compsation is CompressCompensationPattern)
			{
				configFindRangeTargets = (compsation as CompressCompensationPattern).compressFindTargets;
			}
			if (configFindRangeTargets != null)
			{
				BaseFindTargetsByArea.TargetBoundsLocalToWorld(eb, configFindRangeTargets.targetBounds, out var bounds, out var quaternion, out var _);
				comBox.SetActive(bounds, quaternion);
			}
			if (targetBounds.size.magnitude != 0f)
			{
				BaseFindTargetsByArea.TargetBoundsLocalToWorld(eb, targetBounds, out var bounds2, out var quaternion2, out var _);
				tractionBox.SetActive(bounds2, quaternion2);
			}
		}
	}

	private WhereTargets where;

	private UnityEngine.Pool.ObjectPool<AttackGizmo> objectPool;

	private Dictionary<ConfigMotion, List<AttackGizmo>> Using = new Dictionary<ConfigMotion, List<AttackGizmo>>();

	private List<AttackGizmo> remove = new List<AttackGizmo>();

	private void OnSwitchIn(FSMRuntimeState next, ConfigMotion ac)
	{
		if (next.state.value.stateType != MotionState.Attack && next.state.value.stateType != MotionState.AirAttackA)
		{
			return;
		}
		List<AttackGizmo> list = ListPool<AttackGizmo>.Get();
		Using.Add(ac, list);
		if (ac.attacks != null)
		{
			AttackPattern[] attacks = ac.attacks;
			for (int i = 0; i < attacks.Length; i++)
			{
				_ = attacks[i];
				AttackGizmo attackGizmo = objectPool.Get();
				attackGizmo.runtimeState = next;
				list.Add(attackGizmo);
			}
		}
	}

	private void OnSwitchOut(FSMRuntimeState next, ConfigMotion ac)
	{
		if (!Using.TryGetValue(ac, out var value))
		{
			return;
		}
		Using.Remove(ac);
		foreach (AttackGizmo item in value)
		{
			remove.Add(item);
		}
		ListPool<AttackGizmo>.Release(value);
	}

	protected override bool OnInit()
	{
		where = new WhereTargets
		{
			alliance = eb.GetAlliance().GetOp(),
			canBeAttack = true
		};
		objectPool = new UnityEngine.Pool.ObjectPool<AttackGizmo>(() => new AttackGizmo(0f, DebugWindowManager.instance.hitBoxThickness, eb), (AttackGizmo e) =>
		{
			e.lastPos = ListPool<Vector3>.Get();
			DebugWindowManager.instance.AddGizmo(eb, e.comBox.box);
			DebugWindowManager.instance.AddGizmo(eb, e.atkBox.box);
			DebugWindowManager.instance.AddGizmo(eb, e.atkHitBox.box);
			DebugWindowManager.instance.AddGizmo(eb, e.hitPoint.anchor);
			DebugWindowManager.instance.AddGizmo(eb, e.atk2Box.box);
			DebugWindowManager.instance.AddGizmo(eb, e.atk2HitBox.box);
			DebugWindowManager.instance.AddGizmo(eb, e.hit2Point.anchor);
			DebugWindowManager.instance.AddGizmo(eb, e.tractionBox.box);
		}, (AttackGizmo e) =>
		{
			ListPool<Vector3>.Release(e.lastPos);
			e.comBox.box.color.a = 0f;
			e.atkBox.box.color.a = 0f;
			e.atkHitBox.box.color.a = 0f;
			e.hitPoint.anchor.color.a = 0f;
			e.atk2Box.box.color.a = 0f;
			e.atk2HitBox.box.color.a = 0f;
			e.hit2Point.anchor.color.a = 0f;
			e.tractionBox.box.color.a = 0f;
			e.runtimeState = null;
			DebugWindowManager.instance.RemoveGizmo(eb, e.comBox.box);
			DebugWindowManager.instance.RemoveGizmo(eb, e.atkBox.box);
			DebugWindowManager.instance.RemoveGizmo(eb, e.atkHitBox.box);
			DebugWindowManager.instance.RemoveGizmo(eb, e.hitPoint.anchor);
			DebugWindowManager.instance.RemoveGizmo(eb, e.atk2Box.box);
			DebugWindowManager.instance.RemoveGizmo(eb, e.atk2HitBox.box);
			DebugWindowManager.instance.RemoveGizmo(eb, e.hit2Point.anchor);
			DebugWindowManager.instance.RemoveGizmo(eb, e.tractionBox.box);
		});
		CompMotion compMotion = eb.GetCompMotion();
		if (compMotion != null)
		{
			compMotion.OnSwitchIn = (Action<FSMRuntimeState, ConfigMotion>)Delegate.Combine(compMotion.OnSwitchIn, new Action<FSMRuntimeState, ConfigMotion>(OnSwitchIn));
			compMotion.OnSwitchOut = (Action<FSMRuntimeState, ConfigMotion>)Delegate.Combine(compMotion.OnSwitchOut, new Action<FSMRuntimeState, ConfigMotion>(OnSwitchOut));
		}
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.BattleCharacterChange, BatlleCharacterChange);
		return true;
	}

	private void BatlleCharacterChange(BaseEventContent obj)
	{
		BattleCharacterChangeEvt battleCharacterChangeEvt = (BattleCharacterChangeEvt)obj;
		EntityBehaveWindowMonitor.DebugBehave(battleCharacterChangeEvt.lastEb);
		EntityBehaveWindowMonitor.DebugBehave(battleCharacterChangeEvt.newEb);
		DebugWindowManager.DebugHitBox(battleCharacterChangeEvt.lastEb);
		DebugWindowManager.DebugHitBox(battleCharacterChangeEvt.newEb);
	}

	protected override void OnRemove()
	{
		if (eb.TryGetCompMotion(out CompMotion component))
		{
			CompMotion compMotion = component;
			compMotion.OnSwitchIn = (Action<FSMRuntimeState, ConfigMotion>)Delegate.Remove(compMotion.OnSwitchIn, new Action<FSMRuntimeState, ConfigMotion>(OnSwitchIn));
			CompMotion compMotion2 = component;
			compMotion2.OnSwitchOut = (Action<FSMRuntimeState, ConfigMotion>)Delegate.Remove(compMotion2.OnSwitchOut, new Action<FSMRuntimeState, ConfigMotion>(OnSwitchOut));
			Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.BattleCharacterChange, BatlleCharacterChange);
		}
	}

	public override void OnUpdate()
	{
		if (DebugWindowManager.instance.debugCompensationTraceGizmos || DebugWindowManager.instance.debugAttackBoxGizmos)
		{
			eb.GetCompTransform();
			foreach (List<AttackGizmo> value in Using.Values)
			{
				for (int i = 0; i < value.Count; i++)
				{
					AttackGizmo attackGizmo = value[i];
					FSMRuntimeState runtimeState = attackGizmo.runtimeState;
					ConfigMotion configMotion = attackGizmo.configMotion;
					if (DebugWindowManager.instance.debugCompensationTraceGizmos && attackGizmo.configMotion.compensations != null)
					{
						for (int j = 0; j < attackGizmo.configMotion.compensations.Length; j++)
						{
							CompensationPattern compensationPattern = configMotion.compensations[j];
							if (compensationPattern != null)
							{
								CompensationPattern compsation = compensationPattern;
								attackGizmo.CompensationCompensation(DebugWindowManager.instance, eb, compsation);
							}
						}
					}
					if (DebugWindowManager.instance.debugAttackBoxGizmos && configMotion.attacks.Length > i)
					{
						AttackPattern attackPattern = configMotion.attacks[i];
						if (attackPattern is AreaAttackPattern areaAttackPattern && runtimeState.DoByPercentPeriod(attackPattern.time, attackPattern.end, mustDo: false, areaAttackPattern.CanDoPeriod()))
						{
							attackGizmo.Attack(DebugWindowManager.instance, eb, where, areaAttackPattern);
						}
					}
					attackGizmo.Update(DebugWindowManager.instance);
				}
			}
		}
		for (int num = remove.Count - 1; num >= 0; num--)
		{
			AttackGizmo attackGizmo2 = remove[num];
			attackGizmo2.atkBox.Update();
			attackGizmo2.atk2Box.Update();
			attackGizmo2.Update(DebugWindowManager.instance);
			if (attackGizmo2.CheckDie())
			{
				remove.Remove(attackGizmo2);
				objectPool.Release(attackGizmo2);
			}
		}
	}
}
