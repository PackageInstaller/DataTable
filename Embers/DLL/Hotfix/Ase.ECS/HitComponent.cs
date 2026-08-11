using System.Collections.Generic;
using UnityEngine;

namespace Ase.ECS;

public class HitComponent : BaseComponent
{
	private Dictionary<int, BulletAttackCdData> _cdDict = new Dictionary<int, BulletAttackCdData>();

	private List<BulletHitData> hitEntityList = new List<BulletHitData>();

	private Dictionary<int, List<DamageProgressBase>> damageProgressDic = new Dictionary<int, List<DamageProgressBase>>();

	private List<int> _cachedRemovedCdDatas = new List<int>();

	private List<HitData> _alertHitDataList = new List<HitData>();

	private int _attackId;

	private float _damage;

	private int bulletId;

	private int bulletConfigId;

	private bool _isInjured;

	private int damageBeforeAttackId;

	private BulletBuffTypeEnum buffTypeEnum;

	private bool isInjuredByDamageBefore;

	public int AttackId => _attackId;

	public float Damage => _damage;

	public bool IsInjured => _isInjured;

	public int DamageBeforeAttackId => damageBeforeAttackId;

	public BulletBuffTypeEnum BuffTypeEnum => buffTypeEnum;

	public bool IsInjuredByDamageBefore => isInjuredByDamageBefore;

	public void SetBulletHitData(int bulletConfigId, BaseEntity entity)
	{
		SetBulletHitData(bulletConfigId, entity, null);
	}

	public void SetBulletHitData(int bulletConfigId, BaseEntity entity, BulletAttackData bulletAttackData)
	{
		if (entity.LogicType != EntityLogicType.Display)
		{
			BulletHitData bulletHitData = new BulletHitData();
			bulletHitData.bulletConfigId = bulletConfigId;
			bulletHitData.hitEntityId = entity.Id;
			if (bulletAttackData != null)
			{
				bulletHitData.bulletLabel = ((bulletAttackData.bulletData?.extraData?.runtimeConfigData?.BulletLabel != null) ? new List<string>(bulletAttackData.bulletData.extraData.runtimeConfigData.BulletLabel) : null);
				bulletHitData.hitVolumeData = bulletAttackData.Volume;
			}
			hitEntityList.Add(bulletHitData);
		}
	}

	public List<int> GetBulletHitData(int bulletConfigId)
	{
		List<int> list = new List<int>();
		for (int num = hitEntityList.Count - 1; num >= 0; num--)
		{
			BulletHitData bulletHitData = hitEntityList[num];
			if (bulletHitData.bulletConfigId == bulletConfigId && !list.Contains(bulletHitData.hitEntityId))
			{
				list.Add(bulletHitData.hitEntityId);
			}
		}
		return list;
	}

	public List<int> GetBulletHitDataByLabel(string bulletLabel)
	{
		List<int> list = new List<int>();
		List<string> second = new List<string> { bulletLabel };
		for (int num = hitEntityList.Count - 1; num >= 0; num--)
		{
			BulletHitData bulletHitData = hitEntityList[num];
			if (bulletHitData.bulletLabel != null && bulletHitData.bulletLabel.HasCommonWith(second) && !list.Contains(bulletHitData.hitEntityId))
			{
				list.Add(bulletHitData.hitEntityId);
			}
		}
		return list;
	}

	public Vector3 GetBulletHitVolumeCenter(int bulletConfigId)
	{
		for (int num = hitEntityList.Count - 1; num >= 0; num--)
		{
			BulletHitData bulletHitData = hitEntityList[num];
			if (bulletHitData.bulletConfigId == bulletConfigId)
			{
				return bulletHitData.hitVolumeData?.PrimitiveInfo.Center ?? Vector3.zero;
			}
		}
		return Vector3.zero;
	}

	public Vector3 GetBulletHitVolumeCenterByLabel(string bulletLabel)
	{
		List<string> second = new List<string> { bulletLabel };
		for (int num = hitEntityList.Count - 1; num >= 0; num--)
		{
			BulletHitData bulletHitData = hitEntityList[num];
			if (bulletHitData.bulletLabel != null && bulletHitData.bulletLabel.HasCommonWith(second))
			{
				return bulletHitData.hitVolumeData?.PrimitiveInfo.Center ?? Vector3.zero;
			}
		}
		return Vector3.zero;
	}

