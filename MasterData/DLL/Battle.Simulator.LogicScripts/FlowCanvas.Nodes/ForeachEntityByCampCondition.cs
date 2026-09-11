using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("遍历阵营实体", 0)]
[Category("Logic/Entity")]
[Description("遍历传入阵营对应的实体")]
public class ForeachEntityByCampCondition : FlowControlNode
{
	private int m_entityID;

	private bool _Break;

	protected override void RegisterPorts()
	{
		ValueInput<RoleType> roleCampVar = AddValueInput<RoleType>("阵营", "RoleType");
		FlowOutput doOutput = AddFlowOutput("Do", "do");
		FlowOutput doneOutput = AddFlowOutput("Done", "done");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			if (roleCampVar.GetValue() == RoleType.None)
			{
				doneOutput.Call(f);
			}
			else
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
					if (simEntity.hasEntityCamp && RoleCampProcessor.Is((uint)roleCampVar.GetValue(), simEntity.entityCamp.mRoleTypeCamp) && simEntity.hasEntityRemotePlayer)
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
			}
		});
		AddValueOutput("实体ID", "EntityID", () => m_entityID);
	}
}
