using System.Collections.Generic;
using TrueSync;

[AdventureEffect(HotfixEnum.effectType.SPECIAL_ATTR_FIX)]
public class SpecialAttrFix : AdventureEffectBase
{
	private readonly List<LogicEntity> fromActors = new List<LogicEntity>();

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
				fromActors.Add(_owner);
				break;
			case 2:
				if ((bool)(_owner as PlayerAdventureActor))
				{
					fromActors.AddRange(SceneSingleton<AdventurePlayerController>.Instance.ActorLs);
				}
				break;
			case 3:
				if ((bool)(_owner as PlayerAdventureActor) && _owner.attackTarget != null)
				{
					fromActors.Add(_owner.attackTarget);
				}
				else if ((bool)(_owner as MonsterAdventureActor) && _owner.monsterTarget != null)
				{
					fromActors.Add(_owner.monsterTarget);
				}
				break;
			}
			if (fromActors.Count == 0)
			{
				return;
			}
			foreach (LogicEntity fromActor in fromActors)
			{
				if (fromActor == null || !(fromActor is AdventureActor adventureActor))
				{
					return;
				}
				value += adventureActor.specialAttributeList.GetAttributeValue((HotfixEnum.specialAttributeType)intValue2);
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
	}

	private void Process(AdventureActor actor, FDP val, bool post = false)
	{
		if (effectValueConfig.EffectTypeFirstSubtype != 0 && effectValueConfig.EffectTypeFirstSubtype != 5 && !(actor == null) && actor.specialAttributeList != null)
		{
			actor.specialAttributeList.SetAttributeValue(actor.attributeList, (HotfixEnum.specialAttributeType)effectValueConfig.EffectTypeFirstSubtype, (HotfixEnum.parameterType)effectValueConfig.EffectTypeSecondSubtype, val);
		}
	}
}
