using System.Collections.Generic;
using System.Linq;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[TD]得到无人机数据", 0)]
[Category("Active/TowerDefense/Render/UI")]
[Description("得到无人机数据")]
public class TDGetTowerData : FlowControlNodeOfRender
{
	private TowerPTUI ui;

	private int _bodyID;

	private int _bodyLevel;

	private List<int> _weaponIDList;

	private List<int> _weaponLevelList;

	private int _recycleValue;

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
		ValueInput<int> triggetIDInput = AddValueInput<int>("触发器ID");
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput nullOut = AddFlowOutput("无数据", "null");
		FlowOutput errorOut = AddFlowOutput("Error", "error");
		AddValueOutput("机体ID", "_bodyID", () => _bodyID);
		AddValueOutput("机体等级", "_bodyLevel", () => _bodyLevel);
		AddValueOutput("武器ID组", "_weaponIDList", () => _weaponIDList);
		AddValueOutput("武器等级组", "_weaponLevelList", () => _weaponLevelList);
		AddValueOutput("拆除返还点数", "_recycleValue", () => _recycleValue);
		AddFlowInput("In", "input", delegate(Flow f)
		{
			TowerData value;
			if (ui == null && !TowerDefensePtUI.TryGetPTUI(out ui))
			{
				errorOut.Call(f);
			}
			else if (!ui.m_towerDataDict.TryGetValue(triggetIDInput.value, out value))
			{
				nullOut.Call(f);
			}
			else
			{
				_bodyID = value.m_body;
				_bodyLevel = value.m_bodyUpgrade;
				_weaponIDList = value.m_weaponArr.ToList();
				_weaponLevelList = value.m_weaponUpgradeArr.ToList();
				_recycleValue = value.m_recycle;
				output.Call(f);
			}
		});
	}
}
