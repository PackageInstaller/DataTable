using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("回收资源(分支出口)", 0)]
[Category("Render/Asset")]
[Description("回收资源")]
public class DestroyAsset2 : FlowControlNodeOfRender
{
	protected override void RegisterPorts()
	{
		ValueInput<GameObject> goInput = AddValueInput<GameObject>("资源", "gameObject");
		ValueInput<float> delayInput = AddValueInput<float>("延迟", "delay");
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput nullOut = AddFlowOutput("传入空", "nullOut");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			if (goInput.value == null)
			{
				nullOut.Call(f);
			}
			else
			{
				if (goInput.value.activeSelf)
				{
					PooledAsset.DestroyOrReturn(goInput.value, delayInput.value);
				}
				else
				{
					goInput.value.GetComponent<PooledAsset>().Return();
				}
				output.Call(f);
			}
		});
	}
}
