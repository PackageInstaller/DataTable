using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Pool;

namespace Ase.ECS;

public class HitColliderComponent : BaseComponent
{
	private Dictionary<int, List<HitVolume>> _curFrameAlertHit = new Dictionary<int, List<HitVolume>>();

	private Dictionary<int, List<HitVolume>> _curFrameHit = new Dictionary<int, List<HitVolume>>();

	private DRHitBox _drHitBox;

	private HitColliderType colliderType;

	private Color hitColliderColor;

	private Dictionary<string, VolumeData> hitColliderDict = new Dictionary<string, VolumeData>();

	private Dictionary<int, string> hitColliderKeyDic = new Dictionary<int, string>();

	private Vector3 hitColliderParam;

	private Dictionary<string, HitColliderVariableData> hitColliderVariableDict = new Dictionary<string, HitColliderVariableData>();

	public PrimitiveInfo PrimitiveInfo;

	public HitColliderType ColliderType => colliderType;

	public override void OnAwake(object data = null)
	{
		PrimitiveInfo.Type = GetData<PrimitiveEnum>("PrimitiveEnum");
		PrimitiveInfo.BoxSize = GetData<Vector3>("HitColliderParam");
		_drHitBox = GetData<DRHitBox>("HitCollider");
		InitSettingDict();
	}

	public override void OnStart(object data = null)
	{
		base.OnStart(data);
		RegisterVolume();
	}

	private void RegisterVolume()
	{
		mBaseEntity.GetSystem<VolumeSystem>().RegisterHitVolume(mBaseEntity, hitColliderDict);
	}

	private void InitSettingDict()
	{
		if (_drHitBox != null)
		{
			hitColliderDict.Clear();
			hitColliderVariableDict.Clear();
			hitColliderKeyDic.Clear();
			int count = _drHitBox.Count;
			for (int i = 0; i < count; i++)
			{
				AddSingleVolumeData(i);
				AddSingleVariableData(i);
			}
		}
	}

	private void AddSingleVolumeData(int idx)
	{
		if (idx >= _drHitBox.Keys.Count)
		{
			return;
		}
		string text = _drHitBox.Keys[idx];
		if (idx >= _drHitBox.PrimitiveEnum.Count)
		{
			return;
		}
		PrimitiveEnum primitiveEnum = _drHitBox.PrimitiveEnum[idx];
		if ((primitiveEnum == PrimitiveEnum.SpherePrimitive || primitiveEnum == PrimitiveEnum.CapsulePrimitive || primitiveEnum == PrimitiveEnum.BoxPrimitive) && idx < _drHitBox.PrimitiveParams.Count)
		{
			List<float> list = new List<float>();
			for (int i = 0; i < _drHitBox.PrimitiveParams[idx].Count; i++)
			{
				list.Add(_drHitBox.PrimitiveParams[idx][i]);
			}
			Vector3 offset = Vector3.zero;
			Vector3 eulerOffset = Vector3.zero;
			if (idx < _drHitBox.CenterOffset.Count)
			{
				offset = _drHitBox.CenterOffset[idx].ToVector3();
			}
			if (idx >= _drHitBox.RotateOffset.Count)
			{
				eulerOffset = _drHitBox.RotateOffset[idx].ToVector3();
			}
			hitColliderDict.Add(text, VolumeData.Create(offset, eulerOffset, primitiveEnum, list));
			hitColliderKeyDic.Add(idx, text);
		}
	}

	private void AddSingleVariableData(int idx)
	{
		if (idx >= _drHitBox.Keys.Count)
		{
			return;
		}
		string text = _drHitBox.Keys[idx];
		int weight = ((idx >= _drHitBox.Weight.Count) ? 1 : _drHitBox.Weight[idx]);
		float tenacityMagnification = ((idx < _drHitBox.AffectTenacityRatio.Count) ? _drHitBox.AffectTenacityRatio[idx] : 0f);
		int num = ((idx < _drHitBox.HitBoxLevel.Count) ? _drHitBox.HitBoxLevel[idx] : 0);
		float normalTouch = ((idx < _drHitBox.NormalTough.Count) ? _drHitBox.NormalTough[idx] : 0f);
		int hitEffectIndex = ((idx < _drHitBox.KeysEffect.Count) ? _drHitBox.KeysEffect[idx] : 0);
		float damageCumulativeThreshold = 1f;
		if (_drHitBox.DamageCumulativeThreshold.Count > 0)
		{
			foreach (List<float> item in _drHitBox.DamageCumulativeThreshold)
			{
				if (item.Count == 2 && item[0] == (float)num)
				{
					damageCumulativeThreshold = item[1];
					break;
				}
			}
		}
		float damageMagnification = ((idx < _drHitBox.DamageRatio.Count) ? _drHitBox.DamageRatio[idx] : 0f);
		Vector2 hitAngles = ((idx < _drHitBox.HitAngle.Count) ? new Vector2(_drHitBox.HitAngle[idx][0], _drHitBox.HitAngle[idx][1]) : Vector2.zero);
		hitColliderVariableDict.Add(text, HitColliderVariableData.Create(text, weight, damageMagnification, tenacityMagnification, num, normalTouch, damageCumulativeThreshold, 0f, hitAngles, hitEffectIndex));
	}

