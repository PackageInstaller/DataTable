using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("设置战斗UI的可使用状态", 0)]
[Category("Render/UI")]
[Description("设置战斗UI的可使用状态, 相对路径是从battlepanel开始的")]
public class SetAttackEnable : FlowNode
{
	private P08AttackButton button;

	public override void OnGraphStoped()
	{
		button = null;
	}

	protected override void RegisterPorts()
	{
		ValueInput<string> pathInput = AddValueInput<string>("相对路径路径", "pathInput");
		ValueInput<bool> currentInput = AddValueInput<bool>("开关");
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
				button.SetEnable(currentInput.value);
			}
			output.Call(f);
		});
	}
}
