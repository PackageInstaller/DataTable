using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("移动指定战斗UI", 0)]
[Category("Render/UI")]
[Description("移动指定战斗UI, 填的是相对路径")]
public class MoveTargetBattleUI : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<string> targetInput = AddValueInput<string>("要移动的UI路径");
		ValueInput<Vector2> offsetInput = AddValueInput<Vector2>("localPosition");
		ValueInput<Vector3> scaleInput = AddValueInput<Vector3>("localScale").SetDefaultAndSerializedValue(Vector3.one);
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			GameObject battlePanelGameObject = (NScene.GetCurrentScene() as BattleScene).battlePanelGameObject;
			if (battlePanelGameObject == null)
			{
				output.Call(f);
			}
			else
			{
				Transform transform = battlePanelGameObject.transform.Find(targetInput.value);
				if (transform == null)
				{
					output.Call(f);
				}
				else
				{
					BattleUI battleUI = BattleUI.GetBattleUI();
					if (battleUI != null && battleUI.adapter != null)
					{
						battleUI.adapter = null;
					}
					(transform as RectTransform).anchoredPosition = offsetInput.value;
					transform.localScale = scaleInput.value;
					output.Call(f);
				}
			}
		});
	}
}
