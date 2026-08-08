using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("添加BoxCollider", 0)]
[Category("Render/Asset")]
[Description("添加BoxCollider")]
public class AddBoxCollider : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<GameObject> gameObjectInput = AddValueInput<GameObject>("空气墙对象");
		AddValueInput<Int3>("中心位置");
		ValueInput<Int3> sizeInput = AddValueInput<Int3>("大小");
		FlowOutput output = AddFlowOutput("Out");
		AddFlowInput("In", delegate(Flow f)
		{
			GameObject value = gameObjectInput.value;
			if (value != null)
			{
				BoxCollider boxCollider = U3DUtil.Get<BoxCollider>(value);
				boxCollider.size = (Vector3)sizeInput.value;
				boxCollider.center = (Vector3)new Int3(0, 0, -sizeInput.value.z / 2);
				boxCollider.size = boxCollider.size.NewZ(0.1f);
				boxCollider.center = Vector3.zero;
			}
			output.Call(f);
		});
	}
}
