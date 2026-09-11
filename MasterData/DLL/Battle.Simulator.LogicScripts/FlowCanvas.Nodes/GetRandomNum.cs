using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获得随机值", 0)]
[Category("Logic/Random")]
[Description("判断逻辑组件是否存在,不包括上限值[0, rang)")]
[ExposeAsDefinition]
public class GetRandomNum : PureFunctionNode<int, uint>
{
	public override int Invoke(uint range)
	{
		return (int)DRandom.Random(range);
	}
}
