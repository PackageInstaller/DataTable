using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("显示部位破坏值(渲染)", 0)]
[Category("Render/UI")]
[Description("显示部位破坏值")]
public class ShowBreakUI : FlowNode
{
	public FlowOutput mOutput;

	public FlowOutput mError;

	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("agentID");
		ValueInput<int> partIDInput = AddValueInput<int>("部位ID").SetDefaultAndSerializedValue(-1);
		ValueInput<int> BreakMaxInput = AddValueInput<int>("破坏值上限");
		ValueInput<float> autoHideTime = AddValueInput<float>("自动隐藏时长").SetDefaultAndSerializedValue(10f);
		ValueInput<float> LockHideTime = AddValueInput<float>("锁住时隐藏时长").SetDefaultAndSerializedValue(3f);
		mOutput = AddFlowOutput("out");
		mError = AddFlowOutput("error");
		AddValueOutput("agentID", () => entityIDInput.value);
		AddValueOutput("部位ID", () => partIDInput.value);
		AddFlowInput("显示", delegate(Flow f)
		{
			int value = entityIDInput.value;
			int value2 = partIDInput.value;
			BattleUI battleUI = BattleUI.GetBattleUI();
			if (battleUI == null)
			{
				mError.Call(f);
			}
			else
			{
				WorldStateManager worldSatetManager = ((BattleScene)NScene.GetCurrentScene()).GetWorldSatetManager();
				float value3 = autoHideTime.value;
				if (worldSatetManager != null && worldSatetManager.hasManualLock)
				{
					mOutput.Call(f);
				}
				else
				{
					battleUI.PartBreakUI.AddBreakUI(value, value2, value3, BreakMaxInput.value);
					mOutput.Call(f);
				}
			}
		});
		AddFlowInput("隐藏", delegate(Flow f)
		{
			_ = entityIDInput.value;
			_ = partIDInput.value;
			BattleUI battleUI = BattleUI.GetBattleUI();
			if (battleUI == null)
			{
				mError.Call(f);
			}
			else
			{
				WorldStateManager worldSatetManager = ((BattleScene)NScene.GetCurrentScene()).GetWorldSatetManager();
				_ = autoHideTime.value;
				if (worldSatetManager != null && worldSatetManager.hasManualLock)
				{
					mOutput.Call(f);
				}
				else
				{
					battleUI.PartBreakUI.RemoveBreakUI();
					mOutput.Call(f);
				}
			}
		});
		AddFlowInput("锁住", delegate(Flow f)
		{
			int value = entityIDInput.value;
			int value2 = partIDInput.value;
			BattleUI battleUI = BattleUI.GetBattleUI();
			if (battleUI == null)
			{
				mError.Call(f);
			}
			else
			{
				battleUI.PartBreakUI.AddLock(value, value2, LockHideTime.value);
				mOutput.Call(f);
			}
		});
		AddFlowInput("破坏", delegate(Flow f)
		{
			int value = entityIDInput.value;
			int value2 = partIDInput.value;
			BattleUI battleUI = BattleUI.GetBattleUI();
			if (battleUI == null)
			{
				mError.Call(f);
			}
			else
			{
				battleUI.PartBreakUI.AddBreak(value, value2, LockHideTime.value);
				mOutput.Call(f);
			}
		});
	}
}
