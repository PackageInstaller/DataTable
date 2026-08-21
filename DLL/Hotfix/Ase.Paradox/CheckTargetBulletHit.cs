using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("查询指定子弹攻击是否击中", 0)]
[Category("✫ DragonLost/Bullet")]
[Description("用于查询指定子弹攻击是否击中目标实体")]
public class CheckTargetBulletHit : ActionTaskBase
{
	[Name("使用子弹类型查询", 0)]
	[Description("是否使用子弹类型进行查询")]
	public bool checkBySillType;

	[Name("目标实体Id", 0)]
	[Description("目标实体的ID")]
	public BBParameter<int> targetId;

	[Name("攻击来源实体Id", 0)]
	[Description("攻击来源实体的ID")]
	public BBParameter<int> attackId;

	[Name("目标子弹Id", 0)]
	[Description("目标子弹的ID")]
	public BBParameter<int> attackBulletId;

	[Name("子弹所属技能ID", 0)]
	[Description("子弹所属技能ID")]
	public BBParameter<int> AttackBulletSkillId;

	[Name("结果", 0)]
	[Description("查询结果，表示指定子弹攻击是否击中目标实体")]
	public BBParameter<bool> isHit;

	[Name("是否清理数据", 0)]
	[Description("是否在查询后清理击中数据")]
	public bool isClear;

	protected override void OnExecute()
	{
	}
}
