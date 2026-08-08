using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("得到使用的连携奥义ID(渲染)", 0)]
[Category("Render/奥义")]
[Description("如题")]
public class GetUsedCooperateUniqueSkillIDOfRender : FlowControlNode
{
	private FlowOutput _Out;

	private int _CooperateUniqueSkillID;

	protected override void RegisterPorts()
	{
		_Out = AddFlowOutput("Out", "output");
		AddFlowInput("In", "input", delegate(Flow f)
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			if (battleScene != null)
			{
				_CooperateUniqueSkillID = battleScene.ready.SceneDataForExcehange.CooperateUniqueSkillID;
				_Out.Call(f);
			}
		});
		AddValueOutput("连携奥义ID", "cooperateUniqueSkillID", () => _CooperateUniqueSkillID);
	}
}
