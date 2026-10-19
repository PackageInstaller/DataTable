using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Battle.Configs;
using ACT.Event;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;
using UnityEngine.Pool;

namespace ACT.DebugGUI;

public class FindRangeAreaMonitor : EntityBehaveHitBoxAbMonitor
{
	private enum GizmosShapeType
	{
		Cube,
		SectorCylinder
	}

	private List<HitBoxMonitor.AttackGizmo.HitBoxGizmo> m_CurrentBoxes;

	protected override bool OnInit()
	{
		m_CurrentBoxes = CollectionPool<List<HitBoxMonitor.AttackGizmo.HitBoxGizmo>, HitBoxMonitor.AttackGizmo.HitBoxGizmo>.Get();
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.DebugGizmo_DrawFindTargetBounds, OnFindTarget);
		return base.OnInit();
	}

	protected override void OnRemove()
	{
		CollectionPool<List<HitBoxMonitor.AttackGizmo.HitBoxGizmo>, HitBoxMonitor.AttackGizmo.HitBoxGizmo>.Release(m_CurrentBoxes);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.DebugGizmo_DrawFindTargetBounds, OnFindTarget);
	}

	private void OnFindTarget(BaseEventContent obj)
	{
		if (!DebugWindowManager.instance.debugAbilityBoxGizmos || !(obj is FindTargetEvent findTargetEvent))
		{
			return;
		}
		try
		{
			if (eb.IsAlive())
			{
				WhereTargets whereTargets = new WhereTargets
				{
					alliance = eb.GetAlliance().GetOp(),
					canBeAttack = true
				};
				Entity owner = findTargetEvent.owner;
				if (DebugWindowManager.instance.debugAbilityBoxGizmos && (owner.IsBehaveEntity() || owner.IsTrajectory()))
				{
					Attack(DebugWindowManager.instance, findTargetEvent.owner, whereTargets, findTargetEvent.findTargets);
				}
			}
		}
		catch (Exception message)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.Log(message);
			}
		}
	}

	public void Attack(DebugWindowManager manager, Entity eb, WhereTargets where, BaseFindTargets findTarget)
	{
		TargetSectorBounds sectorBounds = default;
		HitBoxMonitor.AttackGizmo.GizmosShapeType shapeType = HitBoxMonitor.AttackGizmo.GizmosShapeType.Cube;
		Bounds bounds;
		Quaternion quaternion;
		Vector3 anchor;
		if (findTarget is ConfigFindRangeTargets configFindRangeTargets)
		{
			BaseFindTargetsByArea.TargetBoundsLocalToWorld(eb, configFindRangeTargets.targetBounds, out bounds, out quaternion, out anchor);
		}
		if (findTarget is ConfigFindRangeSectorTargets configFindRangeSectorTargets)
		{
			BaseFindTargetsByArea.TargetBoundsLocalToWorld(eb, configFindRangeSectorTargets.targetSectorBounds, out bounds, out quaternion, out anchor);
			sectorBounds = configFindRangeSectorTargets.targetSectorBounds;
			shapeType = HitBoxMonitor.AttackGizmo.GizmosShapeType.SectorCylinder;
		}
		else if (findTarget is ConfigFindFlexibleAreaTargets configFindFlexibleAreaTargets)
		{
			BaseFindTargetsByArea.TargetBoundsLocalToWorld(eb, configFindFlexibleAreaTargets.configFindRange.targetBounds, out bounds, out quaternion, out anchor);
		}
		else if (findTarget is ConfigFindRectInRectTargets configFindRectInRectTargets)
		{
			ConfigFindRectInRectTargets configFindRectInRectTargets2 = findTarget as ConfigFindRectInRectTargets;
			BaseFindTargetsByArea.TargetBoundsLocalToWorld(eb, configFindRectInRectTargets.bounds1, out bounds, out quaternion, out anchor);
			List<FindTargetResult> list = ListPool<FindTargetResult>.Get();
			BaseFindTargetsByArea.FindBoundsTargets(eb, configFindRectInRectTargets2.bounds1, BattleConsts.hitMask, list);
			where.FindTargets(list, default);
			if (list.Count != 0)
			{
				BaseFindTargetsByArea.TargetBoundsLocalToWorld(list[0].entity, configFindRectInRectTargets.bounds2, out var bounds2, out var quaternion2, out var anchor2);
				HitBoxMonitor.AttackGizmo.HitBoxGizmo hitBoxGizmo = new HitBoxMonitor.AttackGizmo.HitBoxGizmo(Color.green, isWire: false);
				HitBoxMonitor.AttackGizmo.HitBoxGizmo hitBoxGizmo2 = new HitBoxMonitor.AttackGizmo.HitBoxGizmo(Color.green, isWire: false);
				HitBoxMonitor.AttackGizmo.HitAnchorGizmo hitAnchorGizmo = new HitBoxMonitor.AttackGizmo.HitAnchorGizmo(Color.green);
				hitBoxGizmo.SetActive(bounds2, quaternion2);
				hitBoxGizmo2.SetActive(bounds2, quaternion2);
				hitAnchorGizmo.SetActive(anchor2);
			}
			ListPool<FindTargetResult>.Release(list);
		}
		else if (findTarget is ConfigFindWeaponAreaTargets)
		{
			ConfigFindWeaponAreaTargets configFindWeaponAreaTargets = findTarget as ConfigFindWeaponAreaTargets;
			MonoWeaponPart[] monoWeaponParts = eb.GetMono().GetWeaponPart(configFindWeaponAreaTargets.weaponAreaName).monoWeaponParts;
			bounds = new Bounds(monoWeaponParts[0].transform.position, Vector2.one);
			quaternion = monoWeaponParts[0].transform.rotation;
		}
		else
		{
			if (!(findTarget is ConfigFindRayCastTargets configFindRayCastTargets))
			{
				throw new Exception("不支持的攻击盒类型");
			}
			MonoEntity mono = eb.GetMono();
			if (!string.IsNullOrEmpty(configFindRayCastTargets.attachPoint))
			{
				AttachPoint attachPointAll = mono.GetAttachPointAll(configFindRayCastTargets.attachPoint);
				Vector3 pos = attachPointAll.GetPos();
				attachPointAll.GetForward();
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
				Vector3 vector = mono.transform.TransformPoint(configFindRayCastTargets.offset);
				Vector3 vector2 = mono.transform.position + vector;
				Transform rootTransform = eb.GetRootTransform();
				_ = rootTransform.rotation * Quaternion.Euler(configFindRayCastTargets.directionOffset) * Vector3.forward;
				bounds = new Bounds(vector2, Vector2.one);
				quaternion = rootTransform.rotation;
				anchor = vector2 + quaternion * configFindRayCastTargets.anchorOffest;
			}
		}
		HitBoxMonitor.AttackGizmo.HitBoxGizmo item = new HitBoxMonitor.AttackGizmo.HitBoxGizmo(new Color(0f, 0f, 1f, 0.02f), isWire: false, isCompensation: false, shapeType);
		item.SetActive(item.box, bounds, quaternion);
		if (item.shapeType == HitBoxMonitor.AttackGizmo.GizmosShapeType.SectorCylinder && item.box is DebugGizmoSectorCylinder debugGizmoSectorCylinder)
		{
			debugGizmoSectorCylinder.UpdateGizmoMesh(sectorBounds);
		}
		manager.AddGizmo(item.box);
		m_CurrentBoxes.Add(item);
	}

	public override void OnUpdate()
	{
		if (m_CurrentBoxes.Count >= 20 && LuminApplication.LogEnabled)
		{
			Debug.LogWarning($"当前FindTargetBox数量为{m_CurrentBoxes.Count}是不是有点多了？");
		}
		for (int num = m_CurrentBoxes.Count - 1; num >= 0; num--)
		{
			if (m_CurrentBoxes[num].box.color.a <= 0f)
			{
				DebugWindowManager.instance.RemoveGizmo(m_CurrentBoxes[num].box);
				m_CurrentBoxes.Remove(m_CurrentBoxes[num]);
			}
			else
			{
				m_CurrentBoxes[num].Update();
			}
		}
	}
}
