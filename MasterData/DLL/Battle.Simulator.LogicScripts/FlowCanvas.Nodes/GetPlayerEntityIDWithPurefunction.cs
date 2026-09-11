using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取当前玩家ID(pure)", 0)]
[Category("Logic/Spawn")]
[Description("获取当前玩家ID")]
public class GetPlayerEntityIDWithPurefunction : PureFunctionNode<int>
{
	public override int Invoke()
	{
		return SpawnProcessor.GetLocalPlayerID();
	}
}
