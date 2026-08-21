using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取距离最近的抛掷物ID", 0)]
[Category("Logic/抛掷物")]
[Description("根据输入的实体ID或抛掷物ID，查询获取距离最近的其他抛掷物ID（可指定TimelineID）")]
public class GetNearestThrown : FlowControlNode
{
	private FlowOutput m_output;

	private FlowOutput m_errorOut;

	private int m_thrownID;

	private int m_distance;

	protected override void RegisterPorts()
	{
		m_output = AddFlowOutput("Out", "output");
		m_errorOut = AddFlowOutput("Error", "errorOut");
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<int> thrownIDInput = AddValueInput<int>("抛掷物ID");
		ValueInput<int> timelineIDInput = AddValueInput<int>("TimelineID");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			m_thrownID = 0;
			m_distance = 0;
			if (entityIDInput.value != 0)
			{
				SimEntity entityWithEntityID = base.mSimContext.GetEntityWithEntityID(entityIDInput.value);
				if (entityWithEntityID == null)
				{
					m_errorOut.Call(f);
				}
				else
				{
					m_thrownID = ForeachThrownWithPosition(entityWithEntityID.entityPositon.mPosition, out m_distance, timelineIDInput.value);
					if (m_thrownID == 0)
					{
						m_errorOut.Call(f);
					}
					else
					{
						m_output.Call(f);
					}
				}
			}
			else if (thrownIDInput.value != 0)
			{
				if (!ThrownProcessor.TryGetThrown(base.mSimContext, thrownIDInput.value, out var thrownState))
				{
					m_errorOut.Call(f);
				}
				else
				{
					m_thrownID = ForeachThrownWithPosition(thrownState.mPosition, out m_distance, timelineIDInput.value, thrownState.mCreationIndex);
					if (m_thrownID == 0)
					{
						m_errorOut.Call(f);
					}
					else
					{
						m_output.Call(f);
					}
				}
			}
			else
			{
				m_errorOut.Call(f);
			}
		});
		AddValueOutput("实体ID", "entityID", () => entityIDInput.value);
		AddValueOutput("抛掷物ID", "thrownID", () => thrownIDInput.value);
		AddValueOutput("最近抛掷物ID", "NearestThrownID", () => m_thrownID);
		AddValueOutput("距离", "Distance", () => m_distance);
	}

	private int ForeachThrownWithPosition(Int3 position, out int distance, int timelineID = 0, int outThrownID = 0)
	{
		int result = 0;
		distance = int.MaxValue;
		long num = long.MaxValue;
		foreach (ThrownState mThrown in CommonProcessor.GetWorldState().mThrowns)
		{
			if ((timelineID == 0 || timelineID == mThrown.mAbilityID) && (outThrownID == 0 || outThrownID != mThrown.mCreationIndex))
			{
				long num2 = mThrown.mPosition.XZSqrMagnitude(position);
				if (num2 < num)
				{
					num = num2;
					result = mThrown.mCreationIndex;
				}
			}
		}
		distance = (int)IntMath.SqrtLong(num);
		return result;
	}
}
