using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取敌人层", 0)]
[Category("Logic/Trigger")]
[Description("获取敌人的Lyaer")]
[ExposeAsDefinition]
public class GetEnemyLayer : CallableFunctionNode<uint>
{
	public override uint Invoke()
	{
		uint roleCamp = 0u;
		RoleCampProcessor.Set(ref roleCamp, 2u);
		return roleCamp;
	}
}
