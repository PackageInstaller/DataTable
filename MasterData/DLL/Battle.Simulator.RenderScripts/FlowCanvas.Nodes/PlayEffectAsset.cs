using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("创建特效(纯粹)(渲染)_preload", 0)]
[Category("Render/Asset")]
[Description("纯粹地进行创建并播放特效，不受任何控制，特效等级跟着AI质量走")]
public class PlayEffectAsset : EffectCreateBaseNode
{
	protected override void RegisterPorts()
	{
		base.RegisterPorts();
		ValueInput<Vector3> positionInput = AddValueInput<Vector3>("Position", "Position");
		ValueInput<Vector3> forwardInput = AddValueInput<Vector3>("Rotation", "Forward").SetDefaultAndSerializedValue(Vector3.forward);
		ValueInput<Vector3> sizeInput = AddValueInput<Vector3>("Size", "Size").SetDefaultAndSerializedValue(Vector3.one);
		FlowOutput output = AddFlowOutput("Out", "output");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			string value = _effectPathInput.value;
			Vector3 value2 = positionInput.value;
			Vector3 value3 = forwardInput.value;
			Vector3 value4 = sizeInput.value;
			GameObject gameObject = Asset.Instantiate(value);
			if (!(gameObject == null))
			{
				gameObject.transform.position = value2;
				gameObject.transform.forward = value3;
				gameObject.transform.localScale = value4;
				_effectInstance = gameObject;
				EffectController component = _effectInstance.GetComponent<EffectController>();
				if (component != null)
				{
					component.Initialize(isLoop: true, float.MaxValue, 1f, BattleScene.AIQuality, null);
					component.EnableVirtualCameras();
					component.Simulator(0f);
				}
				output.Call(f);
			}
		});
	}
}
