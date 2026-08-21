using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取复活模式", 0)]
[Category("Render/Resurrect")]
[Description("获取复活模式:0为默认,1为QTE复活,等策划内部规定")]
public class GetResurrectMode : FlowNode
{
	protected override void RegisterPorts()
	{
		AddValueOutput("复活模式", "ResurrectMode", (ValueHandler<int>)delegate
		{
			BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
			return (!(battleScene == null)) ? battleScene.resurrectMode : 0;
		});
	}
}
