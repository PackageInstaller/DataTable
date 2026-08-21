using System.Collections.Generic;
using GameFramework;
using UnityEngine;
using UnityEngine.AI;
using UnityEngine.Pool;

namespace Ase.ECS;

public class VolumeSystem : BaseSystem
{
	private Dictionary<int, List<HitVolume>> _hitVolumes;

	private Dictionary<int, HitVolume> bulletHitVolumes;

	private List<HitVolume> wallVolumes;

	private List<int> cacheRemoveId = new List<int>();

	private double Epsilon = 0.0001;

	protected override bool IsLogicSystem => true;

	public override void OnInit(object data = null)
	{
		base.OnInit(data);
		_hitVolumes = new Dictionary<int, List<HitVolume>>();
		bulletHitVolumes = new Dictionary<int, HitVolume>();
		wallVolumes = new List<HitVolume>();
	}

	public override void OnStart(object data = null)
	{
	}

	private void InitWallVolumes()
	{
		IEnumerable<NavMeshSurface> navMeshSurfaces = GetSystem<PathfindingSystem>().GetNavMeshSurfaces();
		if (navMeshSurfaces == null)
		{
			return;
		}
		foreach (NavMeshSurface item2 in navMeshSurfaces)
		{
			List<BoxCollider> list = CollectionPool<List<BoxCollider>, BoxCollider>.Get();
			((Component)(object)item2).gameObject.GetComponentsInChildren(list);
			foreach (BoxCollider item3 in list)
			{
				HitVolume item = HitVolume.CreateNormal("wall", ((Component)(object)item3).transform.position, ((Component)(object)item3).transform.rotation, VolumeData.Create(item3.center, Vector3.zero, PrimitiveEnum.BoxPrimitive, new List<float>
				{
					item3.size.x * ((Component)(object)item3).transform.localScale.x,
					item3.size.y * ((Component)(object)item3).transform.localScale.y,
					item3.size.z * ((Component)(object)item3).transform.localScale.z
				}));
				wallVolumes.Add(item);
			}
			CollectionPool<List<BoxCollider>, BoxCollider>.Release(list);
		}
	}

	public void RegisterHitVolume(BaseEntity ownerEntity, Dictionary<string, VolumeData> datas)
	{
		if (datas.Count <= 0)
		{
			return;
		}
		if (_hitVolumes.TryGetValue(ownerEntity.Id, out var value))
		{
			_hitVolumes.Remove(ownerEntity.Id);
			for (int i = 0; i < value.Count; i++)
			{
				ReferencePool.Release(value[i]);
			}
		}
		value = new List<HitVolume>();
		foreach (KeyValuePair<string, VolumeData> data in datas)
		{
			HitVolume item = HitVolume.Create(ownerEntity, data.Key, data.Value);
			value.Add(item);
		}
		_hitVolumes.Add(ownerEntity.Id, value);
	}

	public void SetHitVolumeEnable(int entityId, string key, bool enable)
	{
		if (_hitVolumes.TryGetValue(entityId, out var value))
		{
			value?.Find((HitVolume b) => b.Key == key)?.SetEnable(enable);
		}
	}

	public override void OnFixedUpdate(WorldUpdateType updateType, float deltaTime)
	{
		Dictionary<int, List<HitVolume>>.Enumerator enumerator = _hitVolumes.GetEnumerator();
		while (enumerator.MoveNext())
		{
			for (int i = 0; i < enumerator.Current.Value.Count; i++)
			{
				enumerator.Current.Value[i].OnUpdate(deltaTime);
			}
		}
		enumerator.Dispose();
	}

	public override void OnFixedUpdateAfter(WorldUpdateType updateType)
	{
		base.OnFixedUpdateAfter(updateType);
		ReleaseDeadEntity();
		Dictionary<int, List<HitVolume>>.Enumerator enumerator = _hitVolumes.GetEnumerator();
		while (enumerator.MoveNext())
		{
			BaseEntity entity = GetSystem<EntitySystem>().GetEntity(enumerator.Current.Key);
			if (entity != null && entity.IsSurvival)
			{
				entity.GetComponent<HitColliderComponent>()?.OnUpdateVolumesAfter();
			}
		}
		enumerator.Dispose();
	}

	public void UnRegisterHitVolume(int id)
	{
		cacheRemoveId.Add(id);
	}

	public bool IsIntersect(BaseVolume v1, BaseVolume v2)
	{
		if (!v1.Enable || !v2.Enable)
		{
			return false;
		}
		bool num = PrimitiveSystem.IsIntersect(v1.Primitive, v2.Primitive);
		if (num)
		{
			v2.TransferHit(v1.OwnerId);
		}
		return num;
	}

	public bool IsIntersect(int attackerId, int targetId)
	{
		_hitVolumes.TryGetValue(attackerId, out var value);
		_hitVolumes.TryGetValue(targetId, out var value2);
		if (value == null || value2 == null)
		{
			return false;
		}
		bool flag = false;
		for (int i = 0; i < value.Count; i++)
		{
			for (int j = 0; j < value2.Count; j++)
			{
				if (IsIntersect(value[i], value2[j]) && !flag)
				{
					flag = true;
				}
			}
		}
		return flag;
	}

