using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("得到战斗BGM信息(Render)", 0)]
[Category("Render/Config")]
[Description("从SceneMap中得到战斗BGM的信息")]
public class GetBattleBGMInfo : FlowControlNode
{
	private string m_cueSheet;

	private string m_cueName;

	private string m_cueAwb;

	private FlowOutput m_out;

	protected override void RegisterPorts()
	{
		m_out = AddFlowOutput("Out", "output");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			int num = 0;
			num = battleScene.mapConfig.AudioID;
			if (num == 0 && battleScene.m_sceneDefaultBGM != null)
			{
				num = battleScene.m_sceneDefaultBGM.m_audioID;
			}
			if (num == 0)
			{
				num = 5012;
			}
			if (ConfigHelper.GetInstance().TryGetConfig<CommonAudio>(num, out var config))
			{
				m_cueSheet = config.CueSheet;
				m_cueName = config.CueName;
				m_cueAwb = (config.UseStream ? m_cueName : "");
			}
			m_out.Call(f);
		});
		AddValueOutput("包名(CueSheet)", "cueSheet", () => m_cueSheet);
		AddValueOutput("曲名(CueName)", "cueName", () => m_cueName);
		AddValueOutput("流式文件(CueAwb)", "cueAwb", () => m_cueAwb);
	}
}
