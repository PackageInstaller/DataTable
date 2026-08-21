using Config;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("抛掷物产生坐标与朝向", 0)]
[Category("Logic/抛掷物")]
[Description("获取抛掷物产生坐标和朝向")]
public class GetSpawnThrownPositionAndDirection : FlowControlNode
{
	private Int3 m_spawnPosition;

	private Int3 m_spawnForward;

	protected override void RegisterPorts()
	{
		AddValueInput<int>("释放者ID");
		ValueInput<int> abilityTimelineIDVar = AddValueInput<int>("释放抛掷物技能的TimelineID");
		ValueInput<int> abilityEventIndexVar = AddValueInput<int>("释放抛掷物技能上事件索引");
		ValueInput<Int3> originPositionVar = AddValueInput<Int3>("释放者位置");
		ValueInput<Int3> originForwardVar = AddValueInput<Int3>("释放者朝向");
		AddValueInput<int>("得到目标数量(可选,默认1)");
		ValueInput<int> thrownTimelineIDVar = AddValueInput<int>("抛掷物TimelineID(可选)");
		FlowOutput successOutput = AddFlowOutput("成功");
		FlowOutput failOutput = AddFlowOutput("失败");
		AddFlowInput("In", delegate(Flow f)
		{
			m_spawnPosition = originPositionVar.value;
			m_spawnPosition = new Int3(m_spawnPosition.x, 0, m_spawnPosition.z);
			m_spawnForward = originForwardVar.value;
			m_spawnForward = new Int3(m_spawnForward.x, 0, m_spawnForward.z);
			m_spawnForward = m_spawnForward.NormalizeTo(1000);
			if (thrownTimelineIDVar.value != 0)
			{
				successOutput.Call(f);
			}
			else
			{
				Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(abilityTimelineIDVar.value);
				if (config == null)
				{
					Debug.Log("=====>>>>> 没有找到Timleine数据:" + abilityTimelineIDVar.value);
					failOutput.Call(f);
				}
				else
				{
					PostSpwanThrownEventInfo postSpwanThrownEventInfo = config.PostSpwanThrownEvents.get_Item(abilityEventIndexVar.value);
					Int3 spawnPosition = IntMath.Transform(new Int3(postSpwanThrownEventInfo.CenterOffset.X, 0, postSpwanThrownEventInfo.CenterOffset.Z), m_spawnForward, m_spawnPosition);
					m_spawnPosition = spawnPosition;
					m_spawnPosition = CommonProcessor.GetPositionInGraphWithoutTangentMove(originPositionVar.GetValue(), m_spawnPosition);
					if (postSpwanThrownEventInfo.SpawnForward != null)
					{
						Int3 @int = IntMath.Transform(new Int3(postSpwanThrownEventInfo.SpawnForward.X, 0, postSpwanThrownEventInfo.SpawnForward.Z), m_spawnForward, m_spawnPosition);
						m_spawnForward = (@int - m_spawnPosition).NormalizeTo(1000);
					}
					successOutput.Call(f);
				}
			}
		});
		AddValueOutput("孵化位置：", () => m_spawnPosition);
		AddValueOutput("孵化朝向：", () => m_spawnForward);
	}
}
