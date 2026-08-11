namespace Ase.ECS;

public class HeroDestroyComponent : DestroyComponent
{
	public override void DoEntityDead(bool isKilled = false)
	{
		base.DoEntityDead(isKilled);
		mBaseEntity.GetComponent<StateComponent>().EnterDeadState();
		if (mBaseEntity is HeroEntity heroEntity)
		{
			heroEntity.BattleHeroData.EntityEnterDead();
			if (!heroEntity.IsAi)
			{
				mBaseEntity.GetWorld().OnHeroCantRevived(mBaseEntity.Id);
			}
		}
	}
}
