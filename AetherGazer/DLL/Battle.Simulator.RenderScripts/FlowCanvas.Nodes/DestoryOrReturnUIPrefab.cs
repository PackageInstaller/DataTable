using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("回收UI预制体Preload", 0)]
[Category("Render/UI")]
[Description("回收UI预制体")]
public class DestoryOrReturnUIPrefab : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<GameObject> instInput = AddValueInput<GameObject>("实例");
		FlowOutput flowOutput = AddFlowOutput("OUT");
		AddFlowInput("IN", delegate(Flow f)
		{
			PooledAsset.DestroyOrReturn(instInput.value);
			flowOutput.Call(f);
		});
	}
}
