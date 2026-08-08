using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("矩形触发区域(实体类型ID)", 0)]
[Category("Logic/Trigger")]
[Description("判断玩家是否进入到这个区域中")]
public class BoxTriggerAreaWithEntityIDs : FlowControlNodeOfLogic
{
	private List<int> collisions = new List<int>();

	private int _entityID;

	protected override void RegisterPorts()
	{
		ValueInput<Int3> positionInput = AddValueInput<Int3>("位置");
		ValueInput<Int3> forwardInput = AddValueInput<Int3>("朝向");
		ValueInput<Int3> sizeInput = AddValueInput<Int3>("大小");
		ValueInput<int> roleIDInput = AddValueInput<int>("实体类型ID", "roleID");
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		AddValueOutput("实体ID", "entityID", () => _entityID);
		AddFlowInput("In", delegate(Flow f)
		{
			_entityID = 0;
			collisions.Clear();
			uint roleCamp = 0u;
			RoleCampProcessor.Set(ref roleCamp, 1u);
			SimPhysics.OverlapBox(positionInput.value, forwardInput.value, Int3.zero, sizeInput.value, collisions, roleCamp);
			if (collisions.Count > 0)
			{
				foreach (int collision in collisions)
				{
					SimEntity simEntityByMultiColliders = CommonProcessor.GetSimEntityByMultiColliders(collision);
					if (simEntityByMultiColliders != null && simEntityByMultiColliders.hasEntityConfig && simEntityByMultiColliders.entityConfig.mId == roleIDInput.value)
					{
						_entityID = simEntityByMultiColliders.creationIndex;
						break;
					}
				}
			}
			if (_entityID != 0)
			{
				trueOut.Call(f);
			}
			else
			{
				falseOut.Call(f);
			}
		});
	}
}