	public string GetHitColliderKey(int index)
	{
		if (hitColliderKeyDic.TryGetValue(index, out var value))
		{
			return value;
		}
		return string.Empty;
	}

	public void OnUpdateVolumesAfter()
	{
		ClearCurFrameHit();
		ClearCurFrameAlertHit();
	}

	public void OnReceiveHit(int fromId, HitVolume hitVolume)
	{
		if (!_curFrameHit.TryGetValue(fromId, out var value))
		{
			value = CollectionPool<List<HitVolume>, HitVolume>.Get();
			_curFrameHit.Add(fromId, value);
		}
		if (value.IndexOf(hitVolume) == -1)
		{
			value.Add(hitVolume);
		}
	}

	public List<HitVolume> GetCurFrameHitVolume(int fromId)
	{
		_curFrameHit.TryGetValue(fromId, out var value);
		return value;
	}

	public HitColliderVariableData GetHitVariableData(int bulletId, BulletData bulletData, BaseEntity bulletEntity, Vector3 attackerPosition, out HitVolume hitVolume)
	{
		hitVolume = null;
		if (!_curFrameHit.TryGetValue(bulletId, out var value))
		{
			return null;
		}
		if ((BulletEntity)bulletEntity == null)
		{
			return null;
		}
		string part = GetPart(bulletData.cfg, bulletEntity, value, attackerPosition);
		int count = value.Count;
		for (int i = 0; i < count; i++)
		{
			if (value[i].Key == part)
			{
				hitVolume = value[i];
				break;
			}
		}
		BulletExtraData extraData = bulletData.extraData;
		HitColliderVariableData value2;
		if (extraData == null || extraData.initData?.modifySiteLevelEnum != BulletModifySiteLevelEnum.None)
		{
			value2 = GetHitColliderVariableSiteLevelData(bulletData.extraData.initData.modifySiteLevelEnum);
			if (value2 != null)
			{
				return value2;
			}
		}
		if (!hitColliderVariableDict.TryGetValue(part, out value2))
		{
			return null;
		}
		return value2;
	}

	public HitColliderVariableData GetHitVariableData(string key)
	{
		hitColliderVariableDict.TryGetValue(key, out var value);
		return value;
	}

	private string GetPart(DRBullet drBullet, BaseEntity bulletEntity, List<HitVolume> volumes, Vector3 attackerPosition)
	{
		if (drBullet.IsMelee)
		{
			List<HitVolume> tmpSelectedVols = CollectionPool<List<HitVolume>, HitVolume>.Get();
			MeleeBulletHitVolumeSelect(attackerPosition, volumes, in tmpSelectedVols);
			string closestPart = GetClosestPart(attackerPosition, tmpSelectedVols);
			tmpSelectedVols.Clear();
			CollectionPool<List<HitVolume>, HitVolume>.Release(tmpSelectedVols);
			return closestPart;
		}
		if (drBullet.MovementTrajectoryTypeEnum == MovementTrajectoryTypeEnum.NoMove)
		{
			return GetClosestPart(bulletEntity.transform.position, volumes);
		}
		if (drBullet.MovementTrajectoryTypeEnum == MovementTrajectoryTypeEnum.Parabola)
		{
			return GetHighestWeightPart(bulletEntity, volumes);
		}
		if (bulletEntity.GetComponent<BulletMoveComponent>().MovementTrajectoryData == null)
		{
			return GetHighestWeightPart(bulletEntity, volumes);
		}
		return GetFarthestPart(bulletEntity, in volumes);
	}

