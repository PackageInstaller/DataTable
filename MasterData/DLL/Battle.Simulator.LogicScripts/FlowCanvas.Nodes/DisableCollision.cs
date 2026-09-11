using ParadoxNotion.Design;

namespace FlowCanvas.Nodes;

[Name("关闭或启用碰撞(过时)", 0)]
[Category("Logic/Attribute")]
[Description("关闭碰撞")]
public class DisableCollision : CallableActionNode<SimEntity, bool>
{
	public override void Invoke(SimEntity simEntity, bool isEnable)
	{
		if (simEntity.hasEntityShape)
		{
			simEntity.entityShape.mShape.IsEnable = isEnable;
		}
	}
}
