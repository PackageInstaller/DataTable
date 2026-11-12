using Nova.Client;
using TrueSync;
using UnityEngine;

[AdventureEffect(HotfixEnum.effectType.EFFECT_HP_REVERTTO)]
public class EffectHpRevertTo : AdventureEffectBase
{
	private FDP param1;

	private FDP param2;

	public override void InitParams()
	{
		base.InitParams();
		TryParseStringParamToFDP(effectValueConfig.EffectTypeParam1, out param1);
		TryParseStringParamToFDP(effectValueConfig.EffectTypeParam2, out param2);
	}

	public override void Execute()
	{
		base.Execute();
		if (param1 < FDP.Zero || param2 < FDP.Zero)
		{
			Debug.LogError("恢复生命值至 效果参数不能为负数，效果value表id:" + effectValueConfig.Id);
			return;
		}
		for (int i = 0; i < _targets.Count; i++)
		{
			if (_targets.get_Item(i).isDead || _targets.get_Item(i).cureImmunity)
			{
				continue;
			}
			long hp = _targets.get_Item(i).actorHealthInfo.hp;
			long hpMax = _targets.get_Item(i).actorHealthInfo.hpMax;
			if ((FDP)hp * (FDP)100 / hpMax > param1)
			{
				continue;
			}
			FDP fDP = hpMax * param1 / 100L + param2;
			long num = (long)(fDP - hp);
			num = ((num < hpMax - hp) ? num : (hpMax - hp));
			if (num == 0L)
			{
				continue;
			}
			ModuleController<AdventureModuleController>.Instance.RecordEffectDamage(_targets.get_Item(i), (long)fDP, Recorder.Types.DamageType.HpRevert);
			_targets.get_Item(i).actorHealthInfo.hp += num;
			if (_targets.get_Item(i) is PlayerAdventureActor playerAdventureActor)
			{
				if (playerAdventureActor.actived)
				{
					MonoSingleton<LuaManager>.Instance.FireEvent("HudHeal", _targets.get_Item(i).Id, num);
				}
			}
			else
			{
				MonoSingleton<LuaManager>.Instance.FireEvent("HudHeal", _targets.get_Item(i).Id, num);
			}
			AdventureActorHpChangedEvent adventureActorHpChangedEvent = AdventureActorHpChangedEvent.Generate();
			adventureActorHpChangedEvent.sender = _targets.get_Item(i);
			adventureActorHpChangedEvent.currentHp = _targets.get_Item(i).actorHealthInfo.hp;
			adventureActorHpChangedEvent.maxHp = _targets.get_Item(i).actorHealthInfo.hpMax;
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorHpChangedEvent);
		}
	}
}
