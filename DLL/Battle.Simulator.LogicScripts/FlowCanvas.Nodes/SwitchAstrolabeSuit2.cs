using System;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("遍历星盘(规则生成)", 0)]
[Category("Logic/星盘")]
[Description("")]
[ContextDefinedInputs(new Type[] { typeof(int) })]
[HasRefreshButton]
public class SwitchAstrolabeSuit2 : FlowControlNode
{
	[Name("实体类型ID", 0)]
	public int RoleID;

	[Name("套装数量", 0)]
	public int SuitCount = 4;

	[Name("每套效果数", 0)]
	public int SuitEffectCount = 3;

	private int suitID;

	private string portID = string.Empty;

	private bool suitEableState;

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDVar = AddValueInput<int>("EntityID", "entityIDVar");
		int effectCount = SuitCount * SuitEffectCount;
		FlowOutput[] cases = new FlowOutput[effectCount];
		int[] suitIDArr = new int[effectCount];
		bool[] enableArr = new bool[effectCount];
		for (int i = 0; i < SuitCount; i++)
		{
			for (int j = 0; j < SuitEffectCount; j++)
			{
				suitID = RoleID * 10000 + (i + 1) * 10 + (j + 1);
				suitIDArr[i * SuitEffectCount + j] = suitID;
				portID = suitID.ToString();
				cases[i * SuitEffectCount + j] = AddFlowOutput(portID, portID);
			}
		}
		FlowOutput defaultCase = AddFlowOutput("Default");
		AddFlowInput("In", delegate(Flow f)
		{
			int value = entityIDVar.GetValue();
			int varName = 2023;
			int attributeIDByEntityID = AttributeProcessor.GetAttributeIDByEntityID(value);
			for (int k = 0; k < 27; k++)
			{
				AttributeProcessor.GetAttributeWithIntName(attributeIDByEntityID, varName, out var baseValue, out var _, out var _);
				if (baseValue == 0L)
				{
					break;
				}
				for (int l = 0; l < effectCount; l++)
				{
					if (suitIDArr[l] == baseValue)
					{
						enableArr[l] = true;
						break;
					}
				}
			}
			for (int m = 0; m < effectCount; m++)
			{
				suitEableState = enableArr[m];
				cases[m].Call(f);
			}
			defaultCase.Call(f);
		});
		AddValueOutput("激活状态", "suitEableState", () => suitEableState);
	}
}
