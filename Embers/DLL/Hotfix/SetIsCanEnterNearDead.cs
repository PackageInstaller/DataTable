using Ase;
using ParadoxNotion.Design;

[Name("是否能进入濒死", 0)]
[Description("是否能进入濒死")]
[Category("✫ DragonLost/Entity")]
public class SetIsCanEnterNearDead : ActionTaskBase
{
	[Name("是否能进入濒死", 0)]
	public bool IsCan;

	protected override async void OnExecute()
	{
		base.OnExecute();
		ownerEntity.GetComponent<NearDeathRescueComponent>()?.SetIsCanEnterNearDeadState(IsCan);
		OnActionFinish();
	}
}
