using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("播放芯片技能演出(渲染)", 0)]
[Category("Render/UI")]
[Description("播放芯片技能表现效果")]
public class PlayMasterSkillRender : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput output = AddFlowOutput("");
		ValueInput<int> levelInput = AddValueInput<int>("强制规格", "level").SetDefaultAndSerializedValue(-1);
		AddFlowInput("", delegate(Flow f)
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene.masterSkillRenderHigh != null && (levelInput.value == -1 || levelInput.value == 2))
			{
				battleScene.masterSkillRenderHigh.PlayFunction();
			}
			else if (battleScene.masterSkillRenderMedium != null && (levelInput.value == -1 || levelInput.value == 1))
			{
				battleScene.masterSkillRenderMedium.PlayFunction();
			}
			else
			{
				battleScene.masterSkillRenderLow.PlayFunction();
			}
			f.Call(output);
		});
	}
}
