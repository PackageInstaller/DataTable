using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("获取状态的施加者", 0)]
[Category("✫ DragonLost/State")]
[Description("获取当前实体所附加状态的施加者，并将其存储在指定的变量中。")]
public class GetStateInflictionAction : ActionTaskBase
{
	[Name("施加者", 0)]
	[Description("存储状态施加者的变量。")]
	public BBParameter<int> InflictionId;

	protected override void OnExecute()
	{
		base.OnExecute();
		BaseEntity entity = GetEntity(ownerEntity.Id, isSyncEntity: false);
		InflictionId.value = entity.GetComponent<StateComponent>().GetStateInfliction();
		EndAction();
	}
}
