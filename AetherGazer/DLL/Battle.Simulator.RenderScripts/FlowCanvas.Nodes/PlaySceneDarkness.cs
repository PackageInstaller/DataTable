using MessagePack;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("播放黑屏", 0)]
[Category("Render/Effect")]
[Description("播放黑屏")]
public class PlaySceneDarkness : FlowNode, IUpdatable
{
	private FlowOutput output;

	private bool start;

	private float currrentTime;

	private Flow flow;

	private float curveTime;

	private SceneSetting sceneSetting;

	public AnimationCurve curve;

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		options.Resolver.GetFormatterWithVerify<AnimationCurve>().Serialize(ref writer, curve, options);
	}

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		curve = options.Resolver.GetFormatterWithVerify<AnimationCurve>().Deserialize(ref reader, options);
	}

	public void Update()
	{
		if (start)
		{
			currrentTime += Time.deltaTime;
			if (currrentTime > curveTime)
			{
				float value = curve.Evaluate(curveTime);
				value = Mathf.Clamp(value, 0f, 1f);
				sceneSetting.darkness = value;
				flow.Call(output);
				start = false;
			}
			else if (sceneSetting != null && curve != null)
			{
				float value2 = curve.Evaluate(currrentTime);
				value2 = Mathf.Clamp(value2, 0f, 1f);
				sceneSetting.darkness = value2;
			}
		}
	}

	public override void OnGraphStoped()
	{
		base.OnGraphStoped();
		if (sceneSetting != null)
		{
			sceneSetting.darkness = 0f;
		}
		start = false;
		currrentTime = 0f;
	}

	protected override void RegisterPorts()
	{
		output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			if (!start)
			{
				flow = f;
				currrentTime = 0f;
				start = true;
				if (curve != null)
				{
					Keyframe[] keys = curve.keys;
					curveTime = keys[keys.Length - 1].time;
				}
				BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
				if (battleScene != null && battleScene.sceneSetting != null)
				{
					sceneSetting = battleScene.sceneSetting;
				}
				else
				{
					sceneSetting = Object.FindObjectOfType<SceneSetting>();
				}
			}
		});
	}
}
