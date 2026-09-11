using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("战斗UI播放特效(切换)", 0)]
[Category("Render/UI")]
[Description("播放战斗UI技能按钮的切换特效,仅支持技能按钮, 相对路径是从battlepanel开始的;\n例如技能三相对路径:ScreenAdjustContainer/BattleButtons/AbilitButton2/SkillIcon")]
public class PlaySwitchAbilityEffect : FlowNode
{
	private P08AttackButton button;

	public override void OnGraphStoped()
	{
		button = null;
	}

	protected override void RegisterPorts()
	{
		ValueInput<ButtonType> buttonTypeInput = AddValueInput<ButtonType>("按钮类型", "buttonType");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			if (button == null)
			{
				BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
				if (battleScene != null && battleScene.battlePanelGameObject != null)
				{
					string text = string.Empty;
					switch (buttonTypeInput.value)
					{
					case ButtonType.MELEE:
						text = "ScreenAdjustContainer/BattleButtons/Melee";
						break;
					case ButtonType.SKILL1:
						text = "ScreenAdjustContainer/BattleButtons/AbilitButton0";
						break;
					case ButtonType.SKILL2:
						text = "ScreenAdjustContainer/BattleButtons/AbilitButton1";
						break;
					case ButtonType.SKILL3:
						text = "ScreenAdjustContainer/BattleButtons/AbilitButton2";
						break;
					}
					if (!string.IsNullOrEmpty(text))
					{
						Transform transform = battleScene.battlePanelGameObject.transform.Find(text);
						if (transform != null)
						{
							button = transform.gameObject.GetComponent<P08AttackButton>();
						}
					}
				}
			}
			if (button != null)
			{
				switch (buttonTypeInput.value)
				{
				case ButtonType.MELEE:
					if (button.GetButtonUILogic() is P08MeleeButtonUILogic p08MeleeButtonUILogic)
					{
						p08MeleeButtonUILogic.PlayEffectOfSwitchAbility();
					}
					break;
				case ButtonType.SKILL1:
				case ButtonType.SKILL2:
				case ButtonType.SKILL3:
					if (button.GetButtonUILogic() is P08SkillButtonUILogic p08SkillButtonUILogic)
					{
						p08SkillButtonUILogic.PlayEffectOfSwitchAbility();
					}
					break;
				}
			}
			output.Call(f);
		});
	}
}
