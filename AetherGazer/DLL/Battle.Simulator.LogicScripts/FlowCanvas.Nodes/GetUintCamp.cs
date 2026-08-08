using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("判断阵营", 0)]
[Category("Logic/Config")]
[Description("判断输入的阵营(数字)是哪一方")]
public class GetUintCamp : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<uint> campInput = AddValueInput<uint>("阵营");
		FlowOutput enemyOut = AddFlowOutput("敌方阵营");
		FlowOutput playerOut = AddFlowOutput("玩家阵营");
		FlowOutput other = AddFlowOutput("其他阵营");
		AddFlowInput("In", delegate(Flow f)
		{
			uint value = campInput.value;
			if (RoleCampProcessor.IsEnemy(value))
			{
				enemyOut.Call(f);
			}
			else if (RoleCampProcessor.IsPlayer(value))
			{
				playerOut.Call(f);
			}
			else
			{
				other.Call(f);
			}
		});
	}
}
