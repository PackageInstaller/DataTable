using Cinemachine;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("获取CinemachineBrain", 0)]
[Category("Render/Timeline")]
[Description("获取CinemachineBrain")]
public class GetCinemachineBrain : FlowNode
{
	protected override void RegisterPorts()
	{
		AddValueOutput("", () => Camera.main.gameObject.GetComponent<CinemachineBrain>());
	}
}
