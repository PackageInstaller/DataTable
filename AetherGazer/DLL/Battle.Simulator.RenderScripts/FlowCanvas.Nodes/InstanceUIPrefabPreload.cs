using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("实例化UI预制体Preload", 0)]
[Category("Render/UI")]
[Description("实例化UI预制体")]
public class InstanceUIPrefabPreload : EffectCreateBaseNode
{
	protected override void RegisterPorts()
	{
		base.RegisterPorts();
		ValueInput<GameObject> buttonEffectInput = AddValueInput<GameObject>("父亲");
		FlowOutput flowOutput = AddFlowOutput("OUT");
		AddFlowInput("IN", delegate(Flow f)
		{
			if (!string.IsNullOrEmpty(_effectPathInput.value))
			{
				GameObject gameObject = Asset.Instantiate(_effectPathInput.value);
				GameObject value = buttonEffectInput.value;
				if (null == value)
				{
					PooledAsset.DestroyOrReturn(gameObject);
				}
				else
				{
					_effectInstance = gameObject;
					gameObject.transform.SetParent(value.transform, worldPositionStays: false);
					flowOutput.Call(f);
				}
			}
		});
	}
}
