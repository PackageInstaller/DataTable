using System.Collections.Generic;
using TrueSync;

[AdventureEffect(HotfixEnum.effectType.MONSTER_ATTR_FIX)]
public class MonsterAttrFix : AdventureEffectBase
{
	private readonly List<MonsterAdventureActor> fromActors = new List<MonsterAdventureActor>();

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
				if (_owner is MonsterAdventureActor item2)
				{
					fromActors.Add(item2);
				}
				break;
			case 3:
				if ((bool)(_owner as PlayerAdventureActor) && _owner.attackTarget is MonsterAdventureActor item)
				{
					fromActors.Add(item);
				}
				break;
			}
			if (fromActors.Count == 0)
			{
				return;
			}
			foreach (MonsterAdventureActor fromActor in fromActors)
			{
				if (fromActor == null)
				{
					return;
				}
				value += fromActor.GetAttributeValue((HotfixEnum.monsterAttributeType)intValue2);
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
		if (effectValueConfig.EffectTypeFirstSubtype != 1 && actor is MonsterAdventureActor monsterAdventureActor)
		{
			monsterAdventureActor.ChangeMonsterAttrValue(effectValueConfig.EffectTypeFirstSubtype, effectValueConfig.EffectTypeSecondSubtype, val);
		}
	}
}
