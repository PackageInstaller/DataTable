using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("注册黑板变量绑定事件--移除", 0)]
[Category("EventTree")]
[Description("行为树黑板可以根据战斗内事件改变")]
public class RemoveEventTreeAction : ActionTaskBase
{
	[Name("绑定的实体Id", 0)]
	public BBParameter<int> entityId;

	[Name("移除某个绑定事件", 0)]
	public BBParameter<int> actionID;

	protected override void OnExecute()
	{
		base.OnExecute();
		ownerEntity.GetSystem<EntitySystem>().GetEntity(entityId.value)?.GetSystem<ParadoxSystem>().RemoveTree(actionID.value);
		EndAction();
	}
}
