namespace Ase.ECS;

public class PseudoCritComponent : BaseComponent
{
	public bool CalculateCrit(BaseEntity defender, BaseWeaknessData weaknessData, HitColliderVariableData hbData)
	{
		float num = 0f;
		num = mBaseEntity.RandomFloat(0f, 1f);
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance?.WriteAuthorityEntityId($"暴击随机值 ： {num}", defender);
		}
		bool monsterCollapseState = defender.GetComponent<StateComponent>()?.IsDownState() ?? false;
		MonsterPhaseComponent component = defender.GetComponent<MonsterPhaseComponent>();
		bool odState = component != null && component.GetMonsterPhase() == MonsterPhaseEnum.OverDrive;
		if (num <= mBaseEntity.GetEntityCrit(weaknessData, hbData, monsterCollapseState, odState, defender))
		{
			return true;
		}
		return false;
	}
}
