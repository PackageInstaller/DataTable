using System.Collections.Generic;
using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("获取子弹命中的弱点等级 (弃用)", 0)]
[Category("✫ DragonLost/Bullet")]
[Description("用于查询特定子弹命中目标后的弱点等级列表")]
public class GetBulletHitWeakness : ActionTaskBase
{
	[Name("查询子弹方式", 0)]
	[Description("指定查询子弹的方式：通过子弹实体Id或直接传入子弹实体")]
	public QuerryBulletType _querryBulletType;

	[Name("子弹实体Id", 0)]
	[ShowIf("_querryBulletType", 0)]
	[Description("要查询的子弹实体的ID")]
	public BBParameter<int> bulletId;

	[Name("子弹实体", 0)]
	[ShowIf("_querryBulletType", 1)]
	[Description("直接传入要查询的子弹实体")]
	public BBParameter<BaseEntity> bulletEntity;

	[Name("目标实体Id", 0)]
	[Description("要查询的目标实体的ID")]
	public BBParameter<int> targetId;

	[Name("获取后是否清理数据", 0)]
	[Description("指示在获取弱点等级列表后是否清除命中数据")]
	public bool isClear;

	[Name("返回弱点等级列表", 0)]
	[Description("存储查询到的弱点等级列表")]
	public BBParameter<List<int>> weaknessLevelList;

	protected override void OnExecute()
	{
	}
}
