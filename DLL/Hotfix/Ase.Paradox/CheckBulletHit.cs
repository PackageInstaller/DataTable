using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("查询攻击是否击中", 0)]
[Category("✫ DragonLost/Bullet")]
[Description("用于查询子弹是否击中目标实体")]
public class CheckBulletHit : ActionTaskBase
{
	[Name("子弹实体Id", 0)]
	[Description("子弹实体的ID")]
	public BBParameter<int> bulletId;

	[Name("目标实体Id", 0)]
	[Description("目标实体的ID")]
	public BBParameter<int> targetId;

	[Name("结果", 0)]
	[Description("查询结果，表示子弹是否击中目标")]
	public BBParameter<bool> isHit;

	[Name("是否清理数据", 0)]
	[Description("是否清理攻击数据")]
	public bool isClear;

	protected override void OnExecute()
	{
		if (GetEntity(targetId.value, isSyncEntity: false) == null)
		{
			isHit.value = false;
			EndAction();
		}
		else if (!(GetEntity(bulletId.value, isSyncEntity: false) is BulletEntity bulletEntity))
		{
			isHit.value = false;
			EndAction();
		}
		else
		{
			BulletData data = bulletEntity.GetData<BulletData>("bulletData");
			isHit.value = data.LastHitData?.DefenderId == targetId.value;
			EndAction();
		}
	}
}