	private HitColliderVariableData GetHitColliderVariableSiteLevelData(BulletModifySiteLevelEnum siteLevelEnum)
	{
		if (hitColliderVariableDict.IsNullOrEmpty())
		{
			return null;
		}
		switch (siteLevelEnum)
		{
		case BulletModifySiteLevelEnum.Min:
		{
			HitColliderVariableData hitColliderVariableData2 = null;
			{
				foreach (HitColliderVariableData value in hitColliderVariableDict.Values)
				{
					if (hitColliderVariableData2 == null)
					{
						hitColliderVariableData2 = value;
					}
					else if (hitColliderVariableData2.SiteLevel > value.SiteLevel)
					{
						hitColliderVariableData2 = value;
					}
				}
				return hitColliderVariableData2;
			}
		}
		case BulletModifySiteLevelEnum.Max:
		{
			HitColliderVariableData hitColliderVariableData = null;
			{
				foreach (HitColliderVariableData value2 in hitColliderVariableDict.Values)
				{
					if (hitColliderVariableData == null)
					{
						hitColliderVariableData = value2;
					}
					else if (hitColliderVariableData.SiteLevel < value2.SiteLevel)
					{
						hitColliderVariableData = value2;
					}
				}
				return hitColliderVariableData;
			}
		}
		default:
			return null;
		}
	}

	private string GetClosestPart(Vector3 attackerPosition, List<HitVolume> volumes)
	{
		List<HitColliderVariableData> variableDatas = CollectionPool<List<HitColliderVariableData>, HitColliderVariableData>.Get();
		for (int i = 0; i < volumes.Count; i++)
		{
			variableDatas.Add(hitColliderVariableDict[volumes[i].Key]);
		}
		string closestVolume = mBaseEntity.GetSystem<VolumeSystem>().GetClosestVolume(attackerPosition, in volumes, in variableDatas);
		variableDatas.Clear();
		CollectionPool<List<HitColliderVariableData>, HitColliderVariableData>.Release(variableDatas);
		return closestVolume;
	}

	public HitColliderVariableData GetClosedPartHitData(Vector3 position)
	{
		List<HitColliderVariableData> variableDatas = CollectionPool<List<HitColliderVariableData>, HitColliderVariableData>.Get();
		foreach (HitColliderVariableData value in hitColliderVariableDict.Values)
		{
			variableDatas.Add(value);
		}
		HitColliderVariableData closestHitData = mBaseEntity.GetSystem<VolumeSystem>().GetClosestHitData(position, mBaseEntity.Id, in variableDatas);
		CollectionPool<List<HitColliderVariableData>, HitColliderVariableData>.Release(variableDatas);
		return closestHitData;
	}

	private void MeleeBulletHitVolumeSelect(Vector3 attackerPosition, List<HitVolume> volumes, in List<HitVolume> tmpSelectedVols)
	{
		if (volumes.Count <= 1)
		{
			for (int i = 0; i < volumes.Count; i++)
			{
				tmpSelectedVols.Add(volumes[i]);
			}
			return;
		}
		for (int j = 0; j < volumes.Count; j++)
		{
			HitVolume hitVolume = volumes[j];
			HitColliderVariableData hitColliderVariableData = hitColliderVariableDict[hitVolume.Key];
			if (IsEntityInAngleRange(attackerPosition, hitVolume, hitColliderVariableData.hitAngles.x, hitColliderVariableData.hitAngles.y))
			{
				tmpSelectedVols.Add(hitVolume);
			}
		}
	}

	private bool IsEntityInAngleRange(Vector3 attackerPosition, HitVolume hitVolume, float angleStart, float angleEnd)
	{
		if (Mathf.Approximately(angleStart, angleEnd))
		{
			return true;
		}
		Vector3 to = attackerPosition - hitVolume.PrimitiveInfo.Center;
		float t = Vector3.SignedAngle(hitVolume.PrimitiveInfo.Quaternion * Vector3.forward, to, Vector3.up);
		angleStart = Mathf.Repeat(angleStart, 360f);
		angleEnd = Mathf.Repeat(angleEnd, 360f);
		t = Mathf.Repeat(t, 360f);
		if (angleStart > angleEnd)
		{
			if (!(t >= angleStart))
			{
				return t <= angleEnd;
			}
			return true;
		}
		if (t >= angleStart)
		{
			return t <= angleEnd;
		}
		return false;
	}

