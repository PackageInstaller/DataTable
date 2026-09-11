using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("设置怪物属性倍率", 0)]
[Category("Logic/Spawn")]
[Description("设置怪物属性倍率")]
public class SetEnemyAttributeFactor : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> valueInput = AddValueInput<int>("血量倍率");
		ValueInput<int> attackInput = AddValueInput<int>("攻击倍率");
		ValueInput<int> defendInput = AddValueInput<int>("防御倍率");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			CommonProcessor.GetWorldState().currentEnemyHPAttributeFactor = valueInput.value;
			CommonProcessor.GetWorldState().currentEnemyATKAttributeFactor = attackInput.value;
			CommonProcessor.GetWorldState().currentEnemyDEFAttributeFactor = defendInput.value;
			output.Call(f);
		});
	}
}
