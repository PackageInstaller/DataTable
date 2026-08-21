using System.Collections.Generic;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("[特效]创建特效(静态导航线)", 0)]
[Category("Render/Asset")]
[Description("静态导航线")]
public class TDMonsterNavigationLine : EffectCreateBaseNode
{
	protected override void RegisterPorts()
	{
		base.RegisterPorts();
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		ValueInput<List<Vector3>> posListInput = AddValueInput<List<Vector3>>("坐标组", "posList");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			GameObject gameObject = Asset.Instantiate(_effectPathInput.value);
			if (gameObject == null)
			{
				errorOut.Call(f);
			}
			else
			{
				_effectInstance = gameObject;
				LineRenderer componentInChildren = gameObject.GetComponentInChildren<LineRenderer>();
				if (componentInChildren == null)
				{
					errorOut.Call(f);
				}
				else
				{
					List<Vector3> value = posListInput.value;
					componentInChildren.positionCount = value.Count;
					for (int i = 0; i < value.Count; i++)
					{
						componentInChildren.SetPosition(i, value[i]);
					}
					output.Call(f);
				}
			}
		});
	}
}
