using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取当前SceneMapID", 0)]
[Category("Render/UI")]
[Description("获取当前SceneMapID")]
public class GetSceneMapID : FlowNode
{
	protected override void RegisterPorts()
	{
		AddValueOutput("结果", () => (NScene.GetCurrentScene() as BattleScene).ready.SceneDataForExcehange.MSceneID);
	}
}
