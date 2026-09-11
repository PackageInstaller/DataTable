using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取玩家层", 0)]
[Category("Logic/Trigger")]
[Description("获取玩家的Layer")]
[ExposeAsDefinition]
public class GetPlayerLayer : CallableFunctionNode<uint>
{
	public override uint Invoke()
	{
		uint roleCamp = 0u;
		RoleCampProcessor.Set(ref roleCamp, 1u);
		return roleCamp;
	}
}
