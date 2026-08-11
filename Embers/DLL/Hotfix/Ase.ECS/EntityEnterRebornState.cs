using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.ECS;

[Name("实体进入重生状态并开始倒计时", 0)]
[Description("将指定实体设置为重生状态，并开始复活倒计时。")]
[Category("✫ DragonLost/Entity")]
public class EntityEnterRebornState : ActionTaskBase
{
	[Name("实体Id", 0)]
	[Description("要进入重生状态的实体的实体Id。")]
	public BBParameter<int> entityId;

	[Name("是否可以重生", 0)]
	[Description("是否可以进行重生。")]
	public BBParameter<bool> IsReborn;

	protected override void OnExecute()
	{
		base.OnExecute();
		BaseEntity entity = GetEntity(entityId.value, isSyncEntity: false);
		if (entity == null)
		{
			EndAction();
			return;
		}
		IsReborn.value = entity.GetComponent<ReBornComponent>().EntityEnterRebornState();
		EndAction();
	}
}
