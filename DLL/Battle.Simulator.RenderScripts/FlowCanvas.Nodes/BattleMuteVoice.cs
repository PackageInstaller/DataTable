using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("开关战斗语音(渲染)", 0)]
[Category("Render/声音")]
[Description("开关战斗语音, 整体开关")]
public class BattleMuteVoice : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<bool> effectTagInput = AddValueInput<bool>("声效开关").SetDefaultAndSerializedValue(v: false);
		ValueInput<bool> voiceTagInput = AddValueInput<bool>("语音开关").SetDefaultAndSerializedValue(v: false);
		AddFlowOutput("Out");
		FlowOutput errorOutput = AddFlowOutput("Error");
		AddFlowInput("", delegate(Flow f)
		{
			if (SceneDirector.Instance == null)
			{
				errorOutput.Call(f);
			}
			else
			{
				BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
				if (battleScene == null || battleScene.GetBattleSimulatorSystem() == null)
				{
					errorOutput.Call(f);
				}
				else
				{
					WorldStateManager worldSatetManager = battleScene.GetWorldSatetManager();
					if (worldSatetManager == null)
					{
						errorOutput.Call(f);
					}
					else
					{
						worldSatetManager.notMuteEffectVoice = effectTagInput.value;
						worldSatetManager.notMuteCharacterVoice = voiceTagInput.value;
					}
				}
			}
		});
	}
}
