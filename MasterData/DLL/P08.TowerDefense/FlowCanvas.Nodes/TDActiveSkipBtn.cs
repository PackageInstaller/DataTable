using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[TD]激活跳过逻辑", 0)]
[Category("Active/TowerDefense/Render/UI")]
[Description("PTUI")]
public class TDActiveSkipBtn : FlowControlNodeOfRender
{
	private TowerPTUI ui;

	private uint _startTime;

	public override void OnGraphStarted()
	{
		base.OnGraphStarted();
		ui = null;
	}

	public override void OnGraphStoped()
	{
		base.OnGraphStoped();
		ui = null;
	}

	protected override void RegisterPorts()
	{
		ValueInput<int> timeInput = AddValueInput<int>("剩余时长(毫秒)", "time").SetDefaultAndSerializedValue(90000);
		ValueInput<bool> formatInput = AddValueInput<bool>("仅显示秒", "format");
		FlowOutput skipButtonOut = AddFlowOutput("点击跳过");
		FlowOutput hideButtonOut = AddFlowOutput("隐藏跳过");
		FlowOutput errorOut = AddFlowOutput("error");
		AddFlowInput("设置跳过逻辑", delegate(Flow f)
		{
			if (ui == null && !TowerDefensePtUI.TryGetPTUI(out ui))
			{
				errorOut.Call(f);
			}
			else
			{
				WorldStateManager worldStateManager = WorldStateManager.GetWorldStateManager();
				if (worldStateManager == null)
				{
					errorOut.Call(f);
				}
				else if (ui.skipButton != null)
				{
					_startTime = worldStateManager.currentFrameNumber;
					if (ui.m_timeTxt != null)
					{
						ui.m_timeTxt.gameObject.SetActive(value: true);
					}
					ui.skipButton.gameObject.SetActive(value: true);
					ui.skipButton.onClick.RemoveAllListeners();
					ui.skipButton.onClick.AddListener(delegate
					{
						if (ui.m_timeTxt != null)
						{
							ui.m_timeTxt.gameObject.SetActive(value: false);
						}
						ui.skipButton.onClick.RemoveAllListeners();
						ui.skipButton.gameObject.SetActive(value: false);
						f.Call(skipButtonOut);
					});
				}
				else
				{
					errorOut.Call(f);
				}
			}
		});
		AddFlowInput("更新时间", delegate(Flow f)
		{
			if (ui == null && !TowerDefensePtUI.TryGetPTUI(out ui))
			{
				errorOut.Call(f);
			}
			else
			{
				WorldStateManager worldStateManager = WorldStateManager.GetWorldStateManager();
				if (worldStateManager == null)
				{
					errorOut.Call(f);
				}
				else
				{
					float num = 1000 / BattleSimulatorSystem.sTargetLogicFrameRate;
					int num2 = timeInput.value - (int)((float)(worldStateManager.currentFrameNumber - _startTime) * num);
					ui.SetTime(num2, formatInput.value);
					if (num2 <= 0)
					{
						if (ui.m_timeTxt != null)
						{
							ui.m_timeTxt.gameObject.SetActive(value: false);
						}
						ui.skipButton.onClick.RemoveAllListeners();
						if (ui.skipButton != null)
						{
							ui.skipButton.gameObject.SetActive(value: false);
						}
						f.Call(skipButtonOut);
					}
				}
			}
		});
		AddFlowInput("隐藏跳过按钮", delegate(Flow f)
		{
			if (ui == null && !TowerDefensePtUI.TryGetPTUI(out ui))
			{
				errorOut.Call(f);
			}
			else if (ui.skipButton != null)
			{
				ui.skipButton.gameObject.SetActive(value: false);
				hideButtonOut.Call(f);
			}
			else
			{
				errorOut.Call(f);
			}
		});
	}
}
