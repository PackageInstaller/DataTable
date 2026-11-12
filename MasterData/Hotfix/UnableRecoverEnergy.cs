[AdventureEffect(HotfixEnum.effectType.UNABLE_RECOVER_ENERGY)]
public class UnableRecoverEnergy : AdventureEffectBase
{
	public override void Execute()
	{
		base.Execute();
		for (int i = 0; i < _targets.Count; i++)
		{
			PlayerAdventureActor playerAdventureActor = _targets.get_Item(i) as PlayerAdventureActor;
			if (playerAdventureActor != null)
			{
				playerAdventureActor.playerSkillCd.EnterUnableRecoverEnergyState();
			}
		}
	}

	public override void PostExecute()
	{
		base.PostExecute();
		for (int i = 0; i < _targets.Count; i++)
		{
			PlayerAdventureActor playerAdventureActor = _targets.get_Item(i) as PlayerAdventureActor;
			if (playerAdventureActor != null)
			{
				playerAdventureActor.playerSkillCd.ExitUnableRecoverEnergyState();
			}
		}
	}
}
