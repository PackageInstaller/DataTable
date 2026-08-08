using ParadoxNotion.Design;
using UnityEngine.UI;

namespace FlowCanvas.Nodes;

[Name("更新UI时间", 0)]
[Category("Render/UI")]
[Description("更新时间")]
public class UpdateTime : FlowNode
{
	private int count;

	protected override void RegisterPorts()
	{
		ValueInput<Text> goInput = AddValueInput<Text>("text对象");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			WorldStateManager worldStateManager = WorldStateManager.GetWorldStateManager();
			if (worldStateManager != null)
			{
				if (worldStateManager.uITimeType == UITimeType.hide)
				{
					output.Call(f);
				}
				else
				{
					int num = (int)worldStateManager.data.dataForLua.battleTime;
					if (worldStateManager.uITimeType == UITimeType.decrease)
					{
						num = worldStateManager.totalTime / 1000 - num;
					}
					if (count != num && num >= 0)
					{
						Text value = goInput.value;
						if (value == null)
						{
							return;
						}
						string empty = string.Empty;
						if (num < CommonString.Timestamp.Length)
						{
							empty = CommonString.Timestamp[num];
						}
						else
						{
							long num2 = num / 60;
							long num3 = num % 60;
							string text = CommonString.Numbers[num2];
							if (num2 < 10)
							{
								text = "0" + text;
							}
							string text2 = CommonString.Numbers[num3];
							if (num3 < 10)
							{
								text2 = "0" + text2;
							}
							empty = text + ":" + text2;
						}
						value.text = empty;
						count = num;
					}
					output.Call(f);
				}
			}
		});
	}
}
