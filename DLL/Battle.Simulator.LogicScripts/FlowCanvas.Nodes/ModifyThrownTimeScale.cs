using System.Collections.Generic;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("修改抛掷物时间缩放", 0)]
[Category("Logic/抛掷物")]
[Description("修改抛掷物的速度;\n【抛掷物数组下标】:指逻辑层中抛掷物存放的List的下标;\n如果传入【抛掷物数组下标】,则省去在 ThrownList 中搜索的时间")]
public class ModifyThrownTimeScale : FlowControlNode
{
	private ValueInput<int> m_thrownIDInput;

	private ValueInput<int> m_thrownListIndexInput;

	private ValueInput<int> m_timeScaleInput;

	private FlowOutput m_out;

	private FlowOutput m_errorOut;

	protected override void RegisterPorts()
	{
		m_thrownIDInput = AddValueInput<int>("抛掷物ID", "thrownIDInput");
		m_thrownListIndexInput = AddValueInput<int>("抛掷物数组下标", "thrownListIndexInput").SetDefaultAndSerializedValue(-1);
		m_timeScaleInput = AddValueInput<int>("时间缩放", "timeScaleInput");
		m_out = AddFlowOutput("Out", "output");
		m_errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			List<ThrownState> mThrowns = CommonProcessor.GetWorldState().mThrowns;
			int value = m_thrownListIndexInput.GetValue();
			if (value != -1 && value <= mThrowns.Count)
			{
				ThrownState thrownState = CommonProcessor.GetWorldState().mThrowns[value];
				thrownState.mTimeScale = m_timeScaleInput.GetValue();
				CommonProcessor.GetWorldState().mThrowns[value] = thrownState;
				m_out.Call(f);
			}
			else
			{
				int value2 = m_thrownIDInput.GetValue();
				for (int num = mThrowns.Count - 1; num >= 0; num--)
				{
					ThrownState thrownState2 = mThrowns[num];
					if (thrownState2.mCreationIndex == value2)
					{
						thrownState2.mTimeScale = m_timeScaleInput.GetValue();
						mThrowns[num] = thrownState2;
						m_out.Call(f);
						return;
					}
				}
				m_errorOut.Call(f);
			}
		});
		AddValueOutput("抛掷物ID", "thrownID", () => m_thrownIDInput.GetValue());
	}
}
