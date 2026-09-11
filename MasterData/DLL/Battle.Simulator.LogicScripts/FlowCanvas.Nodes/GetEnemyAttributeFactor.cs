using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取怪物属性倍率", 0)]
[Category("Logic/Spawn")]
[Description("获取怪物属性倍率")]
public class GetEnemyAttributeFactor : FlowNode
{
	protected override void RegisterPorts()
	{
		AddValueOutput("血量倍率", () => CommonProcessor.GetWorldState().currentEnemyHPAttributeFactor.i);
		AddValueOutput("攻击倍率", () => CommonProcessor.GetWorldState().currentEnemyATKAttributeFactor.i);
		AddValueOutput("防御倍率", () => CommonProcessor.GetWorldState().currentEnemyDEFAttributeFactor.i);
	}
}
