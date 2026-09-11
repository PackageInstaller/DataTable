using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("(团雪)得分特效", 0)]
[Category("Render/UI")]
[Description("团雪用，播放一个得分特效")]
[ExposeAsDefinition]
public class ShowScoreTip : FlowNode
{
	public GameObject scoreObj;

	private ScoreTips tip;

	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("Out");
		FlowOutput errorOut = AddFlowOutput("Error");
		ValueInput<GameObject> gameObjectInput = AddValueInput<GameObject>("分数预制体", "tipObject");
		ValueInput<int> scoreInput = AddValueInput<int>("score");
		AddFlowInput("init", delegate(Flow f)
		{
			scoreObj = gameObjectInput.value;
			if (scoreObj != null)
			{
				tip = scoreObj.GetComponent<ScoreTips>();
			}
			if (tip == null)
			{
				errorOut.Call(f);
			}
			else
			{
				output.Call(f);
			}
		});
		AddFlowInput("刷新分数", delegate(Flow f)
		{
			int value = scoreInput.value;
			if (scoreObj == null || tip == null)
			{
				errorOut.Call(f);
			}
			else
			{
				tip.AddValue(value);
				output.Call(f);
			}
		});
	}
}
