using Config;
using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("播放胜利BGM(criware)", 0)]
[Category("Render/声音")]
[Description("胜利用的BGM播放节点,会根据人数切换Label,从而切换使用的音效;\n使用全局声源(criware)")]
public class PlayWinCriwareCue : FlowControlNode
{
	private ValueInput<string> m_cueAwb;

	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("Out");
		ValueInput<string> sheetName = AddValueInput<string>("sheetName");
		ValueInput<string> cueName = AddValueInput<string>("cueName");
		m_cueAwb = AddValueInput<string>("Awb file(xxx.awb)");
		AddFlowInput("In", delegate(Flow f)
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			string text = "single";
			switch (battleScene.ready.SceneDataForExcehange.RoleDataInLua.Count)
			{
			case 1:
				text = "single";
				break;
			case 2:
				text = "double";
				break;
			case 3:
				text = "triple";
				break;
			default:
				Debug.LogError("====>>>> 超过3人");
				text = "triple";
				break;
			}
			if (battleScene.ready.SceneDataForExcehange.MMissionClearTimes <= 1 && ConfigHelper.GetInstance().TryGetConfig<Story>(battleScene.ready.SceneDataForExcehange.MSceneID, out var _))
			{
				text = "nocount";
			}
			Debug.Log("===>>> labelName:" + text);
			AudioManager.Instance.SetSelectorLabel("music", "Count", text);
			AudioManager.Instance.Play("music", sheetName.GetValue(), cueName.GetValue(), !string.IsNullOrEmpty(m_cueAwb.GetValue()));
			output.Call(f);
		});
	}
}
