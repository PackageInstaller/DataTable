using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("获取挂点路径(枚举)(渲染)", 0)]
[Category("Render/函数")]
[Description("获取挂点路径,根据传进来的枚举返回对应的挂点路径")]
public class GetAttachPathByEnum : FlowNode
{
	protected override void RegisterPorts()
	{
		ValueInput<int> entityIDInput = AddValueInput<int>("实体ID");
		ValueInput<En_BaseAttachPointType> attachNameInput = AddValueInput<En_BaseAttachPointType>("挂点名称");
		AddValueOutput("挂点路径", delegate
		{
			NAgent agent = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetAgent(entityIDInput.value);
			_ = agent.transform;
			return U3DUtil.Get<AttachPointSetup>(agent.gameObject).GetAttachPointPath(attachNameInput.value);
		});
	}
}
