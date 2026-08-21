using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("设置下个区域的位置(AirTest)", 0)]
[Category("Render/Trigger")]
[Description("发送事件给对应的触发器(AirTest)")]
public class SetNextAreaDirectionToAirTest : CallableActionNode<Vector3>
{
	public override void Invoke(Vector3 direction)
	{
		AirTestTool.SetNextAreaDirection(direction);
	}
}
