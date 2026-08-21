using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("Buff事件(渲染)SimVar", 0)]
[Category("Render/事件")]
[Description("渲染层绘制buff")]
public class BuffRenderEventWithSimVar : BuffRenderEvent
{
	protected override void RegisterPorts()
	{
		mBuffAdded = AddFlowOutput("增加", "buff添加");
		mBuffTick = AddFlowOutput("触发", "buff触发");
		mBuffRemoved = AddFlowOutput("移除", "buff移除");
		mBuffClassID = AddValueInput<int>("类型(处理逻辑)ID", "期望表现的buff类型ID");
		AddValueOutput("持有者实体ID", "实体", () => mBuffState.mBuffOwnerID);
		AddValueOutput("释放者实体ID", "添加者ID", () => mBuffState.mBuffCasterID);
		AddValueOutput("创建ID", "buffID", () => mBuffState.mBuffID);
		AddValueOutput("类型(处理逻辑)ID", "buff类型", () => mBuffState.mBuffClassID);
		AddValueOutput("buff参数1", () => mBuffState.mBuffParams.v1);
		AddValueOutput("buff参数2", () => mBuffState.mBuffParams.v2);
		AddValueOutput("buff参数3", () => mBuffState.mBuffParams.v3);
		AddValueOutput("buff参数4", () => mBuffState.mBuffParams.v4);
	}
}