	public bool IsIntersect(HitVolume v1, int targetId)
	{
		_hitVolumes.TryGetValue(targetId, out var value);
		if (v1 == null || value == null)
		{
			return false;
		}
		bool flag = false;
		for (int i = 0; i < value.Count; i++)
		{
			if (IsIntersect(v1, value[i]) && !flag)
			{
				flag = true;
			}
		}
		return flag;
	}

	public void NormalVolumeLog(HitVolume v1, int targetId)
	{
		_hitVolumes.TryGetValue(targetId, out var _);
	}

	public void AdjustHeroCapsuleVolume(int entityId, float radius)
	{
		_hitVolumes.TryGetValue(entityId, out var value);
		if (value != null)
		{
			for (int i = 0; i < value.Count; i++)
			{
				value[i].AdjustCapsuleRadius(radius);
			}
		}
	}

	public bool IsAlertIntersect(HitVolume v1, int targetId)
	{
		_hitVolumes.TryGetValue(targetId, out var value);
		if (v1 == null || value == null)
		{
			return false;
		}
		bool flag = false;
		for (int i = 0; i < value.Count; i++)
		{
			if (IsAlertIntersect(v1, value[i]) && !flag)
			{
				flag = true;
			}
		}
		return flag;
	}

	private bool IsAlertIntersect(HitVolume v1, HitVolume v2)
	{
		if (!v1.Enable || !v2.Enable)
		{
			return false;
		}
		bool num = PrimitiveSystem.IsIntersect(v1.Primitive, v2.Primitive);
		if (num)
		{
			v2.TransferAlertHit(v1.OwnerId);
		}
		return num;
	}

	public List<HitVolume> GetEntityVolumes(int entityId)
	{
		_hitVolumes.TryGetValue(entityId, out var value);
		return value;
	}

	public HitVolume GetEntityVolume(int entityId, string key, bool ignoreEnabled = false)
	{
		if (!_hitVolumes.TryGetValue(entityId, out var value))
		{
			return null;
		}
		for (int i = 0; i < value.Count; i++)
		{
			HitVolume hitVolume = value[i];
			if (hitVolume.Key == key)
			{
				if (ignoreEnabled)
				{
					return hitVolume;
				}
				if (hitVolume.Enable)
				{
					return hitVolume;
				}
			}
		}
		return null;
	}

	public HitVolume GetClosestVolume(Vector3 point, int entityId, Dictionary<string, HitColliderVariableData> variableDatas)
	{
		if (!_hitVolumes.TryGetValue(entityId, out var value))
		{
			return null;
		}
		int num = 0;
		for (int i = 0; i < value.Count; i++)
		{
			if (value[i].Enable)
			{
				float num2 = Vector3.SqrMagnitude(value[num].PrimitiveInfo.Center - point).FloorRound();
				float num3 = Vector3.SqrMagnitude(value[i].PrimitiveInfo.Center - point).FloorRound();
				if (num2 > num3)
				{
					num = i;
				}
				else if (Mathf.Abs(num2 - num3) < 0.0001f)
				{
					num = ((variableDatas[value[i].Key].Weight > variableDatas[value[num].Key].Weight) ? i : num);
				}
			}
		}
		return value[num];
	}

	public string GetClosestVolume(Vector3 point, in List<HitVolume> volumes, in List<HitColliderVariableData> variableDatas)
	{
		int num = 0;
		for (int i = 0; i < volumes.Count; i++)
		{
			if (volumes[i].Enable)
			{
				float num2 = Vector3.SqrMagnitude(volumes[num].PrimitiveInfo.Center - point).FloorRound();
				float num3 = Vector3.SqrMagnitude(volumes[i].PrimitiveInfo.Center - point).FloorRound();
				LockstepData.Instance?.WriteAuthorityEntityId($"受击盒名: {volumes[i].Key} center:{volumes[num].PrimitiveInfo.Center},minSqrMag:{num2} curSqrMag：{num3}");
				if (num2 > num3)
				{
					num = i;
				}
				else if (Mathf.Abs(num2 - num3) < 0.0001f)
				{
					num = ((variableDatas[i].Weight > variableDatas[num].Weight) ? i : num);
					LockstepData.Instance?.WriteAuthorityEntityId("受击盒1名: " + volumes[num].Key + " 受击盒2名: " + volumes[i].Key + ",相等取权重");
				}
			}
		}
		LockstepData.Instance?.WriteAuthorityEntityId("最终返回的受击盒:" + volumes[num].Key);
		return volumes[num].Key;
	}

