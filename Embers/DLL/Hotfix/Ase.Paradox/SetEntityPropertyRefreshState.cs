using ParadoxNotion.Design;

namespace Ase.Paradox;

[Name("设置属性死亡刷新状态", 0)]
[Description("在实体死亡时设置属性是否刷新的状态。")]
[Category("✫ DragonLost/Entity")]
public class SetEntityPropertyRefreshState : ActionTaskBase
{
	[Name("属性名", 0)]
	[Description("要设置刷新状态的属性的名称。")]
	public string PropertyKey;

	[Name("是否刷新", 0)]
	[Description("指示是否在实体死亡时刷新属性值。")]
	public bool IsRefresh;

	protected override void OnExecute()
	{
		base.OnExecute();
		ownerEntity.SetPropertyRefreshState(PropertyKey, IsRefresh);
		EndAction();
	}
}
