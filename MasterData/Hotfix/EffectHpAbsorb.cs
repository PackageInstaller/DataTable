using Nova.Client;
using TrueSync;
using UnityEngine;

[AdventureEffect(HotfixEnum.effectType.EFFECT_HP_ABSORB)]
public class EffectHpAbsorb : AdventureEffectBase
{
	private FDP param1;

	private FDP param2;

	public override void InitParams()
	{
		base.InitParams();
		TryParseStringParamToFDP(effectValueConfig.EffectTypeParam1, out param1);
		TryParseStringParamToFDP(effectValueConfig.EffectTypeParam2, out param2);
	}

	public override void PostExecute()
	{
		base.PostExecute();
		if (param1 < FDP.Zero || param2 < FDP.Zero)
		{
			Debug.LogError("生命吸取 效果参数不能为负数，效果value表id:" + effectValueConfig.Id);
			return;
		}
		for (int i = 0; i < _targets.Count; i++)
		{
			if (Damage != 0L && !_targets.get_Item(i).isDead && !_targets.get_Item(i).cureImmunity)
			{
				absorbHP(_targets.get_Item(i));
			}
		}
	}

	private void absorbHP(AdventureActor actor)
	{
		long hp = actor.actorHealthInfo.hp;
		long hpMax = actor.actorHealthInfo.hpMax;
		if (hp >= hpMax)
		{
			return;
		}
		long num = (long)(Damage * param1 / 100L + param2);
		if ((FDP)(hp + num) > hpMax)
		{
			num = (long)((FDP)hpMax - (FDP)hp);
		}
		if (num == 0L)
		{
			return;
		}
		ModuleController<AdventureModuleController>.Instance.RecordEffectDamage(actor, num, Recorder.Types.DamageType.HpAbsorb);
		actor.actorHealthInfo.hp += num;
		if (actor is PlayerAdventureActor playerAdventureActor)
		{
			if (playerAdventureActor.actived)
			{
				MonoSingleton<LuaManager>.Instance.FireEvent("HudHeal", actor.Id, num);
			}
		}
		else
		{
			MonoSingleton<LuaManager>.Instance.FireEvent("HudHeal", actor.Id, num);
		}
		AdventureActorHpChangedEvent adventureActorHpChangedEvent = AdventureActorHpChangedEvent.Generate();
		adventureActorHpChangedEvent.sender = actor;
		adventureActorHpChangedEvent.currentHp = actor.actorHealthInfo.hp;
		adventureActorHpChangedEvent.maxHp = actor.actorHealthInfo.hpMax;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorHpChangedEvent);
	}
}
