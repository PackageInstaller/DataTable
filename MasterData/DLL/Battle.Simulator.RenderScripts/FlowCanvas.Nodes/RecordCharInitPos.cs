using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Category("Render/UI")]
[Description("RecordCharInitPos, 记录玩家初始位置")]
public class RecordCharInitPos : FlowNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("");
		ValueInput<Int3> posInput = AddValueInput<Int3>("位置");
		AddFlowInput("", delegate(Flow f)
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene != null)
			{
				battleScene.SetCharInitPos((Vector3)posInput.value);
			}
			f.Call(output);
		});
	}
}
