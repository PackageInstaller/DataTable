using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("属性名字节点", 0)]
[Category("Logic/Attribute")]
[Description("属性名字节点")]
public class AttributeNameNode : FlowNode
{
	[SerializeField]
	public int value;

	protected override void RegisterPorts()
	{
		AddValueOutput("属性ID", () => value);
	}
}
