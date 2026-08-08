using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("添加词缀", 0)]
[Category("Logic/Trigger")]
[Description("添加词缀,这几个list长度必须一样")]
public class AddAffix : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		AddValueOutput("实体ID", () => entityIDInput.value);
		ValueInput<List<int>> affixIDsInput = AddValueInput<List<int>>("词缀ID");
		ValueInput<List<int>> affixWeightsInput = AddValueInput<List<int>>("词缀权重");
		ValueInput<List<int>> affixLevelsInput = AddValueInput<List<int>>("词缀等级");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			List<int> value = affixIDsInput.value;
			List<int> value2 = affixWeightsInput.value;
			List<int> value3 = affixLevelsInput.value;
			int value4 = entityIDInput.value;
			int num = (int)DRandom.Random(100u);
			int num2 = 0;
			bool flag = false;
			for (int i = 0; i < value.Count; i++)
			{
				num2 += value2[i];
				if (num < num2 && !flag)
				{
					if (base.mSimContext.GetSimInterface().mAddAffixEvent != null)
					{
						base.mSimContext.GetSimInterface().mAddAffixEvent(value4, value[i], value3[i]);
					}
					flag = true;
				}
				if (num2 >= 100)
				{
					num = (int)DRandom.Random(100u);
					num2 = 0;
					flag = false;
				}
			}
			f.Call(output);
		});
	}
}
