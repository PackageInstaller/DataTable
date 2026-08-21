using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("获取自身实体ID", 0)]
[Description("从当前任务所属的实体获取其 ID。")]
[Category("✫ DragonLost/Entity")]
public class GetEntityId : ActionTaskBase
{
	[Name("实体ID", 0)]
	[Description("存储获取到的实体的ID。")]
	public BBParameter<int> EntityId;

	protected override void OnExecute()
	{
		base.OnExecute();
		EntityId.value = GetOwnerEntity().Id;
		EndAction();
	}
}
