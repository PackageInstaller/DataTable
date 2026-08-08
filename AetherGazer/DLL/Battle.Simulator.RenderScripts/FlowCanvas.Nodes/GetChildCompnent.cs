using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("根据路径获取子物件上的组件", 0)]
[Category("Render/UI")]
[Description("根据路径获取子物件上的组件")]
public class GetChildCompnent<T> : FlowNode where T : Component
{
	private T _instance;

	protected override void RegisterPorts()
	{
		ValueInput<string> pathInput = AddValueInput<string>("路径");
		ValueInput<GameObject> parentInput = AddValueInput<GameObject>("父亲");
		AddValueOutput("实例", () => _instance);
		FlowOutput flowOutput = AddFlowOutput("OUT");
		FlowOutput errorOutput = AddFlowOutput("ERROR");
		AddFlowInput("IN", delegate(Flow f)
		{
			if (!string.IsNullOrEmpty(pathInput.value))
			{
				Transform transform = parentInput.value.transform.Find(pathInput.value);
				if (null == transform)
				{
					errorOutput.Call(f);
				}
				else
				{
					_instance = transform.GetComponent<T>();
					if (null == _instance)
					{
						errorOutput.Call(f);
					}
					else
					{
						flowOutput.Call(f);
					}
				}
			}
		});
	}
}
