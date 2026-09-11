using ParadoxNotion.Design;
using UnityEngine;
using UnityEngine.UI;

namespace FlowCanvas.Nodes;

[Name("设置战斗UI图标", 0)]
[Category("Render/UI")]
[Description("设置战斗UI图标, 相对路径是从battlepanel开始的;\n例如技能三相对路径:ScreenAdjustContainer/BattleButtons/AbilitButton2/SkillIcon")]
public class SetIconImageFromAtlas : FlowNode
{
	private Image image;

	public override void OnGraphStoped()
	{
		image = null;
	}

	protected override void RegisterPorts()
	{
		ValueInput<string> pathInput = AddValueInput<string>("Image相对路径路径", "pathInput");
		ValueInput<string> atlasNameInput = AddValueInput<string>("图集路径", "atlasNameInput");
		ValueInput<string> iconNameInput = AddValueInput<string>("图片名", "iconNameInput");
		FlowOutput output = AddFlowOutput("");
		AddFlowInput("", delegate(Flow f)
		{
			if (image == null)
			{
				BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
				if (battleScene != null && battleScene.battlePanelGameObject != null)
				{
					Transform transform = battleScene.battlePanelGameObject.transform.Find(pathInput.value);
					if (transform != null)
					{
						image = transform.gameObject.GetComponent<Image>();
					}
				}
			}
			if (image != null)
			{
				image.sprite = AtlasManager.GetSprite(atlasNameInput.value, iconNameInput.value);
			}
			output.Call(f);
		});
	}
}
