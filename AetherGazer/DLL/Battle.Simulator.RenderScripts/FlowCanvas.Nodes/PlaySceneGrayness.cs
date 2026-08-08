using MessagePack;
using NodeCanvas.Framework;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("播放灰屏", 0)]
[Category("Render/Effect")]
[Description("播放灰屏")]
public class PlaySceneGrayness : FlowNode, IUpdatable
{
	private FlowOutput output;

	private bool start;

	private float currrentTime;

	private Flow flow;

	private float curveTime;

	private SceneSetting sceneSetting;

	private SceneSetting innersceneSetting;

	public AnimationCurve curve;

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		curve = options.Resolver.GetFormatter<AnimationCurve>().Deserialize(ref reader, options);
	}

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		options.Resolver.GetFormatter<AnimationCurve>().Serialize(ref writer, curve, options);
	}

	public void Update()
	{
		if (!start)
		{
			return;
		}
		currrentTime += Time.deltaTime;
		if (currrentTime > curveTime)
		{
			flow.Call(output);
			start = false;
		}
		else if (sceneSetting != null && curve != null)
		{
			float value = curve.Evaluate(currrentTime);
			value = Mathf.Clamp(value, 0f, 1f);
			sceneSetting.grayness = value;
			if (innersceneSetting != null)
			{
				innersceneSetting.grayness = value;
			}
		}
	}

	public override void OnGraphStoped()
	{
		base.OnGraphStoped();
		if (sceneSetting != null)
		{
			sceneSetting.grayness = 0f;
		}
		if (innersceneSetting != null)
		{
			innersceneSetting.grayness = 0f;
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
					if (battleScene.InnerSceneSettingOnSourceSpaceAsset != null)
					{
						innersceneSetting = battleScene.InnerSceneSettingOnSourceSpaceAsset.GetComponent<SceneSetting>();
					}
				}
				else
				{
					sceneSetting = Object.FindObjectOfType<SceneSetting>();
				}
			}
		});
	}
}
