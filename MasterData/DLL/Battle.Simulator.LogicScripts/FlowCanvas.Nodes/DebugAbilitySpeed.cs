using ParadoxNotion.Design;
using UnityEngine;

namespace FlowCanvas.Nodes;

[Name("打印技能速度", 0)]
[Category("Logic/Abilities")]
[Description("打印技能速度")]
public class DebugAbilitySpeed : CallableActionNode<int>
{
	public override void Invoke(int entityID)
	{
		Debug.Log(base.parentNode.mSimContext.GetEntityWithEntityID(entityID).entityActionAbility.mAbilitySpeed);
	}
}
