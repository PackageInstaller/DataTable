using Ase.ECS;
using NodeCanvas.Framework;
using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("实体重置护盾", 0)]
[Description("重置指定实体的护盾值。")]
[Category("✫ DragonLost/Entity")]
public class ResetEntityShield : ActionTaskBase
{
	[Name("自身添加", 0)]
	[Description("指定是否为自身添加护盾值。")]
	public bool toSelf = true;

	[ShowIf("toSelf", 0)]
	[Name("目标实体", 0)]
	[Description("要重置护盾值的目标实体。")]
	public BBParameter<BaseEntity> targetEntity;

	[Name("护盾值", 0)]
	[Description("要重置的护盾值。")]
	public BBParameter<int> shieldValue;

	protected override void OnExecute()
	{
		base.OnExecute();
		OnActionFinish();
	}
}
