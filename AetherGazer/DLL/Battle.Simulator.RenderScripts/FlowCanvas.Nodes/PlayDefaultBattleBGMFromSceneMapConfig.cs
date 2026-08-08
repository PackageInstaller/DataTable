using Config;
using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("播放默认战斗BGM(criware)", 0)]
[Category("Render/声音")]
[Description("从SceneMap表格中读取默认战斗音乐配置,并进行播放")]
public class PlayDefaultBattleBGMFromSceneMapConfig : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("Out", "output");
		AddFlowInput("In", delegate(Flow f)
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			int num = 0;
			SceneMap mapConfig = battleScene.mapConfig;
			num = mapConfig.AudioID;
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
				string cueSheet = config.CueSheet;
				string cueName = config.CueName;
				bool useStream = config.UseStream;
				if (mapConfig != null && !string.IsNullOrEmpty(cueSheet))
				{
					AudioManager.Instance.Play("music", cueSheet, cueName, useStream);
				}
			}
			output.Call(f);
		});
	}
}
