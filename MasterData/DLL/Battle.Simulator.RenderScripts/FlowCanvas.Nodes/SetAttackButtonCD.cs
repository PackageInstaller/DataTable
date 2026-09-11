using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("设置战斗UI的CD", 0)]
[Category("Render/UI")]
[Description("设置战斗UI的CD, 相对路径是从battlepanel开始的")]
public class SetAttackButtonCD : FlowNode
{
	private P08AttackButton button;

	public override void OnGraphStoped()
	{
		button = null;
	}

	protected override void RegisterPorts()
	{
		ValueInput<string> pathInput = AddValueInput<string>("相对路径路径", "pathInput");
		ValueInput<int> currentInput = AddValueInput<int>("当前值");
		ValueInput<int> maxInput = AddValueInput<int>("最大值");
		ValueInput<int> chargeCountInput = AddValueInput<int>("充能次数");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			if (button == null)
			{
				BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
				if (battleScene != null && battleScene.battlePanelGameObject != null)
				{
					Transform transform = battleScene.battlePanelGameObject.transform.Find(pathInput.value);
					if (transform != null)
					{
						button = transform.gameObject.GetComponent<P08AttackButton>();
					}
				}
			}
			if (button != null)
			{
				button.SetCD(currentInput.value, maxInput.value, chargeCountInput.value);
			}
			output.Call(f);
		});
	}
}
