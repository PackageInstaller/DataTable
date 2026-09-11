using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("创建碰撞体", 0)]
[Category("Logic/Trigger")]
[Description("创建碰撞体")]
public class CreateCollidShape : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<Int3> posInput = AddValueInput<Int3>("位置");
		ValueInput<int> radiusInput = AddValueInput<int>("半径");
		int entityID = 0;
		AddValueOutput("", () => entityID);
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			SimEntity simEntity = SpawnProcessor.CreateEmptyEntity();
			Int3 value = posInput.value;
			simEntity.AddEntityPositon(posInput.value, Int3.forward, IntMath.AngleOfVector(Int3.forward), Int3.up, newIsTeleport: false);
			SimSphere newMShape = SimShapeProcessor.CreateSimSphere(simEntity.creationIndex, value, radiusInput.value, value.y, Int3.forward, RoleType.Box);
			simEntity.AddEntityShape(Int3.zero, ShapePartType.Body, newMShape, uint.MaxValue, int.MaxValue, default(ShapePartInfo));
			entityID = simEntity.creationIndex;
			SimShapeProcessor.UpdateShapeWorldPosition(simEntity);
			output.Call(f);
		});
	}
}
