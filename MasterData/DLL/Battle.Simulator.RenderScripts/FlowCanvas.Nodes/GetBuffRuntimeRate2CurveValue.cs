using MessagePack;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("得到Buff运行比率曲线值(渲染)", 0)]
[Category("Render/Attribute")]
[Description("得到BUFF运行的总时间比率,得到变化曲线上的值,进而得到需要的目标值;\n如果配置了进入时长、退出时长,则当 进入时长+退出时长>Buff时长时候,则会按照等比处理")]
public class GetBuffRuntimeRate2CurveValue : FlowControlNode
{
	[Name("最大值", 0)]
	public float MaxValue;

	[Name("变化曲线", 0)]
	public AnimationCurve RateCurve = new AnimationCurve(new Keyframe(0f, 1f), new Keyframe(1f, 1f));

	[Name("进入时长(毫秒)", 0)]
	public int EnterTime = -1;

	[Name("退出时长(毫秒)", 0)]
	public int ExitTime = -1;

	private float m_curveValue;

	public override void OnSerializeHandler(ref MessagePackWriter writer, MessagePackSerializerOptions options)
	{
		writer.Write(MaxValue);
		writer.Write(EnterTime);
		writer.Write(ExitTime);
		options.Resolver.GetFormatterWithVerify<AnimationCurve>().Serialize(ref writer, RateCurve, options);
	}

	public override void OnDeserializeHandler(ref MessagePackReader reader, MessagePackSerializerOptions options)
	{
		MaxValue = reader.ReadSingle();
		EnterTime = reader.ReadInt32();
		ExitTime = reader.ReadInt32();
		RateCurve = options.Resolver.GetFormatterWithVerify<AnimationCurve>().Deserialize(ref reader, options);
	}

	protected override void RegisterPorts()
	{
		ValueInput<int> agentIDVar = AddValueInput<int>("实体ID", "agentIDVar");
		ValueInput<int> buffIDVar = AddValueInput<int>("创建ID", "buffIDVar");
		FlowOutput abnormalOut = AddFlowOutput("异常", "abnormalOut");
		FlowOutput nullOut = AddFlowOutput("无BUFF", "nullOut");
		FlowOutput output = AddFlowOutput("Out", "output");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			m_curveValue = 0f;
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene == null)
			{
				abnormalOut.Call(f);
			}
			else
			{
				float rate = 0f;
				if (!BuffRuntimtRateHelper.TryGetBuffRuntimeRate(battleScene, agentIDVar.GetValue(), buffIDVar.GetValue(), out rate, EnterTime, ExitTime))
				{
					nullOut.Call(f);
				}
				else
				{
					m_curveValue = MaxValue * RateCurve.Evaluate(rate);
					output.Call(f);
				}
			}
		});
		AddValueOutput("实体ID", "agentID", () => agentIDVar.GetValue());
		AddValueOutput("创建ID", "buffID", () => buffIDVar.GetValue());
		AddValueOutput("目标值", "targetValue", () => m_curveValue);
	}
}