	public HitColliderVariableData GetClosestHitData(Vector3 point, int targetId, in List<HitColliderVariableData> variableDatas)
	{
		LockstepData.Instance?.WriteAuthorityEntityId($"获取距离目标实体最近的受击盒数据,距离相等时取权重最高的一个: point:{point},targetId:{targetId}");
		int num = 0;
		List<HitVolume> entityVolumes = GetEntityVolumes(targetId);
		if (entityVolumes.IsNullOrEmpty())
		{
			return null;
		}
		for (int i = 0; i < entityVolumes.Count; i++)
		{
			if (entityVolumes[i].Enable)
			{
				float num2 = Vector3.SqrMagnitude(entityVolumes[num].PrimitiveInfo.Center - point).FloorRound();
				float num3 = Vector3.SqrMagnitude(entityVolumes[i].PrimitiveInfo.Center - point).FloorRound();
				LockstepData.Instance?.WriteAuthorityEntityId($"受击盒名: {entityVolumes[i].Key} center:{entityVolumes[num].PrimitiveInfo.Center},minSqrMag:{num2} curSqrMag：{num3}");
				if (num2 > num3)
				{
					num = i;
				}
				else if (Mathf.Abs(num2 - num3) < 0.0001f)
				{
					num = ((variableDatas[i].Weight > variableDatas[num].Weight) ? i : num);
					LockstepData.Instance?.WriteAuthorityEntityId("受击盒1名: " + entityVolumes[num].Key + " 受击盒2名: " + entityVolumes[i].Key + ",相等取权重");
				}
			}
		}
		LockstepData.Instance?.WriteAuthorityEntityId("最终返回的受击盒:" + entityVolumes[num].Key);
		return variableDatas[num];
	}

	public string GetFarthestVolume(Vector3 point, Vector3 direct, in List<HitVolume> volumes, Vector3 hitTargetPoint)
	{
		int num = 0;
		Vector3 vector = -direct.normalized;
		Vector3 vector2 = hitTargetPoint + vector;
		Vector3 vector3 = hitTargetPoint + direct;
		LockstepData.Instance?.WriteAuthorityEntityId($"point:{point} direct:{direct} hitTargetPoint:{hitTargetPoint} negDirect:{vector} negPoint:{vector2} posPoint:{vector3}");
		for (int i = 0; i < volumes.Count; i++)
		{
			if (!volumes[i].Enable)
			{
				continue;
			}
			LockstepData.Instance?.WriteAuthorityEntityId("射线与受击盒检测:受击盒数据 : key:" + volumes[i].Key + ", " + volumes[i].Primitive.ToString());
			if (!PrimitiveSystem.IsIntersect(point, direct, volumes[i].Primitive))
			{
				continue;
			}
			Vector3 vector4 = IntersectionDetection.PointProjectionOnLineSeg(point, point + direct, volumes[i].PrimitiveInfo.Center) - hitTargetPoint;
			Vector3 vector5 = IntersectionDetection.PointProjectionOnLineSeg(point, point + direct, volumes[num].PrimitiveInfo.Center) - hitTargetPoint;
			float num2 = Vector3.Dot(vector4, vector5);
			LockstepData.Instance?.WriteAuthorityEntityId($"ipro:{vector4} maxpro:{vector5}  {num2}");
			if (num2 >= 0f)
			{
				float num3 = Vector3.SqrMagnitude(vector4 - hitTargetPoint).FloorRound();
				float num4 = Vector3.SqrMagnitude(vector5 - hitTargetPoint).FloorRound();
				if (Vector3.Dot(vector4, direct) >= 0f && Vector3.Dot(vector5, direct) >= 0f)
				{
					if (num3 <= num4)
					{
						num = i;
					}
				}
				else if (num3 >= num4)
				{
					num = i;
				}
			}
			else
			{
				num2 = Vector3.Dot(vector4, direct);
				if (!((double)Mathf.Abs(num2) > Epsilon) || !(num2 > 0f))
				{
					num = i;
				}
			}
		}
		return volumes[num].Key;
	}

	public int GetHighestWeightVolume(List<HitColliderVariableData> variableData)
	{
		int result = 0;
		for (int i = 0; i < variableData.Count; i++)
		{
			if (variableData[i].Weight >= variableData[result].Weight)
			{
				result = i;
			}
		}
		return result;
	}

	private void ReleaseDeadEntity()
	{
		if (cacheRemoveId.Count <= 0)
		{
			return;
		}
		foreach (int item in cacheRemoveId)
		{
			if (!_hitVolumes.TryGetValue(item, out var value))
			{
				continue;
			}
			_hitVolumes.Remove(item);
			if (value != null)
			{
				for (int i = 0; i < value.Count; i++)
				{
					ReferencePool.Release(value[i]);
				}
			}
		}
		cacheRemoveId.Clear();
	}

	public override void OnReset()
	{
		base.OnReset();
		Dictionary<int, List<HitVolume>>.Enumerator enumerator = _hitVolumes.GetEnumerator();
		while (enumerator.MoveNext())
		{
			foreach (HitVolume item in enumerator.Current.Value)
			{
				if (item != null)
				{
					ReferencePool.Release(item);
				}
			}
			enumerator.Current.Value.Clear();
		}
		enumerator.Dispose();
		_hitVolumes.Clear();
		foreach (HitVolume wallVolume in wallVolumes)
		{
			ReferencePool.Release(wallVolume);
		}
		wallVolumes.Clear();
	}

	public override void OnDispose()
	{
		base.OnDispose();
		OnReset();
	}
}
