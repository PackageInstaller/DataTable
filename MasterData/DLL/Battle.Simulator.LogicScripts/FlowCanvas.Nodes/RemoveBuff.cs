using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("移除Buff(创建ID)(逻辑)", 0)]
[Category("Logic/Buff")]
[Description("移除指定Buffer\n新名字:移除Buff(创建ID)")]
[ExposeAsDefinition]
public class RemoveBuff : FlowControlNode
{
	protected override void RegisterPorts()
	{
		FlowOutput trueOut = AddFlowOutput("True");
		FlowOutput falseOut = AddFlowOutput("false");
		ValueInput<int> p1 = AddValueInput<int>("释放者实体ID", "添加者");
		ValueInput<int> p2 = AddValueInput<int>("持有者实体ID", "作用对象");
		ValueInput<int> p3 = AddValueInput<int>("创建ID", "buff ID");
		AddFlowInput(" ", delegate(Flow f)
		{
			if (Invoke(p1.GetValue(), p2.GetValue(), p3.GetValue()))
			{
				trueOut.Call(f);
			}
			else
			{
				falseOut.Call(f);
			}
		});
		AddValueOutput("释放者实体ID", "casterID", () => p1.GetValue());
		AddValueOutput("持有者实体ID", "ownerID", () => p2.GetValue());
	}

	private bool Invoke(int who, int targetID, int buffID)
	{
		BuffProcessor.RemoveBuffID(who, targetID, buffID);
		return true;
	}
}
