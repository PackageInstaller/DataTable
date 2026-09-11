using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("[CD]增减CD时间上限百分比(已过时)", 0)]
[Category("Logic/Attribute")]
[Description("增减CD时间上限百分比，计算时是用用100 - 设置的值；所以这边填50%得到的是50%；填-50%，得到的是150%。原本的命名可能有歧意")]
[ExposeAsDefinition]
public class ModifyAbilityCDPercent : CallableActionNode<int, int>
{
	public override void Invoke(int entityID, int percentPlusValue)
	{
	}
}
