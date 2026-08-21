using System.Collections.Generic;
using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("矩形触发区域(阵营与实体类型ID)", 0)]
[Category("Logic/Trigger")]
[Description("判断指定实体是否进入到这个区域中")]
public class BoxTriggerAreaWithCampAndEntityID : FlowNode
{
	private List<int> collisions = new List<int>();

	private HashSet<int> entityIDs = new HashSet<int>();

	private int _entityID;

	protected override void RegisterPorts()
	{
		ValueInput<Int3> positionInput = AddValueInput<Int3>("位置", "position");
		ValueInput<Int3> forwardInput = AddValueInput<Int3>("朝向", "forward");
		ValueInput<Int3> sizeInput = AddValueInput<Int3>("大小", "size");
		ValueInput<int> roleID = AddValueInput<int>("实体类型ID", "roleID");
		ValueInput<RoleType> roleCamp = AddValueInput<RoleType>("阵营").SetDefaultAndSerializedValue(RoleType.Player);
		FlowOutput DoOutput = AddFlowOutput("Do");
		FlowOutput DoneOutput = AddFlowOutput("Done");
		FlowOutput NoneOutput = AddFlowOutput("None");
		AddValueOutput("实体ID", "entityID", () => _entityID);
		AddFlowInput("In", delegate(Flow f)
		{
			collisions.Clear();
			entityIDs.Clear();
			uint roleCamp2 = 0u;
			RoleCampProcessor.Set(ref roleCamp2, (uint)roleCamp.value);
			SimPhysics.OverlapBox(positionInput.value, forwardInput.value, Int3.zero, sizeInput.value, collisions, roleCamp2);
			if (collisions.Count <= 0)
			{
				_entityID = 0;
				NoneOutput.Call(f);
			}
			else
			{
				foreach (int collision in collisions)
				{
					SimEntity simEntityByMultiColliders = CommonProcessor.GetSimEntityByMultiColliders(collision);
					if (simEntityByMultiColliders != null && !entityIDs.Contains(simEntityByMultiColliders.creationIndex) && (roleID.value == 0 || (simEntityByMultiColliders.hasEntityConfig && simEntityByMultiColliders.entityConfig.mId == roleID.value)))
					{
						_entityID = simEntityByMultiColliders.creationIndex;
						entityIDs.Add(_entityID);
						DoOutput.Call(f);
					}
				}
				DoneOutput.Call(f);
			}
		});
	}
}
