using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[OnlineTD]移除卡池中某项", 0)]
[Category("Active/TowerDefense/Logic/Gacha")]
[Description("某个玩家选择了唯一buff，通知卡池移除该buff")]
public class OnlineTDRemoveUiqueBuff : FlowControlNodeOfLogic
{
	private SimWorldState worldState;

	public override void OnGraphStarted()
	{
		base.OnGraphStarted();
		worldState = null;
	}

	public override void OnGraphStoped()
	{
		base.OnGraphStoped();
		worldState = null;
	}

	protected override void RegisterPorts()
	{
		ValueInput<int> type = AddValueInput<int>("强化类型", "type");
		ValueInput<int> buffInput = AddValueInput<int>("BUFF配置ID", "buffID");
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			if (worldState == null)
			{
				worldState = base.mSimContext.sEntityWorldState.status;
			}
			if (worldState == null || type.value > worldState.m_tower_gacha_List.Length)
			{
				errorOut.Call(f);
			}
			worldState.m_tower_gacha_List[type.value].Remove(buffInput.value);
			output.Call(f);
		});
	}
}
