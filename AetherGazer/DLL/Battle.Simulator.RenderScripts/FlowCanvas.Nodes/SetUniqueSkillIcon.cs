using Config;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("设置奥义图标", 0)]
[Category("Render/UI")]
[Description("设置奥义图标, 相对路径是从battlepanel开始的")]
public class SetUniqueSkillIcon : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<string> pathInput = AddValueInput<string>("AbilityButtonsUI相对路径路径").SetDefaultAndSerializedValue("ScreenAdjustContainer/BattleButtons/QTEButton");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("设置", delegate(Flow f)
		{
			P08AttackButton p08AttackButton = null;
			string text = null;
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene != null && battleScene.battlePanelGameObject != null)
			{
				Transform transform = battleScene.battlePanelGameObject.transform.Find(pathInput.value);
				if (transform != null)
				{
					p08AttackButton = transform.gameObject.GetComponent<P08AttackButton>();
				}
				if (ConfigHelper.GetInstance().TryGetConfig<cooperate_unique_skill>(battleScene.ready.SceneDataForExcehange.CooperateUniqueSkillID, out var config))
				{
					text = config.IconPath;
				}
			}
			if (p08AttackButton != null && !string.IsNullOrEmpty(text))
			{
				p08AttackButton.abilityIcon.sprite = AtlasManager.GetSpriteWithoutAtlas(text);
			}
			else
			{
				Debug.LogError("设置奥义图标 出错了, 组件路径或者图片路径错了");
			}
			output.Call(f);
		});
		AddFlowInput("还原", delegate(Flow f)
		{
			P08AttackButton p08AttackButton = null;
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene != null && battleScene.battlePanelGameObject != null)
			{
				Transform transform = battleScene.battlePanelGameObject.transform.Find(pathInput.value);
				if (transform != null)
				{
					p08AttackButton = transform.gameObject.GetComponent<P08AttackButton>();
				}
			}
			if (p08AttackButton != null && p08AttackButton.GetButtonUILogic() is P08QTEButtonUILogic p08QTEButtonUILogic)
			{
				p08QTEButtonUILogic.InitQteIcon();
			}
			output.Call(f);
		});
	}
}
