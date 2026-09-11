using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("记录空气墙数据", 0)]
[Category("Render/Asset")]
[Description("记录空气墙数据")]
[ExposeAsDefinition]
public class NewAirWall : CallableFunctionNode<AirWallInfo, int, Int3, Int3, Int3>
{
	public override AirWallInfo Invoke(int id, Int3 position, Int3 forward, Int3 size)
	{
		return new AirWallInfo
		{
			ID = id,
			Position = position,
			Forward = forward,
			Size = size
		};
	}
}
