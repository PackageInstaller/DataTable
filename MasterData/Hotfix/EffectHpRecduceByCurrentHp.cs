using Nova.Client;
using TrueSync;
using UnityEngine;

[AdventureEffect(HotfixEnum.effectType.REDUCE_HP_BY_CURRENTHP)]
public class EffectHpRecduceByCurrentHp : AdventureEffectBase
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
			Debug.LogError("根据当前生命扣除血量 效果参数不能为负数，效果value表id:" + effectValueConfig.Id);
			return;
		}
		for (int i = 0; i < _targets.Count; i++)
		{
			if (!_targets.get_Item(i).actorHealthInfo.isAlive)
			{
				continue;
			}
			long hp = _targets.get_Item(i).actorHealthInfo.hp;
			_ = _targets.get_Item(i).actorHealthInfo.hpMax;
			FDP fDP = hp * param1 / 100L + param2;
			FDP fDP2 = hp * param3 / 100L + param4;
			fDP = ((fDP2 < fDP) ? fDP2 : fDP);
			long num = (long)(hp - fDP);
			num = ((num > 1) ? num : 1);
			long num2 = hp - num;
			if (num2 == 0L)
			{
				continue;
			}
			ModuleController<AdventureModuleController>.Instance.RecordEffectDamage(_targets.get_Item(i), num2, Recorder.Types.DamageType.HpReduce);
			_targets.get_Item(i).actorHealthInfo.hp = num;
			if (_targets.get_Item(i) is PlayerAdventureActor playerAdventureActor)
			{
				if (playerAdventureActor.actived)
				{
					MonoSingleton<LuaManager>.Instance.FireEvent("HudDamage", _targets.get_Item(i).Id, num2);
				}
			}
			else
			{
				MonoSingleton<LuaManager>.Instance.FireEvent("HudDamage", _targets.get_Item(i).Id, num2);
			}
			AdventureActorHpChangedEvent adventureActorHpChangedEvent = AdventureActorHpChangedEvent.Generate();
			adventureActorHpChangedEvent.sender = _targets.get_Item(i);
			adventureActorHpChangedEvent.currentHp = _targets.get_Item(i).actorHealthInfo.hp;
			adventureActorHpChangedEvent.maxHp = _targets.get_Item(i).actorHealthInfo.hpMax;
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorHpChangedEvent);
		}
	}
}
