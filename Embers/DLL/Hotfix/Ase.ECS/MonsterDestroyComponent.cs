namespace Ase.ECS;

public class MonsterDestroyComponent : DestroyComponent
{
	public override void DoEntityDead(bool isKilled = false)
	{
		base.DoEntityDead(isKilled);
		mBaseEntity.GetComponent<StateComponent>().EnterDeadState();
		mBaseEntity.GetSystem<BattleSystem>().RecodeKillMonsterNumber(mBaseEntity, base.KillerEntity);
		if (mBaseEntity is MonsterEntity { IsBoss: not false })
		{
			mBaseEntity.GetSystem<BattleSystem>().ShowBossBarWindow(isShow: false);
		}
	}
}
