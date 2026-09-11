using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("实例化UI预制体", 0)]
[Category("Render/UI")]
[Description("实例化UI预制体")]
public class InstanceUIPrefab : FlowNode
{
	private GameObject _instance;

	protected override void RegisterPorts()
	{
		ValueInput<string> pathInput = AddValueInput<string>("路径");
		ValueInput<GameObject> buttonEffectInput = AddValueInput<GameObject>("父亲");
		AddValueOutput("实例", () => _instance);
		FlowOutput flowOutput = AddFlowOutput("OUT");
		AddFlowInput("IN", delegate(Flow f)
		{
			if (!string.IsNullOrEmpty(pathInput.value))
			{
				GameObject gameObject = Asset.Instantiate(pathInput.value);
				GameObject value = buttonEffectInput.value;
				if (null == value)
				{
					PooledAsset.DestroyOrReturn(gameObject);
				}
				else
				{
					_instance = gameObject;
					gameObject.transform.SetParent(value.transform, worldPositionStays: false);
					flowOutput.Call(f);
				}
			}
		});
	}
}
