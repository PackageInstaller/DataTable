using System.Collections.Generic;
using GameFramework;
using UnityEngine;
using UnityEngine.Pool;

namespace Ase.ECS;

public class AlertHitInfoSystem : BaseSystem
{
	public class AlertBulletInfo : IReference
	{
		public BaseEntity bullet;

		public uint Tick;

		public float LeadTime;

		public int AttackerId;

		public DRBullet BulletData;

		public Vector3 BulletPosition;

		public Vector3 HitDirect;

		public static AlertBulletInfo Create(BaseEntity bullet, uint tick, float leadTime, int attackerId, DRBullet bulletData, Vector3 bulletPos, Vector3 hitDirect)
		{
			AlertBulletInfo alertBulletInfo = ReferencePool.Acquire<AlertBulletInfo>();
			alertBulletInfo.bullet = bullet;
			alertBulletInfo.Tick = tick;
			alertBulletInfo.LeadTime = leadTime;
			alertBulletInfo.AttackerId = attackerId;
			alertBulletInfo.BulletData = bulletData;
			alertBulletInfo.BulletPosition = bulletPos;
			alertBulletInfo.HitDirect = hitDirect;
			return alertBulletInfo;
		}

		public void Clear()
		{
			bullet = null;
			Tick = 0u;
			LeadTime = 0f;
			AttackerId = 0;
			BulletData = null;
			BulletPosition = Vector3.zero;
			HitDirect = Vector3.zero;
		}
	}

	private SortedDictionary<int, List<AlertBulletInfo>> AlertDict = new SortedDictionary<int, List<AlertBulletInfo>>();

	private List<int> _cacheAlertKeysList = new List<int>();

	private List<int> cacheRemovedAlert = new List<int>();

	private List<Vector3> Directs = new List<Vector3>();

	protected override bool IsLogicSystem => true;

	public override void OnInit(object data = null)
	{
		base.OnInit(data);
		AlertDict = new SortedDictionary<int, List<AlertBulletInfo>>();
		Directs = new List<Vector3>
		{
			new Vector3(0f, 0f, 1f),
			new Vector3(1f, 0f, 1f),
			new Vector3(1f, 0f, 0f),
			new Vector3(1f, 0f, -1f),
			new Vector3(0f, 0f, -1f),
			new Vector3(-1f, 0f, -1f),
			new Vector3(-1f, 0f, 0f),
			new Vector3(-1f, 0f, 1f)
		};
	}

	public override void OnFixedUpdateAfter(WorldUpdateType updateType)
	{
		base.OnFixedUpdateAfter(updateType);
		foreach (int cacheAlertKeys in _cacheAlertKeysList)
		{
			HandleEntityAlertData(cacheAlertKeys);
		}
		ReleaseCacheRemove();
	}

	public void StoreAlertHitInfo(BaseEntity bulletEntity, float leadTime, int attackerId, DRBullet bulletData, Vector3 bulletPos, Vector3 hitDirect, BaseEntity entity)
	{
		if (AlertDict == null)
		{
			AlertDict = new SortedDictionary<int, List<AlertBulletInfo>>();
		}
		if (!AlertDict.TryGetValue(entity.Id, out var value))
		{
			value = new List<AlertBulletInfo>();
			AlertDict.Add(entity.Id, value);
			_cacheAlertKeysList.Clear();
			foreach (KeyValuePair<int, List<AlertBulletInfo>> item in AlertDict)
			{
				_cacheAlertKeysList.Add(item.Key);
			}
		}
		value.Add(AlertBulletInfo.Create(bulletEntity, world.Tick, leadTime, attackerId, bulletData, bulletPos, hitDirect));
	}

	public void ExitAlertHitInfo(BaseEntity bulletEntity, BaseEntity targetEntity)
	{
		targetEntity.GetComponent<AIParadoxComponent>()?.SetVariableValues("s_alertHit", paramValue: false);
	}

	private void HandleEntityAlertData(int targetId)
	{
		if (GetSystem<EntitySystem>() == null)
		{
			return;
		}
		BaseEntity entity = GetSystem<EntitySystem>().GetEntity(targetId);
		if (entity != null)
		{
			GetIfHitByAlertInfo(targetId, out var isAlertHit);
			GetTempSafeDirectByAlertInfo(targetId, entity.transform.rotation * Vector3.forward, out var _);
			lock (cacheRemovedAlert)
			{
				cacheRemovedAlert.Add(targetId);
			}
			if (isAlertHit)
			{
				entity.GetComponent<AIParadoxComponent>()?.SetVariableValues("s_alertHit", paramValue: true);
			}
		}
	}

	private void GetIfHitByAlertInfo(int targetId, out bool isAlertHit)
	{
		isAlertHit = false;
		if (AlertDict == null || !AlertDict.TryGetValue(targetId, out var value))
		{
			return;
		}
		List<AlertBulletInfo> list = CollectionPool<List<AlertBulletInfo>, AlertBulletInfo>.Get();
		list.Clear();
		uint tick = world.Tick;
		for (int i = 0; i < value.Count; i++)
		{
			if (value[i].Tick == tick)
			{
				list.Add(value[i]);
			}
		}
		if (list.Count <= 0)
		{
			list.Clear();
			CollectionPool<List<AlertBulletInfo>, AlertBulletInfo>.Release(list);
		}
		else
		{
			isAlertHit = true;
			list.Clear();
			CollectionPool<List<AlertBulletInfo>, AlertBulletInfo>.Release(list);
		}
	}

