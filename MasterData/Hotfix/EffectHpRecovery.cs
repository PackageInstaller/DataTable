using Nova.Client;
using TrueSync;
using UnityEngine;

[AdventureEffect(HotfixEnum.effectType.EFFECT_HP_RECOVRY)]
public class EffectHpRecovery : AdventureEffectBase
{
	private FDP param1;

	private FDP param2;

	private FDP param3;

	private FDP param4;

	public override void InitParams()
	{
		base.InitParams();
		TryParseStringParamToFDP(effectValueConfig.EffectTypeParam1, out param1);
		TryParseStringParamToFDP(effectValueConfig.EffectTypeParam2, out param2);
		TryParseStringParamToFDP(effectValueConfig.EffectTypeParam3, out param3);
		TryParseStringParamToFDP(effectValueConfig.EffectTypeParam4, out param4);
	}

	public override void Execute()
	{
		base.Execute();
		if (param1 < FDP.Zero || param2 < FDP.Zero || param3 < FDP.Zero || param4 < FDP.Zero)
		{
			Debug.LogError("回复生命值 效果参数不能为负数，效果value表id:" + effectValueConfig.Id);
			return;
		}
		for (int i = 0; i < _targets.Count; i++)
		{
			if (_targets.get_Item(i).isDead || _targets.get_Item(i).cureImmunity)
			{
				continue;
			}
			FDP fDP = _targets.get_Item(i).actorHealthInfo.hp;
			FDP fDP2 = _targets.get_Item(i).actorHealthInfo.hpMax;
			FDP fDP3 = fDP2 * param1 / 100L + param2;
			FDP fDP4 = fDP2 * param3 / 100L + param4;
			fDP3 = ((fDP4 < fDP3) ? fDP4 : fDP3);
			fDP3 = ((fDP3 < fDP2 - fDP) ? fDP3 : (fDP2 - fDP));
			if (!(fDP3 != 0))
			{
				continue;
			}
			ModuleController<AdventureModuleController>.Instance.RecordEffectDamage(_targets.get_Item(i), (long)fDP3, Recorder.Types.DamageType.HpRecover);
			_targets.get_Item(i).actorHealthInfo.hp += (long)fDP3;
			if (_targets.get_Item(i) is PlayerAdventureActor playerAdventureActor)
			{
				if (playerAdventureActor.actived)
				{
					MonoSingleton<LuaManager>.Instance.FireEvent("HudHeal", _targets.get_Item(i).Id, (long)fDP3);
				}
			}
			else
			{
				MonoSingleton<LuaManager>.Instance.FireEvent("HudHeal", _targets.get_Item(i).Id, (long)fDP3);
			}
			AdventureActorHpChangedEvent adventureActorHpChangedEvent = AdventureActorHpChangedEvent.Generate();
			adventureActorHpChangedEvent.sender = _targets.get_Item(i);
			adventureActorHpChangedEvent.currentHp = _targets.get_Item(i).actorHealthInfo.hp;
			adventureActorHpChangedEvent.maxHp = _targets.get_Item(i).actorHealthInfo.hpMax;
			adventureActorHpChangedEvent.isCovery = true;
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorHpChangedEvent);
		}
	}
}
