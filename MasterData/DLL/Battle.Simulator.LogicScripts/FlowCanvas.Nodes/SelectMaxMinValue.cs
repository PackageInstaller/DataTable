using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("筛选最大值或最小值", 0)]
[Category("Common/Math")]
[Description("自行输入一系列Integer值，并输出之前输入所有值的最大或最小值及其下标。\n允许输入重复值。若最大或最小值有重复，则优先选靠前（靠近0）的\n添加值：向节点内部的列表添加一个int，添加完成后输出【添加完成】控制流\n清空列表：清空节点内部存值的列表，清空后输出【清空】控制流\n输出最大/小值：从当前节点内部列表中选出最大/小值并输出到【输出值】，对应下标输出到【值下标】，并输出Out控制流。若列表为空，则输出【列表为空】控制流，此时两个输出值均无效")]
public class SelectMaxMinValue : FlowNode
{
	private ValueInput<int> vInValue;

	private List<int> values = new List<int>(5);

	private int destValue;

	private int index;

	public override void OnGraphStarted()
	{
		base.OnGraphStarted();
		values = new List<int>(5);
	}

	protected override void RegisterPorts()
	{
		vInValue = AddValueInput<int>("Value");
		FlowOutput fOutAdd = AddFlowOutput("添加完成");
		FlowOutput fOutClear = AddFlowOutput("清空");
		FlowOutput fOutEmpty = AddFlowOutput("列表为空");
		FlowOutput fOut = AddFlowOutput("Out");
		AddFlowInput("添加值", delegate(Flow f)
		{
			values.Add(vInValue.value);
			fOutAdd.Call(f);
		});
		AddFlowInput("清空列表", delegate(Flow f)
		{
			values.Clear();
			fOutClear.Call(f);
		});
		AddFlowInput("输出最大值", delegate(Flow f)
		{
			if (values.Count == 0)
			{
				fOutEmpty.Call(f);
			}
			else
			{
				destValue = int.MinValue;
				for (int i = 0; i < values.Count; i++)
				{
					if (destValue < values[i])
					{
						destValue = values[i];
						index = i;
					}
				}
				fOut.Call(f);
			}
		});
		AddFlowInput("输出最小值", delegate(Flow f)
		{
			if (values.Count == 0)
			{
				fOutEmpty.Call(f);
			}
			else
			{
				destValue = int.MaxValue;
				for (int i = 0; i < values.Count; i++)
				{
					if (destValue > values[i])
					{
						destValue = values[i];
						index = i;
					}
				}
				fOut.Call(f);
			}
		});
		AddValueOutput("输出值", () => destValue);
		AddValueOutput("值下标", () => index);
	}
}
