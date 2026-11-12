using AIScript.Monster.Template;

namespace AIScript.Monster._31301JiJuXie;

public class Parrallel_BossRush : Parallel_BossRush
{
	private readonly string bossTagId = "100022";

	private readonly int buff_assistVulnerable = 631021030;

	private readonly int buff_assistVulnerable1 = 631021040;

	private readonly string bossTagId_2 = "100023";

	private readonly int buff_ultVulnerable_1 = 631025040;

	private readonly int buff_ultVulnerable_2 = 631025050;

	private bool hasTag;

	private bool hasTag_2;

	public override void OnStart()
	{
		base.OnStart();
		hasTag = _actor.CheckTag(bossTagId);
		hasTag_2 = _actor.CheckTag(bossTagId_2);
	}

	public override void OnDisable()
	{
		base.OnDisable();
	}

	protected override void OnActorReceiveDamage(AdventureActorReceiveDamageEvent damageEvent)
	{
		if (hasTag && !(damageEvent.to != _actor) && damageEvent.from is PlayerAdventureActor { isAssist: not false } playerAdventureActor)
		{
			if (damageEvent.damageType == HotfixEnum.damageType.ULTIMATE)
			{
				_actor.buffComponent?.AddBuff(buff_assistVulnerable1, playerAdventureActor);
			}
			else if (damageEvent.damageType == HotfixEnum.damageType.NORMAL)
			{
				_actor.buffComponent?.AddBuff(buff_assistVulnerable, playerAdventureActor);
			}
		}
	}

	protected override void OnActorCastSkill(AdventureActorCastSkillEvent castSkillEvent)
	{
		if (hasTag_2 && castSkillEvent.sender is PlayerAdventureActor { isAssist: false } playerAdventureActor && castSkillEvent.skillEventInfo != null && castSkillEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.D)
		{
			_actor.buffComponent?.AddBuff(buff_ultVulnerable_1, playerAdventureActor);
			_actor.buffComponent?.AddBuff(buff_ultVulnerable_2, playerAdventureActor);
		}
	}
}