	public List<int> GetHitEntityBulletIdList(int entityId)
	{
		List<int> list = new List<int>();
		for (int num = hitEntityList.Count - 1; num >= 0; num--)
		{
			BulletHitData bulletHitData = hitEntityList[num];
			if (bulletHitData.hitEntityId == entityId && !list.Contains(bulletHitData.bulletConfigId))
			{
				list.Add(bulletHitData.bulletConfigId);
			}
		}
		return list;
	}

	public void ClearBulletHitData(int bulletConfig)
	{
		for (int num = hitEntityList.Count - 1; num >= 0; num--)
		{
			if (hitEntityList[num].bulletConfigId == bulletConfig)
			{
				hitEntityList.RemoveAt(num);
			}
		}
	}

	public void ClearBulletHitDataByLabel(string bulletLabel)
	{
		List<string> second = new List<string> { bulletLabel };
		for (int num = hitEntityList.Count - 1; num >= 0; num--)
		{
			BulletHitData bulletHitData = hitEntityList[num];
			if (bulletHitData.bulletLabel != null && bulletHitData.bulletLabel.HasCommonWith(second))
			{
				hitEntityList.RemoveAt(num);
			}
		}
	}

	public override void OnFixedUpdate(WorldUpdateType updateType, float deltaTime)
	{
		base.OnFixedUpdate(updateType, deltaTime);
	}

	public override void OnFixedUpdateAfter(WorldUpdateType updateType)
	{
		base.OnFixedUpdateAfter(updateType);
	}

	public void AddCdData(int eId, BulletAttackCdData cdData)
	{
		if (!_cdDict.TryGetValue(eId, out var _))
		{
			_cdDict.Add(eId, cdData);
		}
	}

	public bool CheckIfInHitCd(int eId)
	{
		if (!_cdDict.TryGetValue(eId, out var value))
		{
			return false;
		}
		return value.IsInCd();
	}

	private void ClearCdDict()
	{
		Dictionary<int, BulletAttackCdData>.Enumerator enumerator = _cdDict.GetEnumerator();
		while (enumerator.MoveNext())
		{
			enumerator.Current.Value.OnDispose();
		}
		enumerator.Dispose();
		_cdDict.Clear();
	}

	public void AddAlertHitData(HitData alertHitData)
	{
		_alertHitDataList.Add(alertHitData);
	}

	public bool CheckIfHasAlertHitDataByBulletId(int bulletId, bool isClear)
	{
		bool result = false;
		for (int num = _alertHitDataList.Count - 1; num >= 0; num--)
		{
			if (_alertHitDataList[num].ExactAttackerId == bulletId)
			{
				result = true;
				if (isClear)
				{
					_alertHitDataList.RemoveAt(num);
				}
			}
		}
		return result;
	}

	public void SetEntityInjuredData(int attack, float damage, int bulletId, int bulletConfigId)
	{
		_attackId = attack;
		_damage = damage;
		this.bulletId = bulletId;
		this.bulletConfigId = bulletConfigId;
		_isInjured = true;
	}

	public void ClearEntityInjuredData()
	{
		_isInjured = false;
		_attackId = 0;
		_damage = 0f;
		bulletId = 0;
		bulletConfigId = 0;
	}

	public void SetEntityInjuredByDamageBefore(int attack, BulletBuffTypeEnum buffTypeEnum)
	{
		damageBeforeAttackId = attack;
		this.buffTypeEnum = buffTypeEnum;
		isInjuredByDamageBefore = true;
	}

	public void ClearEntityInjuredByDamageBefore()
	{
		damageBeforeAttackId = 0;
		buffTypeEnum = BulletBuffTypeEnum.None;
		isInjuredByDamageBefore = false;
	}

	public override void OnDispose()
	{
		base.OnDispose();
		ClearCdDict();
		_cachedRemovedCdDatas.Clear();
		hitEntityList.Clear();
	}
}