	private string GetHighestWeightPart(BaseEntity bulletEntity, List<HitVolume> volumes)
	{
		List<HitColliderVariableData> list = CollectionPool<List<HitColliderVariableData>, HitColliderVariableData>.Get();
		bool flag = false;
		string key = volumes[0].Key;
		for (int i = 0; i < volumes.Count; i++)
		{
			if (hitColliderVariableDict.TryGetValue(volumes[i].Key, out var value))
			{
				list.Add(value);
			}
			else
			{
				flag = true;
			}
		}
		key = (flag ? key : volumes[mBaseEntity.GetSystem<VolumeSystem>().GetHighestWeightVolume(list)].Key);
		list.Clear();
		CollectionPool<List<HitColliderVariableData>, HitColliderVariableData>.Release(list);
		return key;
	}

	private string GetFarthestPart(BaseEntity bulletEntity, in List<HitVolume> volumes)
	{
		Vector3 lastFramePosition = bulletEntity.GetComponent<BulletMoveComponent>().MovementTrajectoryData.LastFramePosition;
		Vector3 position = bulletEntity.transform.position;
		return mBaseEntity.GetSystem<VolumeSystem>().GetFarthestVolume(lastFramePosition, position - lastFramePosition, in volumes, position);
	}

	public int GetMaxSiteLevel(int bulletId)
	{
		if (_curFrameHit.IsNullOrEmpty())
		{
			return -1;
		}
		if (!_curFrameHit.TryGetValue(bulletId, out var value))
		{
			return -1;
		}
		int num = -1;
		for (int i = 0; i < value.Count; i++)
		{
			if (hitColliderVariableDict.TryGetValue(value[i].Key, out var value2))
			{
				num = ((value2.SiteLevel > num) ? value2.SiteLevel : num);
			}
		}
		return num;
	}

	public HitVolume GetClosestVolume(Vector3 attackerPos)
	{
		return mBaseEntity.GetSystem<VolumeSystem>().GetClosestVolume(attackerPos, mBaseEntity.Id, hitColliderVariableDict);
	}

	public bool ConfirmSkillDirect(Vector3 attackerPos, Quaternion attackerRot, ref float deg)
	{
		HitVolume closestVolume = mBaseEntity.GetSystem<VolumeSystem>().GetClosestVolume(attackerPos, mBaseEntity.Id, hitColliderVariableDict);
		if (closestVolume == null)
		{
			return false;
		}
		deg = Quaternion.LookRotation(closestVolume.PrimitiveInfo.Center - attackerPos).eulerAngles.y - attackerRot.eulerAngles.y;
		return true;
	}

	public override void OnEntityRelease()
	{
		base.OnEntityRelease();
		hitColliderDict.Clear();
		hitColliderVariableDict.Clear();
		ClearCurFrameHit();
	}

	public override void OnDispose()
	{
		mBaseEntity.GetSystem<VolumeSystem>().UnRegisterHitVolume(mBaseEntity.Id);
		base.OnDispose();
	}

	private void ClearCurFrameHit()
	{
		Dictionary<int, List<HitVolume>>.Enumerator enumerator = _curFrameHit.GetEnumerator();
		while (enumerator.MoveNext())
		{
			CollectionPool<List<HitVolume>, HitVolume>.Release(enumerator.Current.Value);
		}
		enumerator.Dispose();
		_curFrameHit.Clear();
	}

	public PrimitiveInfo GetHitColliderPrimitiveInfo()
	{
		if (mBaseEntity.LogicType == EntityLogicType.Display)
		{
			PrimitiveInfo.Type = PrimitiveEnum.NONE;
		}
		PrimitiveInfo.Center = base.transform.position + new Vector3(0f, PrimitiveInfo.BoxSize.y / 2f, 0f);
		PrimitiveInfo.Quaternion = base.transform.rotation;
		return PrimitiveInfo;
	}

	public Vector3 GetColliderParam()
	{
		return PrimitiveInfo.Type switch
		{
			PrimitiveEnum.BoxPrimitive => PrimitiveInfo.BoxSize, 
			PrimitiveEnum.SpherePrimitive => PrimitiveInfo.Radius * Vector3.one, 
			PrimitiveEnum.SectorPrimitive => PrimitiveInfo.Radius * Vector3.one, 
			_ => Vector3.zero, 
		};
	}

	public void OnReceiveAlertHit(int fromId, HitVolume hitVolume)
	{
	}

	private void ClearCurFrameAlertHit()
	{
	}
}
