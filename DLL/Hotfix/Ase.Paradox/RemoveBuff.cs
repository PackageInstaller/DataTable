using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("移除BUFF", 0)]
[Category("✫ DragonLost/Buff")]
[Description("用于移除指定实体身上的BUFF")]
public class RemoveBuff : ActionTaskBase
{
	[Name("BUFF编号", 0)]
	[RequiredField]
	[Description("要移除的BUFF的编号")]
	public BBParameter<int> buffId;

	[Name("目标实体ID", 0)]
	[Description("要移除BUFF的目标实体的ID")]
	public BBParameter<int> entityId;

	protected override void OnExecute()
	{
		base.OnExecute();
		ownerEntity.GetSystem<BuffSystem>()?.FinishEntityBuff(entityId.value, buffId.value);
		OnActionFinish();
	}
}
