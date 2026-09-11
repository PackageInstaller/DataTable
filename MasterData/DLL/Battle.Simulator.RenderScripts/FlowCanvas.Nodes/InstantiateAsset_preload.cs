using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("实例化资源_preload", 0)]
[Category("Render/Asset")]
[Description("实例化资源")]
[ExposeAsDefinition]
public class InstantiateAsset_preload : EffectCreateBaseNode
{
	protected override void RegisterPorts()
	{
		base.RegisterPorts();
		ValueInput<Int3> positionInput = AddValueInput<Int3>("Position");
		ValueInput<Int3> forwardInput = AddValueInput<Int3>("Forward");
		ValueInput<Int3> SizeInput = AddValueInput<Int3>("Size");
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput errorOout = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			string value = _effectPathInput.value;
			Int3 value2 = positionInput.value;
			Int3 value3 = forwardInput.value;
			Int3 value4 = SizeInput.value;
			GameObject gameObject = Asset.Instantiate(value);
			if (gameObject == null)
			{
				errorOout.Call(f);
			}
			else
			{
				gameObject.transform.position = (Vector3)value2;
				gameObject.transform.forward = (Vector3)value3;
				gameObject.transform.localScale = (Vector3)value4;
				_effectInstance = gameObject;
				output.Call(f);
			}
		});
	}
}