	private void GetTempSafeDirectByAlertInfo(int targetId, Vector3 forwardDirect, out Vector3 safe)
	{
		safe = Vector3.zero;
		if (AlertDict == null || !AlertDict.TryGetValue(targetId, out var value))
		{
			return;
		}
		List<AlertBulletInfo> alertBulletInfos = CollectionPool<List<AlertBulletInfo>, AlertBulletInfo>.Get();
		alertBulletInfos.Clear();
		uint tick = world.Tick;
		for (int i = 0; i < value.Count; i++)
		{
			if (value[i].Tick == tick)
			{
				alertBulletInfos.Add(value[i]);
			}
		}
		if (alertBulletInfos.Count <= 0)
		{
			alertBulletInfos.Clear();
			CollectionPool<List<AlertBulletInfo>, AlertBulletInfo>.Release(alertBulletInfos);
			return;
		}
		List<Vector3> safeDirect = CollectionPool<List<Vector3>, Vector3>.Get();
		safeDirect.Clear();
		CalCurTickSafeDirect(in alertBulletInfos, in safeDirect);
		if (safeDirect.Count > 0)
		{
			FindMostSuitableSafeDirect(forwardDirect, safeDirect, out safe);
		}
		alertBulletInfos.Clear();
		CollectionPool<List<AlertBulletInfo>, AlertBulletInfo>.Release(alertBulletInfos);
		safeDirect.Clear();
		CollectionPool<List<Vector3>, Vector3>.Release(safeDirect);
	}

	private void FindMostSuitableSafeDirect(Vector3 forwardDirect, List<Vector3> safeDirects, out Vector3 safe)
	{
		int num = 0;
		for (int i = 0; i < safeDirects.Count; i++)
		{
			if (Vector3.Dot(forwardDirect, safeDirects[i]) > Vector3.Dot(forwardDirect, safeDirects[num]))
			{
				num = i;
			}
		}
		safe = safeDirects[num];
	}

	private void CalCurTickSafeDirect(in List<AlertBulletInfo> alertBulletInfos, in List<Vector3> safeDirect)
	{
		List<int> list = CollectionPool<List<int>, int>.Get();
		list.Clear();
		for (int i = 0; i < alertBulletInfos.Count; i++)
		{
			GetAlertDirectionIndex(Mathf.Atan2(alertBulletInfos[i].HitDirect.x, alertBulletInfos[i].HitDirect.z) * 57.29578f, out var directionIndex);
			GetAlertDirectionIndex(Mathf.Atan2(0f - alertBulletInfos[i].HitDirect.x, 0f - alertBulletInfos[i].HitDirect.z) * 57.29578f, out var directionIndex2);
			if (directionIndex[0] != -1 && list.IndexOf(directionIndex[0]) == -1)
			{
				list.Add(directionIndex[0]);
			}
			if (directionIndex[1] != -1 && list.IndexOf(directionIndex[1]) == -1)
			{
				list.Add(directionIndex[1]);
			}
			if (directionIndex2[0] != -1 && list.IndexOf(directionIndex2[0]) == -1)
			{
				list.Add(directionIndex2[0]);
			}
			if (directionIndex2[1] != -1 && list.IndexOf(directionIndex2[1]) == -1)
			{
				list.Add(directionIndex2[1]);
			}
		}
		for (int j = 0; j < Directs.Count; j++)
		{
			if (list.IndexOf(j) == -1)
			{
				safeDirect.Add(Directs[j]);
			}
		}
		list.Clear();
		CollectionPool<List<int>, int>.Release(list);
	}

	private void GetAlertDirectionIndex(float angle, out Vector2Int directionIndex)
	{
		if (angle < 0f)
		{
			angle += 360f;
		}
		int num = Mathf.FloorToInt(angle / 45f);
		int y = ((num + 1 <= 7) ? (num + 1) : 0);
		directionIndex = new Vector2Int(num, y);
	}

	private void ReleaseCacheRemove()
	{
		lock (cacheRemovedAlert)
		{
			for (int i = 0; i < cacheRemovedAlert.Count; i++)
			{
				if (AlertDict.TryGetValue(cacheRemovedAlert[i], out var value) && value != null)
				{
					for (int j = 0; j < value.Count; j++)
					{
						ReferencePool.Release(value[j]);
					}
					value.Clear();
				}
			}
			cacheRemovedAlert.Clear();
		}
	}

	public override void OnDispose()
	{
		base.OnDispose();
		SortedDictionary<int, List<AlertBulletInfo>>.Enumerator enumerator = AlertDict.GetEnumerator();
		while (enumerator.MoveNext())
		{
			if (enumerator.Current.Value != null)
			{
				for (int i = 0; i < enumerator.Current.Value.Count; i++)
				{
					ReferencePool.Release(enumerator.Current.Value[i]);
				}
				enumerator.Current.Value.Clear();
			}
		}
		enumerator.Dispose();
		AlertDict.Clear();
		Directs.Clear();
		cacheRemovedAlert.Clear();
		_cacheAlertKeysList.Clear();
	}
}
