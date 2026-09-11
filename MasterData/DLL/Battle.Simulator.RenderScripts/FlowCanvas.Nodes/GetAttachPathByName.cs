using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取挂点路径(挂点名)(渲染)", 0)]
[Category("Render/函数")]
[Description("获取挂点路径,根据传进来的枚举返回对应的挂点路径")]
public class GetAttachPathByName : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID", "agentID");
		ValueInput<string> attachNameInput = AddValueInput<string>("挂点名称", "attachPointName");
		AddValueOutput("挂点路径", delegate
		{
			NAgent agent = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetAgent(entityIDInput.value);
			_ = agent.transform;
			return U3DUtil.Get<AttachPointSetup>(agent.gameObject).GetAttachPointPath(attachNameInput.value);
		});
	}
}
