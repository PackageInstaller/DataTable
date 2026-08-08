using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("加载场景", 0)]
[Category("Render/UI")]
[Description("加载场景")]
public class LoadTargetScene : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> idInput = AddValueInput<int>("id");
		AddFlowInput("", delegate
		{
			NScene.GetCurrentScene();
			int value = idInput.value;
			SceneDirector.Instance.Restart(value, showLoadUI: false);
		});
	}
}
