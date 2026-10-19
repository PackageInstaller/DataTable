using System.Collections.Generic;
using ACT.Utility;
using Bamboo.Collections;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("查找射线检测范围目标", "FindTargets", new string[] { "find", "raycast", "range", "targets" })]
public class ConfigFindRayCastRangeTargets : BaseFindTargetsByRayCast
{
	private struct ReplenishAABB
	{
		public Vector3 center;

		public Vector3 extents;

		public Quaternion quaternion;

		public Vector3 pos;

		public bool dataInit;
	}

	public Vector2 size = new Vector2(2f, 0.1f);

	public Vector2 enviromentSize = new Vector2(2f, 0.1f);

	public bool blockByEnemy;

	public FilterEntityType filterEntityType;

	public AllianceCondition allianceCondition;

	public int replenishRayCastCount;

	public bool useAttachCurve;

	public bool enableReflect;

	[Min(1f)]
	public int maxReflectCount = 1;

	[Tooltip("平台跳跃游戏中，将反射方向和位置约束在角色所在Z平面上")]
	public bool projectToZPlane;

	[Tooltip("保存射线路径到 rayHitName 供特效使用，不填则不输出")]
	public string rayHitName;

	private ReplenishAABB _mCurReplenishAABB;

	private ReplenishAABB _mLastReplenishAABB;

	[HideInInspector]
	public float hitDis;

	private const float kMinSegment = 0.005f;

	private const float kEpsilonPush = 0.02f;

	public override void FindTargets(Entity referenceEntity, List<FindTargetResult> results)
	{
		if (enableReflect)
		{
			FindTargetsReflect(referenceEntity, results);
		}
		else
		{
			FindTargetsOriginal(referenceEntity, results);
		}
	}

