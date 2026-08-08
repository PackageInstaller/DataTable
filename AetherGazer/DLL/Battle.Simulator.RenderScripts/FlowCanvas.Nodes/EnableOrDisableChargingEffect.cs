using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("隐藏显示UI技能充能动效(渲染)", 0)]
[Category("Render/UI")]
[Description("隐藏UI技能充能动效(渲染)")]
public class EnableOrDisableChargingEffect : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> slotIDInput = AddValueInput<int>("SlotID(0-2)");
		ValueInput<bool> hideInput = AddValueInput<bool>("Hide").SetDefaultAndSerializedValue(v: true);
		FlowOutput output = AddFlowOutput("Out", "output");
		FlowOutput error = AddFlowOutput("Error", "error");
		AddFlowInput("In ", delegate(Flow f)
		{
			GameObject gameObject = BattleUI.GetBattleUI().gameObject;
			if (gameObject == null)
			{
				error.Call(f);
			}
			else
			{
				P08AttackButton[] componentsInChildren = gameObject.GetComponentsInChildren<P08AttackButton>(includeInactive: true);
				P08AttackButton p08AttackButton = null;
				P08AttackButton[] array = componentsInChildren;
				foreach (P08AttackButton p08AttackButton2 in array)
				{
					if (p08AttackButton2.buttonType == (ButtonType)slotIDInput.GetValue())
					{
						p08AttackButton = p08AttackButton2;
						break;
					}
				}
				if (p08AttackButton != null && p08AttackButton.GetButtonUILogic() is P08ButtonUILogic p08ButtonUILogic && p08ButtonUILogic.ChargingController != null)
				{
					p08ButtonUILogic.ChargingController.gameObject.SetActive(!hideInput.value);
				}
				output.Call(f);
			}
		});
	}
}
