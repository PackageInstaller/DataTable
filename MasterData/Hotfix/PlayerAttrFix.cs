using System.Collections.Generic;
using TrueSync;

[AdventureEffect(HotfixEnum.effectType.PLAYER_ATTR_FIX)]
public class PlayerAttrFix : AdventureEffectBase
{
	private readonly List<PlayerAdventureActor> fromActors = new List<PlayerAdventureActor>();

	private FDP value;

	public override void Execute()
	{
		base.Execute();
		if (!TryParseStringParamToInt(effectValueConfig.EffectTypeParam2, out var intValue, allowEmpty: true) || !TryParseStringParamToInt(effectValueConfig.EffectTypeParam3, out var intValue2, allowEmpty: true))
		{
			return;
		}
		if (intValue != 0)
		{
			if (!TryParseStringParamToFDP(effectValueConfig.EffectTypeParam1, out var floatValue))
			{
				return;
			}
			fromActors.Clear();
			switch (intValue)
			{
			case 1:
				if (_owner is PlayerAdventureActor item2)
				{
					fromActors.Add(item2);
				}
				break;
			case 2:
				if (!(_owner is PlayerAdventureActor))
				{
					break;
				}
				foreach (PlayerAdventureActor actorL in SceneSingleton<AdventurePlayerController>.Instance.ActorLs)
				{
					fromActors.Add(actorL);
				}
				break;
			case 3:
				if (_owner is MonsterAdventureActor && _owner.monsterTarget is PlayerAdventureActor item)
				{
					fromActors.Add(item);
				}
				break;
			}
			if (fromActors.Count == 0)
			{
				return;
			}
			foreach (PlayerAdventureActor fromActor in fromActors)
			{
				if (fromActor == null)
				{
					return;
				}
				value += fromActor.GetAttributeValue((HotfixEnum.playerAttributeType)intValue2);
			}
			value /= (FDP)fromActors.Count;
			value *= floatValue;
		}
		else if (!TryParseStringParamToFDP(effectValueConfig.EffectTypeParam1, out value))
		{
			return;
		}
		for (int i = 0; i < _targets.Count; i++)
		{
			Process(_targets.get_Item(i), value);
		}
	}

	public override void PostExecute()
	{
		base.PostExecute();
		for (int i = 0; i < _targets.Count; i++)
		{
			Process(_targets.get_Item(i), -value, post: true);
		}
	}

	private void Process(AdventureActor actor, FDP val, bool post = false)
	{
		if (effectValueConfig.EffectTypeFirstSubtype != 3 && actor is PlayerAdventureActor playerAdventureActor)
		{
			playerAdventureActor.ChangePlayerAttrValue(effectValueConfig.EffectTypeFirstSubtype, effectValueConfig.EffectTypeSecondSubtype, val);
		}
	}
}
