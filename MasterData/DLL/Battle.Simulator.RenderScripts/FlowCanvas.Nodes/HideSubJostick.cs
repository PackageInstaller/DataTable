using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("中断子摇杆", 0)]
[Category("Render/UI")]
[Description("外部调用强制结束子摇杆")]
public class HideSubJostick : FlowControlNode
{
	private GameObject _battlePanel;

	private P08AttackButton[] _buttons;

	public override void OnGraphStarted()
	{
		base.OnGraphStarted();
		_battlePanel = null;
		_buttons = null;
	}

	public override void OnGraphStoped()
	{
		base.OnGraphStoped();
		_battlePanel = null;
		_buttons = null;
	}

	protected override void RegisterPorts()
	{
		ValueInput<GameObject> battlePanelVar = AddValueInput<GameObject>("战斗UI", "battlePanelVar");
		ValueInput<int> buttonIndexVar = AddValueInput<int>("技能按钮索引(0-2)", "buttonIndexVar");
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput error = AddFlowOutput("Error", "error");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			if (_battlePanel == null)
			{
				_battlePanel = battlePanelVar.value;
				if (_battlePanel == null)
				{
					_battlePanel = BattleUI.GetBattleUI().gameObject;
				}
				if (_battlePanel == null)
				{
					error.Call(f);
					return;
				}
			}
			if (_buttons == null)
			{
				_buttons = _battlePanel.GetComponentsInChildren<P08AttackButton>(includeInactive: true);
			}
			if (_buttons == null)
			{
				error.Call(f);
			}
			else
			{
				P08AttackButton p08AttackButton = null;
				P08AttackButton[] buttons = _buttons;
				foreach (P08AttackButton p08AttackButton2 in buttons)
				{
					if (p08AttackButton2.buttonType == (ButtonType)buttonIndexVar.GetValue())
					{
						p08AttackButton = p08AttackButton2;
					}
				}
				if (p08AttackButton != null)
				{
					p08AttackButton.JoyStickLogicOnPointerUp();
					output.Call(f);
				}
				else
				{
					error.Call(f);
				}
			}
		});
	}
}
