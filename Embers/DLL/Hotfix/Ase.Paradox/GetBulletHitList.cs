using System.Collections.Generic;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace Ase.Paradox;

[Name("获取子弹命中的实体Id列表", 0)]
[Category("✫ DragonLost/Bullet")]
[Description("用于获取特定子弹命中的实体ID列表")]
public class GetBulletHitList : ActionTaskBase
{
	[Name("子弹标签筛选", 0)]
	public bool BulletLabelFilter;

	[Name("子弹的ConfigId", 0)]
	[Description("要查询的子弹的配置ID")]
	[ShowIf("BulletLabelFilter", false)]
	public int BulletConfigId;

	[Name("子弹标签", 0)]
	[ShowIf("BulletLabelFilter", true)]
	public string BulletLabel;

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

	protected override void OnExecute()
	{
		base.OnExecute();
		if (ReturnHitEntityIdList.value == null)
		{
			ReturnHitEntityIdList.value = new List<int>();
		}
		HitComponent component = ownerEntity.GetComponent<HitComponent>();
		List<int> list = ((!BulletLabelFilter) ? component.GetBulletHitData(BulletConfigId) : component.GetBulletHitDataByLabel(BulletLabel));
		if (HitVolumeCenter != null)
		{
			HitVolumeCenter.value = ((!BulletLabelFilter) ? component.GetBulletHitVolumeCenter(BulletConfigId) : component.GetBulletHitVolumeCenterByLabel(BulletLabel));
			if (isProjection)
			{
				HitVolumeCenter.value = new Vector3(HitVolumeCenter.value.x, ownerEntity.transform.position.y, HitVolumeCenter.value.z);
			}
		}
		if (list == null)
		{
			ReturnHitEntityIdList?.value?.Clear();
			HitListCount.value = 0;
			if (HitVolumeCenter != null)
			{
				HitVolumeCenter.value = Vector3.zero;
			}
			EndAction();
			return;
		}
		ReturnHitEntityIdList?.value?.Clear();
		HitListCount.value = 0;
		for (int i = 0; i < list.Count; i++)
		{
			ReturnHitEntityIdList?.value?.Add(list[i]);
		}
		HitListCount.value = (ReturnHitEntityIdList?.value?.Count).GetValueOrDefault();
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
			if (BulletLabelFilter)
			{
				component.ClearBulletHitDataByLabel(BulletLabel);
			}
			else
			{
				component.ClearBulletHitData(BulletConfigId);
			}
		}
		EndAction();
	}
}
