using System.Collections.Generic;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("获取子弹命中的实体Id列表 (可筛选)", 0)]
[Category("✫ DragonLost/Bullet")]
[Description("用于获取特定子弹命中的实体ID列表")]
public class GetBulletHitListFilter : ActionTaskBase
{
	[Name("子弹标签筛选", 0)]
	public bool bulletLabelFilter;

	[Name("子弹的ConfigId", 0)]
	[Description("要查询的子弹的配置ID")]
	[ShowIf("bulletLabelFilter", false)]
	public int BulletConfigId;

	[Name("子弹标签", 0)]
	[ShowIf("bulletLabelFilter", true)]
	public string bulletLabel;

	[Name("命中的实体数量", 0)]
	[Description("存储命中实体ID列表的数量")]
	public BBParameter<int> HitListCount;

	[Name("命中的受击盒中心", 0)]
	[Description("返回运行到此节点时，该子弹命中的最新的受击盒数据，可存为黑板值")]
	public BBParameter<Vector3> HitVolumeCenter;

	[Name("是否只获取投影位置", 0)]
	public bool isProjection;

	[Name("获取后是否清理数据", 0)]
	[Description("指示在获取命中实体ID列表后是否清除命中数据")]
	public bool IsClear;

	[Name("命中的实体ID列表", 0)]
	[Description("存储命中实体ID的列表")]
	public BBParameter<List<int>> ReturnHitEntityIdList;

	[Name("是否存活", 0)]
	public bool isSurvival;

	[Name("阵营", 0)]
	public EntityType entityType;

	protected override void OnExecute()
	{
		base.OnExecute();
		if (ReturnHitEntityIdList == null)
		{
			ReturnHitEntityIdList = new BBParameter<List<int>>();
		}
		if (ReturnHitEntityIdList.value == null)
		{
			ReturnHitEntityIdList.value = new List<int>();
		}
		HitComponent component = ownerEntity.GetComponent<HitComponent>();
		List<int> list = ((!bulletLabelFilter) ? component.GetBulletHitData(BulletConfigId) : component.GetBulletHitDataByLabel(bulletLabel));
		if (HitVolumeCenter != null)
		{
			HitVolumeCenter.value = ((!bulletLabelFilter) ? component.GetBulletHitVolumeCenter(BulletConfigId) : component.GetBulletHitVolumeCenterByLabel(bulletLabel));
			if (isProjection)
			{
				HitVolumeCenter.value = new Vector3(HitVolumeCenter.value.x, ownerEntity.transform.position.y, HitVolumeCenter.value.z);
			}
		}
		if (list == null)
		{
			ReturnHitEntityIdList.value.Clear();
			HitListCount.value = 0;
			if (HitVolumeCenter != null)
			{
				HitVolumeCenter.value = Vector3.zero;
			}
			EndAction();
			return;
		}
		ReturnHitEntityIdList.value.Clear();
		HitListCount.value = 0;
		for (int i = 0; i < list.Count; i++)
		{
			BaseEntity entity = ownerEntity.GetSystem<EntitySystem>().GetEntity(list[i]);
			if (entity != null && entity.IsSurvival == isSurvival && entity.GetEntityType() == entityType)
			{
				ReturnHitEntityIdList.value.Add(list[i]);
			}
		}
		HitListCount.value = ReturnHitEntityIdList.value.Count;
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance?.WriteAuthorityEntityId($"获取子弹命中的实体Id列表 子弹的ConfigId ：{BulletConfigId}  命中的实体数量 ：{HitListCount.value} " + $"获取后是否清理数据: {IsClear}", ownerEntity);
		}
		for (int j = 0; j < ReturnHitEntityIdList?.value?.Count; j++)
		{
			if (LockstepData.Instance != null)
			{
				LockstepData.Instance?.WriteAuthorityEntityId($"获取子弹命中的实体Id列表  命中的实体ID列表 : {ReturnHitEntityIdList?.value[j]}", ownerEntity);
			}
		}
		if (IsClear)
		{
			if (bulletLabelFilter)
			{
				component.ClearBulletHitDataByLabel(bulletLabel);
			}
			else
			{
				component.ClearBulletHitData(BulletConfigId);
			}
		}
		EndAction();
	}
}
