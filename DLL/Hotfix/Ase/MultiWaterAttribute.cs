using System.Collections.Generic;
using Ase.ECS;
using GameFramework;
using UnityEngine.Pool;

namespace Ase;

public class MultiWaterAttribute : MultiAttributeBase
{
	public enum WaterState
	{
		None,
		Recovery,
		Damage
	}

	private List<WaterEntityInfo> infoList;

	private int bulletId;

	private float bulletIntervalTime;

	public static MultiWaterAttribute Create(MultiPlayerSystem multiPlayerSystem, DRAttributeMatching cfg)
	{
		MultiWaterAttribute multiWaterAttribute = ReferencePool.Acquire<MultiWaterAttribute>();
		multiWaterAttribute.multiPlayerSystem = multiPlayerSystem;
		multiWaterAttribute.attributeMatchingCfg = cfg;
		multiWaterAttribute.attributeEnum = HeroAttributeEnum.Water;
		return multiWaterAttribute;
	}

	protected override void OnInit()
	{
	}

	public override void OnStartAfter()
	{
		if (attributeMatchingCfg != null && !string.IsNullOrEmpty(attributeMatchingCfg.Params))
		{
			string[] array = attributeMatchingCfg.Params.Split(',');
			if (array != null && array.Length == 4)
			{
				bulletIntervalTime = float.Parse(array[0]);
				bulletId = int.Parse(array[attributeEntityCount]);
			}
		}
	}

	public override void OnUpdate(float delta)
	{
		UpdateWaterInfo(delta);
	}

	public override void CreateEntityMessager(BaseEntity entity)
	{
		base.CreateEntityMessager(entity);
		if (IsConditionEntity(entity) && addBuffList != null && addBuffList.Count != 0)
		{
			OnAddBuffs(entity);
			CreateEntityWaterInfo(entity);
		}
	}

	private void CreateEntityWaterInfo(BaseEntity entity)
	{
		WaterEntityInfo waterEntityInfo = new WaterEntityInfo();
		waterEntityInfo.entity = entity;
		OnEntityHpChanged(waterEntityInfo);
		if (infoList == null)
		{
			infoList = CollectionPool<List<WaterEntityInfo>, WaterEntityInfo>.Get();
		}
		infoList.Add(waterEntityInfo);
	}

	public void OnEntityHpChanged(WaterEntityInfo info)
	{
		if (info == null || info.propertyData == null)
		{
			return;
		}
		if (info.propertyData.IsMax)
		{
			if (info.state == WaterState.Recovery || info.state == WaterState.None)
			{
				SwithEntityWaterState(info, WaterState.Damage);
			}
		}
		else if (info.state == WaterState.Damage || info.state == WaterState.None)
		{
			SwithEntityWaterState(info, WaterState.Recovery);
		}
	}

	private void SwithEntityWaterState(WaterEntityInfo info, WaterState state)
	{
		info.state = state;
		info.time = 0f;
	}

	private void UpdateWaterInfo(float delta)
	{
		if (bulletId != 0 && infoList != null)
		{
			for (int i = 0; i < infoList.Count; i++)
			{
				UpdateEntityWaterInfo(infoList[i], delta);
			}
		}
	}

	private void UpdateEntityWaterInfo(WaterEntityInfo info, float delta)
	{
		if (info.entity == null)
		{
			return;
		}
		if (!info.entity.IsSurvival)
		{
			SwithEntityWaterState(info, WaterState.None);
		}
		else if (info.state == WaterState.Damage)
		{
			info.time += delta;
			if (info.time >= bulletIntervalTime)
			{
				info.time -= bulletIntervalTime;
				CreateBullet(info.entity);
			}
		}
	}

	private void CreateBullet(BaseEntity entity)
	{
		multiPlayerSystem.GetSystem<BulletSystem>().CreateBulletEntity(entity, bulletId, entity.transform.position, entity.transform.eulerAngles, currentTickCreate: false);
	}

	public override void OnClear()
	{
		CollectionPool<List<WaterEntityInfo>, WaterEntityInfo>.Release(infoList);
	}
}
