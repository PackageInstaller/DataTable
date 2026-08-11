using Ase.ECS;

namespace Ase;

public class RecoverEnergyEnabledBuff : BuffOperationBase<BuffDataRecoverEnergyEnabled>
{
	protected override void OnExecute()
	{
		if (base.buffOwner is HeroEntity { BattleHeroData: not null } heroEntity)
		{
			heroEntity.BattleHeroData.RecoverEnergyEnabled = dataBase.enabled;
		}
	}

	protected override void OnDispose()
	{
		if (base.buffOwner is HeroEntity { BattleHeroData: not null } heroEntity)
		{
			heroEntity.BattleHeroData.RecoverEnergyEnabled = !dataBase.enabled;
		}
	}
}
