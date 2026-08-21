using Ase;
using Ase.ECS;
using ParadoxNotion.Design;

[Name("进入伤员名单", 0)]
[Description("将实体注册为伤员，加入伤员名单。")]
[Category("✫ DragonLost/Entity")]
public class RegisterWoundedAction : ActionTaskBase
{
	protected override void OnExecute()
	{
		base.OnExecute();
		GetOwnerEntity().GetSystem<EntitySystem>().RegisterWounded((HeroEntity)ownerEntity);
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance?.WriteAuthorityEntityId("进入伤员名单", ownerEntity);
		}
		OnActionFinish();
	}
}
