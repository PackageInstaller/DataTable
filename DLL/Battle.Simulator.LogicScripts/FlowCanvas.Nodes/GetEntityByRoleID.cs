using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("遍历阵营实体(实体类型ID)(逻辑)", 0)]
[Category("Logic/Entity")]
[Description("遍历传入阵营内实体类型ID对应的全部实体")]
public class GetEntityByRoleID : FlowControlNode
{
	private int _EntityID;

	private ValueInput<int> _RoleIDInput;

	private ValueInput<RoleType> _RoleCampInput;

	private FlowOutput _DoOutput;

	private FlowOutput _DoneOutput;

	protected override void RegisterPorts()
	{
		_RoleIDInput = AddValueInput<int>("实体类型ID", "roleID");
		_RoleCampInput = AddValueInput<RoleType>("阵营", "RoleType");
		_DoOutput = AddFlowOutput("Do", "do");
		_DoneOutput = AddFlowOutput("Done", "done");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			if (_RoleCampInput.GetValue() == RoleType.None)
			{
				_DoneOutput.Call(f);
			}
			else
			{
				SimEntity[] entities = base.mSimContext.GetEntities();
				SimEntity simEntity = null;
				for (int i = 0; i < entities.Length; i++)
				{
					_EntityID = 0;
					simEntity = entities[i];
					if (simEntity.hasEntityCamp && RoleCampProcessor.Is((uint)_RoleCampInput.GetValue(), simEntity.entityCamp.mRoleTypeCamp) && simEntity.hasEntityConfig && simEntity.entityConfig.mId == _RoleIDInput.GetValue() && simEntity.hasEntityRemotePlayer)
					{
						_EntityID = simEntity.creationIndex;
						_DoOutput.Call(f);
					}
				}
				_DoneOutput.Call(f);
			}
		});
		AddValueOutput("实体ID", "EntityID", () => _EntityID);
	}
}
