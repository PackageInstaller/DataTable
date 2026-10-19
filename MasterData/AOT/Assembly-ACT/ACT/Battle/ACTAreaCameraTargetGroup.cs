using Bamboo.ECS;
using Cinemachine;
using UnityEngine;

namespace ACT.Battle;

[AddComponentMenu("4战斗相关组件/区域相机Target组")]
public class ACTAreaCameraTargetGroup : CinemachineTargetGroup
{
	public enum GroupComposition
	{
		PlayerAndBoss,
		PlayerAndScenePoint
	}

	public enum GroupMemberFilter
	{
		BossOnly,
		BossAndElite,
		IncludeMonster
	}

	public GroupComposition composition;

	public GroupMemberFilter memberFilter;

	private static readonly Collider[] s_OverlapCache = new Collider[32];

	public void BindFromArea(Collider areaCollider)
	{
		BindPlayer();
		if (composition == GroupComposition.PlayerAndScenePoint)
		{
			TryBindScenePoint(areaCollider);
		}
		else
		{
			BindMonstersInArea(areaCollider);
		}
	}

	public void BindPlayer()
	{
		CameraPlayerWrapper cameraPlayerWrapper = GameManager.cameraSystem?.CameraPlayerWrapper;
		if ((bool)cameraPlayerWrapper)
		{
			BindSlot(CameraFollowTargertType.player, cameraPlayerWrapper.transform, replaceExisting: true, 0);
		}
	}

	public void TryBindMonster(Entity entity)
	{
		if (composition == GroupComposition.PlayerAndBoss && Accepts(entity))
		{
			Transform modelTrans = entity.GetModelTrans();
			if ((bool)modelTrans)
			{
				BindSlot(CameraFollowTargertType.monster, modelTrans, replaceExisting: false, 1);
			}
		}
	}

	public void TryBindScenePoint(Collider areaCollider)
	{
		if (composition == GroupComposition.PlayerAndScenePoint)
		{
			AreaCameraTargetPoint areaCameraTargetPoint = AreaCameraTargetPoint.FindInBounds(areaCollider ? areaCollider.bounds : default(Bounds));
			if ((bool)areaCameraTargetPoint)
			{
				BindSlot(CameraFollowTargertType.monster, areaCameraTargetPoint.transform, replaceExisting: true, 1);
			}
		}
	}

	public static void RefreshPlayerSlot(CinemachineTargetGroup targetGroup)
	{
		if (!targetGroup)
		{
			return;
		}
		if (targetGroup is ACTAreaCameraTargetGroup aCTAreaCameraTargetGroup)
		{
			aCTAreaCameraTargetGroup.BindPlayer();
			return;
		}
		CameraPlayerWrapper cameraPlayerWrapper = GameManager.cameraSystem?.CameraPlayerWrapper;
		if (!cameraPlayerWrapper || targetGroup.m_Targets == null || targetGroup.m_Targets.Length == 0)
		{
			return;
		}
		bool flag = false;
		for (int i = 0; i < targetGroup.m_Targets.Length; i++)
		{
			if (targetGroup.m_Targets[i].cameraFollowTargertType == CameraFollowTargertType.player)
			{
				targetGroup.m_Targets[i].target = cameraPlayerWrapper.transform;
				flag = true;
				break;
			}
		}
		if (!flag)
		{
			targetGroup.m_Targets[0].target = cameraPlayerWrapper.transform;
		}
	}

	public bool Accepts(Entity entity)
	{
		if (!entity.IsValid || !entity.IsMonster())
		{
			return false;
		}
		EntityType entityType = entity.GetEntityType();
		switch (memberFilter)
		{
		case GroupMemberFilter.BossOnly:
			return entityType == EntityType.Boss;
		case GroupMemberFilter.BossAndElite:
			if (entityType != EntityType.Boss)
			{
				return entityType == EntityType.Elite;
			}
			return true;
		case GroupMemberFilter.IncludeMonster:
			if (entityType != EntityType.Boss && entityType != EntityType.Elite)
			{
				return entityType == EntityType.Monster;
			}
			return true;
		default:
			return false;
		}
	}

	private void BindMonstersInArea(Collider areaCollider)
	{
		if (!areaCollider)
		{
			return;
		}
		Bounds bounds = areaCollider.bounds;
		int num = Physics.OverlapBoxNonAlloc(bounds.center, bounds.extents, s_OverlapCache, Quaternion.identity, BattleConsts.entityMask, QueryTriggerInteraction.Collide);
		for (int i = 0; i < num; i++)
		{
			Collider collider = s_OverlapCache[i];
			if ((bool)collider)
			{
				MonoEntity componentInParent = collider.GetComponentInParent<MonoEntity>();
				if (!(componentInParent == null) && componentInParent.entity.IsValid)
				{
					TryBindMonster(componentInParent.entity);
				}
			}
		}
	}

	private void BindSlot(CameraFollowTargertType followType, Transform target, bool replaceExisting, int fallbackIndex)
	{
		if (!target || m_Targets == null || m_Targets.Length == 0 || ContainsTarget(target))
		{
			return;
		}
		int num = 0;
		for (int i = 0; i < m_Targets.Length; i++)
		{
			if (m_Targets[i].cameraFollowTargertType == followType)
			{
				num++;
				if (!(m_Targets[i].target != null) || replaceExisting)
				{
					m_Targets[i].target = target;
					return;
				}
			}
		}
		if (num == 0 && fallbackIndex >= 0 && fallbackIndex < m_Targets.Length && ((m_Targets[fallbackIndex].target == null) | replaceExisting))
		{
			m_Targets[fallbackIndex].target = target;
		}
	}

	private bool ContainsTarget(Transform target)
	{
		for (int i = 0; i < m_Targets.Length; i++)
		{
			if (m_Targets[i].target == target)
			{
				return true;
			}
		}
		return false;
	}
}
