using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("生成精灵", 0)]
[Category("Render/Asset")]
[Description("记录空气墙数据")]
public class SpawnElfin : CallableActionNode<int, string>
{
	public override void Invoke(int agent, string path)
	{
		SpawnPendant.Create<Elfin>(agent, path);
	}
}
