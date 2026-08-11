using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("获取实体ConfigID", 0)]
[Description("从指定的实体获取其对应的 ConfigID。")]
[Category("✫ DragonLost/Entity")]
public class GetEntityConfigId : ActionTaskBase
{
	[Name("实体ID", 0)]
	[Description("要获取 ConfigID 的实体的ID。")]
	public BBParameter<int> EntityId;

	[Name("ConfigId", 0)]
	[Description("存储获取到的实体的 ConfigID。")]
	public BBParameter<int> ConfigId;

	protected override void OnExecute()
	{
		base.OnExecute();
		ConfigId.value = GetEntity(EntityId.value, isSyncEntity: true)?.EntityId ?? 0;
		EndAction();
	}
}
