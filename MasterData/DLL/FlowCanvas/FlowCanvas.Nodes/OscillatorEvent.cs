using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("OSC Pulse", 0)]
[Category("Events/Other")]
[Description("Calls Hi when curve value is greater than 0, else calls Low.\nThe curve is evaluated over time and it's evaluated value is exposed")]
public class OscillatorEvent : EventNode, IUpdatable
{
	public BBParameter<AnimationCurve> curve;

	private float time;

	private float value;

	private FlowOutput hi;

	private FlowOutput low;

	public OscillatorEvent()
	{
		Keyframe keyframe = new Keyframe(0f, 1f);
		Keyframe keyframe2 = new Keyframe(0.5f, 1f);
		Keyframe keyframe3 = new Keyframe(0.5f, -1f);
		Keyframe keyframe4 = new Keyframe(1f, -1f);
		curve = new BBParameter<AnimationCurve>(new AnimationCurve(keyframe, keyframe2, keyframe3, keyframe4));
	}

	protected override void RegisterPorts()
	{
		hi = AddFlowOutput("Hi");
		low = AddFlowOutput("Low");
		AddValueOutput("Value", () => value);
	}

	public override void OnGraphStarted()
	{
		time = 0f;
	}

	public void Update()
	{
		value = curve.value.Evaluate(time);
		time += Time.deltaTime;
		time = Mathf.Repeat(time, 1f);
		Flow.New.Call((value >= 0f) ? hi : low);
	}
}
