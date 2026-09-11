using System;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("Input Axis (Preset)", 0)]
[Category("Events/Input")]
[Description("Calls out when Horizontal or Vertical Input Axis is not zero")]
[Obsolete("Use Input Axis")]
public class InputAxisEvent : EventNode, IUpdatable
{
	private FlowOutput o;

	private float horizontal;

	private float vertical;

	private bool calledLastFrame;

	protected override void RegisterPorts()
	{
		o = AddFlowOutput("Out");
		AddValueOutput("Horizontal", () => horizontal);
		AddValueOutput("Vertical", () => vertical);
	}

	public void Update()
	{
		horizontal = Input.GetAxis("Horizontal");
		vertical = Input.GetAxis("Vertical");
		if (horizontal != 0f || vertical != 0f)
		{
			o.Call(default(Flow));
			calledLastFrame = true;
		}
		if (horizontal == 0f && vertical == 0f && calledLastFrame)
		{
			o.Call(default(Flow));
			calledLastFrame = false;
		}
	}
}
