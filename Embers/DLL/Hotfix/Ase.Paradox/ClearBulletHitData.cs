using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("清空子弹的击中信息", 0)]
[Category("✫ DragonLost/Bullet")]
[Description("用于清空特定子弹的击中信息")]
public class ClearBulletHitData : ActionTaskBase
{
	[Name("实体ID", 0)]
	[Description("需要清空击中信息的实体的ID")]
	public BBParameter<int> EntityId;

	[Name("子弹的ConfigID", 0)]
	[Description("要清空击中信息的子弹的ConfigID")]
	public int BulletConfig;

	protected override void OnExecute()
	{
		base.OnExecute();
		ownerEntity.GetComponent<HitComponent>().ClearBulletHitData(BulletConfig);
		EndAction();
	}
}
