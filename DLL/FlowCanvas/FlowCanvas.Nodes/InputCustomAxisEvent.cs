using System.Collections.Generic;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("Input Axis", 0)]
[Category("Events/Input")]
[Description("You are free to define any Input Axis in this node.\nAxis can be set in 'Project Settings/Input'.\nCalls Out when either of the Axis defined is not zero")]
public class InputCustomAxisEvent : EventNode, IUpdatable
{
	public BBParameter<List<string>> axis = new BBParameter<List<string>>(new List<string> { "Horizontal", "Vertical" });

	private float[] axisValues;

	private bool calledLastFrame;

	private FlowOutput o;

	protected override void RegisterPorts()
	{
		o = AddFlowOutput("Out");
		axisValues = new float[axis.value.Count + 1];
		for (int i = 0; i < axis.value.Count; i++)
		{
			int i2 = i;
			if (!string.IsNullOrEmpty(axis.value[i2]))
			{
				AddValueOutput(axis.value[i2], () => axisValues[i2], i2.ToString());
			}
		}
	}

	public void Update()
	{
		List<string> value = axis.value;
		bool flag = false;
		for (int i = 0; i < value.Count; i++)
		{
			if (!string.IsNullOrEmpty(value[i]))
			{
				float num = Input.GetAxis(value[i]);
				axisValues[i] = num;
				if (num != 0f)
				{
					flag = true;
				}
			}
		}
		if (flag)
		{
			o.Call(default(Flow));
			calledLastFrame = true;
		}
		if (!flag && calledLastFrame)
		{
			o.Call(default(Flow));
			calledLastFrame = false;
		}
	}
}
