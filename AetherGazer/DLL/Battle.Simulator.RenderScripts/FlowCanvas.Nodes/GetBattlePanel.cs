using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("得到战斗界面(渲染)", 0)]
[Category("Render/UI")]
[Description("【战斗子面板路径】从 BattlePanel 下开始,例如要挂在 PlayerInfo 下,则填写 ScreenAdjustContainer/PlayerInfo, 为空则返回战斗面板")]
public class GetBattlePanel : FlowControlNode
{
	private FlowOutput _Found;

	private FlowOutput _UnFound;

	private FlowOutput _Error;

	private ValueInput<string> _ChildPanelPathInput;

	private GameObject _ChildPanel;

	protected override void RegisterPorts()
	{
		_Found = AddFlowOutput("找到", "found");
		_UnFound = AddFlowOutput("未找到", "unfound");
		_ChildPanelPathInput = AddValueInput<string>("战斗子面板路径", "battleChildPanel").SetDefaultAndSerializedValue("ScreenAdjustContainer/PlayerInfo");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			if (_ChildPanel == null)
			{
				if (string.IsNullOrEmpty(_ChildPanelPathInput.GetValue()))
				{
					_ChildPanel = GameObject.Find("UICamera/Canvas/UIMain/BattlePanel");
				}
				else
				{
					_ChildPanel = GameObject.Find("UICamera/Canvas/UIMain/BattlePanel/" + _ChildPanelPathInput.GetValue());
				}
			}
			if (_ChildPanel == null)
			{
				_UnFound.Call(f);
			}
			else
			{
				_Found.Call(f);
			}
		});
		AddValueOutput("面板", "panel", () => _ChildPanel);
	}
}
