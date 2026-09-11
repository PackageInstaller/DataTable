using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("矩形触发区域", 0)]
[Category("Logic/Trigger")]
[Description("判断玩家是否进入到这个区域中")]
public class BoxTriggerArea : FlowNode
{
	private List<int> collisions = new List<int>();

	protected override void RegisterPorts()
	{
		ValueInput<Int3> positionInput = AddValueInput<Int3>("位置");
		ValueInput<Int3> forwardInput = AddValueInput<Int3>("朝向");
		ValueInput<Int3> sizeInput = AddValueInput<Int3>("大小");
		FlowOutput trueOut = AddFlowOutput("true");
		FlowOutput falseOut = AddFlowOutput("false");
		AddFlowInput("In", delegate(Flow f)
		{
			collisions.Clear();
			uint roleCamp = 0u;
			RoleCampProcessor.Set(ref roleCamp, 1u);
			SimPhysics.OverlapBox(positionInput.value, forwardInput.value, Int3.zero, sizeInput.value, collisions, roleCamp);
			for (int i = 0; i < collisions.Count; i++)
			{
				SimEntity simEntityByMultiColliders = CommonProcessor.GetSimEntityByMultiColliders(collisions[i]);
				if (simEntityByMultiColliders != null && !simEntityByMultiColliders.hasEntityAIThink)
				{
					trueOut.Call(f);
					return;
				}
			}
			falseOut.Call(f);
		});
	}
}
