using Ase.ECS;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("交互物绑定移动", 0)]
[Description("根据交互物触发器绑定移动组件，可选择是否旋转到当前正方向。")]
[Category("✫ DragonLost/Entity")]
public class InteractiveEntityBingMove : ActionTaskBase
{
	[Name("是否旋转到当前正方向", 0)]
	[Description("如果选择，移动时将会旋转到当前正方向。")]
	public bool IsRotateForward = true;

	protected override void OnExecute()
	{
		base.OnExecute();
		BingMoveComponent component = ownerEntity.GetComponent<BingMoveComponent>();
		AIParadoxComponent component2 = ownerEntity.GetComponent<AIParadoxComponent>();
		if (component != null && component2 != null)
		{
			int variableValue = component2.GetVariableValue<int>(Constant.InteractiveConstant.MapItemTriggerId);
			component.SetEnableComp(variableValue, IsRotateForward);
		}
		OnActionFinish();
	}
}
