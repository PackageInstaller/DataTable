namespace AIScript.Monster.Soldier._30921;

public class Action : SoldierBaseAI
{
	public const int BuffId = 250106001;

	protected override bool CanInterruptNormalAttackForMainSkill()
	{
		return false;
	}

	protected override bool OnMainSkillReadyDuringNormalAttack(SoldierActor caster)
	{
		if (caster == null || caster.mainSkillId == 0)
		{
			return false;
		}
		_actor.buffComponent.AddBuff(250106001, _actor);
		caster.ConsumeEnergy();
		if (!caster.isEnemyCamp)
		{
			MonoSingleton<LuaManager>.Instance.FireEvent("Soldier_CastSkill", caster.Id, caster.dataID, caster.mainSkillId);
		}
		return true;
	}
}
