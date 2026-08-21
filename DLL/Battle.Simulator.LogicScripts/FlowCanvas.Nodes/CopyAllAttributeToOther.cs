using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("将某个实体的属性拷贝到另一个上", 0)]
[Category("Logic/Attribute")]
[Description("将某个实体的属性拷贝到另一个上")]
public class CopyAllAttributeToOther : CallableActionNode<int, int>
{
	public override void Invoke(int a, int b)
	{
		FlowCanvasLogicFuncHelper.CopyAllAttributeToOther(base.parentNode.mSimContext, a, b);
	}
}
