using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取当前玩家ID", 0)]
[Category("Logic/Spawn")]
[Description("获取当前玩家ID")]
public class GetCurrentPlayerID : CallableFunctionNode<int>
{
	public override int Invoke()
	{
		return SpawnProcessor.GetLocalPlayerID();
	}
}