	private void FindTargetsOriginal(Entity referenceEntity, List<FindTargetResult> results)
	{
		BSet<FindTargetResult> bSet = BSetPool<FindTargetResult>.Default.Get(results.Count);
		hitDis = distance;
		var (vector, quaternion, vector2, anchor) = GetEmissionPointInfo(referenceEntity, useAttachCurve);
		if (Physics.BoxCast(vector, enviromentSize / 2f, vector2, out var hitInfo, quaternion, hitDis, BattleConsts.enviromentMask))
		{
			hitDis = hitInfo.distance;
		}
		Vector3 center = vector + vector2 * hitDis / 2f;
		new Vector3(enviromentSize.x, enviromentSize.y, hitDis);
		Collider[] cacheColliders = PhysicsUtility.cacheColliders;
		Vector3 vector3 = new Vector3(size.x, size.y, hitDis + 0.25f);
		int num = Physics.OverlapBoxNonAlloc(center, vector3 / 2f, cacheColliders, quaternion, BattleConsts.hitMask);
		_mCurReplenishAABB.center = center;
		_mCurReplenishAABB.extents = vector3;
		_mCurReplenishAABB.quaternion = quaternion;
		_mCurReplenishAABB.pos = vector;
		_mCurReplenishAABB.dataInit = true;
		if (num > 0)
		{
			if (!blockByEnemy)
			{
				for (int i = 0; i < num; i++)
				{
					BaseFindTargetsByArea.AddTargetByCollider(anchor, cacheColliders[i], bSet);
				}
			}
			else
			{
				float num2 = float.MaxValue;
				Collider collider = null;
				for (int j = 0; j < num; j++)
				{
					var (flag, result) = BaseFindTargetsByArea.GetResult(anchor, cacheColliders[j], Vector3.zero);
					if (flag && Check(result))
					{
						float num3 = Vector3.Distance(vector, cacheColliders[j].ClosestPoint(vector));
						if (num3 < num2)
						{
							num2 = num3;
							collider = cacheColliders[j];
						}
					}
				}
				if (collider != null)
				{
					BaseFindTargetsByArea.AddTargetByCollider(anchor, collider, bSet);
				}
			}
		}
		if (replenishRayCastCount > 0 && _mLastReplenishAABB.dataInit)
		{
			for (int k = 1; k <= replenishRayCastCount; k++)
			{
				float t = (float)k / (float)(replenishRayCastCount + 1);
				Vector3 vector4 = Vector3.Lerp(_mLastReplenishAABB.pos, _mCurReplenishAABB.pos, t);
				Vector3 center2 = Vector3.Lerp(_mLastReplenishAABB.center, _mCurReplenishAABB.center, t);
				Quaternion orientation = Quaternion.Slerp(_mLastReplenishAABB.quaternion, _mCurReplenishAABB.quaternion, t);
				Vector3 vector5 = Vector3.Lerp(_mLastReplenishAABB.extents, _mCurReplenishAABB.extents, t);
				Collider[] cacheColliders2 = PhysicsUtility.cacheColliders;
				int num4 = Physics.OverlapBoxNonAlloc(center2, vector5 / 2f, cacheColliders2, orientation, BattleConsts.hitMask);
				if (num4 > 0)
				{
					if (!blockByEnemy)
					{
						for (int l = 0; l < num4; l++)
						{
							BaseFindTargetsByArea.AddTargetByCollider(anchor, cacheColliders2[l], bSet);
						}
					}
					else
					{
						float num5 = float.MaxValue;
						Collider collider2 = null;
						for (int m = 0; m < num4; m++)
						{
							Collider collider3 = cacheColliders2[m];
							var (flag2, findTargetResult) = BaseFindTargetsByArea.GetResult(anchor, collider3, Vector3.zero);
							if (flag2 && Check2(findTargetResult.entity))
							{
								float num6 = Vector3.Distance(vector4, collider3.ClosestPoint(vector4));
								if (num6 < num5)
								{
									num5 = num6;
									collider2 = collider3;
								}
							}
						}
						if (collider2 != null)
						{
							BaseFindTargetsByArea.AddTargetByCollider(anchor, collider2, bSet);
						}
					}
				}
				PhysicsUtility.Release(cacheColliders2);
			}
		}
		_mLastReplenishAABB = _mCurReplenishAABB;
		bSet.Compress();
		foreach (FindTargetResult item in bSet)
		{
			if (Check3(item))
			{
				results.Add(item);
			}
		}
		PhysicsUtility.Release(cacheColliders);
		BSetPool<FindTargetResult>.Default.Recycle(bSet);
		if (!string.IsNullOrEmpty(rayHitName))
		{
			Vector3 endPos = vector + vector2 * hitDis;
			referenceEntity.GetCompEffect().rayEffectInfos[rayHitName] = new RayHitEffectInfo
			{
				startPos = vector,
				endPos = endPos
			};
		}
		bool Check(FindTargetResult findTargetResult2)
		{
			if (findTargetResult2.damageable != null)
			{
				return true;
			}
			Entity entity = findTargetResult2.entity;
			if (!entity.IsValid)
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError("collider的MonoEntity中的entity为空，无法判断 entity 的类别和阵营");
				}
				return false;
			}
			if (!entity.IsLogicAvailable())
			{
				return false;
			}
			if ((entity.GetCompAlliance().alliance & GameUtility.GetAlliance(allianceCondition, referenceEntity.GetCompAlliance().alliance)) == 0)
			{
				return false;
			}
			if (!filterEntityType.HasEntityType(entity.GetEntityType()))
			{
				return false;
			}
			if (!entity.IsAlive())
			{
				return false;
			}
			return true;
		}
		bool Check2(Entity target)
		{
			if (target == null)
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError("collider的MonoEntity中的entity为空，无法判断 entity 的类别和阵营");
				}
				return false;
			}
			if (!target.IsLogicAvailable())
			{
				return false;
			}
			if ((target.GetCompAlliance().alliance & GameUtility.GetAlliance(allianceCondition, referenceEntity.GetCompAlliance().alliance)) == 0)
			{
				return false;
			}
			if (!filterEntityType.HasEntityType(target.GetEntityType()))
			{
				return false;
			}
			return true;
		}
		bool Check3(FindTargetResult findTargetResult2)
		{
			if (findTargetResult2.damageable != null)
			{
				return true;
			}
			Entity entity = findTargetResult2.entity;
			if (entity == null)
			{
				if (LuminApplication.LogEnabled)
				{
					Debug.LogError("collider的MonoEntity中的entity为空，无法判断 entity 的类别和阵营");
				}
				return false;
			}
			if (!entity.IsLogicAvailable())
			{
				return false;
			}
			if ((entity.GetCompAlliance().alliance & GameUtility.GetAlliance(allianceCondition, referenceEntity.GetCompAlliance().alliance)) == 0)
			{
				return false;
			}
			if (!filterEntityType.HasEntityType(entity.GetEntityType()))
			{
				return false;
			}
			return true;
		}
	}

	private void FindTargetsReflect(Entity referenceEntity, List<FindTargetResult> results)
	{
		BSet<FindTargetResult> bSet = BSetPool<FindTargetResult>.Default.Get(results.Count);
		(Vector3 pos, Quaternion rot, Vector3 forward, Vector3 anchor) emissionPointInfo = GetEmissionPointInfo(referenceEntity, useAttachCurve);
		Vector3 item = emissionPointInfo.pos;
		Quaternion item2 = emissionPointInfo.rot;
		Vector3 item3 = emissionPointInfo.forward;
		Vector3 item4 = emissionPointInfo.anchor;
		Vector3 vector = item;
		Vector3 vector2 = item3;
		Quaternion orientation = item2;
		int num = 0;
		float num2 = distance;
		float z = item.z;
		if (projectToZPlane)
		{
			vector2.z = 0f;
			if (vector2.sqrMagnitude < 1E-06f)
			{
				vector2 = Vector3.right;
			}
			vector2.Normalize();
			vector.z = z;
			orientation = Quaternion.LookRotation(vector2);
		}
		List<Vector3> list = new List<Vector3>(maxReflectCount + 2);
		list.Add(vector);
		Vector2 vector3 = enviromentSize / 2f;
		while (num2 > 0.01f)
		{
			float num3 = num2;
			bool flag = Physics.BoxCast(vector, vector3, vector2, out var hitInfo, orientation, num2);
			flag &= hitInfo.collider != null && hitInfo.collider.CompareTag("Reflective");
			if (flag)
			{
				num3 = hitInfo.distance;
			}
			Vector3 center = vector + vector2 * num3 / 2f;
			Vector3 vector4 = new Vector3(size.x, size.y, num3 + 0.25f);
			Collider[] cacheColliders = PhysicsUtility.cacheColliders;
			int num4 = Physics.OverlapBoxNonAlloc(center, vector4 / 2f, cacheColliders, orientation, BattleConsts.hitMask);
			if (num4 > 0)
			{
				if (!blockByEnemy)
				{
					for (int i = 0; i < num4; i++)
					{
						BaseFindTargetsByArea.AddTargetByCollider(item4, cacheColliders[i], bSet);
					}
				}
				else
				{
					float num5 = float.MaxValue;
					Collider collider = null;
					for (int j = 0; j < num4; j++)
					{
						var (flag2, result) = BaseFindTargetsByArea.GetResult(item4, cacheColliders[j], Vector3.zero);
						if (flag2 && CheckTarget(result, referenceEntity))
						{
							float num6 = Vector3.Distance(vector, cacheColliders[j].ClosestPoint(vector));
							if (num6 < num5)
							{
								num5 = num6;
								collider = cacheColliders[j];
							}
						}
					}
					if (collider != null)
					{
						BaseFindTargetsByArea.AddTargetByCollider(item4, collider, bSet);
					}
				}
			}
			PhysicsUtility.Release(cacheColliders);
			if (flag && hitInfo.collider != null && hitInfo.collider.CompareTag("Reflective") && num < maxReflectCount && Vector3.Dot(-vector2, hitInfo.normal) > 0.087f)
			{
				float num7 = Mathf.Max(0f, num3);
				Vector3 vector5 = vector + vector2 * num7;
				Vector3 vector6 = Vector3.Reflect(vector2, hitInfo.normal).normalized;
				if (projectToZPlane)
				{
					vector5.z = z;
					vector6.z = 0f;
					if (vector6.sqrMagnitude < 1E-06f)
					{
						vector6 = Vector3.right;
					}
					vector6.Normalize();
				}
				if (num7 <= 0.005f)
				{
					vector = vector5 + vector6 * 0.02f;
					num2 -= 0.02f;
					if (num2 <= 0f)
					{
						list.Add(vector);
						break;
					}
					vector2 = vector6;
					orientation = Quaternion.LookRotation(vector2);
				}
				else
				{
					if ((vector5 - list[list.Count - 1]).sqrMagnitude > 1E-08f)
					{
						list.Add(vector5);
					}
					num2 -= num3;
					vector = vector5 + vector6 * 0.01f;
					vector2 = vector6;
					orientation = Quaternion.LookRotation(vector2);
					num++;
				}
				continue;
			}
			Vector3 item5 = vector + vector2 * num3;
			if (projectToZPlane)
			{
				item5.z = z;
			}
			list.Add(item5);
			break;
		}
		hitDis = Vector3.Distance(item, (list.Count > 1) ? list[1] : list[0]);
		bSet.Compress();
		foreach (FindTargetResult item6 in bSet)
		{
			if (CheckTarget(item6, referenceEntity))
			{
				results.Add(item6);
			}
		}
		BSetPool<FindTargetResult>.Default.Recycle(bSet);
		if (!string.IsNullOrEmpty(rayHitName))
		{
			referenceEntity.GetCompEffect().rayEffectInfos[rayHitName] = new RayHitEffectInfo
			{
				startPos = list[0],
				endPos = list[list.Count - 1],
				reflectPathPoints = list
			};
		}
	}

	private bool CheckTarget(FindTargetResult result, Entity referenceEntity)
	{
		if (result.damageable != null)
		{
			return true;
		}
		Entity entity = result.entity;
		if (!entity.IsLogicAvailable() || (entity.GetAlliance() & GameUtility.GetAlliance(allianceCondition, referenceEntity.GetAlliance())) == 0 || !filterEntityType.HasEntityType(entity.GetEntityType()) || !entity.IsAlive())
		{
			return false;
		}
		return true;
	}

	public override void OnInit()
	{
		_mCurReplenishAABB = (_mLastReplenishAABB = default);
	}
}
