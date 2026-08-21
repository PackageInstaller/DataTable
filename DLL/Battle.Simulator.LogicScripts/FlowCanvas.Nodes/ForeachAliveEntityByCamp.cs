using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("遍历存活实体(指定阵营)", 0)]
[Category("Logic/Entity")]
[Description("遍历场内指定阵营的，生命值大于0的实体\n注意仅考虑生命值")]
public class ForeachAliveEntityByCamp : FlowControlNode
{
	private int m_entityID;

	private bool _Break;

	private ValueInput<RoleType> vInRoleType;

	protected override void RegisterPorts()
	{
		FlowOutput doOutput = AddFlowOutput("Do", "do");
		FlowOutput doneOutput = AddFlowOutput("Done", "done");
		vInRoleType = AddValueInput<RoleType>("阵营");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			_Break = false;
			f.breakCall = delegate
			{
				_Break = true;
			};
			SimEntity[] entities = base.mSimContext.GetEntities();
			SimEntity simEntity = null;
			for (int num = 0; num < entities.Length; num++)
			{
				m_entityID = 0;
				simEntity = entities[num];
				if (simEntity.hasEntityCamp && RoleCampProcessor.Is((uint)vInRoleType.value, simEntity.entityCamp.mRoleTypeCamp) && simEntity.entityBlackboard.var.mHP > 0 && simEntity.hasEntityRemotePlayer)
				{
					m_entityID = simEntity.creationIndex;
					doOutput.Call(f);
					if (_Break)
					{
						break;
					}
				}
			}
			doneOutput.Call(f);
		});
		AddValueOutput("实体ID", "EntityID", () => m_entityID);
	}
}
