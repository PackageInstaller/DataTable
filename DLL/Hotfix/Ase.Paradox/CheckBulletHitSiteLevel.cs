using System.Collections.Generic;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("获取子弹命中的最大部位等级", 0)]
[Category("✫ DragonLost/Bullet")]
[Description("用于获取子弹命中目标实体的最大部位等级")]
public class CheckBulletHitSiteLevel : ActionTaskBase
{
	[Name("子弹实体Id", 0)]
	[Description("子弹实体的ID")]
	public BBParameter<int> bulletId;

	[Name("是否从一个目标实体上取值", 0)]
	[Description("是否从单个目标实体上获取最大部位等级")]
	public bool isGetFromSingle;

	[Name("目标实体Id", 0)]
	[Description("单个目标实体的ID")]
	[ShowIf("isGetFromSingle", 1)]
	public BBParameter<int> targetId;

	[Name("目标实体Id列表", 0)]
	[Description("目标实体ID列表")]
	[ShowIf("isGetFromSingle", 0)]
	public BBParameter<List<int>> targetList;

	[Name("返回最大部位等级", 0)]
	[Description("返回查询结果，表示子弹命中目标的最大部位等级")]
	public BBParameter<int> maxLevel;

	[Name("子弹标签筛选", 0)]
	public bool bulletLabelFilter;

	[Name("子弹标签列表", 0)]
	[ShowIf("bulletLabelFilter", true)]
	public List<string> bulletLabelList = new List<string>();

	protected override void OnExecute()
	{
		base.OnExecute();
		if (ownerEntity.GetSystem<EntitySystem>() == null)
		{
			EndAction();
			return;
		}
		if (!(GetEntity(bulletId.value, isSyncEntity: false) is BulletEntity bulletEntity))
		{
			EndAction();
			return;
		}
		if (isGetFromSingle)
		{
			if (ownerEntity.GetSystem<EntitySystem>().GetEntity(targetId.value) == null)
			{
				EndAction();
				return;
			}
			BulletData data = bulletEntity.GetData<BulletData>("bulletData");
			if (data == null)
			{
				EndAction();
				return;
			}
			if (bulletLabelFilter)
			{
				if (bulletLabelList.Count == 0)
				{
					EndAction();
					return;
				}
				if (!bulletLabelList.HasCommonWith(data.cfg.BulletLabel))
				{
					EndAction();
					return;
				}
			}
			maxLevel.value = data.LastHitData?.SiteLevel ?? (-1);
			EndAction();
			return;
		}
		if (targetList == null || targetList.value.Count <= 0)
		{
			EndAction();
			return;
		}
		int num = -1;
		foreach (int item in targetList.value)
		{
			if (ownerEntity.GetSystem<EntitySystem>().GetEntity(item) != null)
			{
				int num2 = bulletEntity.GetData<BulletData>("bulletData").LastHitData?.SiteLevel ?? (-1);
				num = ((num >= num2) ? num : num2);
			}
		}
		maxLevel.value = num;
	}
}
