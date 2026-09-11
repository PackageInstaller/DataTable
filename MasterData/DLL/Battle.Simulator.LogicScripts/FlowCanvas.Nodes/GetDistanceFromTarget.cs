using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取实体之间的距离", 0)]
[Category("Logic/PosAndRot")]
[Description("获取两个实体之间的距离,传入两个实体的ID, 这个距离是没有减去实体半径的")]
public class GetDistanceFromTarget : CallableFunctionNode<int, int, int>
{
	public override int Invoke(int targetID, int entityID)
	{
		Int3 entityPostion = AIProcessor.GetEntityPostion(entityID);
		Int3 entityPostion2 = AIProcessor.GetEntityPostion(targetID);
		return (entityPostion - entityPostion2).IntMagnitude.i;
	}
}
