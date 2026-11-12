using System.Collections.Generic;
using TrueSync;
using UnityEngine;

[AdventureEffect(HotfixEnum.effectType.ATTR_FIX)]
public class BaseAttriFix : AdventureEffectBase
{
	private readonly List<LogicEntity> fromActors = new List<LogicEntity>();

	private FDP _valueFDP;

	public override void Execute()
	{
		base.Execute();
		if (!TryParseStringParamToInt(effectValueConfig.EffectTypeParam2, out var intValue, allowEmpty: true))
		{
			return;
		}
		if (intValue != 0)
		{
			if (!TryParseStringParamToFDP(effectValueConfig.EffectTypeParam1, out var floatValue))
			{
				return;
			}
			string[] array = effectValueConfig.EffectTypeParam3.Split(';');
			if (array.Length != 4)
			{
				Debug.LogError($"属性修改 效果参数3错误，正确格式为 1;1;1;1（属性来源;属性类型;元素组合类型;伤害组合类型）, effectValueId:{effectValueConfig.Id}");
				return;
			}
			if (!TryParseStringParamToInt(array[0], out var intValue2) || !TryParseStringParamToInt(array[1], out var intValue3) || !TryParseStringParamToInt(array[2], out var intValue4) || !TryParseStringParamToInt(array[3], out var intValue5))
			{
				return;
			}
			if (intValue4 != 0 || intValue5 != 0)
			{
				if (intValue4 < 0 || intValue4 > 6)
				{
					Debug.LogError($"属性修改 效果参数3错误，元素组合类型配置错误：{intValue4}, effectValueId:{effectValueConfig.Id}");
					return;
				}
				if (intValue5 < 0 || intValue5 > 7)
				{
					Debug.LogError($"属性修改 效果参数3错误，伤害组合类型配置错误：{intValue5}, effectValueId:{effectValueConfig.Id}");
					return;
				}
				intValue3 = ((intValue4 != 0) ? 4 : 5);
			}
			if (!TryParseStringParamToFDP(effectValueConfig.EffectTypeParam4, out var floatValue2) || !TryParseStringParamToFDP(effectValueConfig.EffectTypeParam5, out var floatValue3) || !TryParseStringParamToFDP(effectValueConfig.EffectTypeParam6, out var floatValue4))
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
			case 4:
				fromActors.Add(_fromActor);
				break;
			}
			if (fromActors.Count == 0)
			{
				return;
			}
			_valueFDP = FDP.Zero;
			foreach (LogicEntity fromActor in fromActors)
			{
				if (fromActor == null || !(fromActor is AdventureActor adventureActor))
				{
					return;
				}
				FDP fDP = intValue3 switch
				{
					1 => adventureActor.attributeList.GetOriginValue((HotfixEnum.effectAttributeType)intValue2), 
					2 => FDP.Max(FDP.Zero, adventureActor.attributeList.GetAttributeValue((HotfixEnum.effectAttributeType)intValue2) - adventureActor.attributeList.GetOriginValue((HotfixEnum.effectAttributeType)intValue2)), 
					3 => adventureActor.attributeList.GetAttributeValue((HotfixEnum.effectAttributeType)intValue2), 
					4 => adventureActor.actorInfo.GetAttributeValueWithElementOrDamageType((HotfixEnum.effectAttributeType)intValue2, (HotfixEnum.elementType)intValue4, HotfixEnum.damageType.NONE), 
					_ => adventureActor.actorInfo.GetAttributeValueWithElementOrDamageType((HotfixEnum.effectAttributeType)intValue2, HotfixEnum.elementType.NONE, (HotfixEnum.damageType)intValue5), 
				};
				fDP = ((!(fDP > floatValue3)) ? FDP.Zero : ((fDP - floatValue3) / floatValue2));
				_valueFDP += fDP;
			}
			_valueFDP *= floatValue;
			_valueFDP = FDP.Min(_valueFDP, floatValue4);
		}
		else if (!TryParseStringParamToFDP(effectValueConfig.EffectTypeParam1, out _valueFDP))
		{
			return;
		}
		for (int i = 0; i < _targets.Count; i++)
		{
			Process(_targets.get_Item(i), _valueFDP);
		}
	}

	public override void PostExecute()
	{
		base.PostExecute();
		for (int i = 0; i < _targets.Count; i++)
		{
			Process(_targets.get_Item(i), -_valueFDP, post: true);
		}
	}

	private void Process(AdventureActor actor, FDP val, bool post = false)
	{
		if (!(_valueFDP == FDP.Zero) && effectValueConfig.EffectTypeFirstSubtype != 0 && !(actor == null) && actor.attributeList != null)
		{
			actor.attributeList.ChangeValue(effectValueConfig.EffectTypeFirstSubtype, effectValueConfig.EffectTypeSecondSubtype, val);
		}
	}
}
