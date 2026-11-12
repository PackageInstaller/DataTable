#define LOG_ERROR
using System.Collections.Generic;
using Google.Protobuf.Collections;
using Nova.Client;
using Nova.Hotfix;
using TrueSync;
using UnityEngine;

public sealed class ActorAdditionalAttrInfo
{
	private Dictionary<int, FDP> attributeWithElementOrDamageTypeDict = new Dictionary<int, FDP>();

	public AttributeList attributeList { get; } = new AttributeList();

	public FDP atk => GetAttributeValue(HotfixEnum.effectAttributeType.ATK);

	public FDP defIgnore => GetAttributeValue(HotfixEnum.effectAttributeType.DEF_IGNORE);

	public FDP defPenetrate => GetAttributeValue(HotfixEnum.effectAttributeType.PENETRATE);

	public FDP suppressRatio => GetAttributeValue(HotfixEnum.effectAttributeType.SUPPRESS);

	public FDP normalSuppressRatio => GetAttributeValue(HotfixEnum.effectAttributeType.NORMAL_SUPPRESS);

	public FDP skillSuppressRatio => GetAttributeValue(HotfixEnum.effectAttributeType.SKILL_SUPPRESS);

	public FDP ultraSuppressRatio => GetAttributeValue(HotfixEnum.effectAttributeType.ULTRA_SUPPRESS);

	public FDP markSuppressRatio => GetAttributeValue(HotfixEnum.effectAttributeType.MARK_SUPPRESS);

	public FDP summonSuppressRatio => GetAttributeValue(HotfixEnum.effectAttributeType.SUMMON_SUPPRESS);

	public FDP projectileSuppressRatio => GetAttributeValue(HotfixEnum.effectAttributeType.PROJECTILE_SUPPRESS);

	public FDP otherSuppressRatio => GetAttributeValue(HotfixEnum.effectAttributeType.OTHER_SUPPRESS);

	public FDP normalDmgRatio => GetAttributeValue(HotfixEnum.effectAttributeType.NORMALDMG);

	public FDP skillDmgRatio => GetAttributeValue(HotfixEnum.effectAttributeType.SKILLDMG);

	public FDP ultraDmgRatio => GetAttributeValue(HotfixEnum.effectAttributeType.ULTRADMG);

	public FDP otherDmgRatio => GetAttributeValue(HotfixEnum.effectAttributeType.OTHERDMG);

	public FDP intensityRatio => GetAttributeValue(HotfixEnum.effectAttributeType.INTENSITY);

	public FDP critPower => GetAttributeValue(HotfixEnum.effectAttributeType.CRITPOWER_P);

	public FDP genDmgRatio => GetAttributeValue(HotfixEnum.effectAttributeType.GENDMG);

	public FDP dmgPlus => GetAttributeValue(HotfixEnum.effectAttributeType.DMGPLUS);

	public FDP finalDmgRatio => GetAttributeValue(HotfixEnum.effectAttributeType.FINALDMG);

	public FDP finalDmgPlus => GetAttributeValue(HotfixEnum.effectAttributeType.FINALDMGPLUS);

	public FDP critRate => GetAttributeValue(HotfixEnum.effectAttributeType.CRITRATE);

	public FDP hitRate => GetAttributeValue(HotfixEnum.effectAttributeType.HITRATE);

	public FDP toughnessDamageRatio => GetAttributeValue(HotfixEnum.effectAttributeType.TOUGHNESS_DAMAGE_ADJUST);

	public FDP markDmgRatio => GetAttributeValue(HotfixEnum.effectAttributeType.MARKDMG);

	public FDP summonDmgRatio => GetAttributeValue(HotfixEnum.effectAttributeType.SUMMONDMG);

	public FDP projectileDmgRatio => GetAttributeValue(HotfixEnum.effectAttributeType.PROJECTILEDMG);

	public FDP normalCritRate => GetAttributeValue(HotfixEnum.effectAttributeType.NORMALCRITRATE);

	public FDP skillCritRate => GetAttributeValue(HotfixEnum.effectAttributeType.SKILLCRITRATE);

	public FDP ultraCritRate => GetAttributeValue(HotfixEnum.effectAttributeType.ULTRACRITRATE);

	public FDP markCritRate => GetAttributeValue(HotfixEnum.effectAttributeType.MARKCRITRATE);

	public FDP summonCritRate => GetAttributeValue(HotfixEnum.effectAttributeType.SUMMONCRITRATE);

	public FDP projectileCritRate => GetAttributeValue(HotfixEnum.effectAttributeType.PROJECTILECRITRATE);

	public FDP otherCritRate => GetAttributeValue(HotfixEnum.effectAttributeType.OTHERCRITRATE);

	public FDP normalCritPower => GetAttributeValue(HotfixEnum.effectAttributeType.NORMALCRITPOWER);

	public FDP skillCritPower => GetAttributeValue(HotfixEnum.effectAttributeType.SKILLCRITPOWER);

	public FDP ultraCritPower => GetAttributeValue(HotfixEnum.effectAttributeType.ULTRACRITPOWER);

	public FDP markCritPower => GetAttributeValue(HotfixEnum.effectAttributeType.MARKCRITPOWER);

	public FDP summonCritPower => GetAttributeValue(HotfixEnum.effectAttributeType.SUMMONCRITPOWER);

	public FDP projectileCritPower => GetAttributeValue(HotfixEnum.effectAttributeType.PROJECTILECRITPOWER);

	public FDP otherCritPower => GetAttributeValue(HotfixEnum.effectAttributeType.OTHERCRITPOWER);

	public FDP skillIntensityRatio => GetAttributeValue(HotfixEnum.effectAttributeType.SKILL_INTENSITY);

	public FDP def => GetAttributeValue(HotfixEnum.effectAttributeType.DEF);

	public FDP genDmgRcdRatio => GetAttributeValue(HotfixEnum.effectAttributeType.GENDMGRCD);

	public FDP evd => GetAttributeValue(HotfixEnum.effectAttributeType.EVD);

	public FDP opposeCritRate => GetAttributeValue(HotfixEnum.effectAttributeType.CRITRESIST);

	public FDP normalDmgRcdRatio => GetAttributeValue(HotfixEnum.effectAttributeType.RCDNORMALDMG);

	public FDP skillDmgRcdRatio => GetAttributeValue(HotfixEnum.effectAttributeType.RCDSKILLDMG);

	public FDP ultraDmgRcdRatio => GetAttributeValue(HotfixEnum.effectAttributeType.RCDULTRADMG);

	public FDP otherDmgRcdRatio => GetAttributeValue(HotfixEnum.effectAttributeType.RCDOTHERDMG);

	public FDP dmgPlusRcd => GetAttributeValue(HotfixEnum.effectAttributeType.DMGPLUSRCD);

	public FDP markDmgRcdRatio => GetAttributeValue(HotfixEnum.effectAttributeType.RCDMARKDMG);

	public FDP summonDmgRcdRatio => GetAttributeValue(HotfixEnum.effectAttributeType.RCDSUMMONDMG);

	public FDP projectileDmgRcdRatio => GetAttributeValue(HotfixEnum.effectAttributeType.RCDPROJECTILEDMG);

	public FDP toughnessBrokenDmgRatio => GetAttributeValue(HotfixEnum.effectAttributeType.TOUGHNESS_BROKEN_DMG);

	public FDP envAmendRatio => GetAttributeValue(HotfixEnum.effectAttributeType.ENV_AMEND);

	public bool forceCrit { get; set; }

	public bool forceMissDamage { get; set; }

	public FDP GetAttributeValue(HotfixEnum.effectAttributeType type)
	{
		return attributeList.GetAttributeValue(type);
	}

	public FDP GetAttributeOriginValue(HotfixEnum.effectAttributeType type)
	{
		return attributeList.GetOriginValue(type);
	}

	private FDP GetAttributePercentAmendValue(HotfixEnum.effectAttributeType type)
	{
		return attributeList.GetAmendValue(type, HotfixEnum.parameterType.PERCENTAGE);
	}

	private FDP GetAttributeBaseValue(HotfixEnum.effectAttributeType type)
	{
		return attributeList.GetBaseValue(type);
	}

	private FDP GetAttributeAbsAmendValue(HotfixEnum.effectAttributeType type)
	{
		return attributeList.GetAmendValue(type, HotfixEnum.parameterType.ABSOLUTE_VALUE);
	}

	public FDP GetAttributeValueWithElementOrDamageType(HotfixEnum.effectAttributeType type, HotfixEnum.elementType elementType, HotfixEnum.damageType damageType)
	{
		bool isElementType = true;
		int elementOrDamageType = (int)elementType;
		if (damageType != HotfixEnum.damageType.NONE)
		{
			isElementType = false;
			elementOrDamageType = (int)damageType;
		}
		int key = CommonHelper.ConvertAttributeTypeAndElementOrDamageTypeToKey((int)type, elementOrDamageType, isElementType, isBaseValue: false, isAssignValue: true);
		int key2 = CommonHelper.ConvertAttributeTypeAndElementOrDamageTypeToKey((int)type, elementOrDamageType, isElementType, isBaseValue: true, isAssignValue: false);
		int key3 = CommonHelper.ConvertAttributeTypeAndElementOrDamageTypeToKey((int)type, elementOrDamageType, isElementType, isBaseValue: false, isAssignValue: false);
		if (attributeWithElementOrDamageTypeDict.TryGetValue(key, out var value))
		{
			return value;
		}
		return (attributeWithElementOrDamageTypeDict.GetValueOrDefault(key2, FDP.Zero) + GetAttributeBaseValue(type)) * (FDP.One + GetAttributePercentAmendValue(type) + attributeWithElementOrDamageTypeDict.GetValueOrDefault(key3, FDP.Zero)) + GetAttributeAbsAmendValue(type);
	}

	public void CopyFrom(AttributeList list, Dictionary<int, FDP> attributeWithElementOrDamageType)
	{
		attributeList.CopyValueFrom(list);
		attributeWithElementOrDamageTypeDict.Clear();
		if (attributeWithElementOrDamageType == null)
		{
			return;
		}
		foreach (KeyValuePair<int, FDP> item in attributeWithElementOrDamageType)
		{
			attributeWithElementOrDamageTypeDict.Add(item.Key, item.Value);
		}
	}

	public void AddFrom(AttributeList list, Dictionary<int, FDP> attributeWithElementOrDamageType)
	{
		attributeList.AddValueFrom(list);
		if (attributeWithElementOrDamageType == null)
		{
			return;
		}
		foreach (KeyValuePair<int, FDP> item in attributeWithElementOrDamageType)
		{
			if (attributeWithElementOrDamageTypeDict.ContainsKey(item.Key))
			{
				attributeWithElementOrDamageTypeDict.get_Item(item.Key) += item.Value;
			}
			else
			{
				attributeWithElementOrDamageTypeDict.Add(item.Key, item.Value);
			}
		}
	}

	public void WriteMessage(RepeatedField<Recorder.Types.Attribute> attributes)
	{
		attributeList.WriteMessage(attributes);
	}

	public void WriteSpecialMessage(RepeatedField<Recorder.Types.SpecialAttribute> attributes)
	{
		attributes.Clear();
		foreach (KeyValuePair<int, FDP> item2 in attributeWithElementOrDamageTypeDict)
		{
			Recorder.Types.SpecialAttribute item = new Recorder.Types.SpecialAttribute
			{
				AttrType = item2.Key,
				Value = item2.Value.AsFloat()
			};
			attributes.Add(item);
		}
	}

	public void AddAttr(AdventureActor fromActor, List<int> idList, int count = 1)
	{
		if (idList != null)
		{
			for (int i = 0; i < idList.Count; i++)
			{
				AddAttr(fromActor, idList.get_Item(i), count);
			}
		}
	}

	public void AddAttr(AdventureActor fromActor, int id, int count = 1)
	{
		OnceAdditionalAttribute onceAdditionalAttribute = Singleton<HotfixDataController>.Instance.GetOnceAdditionalAttribute(id);
		if (onceAdditionalAttribute != null)
		{
			int valueConfigIdByLevelType = CommonHelper.GetValueConfigIdByLevelType(fromActor, onceAdditionalAttribute.Id, (HotfixEnum.levelTypeData)onceAdditionalAttribute.LevelTypeData, onceAdditionalAttribute.LevelData);
			OnceAdditionalAttributeValue onceAdditionalAttributeValue = Singleton<HotfixDataController>.Instance.GetOnceAdditionalAttributeValue(valueConfigIdByLevelType);
			if (onceAdditionalAttributeValue != null)
			{
				AddAttr((HotfixEnum.effectAttributeType)onceAdditionalAttributeValue.AttributeType1, (HotfixEnum.parameterType)onceAdditionalAttributeValue.ParameterType1, onceAdditionalAttributeValue.Value1, count, (HotfixEnum.elementType)onceAdditionalAttributeValue.ElementType1, (HotfixEnum.damageType)onceAdditionalAttributeValue.DamageType1, onceAdditionalAttributeValue.Id);
				AddAttr((HotfixEnum.effectAttributeType)onceAdditionalAttributeValue.AttributeType2, (HotfixEnum.parameterType)onceAdditionalAttributeValue.ParameterType2, onceAdditionalAttributeValue.Value2, count, (HotfixEnum.elementType)onceAdditionalAttributeValue.ElementType2, (HotfixEnum.damageType)onceAdditionalAttributeValue.DamageType2, onceAdditionalAttributeValue.Id);
				AddAttr((HotfixEnum.effectAttributeType)onceAdditionalAttributeValue.AttributeType3, (HotfixEnum.parameterType)onceAdditionalAttributeValue.ParameterType3, onceAdditionalAttributeValue.Value3, count, (HotfixEnum.elementType)onceAdditionalAttributeValue.ElementType3, (HotfixEnum.damageType)onceAdditionalAttributeValue.DamageType3, onceAdditionalAttributeValue.Id);
			}
			else
			{
				Debug.LogError($"OnceAdditionalAttribute Value Config Not Exist, Id:{valueConfigIdByLevelType}");
			}
		}
		else
		{
			Debug.LogError($"OnceAdditionalAttribute Config Not Exist, Id:{id}");
		}
	}

	public void AddAttr(HotfixEnum.effectAttributeType attributeType, HotfixEnum.parameterType parameterType, int value, int count, HotfixEnum.elementType elementType, HotfixEnum.damageType damageType, int valueConfigId)
	{
		FDP fDP = FDP.FromMyriad(value) * count;
		int key = 0;
		if (IsElementCombineAttr(attributeType, elementType, valueConfigId))
		{
			switch (parameterType)
			{
			case HotfixEnum.parameterType.BASE_VALUE:
				key = CommonHelper.ConvertAttributeTypeAndElementTypeToKey(attributeType, elementType);
				break;
			case HotfixEnum.parameterType.PERCENTAGE:
				key = CommonHelper.ConvertAttributeTypeAndElementTypeToKey(attributeType, elementType, isBaseValue: false);
				break;
			}
			if (!attributeWithElementOrDamageTypeDict.TryAdd(key, fDP))
			{
				attributeWithElementOrDamageTypeDict.get_Item(key) += fDP;
			}
		}
		else if (IsDamageTypeCombineAttr(attributeType, damageType, valueConfigId))
		{
			switch (parameterType)
			{
			case HotfixEnum.parameterType.BASE_VALUE:
				key = CommonHelper.ConvertAttributeTypeAndDamageTypeToKey(attributeType, damageType);
				break;
			case HotfixEnum.parameterType.PERCENTAGE:
				key = CommonHelper.ConvertAttributeTypeAndDamageTypeToKey(attributeType, damageType, isBaseValue: false);
				break;
			}
			if (!attributeWithElementOrDamageTypeDict.TryAdd(key, fDP))
			{
				attributeWithElementOrDamageTypeDict.get_Item(key) += fDP;
			}
		}
		else if (valueConfigId > 0)
		{
			attributeList.ChangeValue((int)attributeType, (int)parameterType, fDP);
		}
	}

	private bool IsElementCombineAttr(HotfixEnum.effectAttributeType attributeType, HotfixEnum.elementType elementType, int configId)
	{
		if (elementType == HotfixEnum.elementType.NONE || elementType == HotfixEnum.elementType.INHERIT)
		{
			return false;
		}
		if (attributeType == HotfixEnum.effectAttributeType.NORMALDMG || attributeType == HotfixEnum.effectAttributeType.SKILLDMG || attributeType == HotfixEnum.effectAttributeType.ULTRADMG || attributeType == HotfixEnum.effectAttributeType.MARKDMG || attributeType == HotfixEnum.effectAttributeType.SUMMONDMG || attributeType == HotfixEnum.effectAttributeType.PROJECTILEDMG || attributeType == HotfixEnum.effectAttributeType.OTHERDMG || attributeType == HotfixEnum.effectAttributeType.RCDNORMALDMG || attributeType == HotfixEnum.effectAttributeType.RCDSKILLDMG || attributeType == HotfixEnum.effectAttributeType.RCDULTRADMG || attributeType == HotfixEnum.effectAttributeType.RCDMARKDMG || attributeType == HotfixEnum.effectAttributeType.RCDSUMMONDMG || attributeType == HotfixEnum.effectAttributeType.RCDPROJECTILEDMG || attributeType == HotfixEnum.effectAttributeType.RCDOTHERDMG || attributeType == HotfixEnum.effectAttributeType.NORMALCRITRATE || attributeType == HotfixEnum.effectAttributeType.SKILLCRITRATE || attributeType == HotfixEnum.effectAttributeType.ULTRACRITRATE || attributeType == HotfixEnum.effectAttributeType.MARKCRITRATE || attributeType == HotfixEnum.effectAttributeType.SUMMONCRITRATE || attributeType == HotfixEnum.effectAttributeType.PROJECTILECRITRATE || attributeType == HotfixEnum.effectAttributeType.OTHERCRITRATE || attributeType == HotfixEnum.effectAttributeType.NORMALCRITPOWER || attributeType == HotfixEnum.effectAttributeType.SKILLCRITPOWER || attributeType == HotfixEnum.effectAttributeType.ULTRACRITPOWER || attributeType == HotfixEnum.effectAttributeType.MARKCRITPOWER || attributeType == HotfixEnum.effectAttributeType.SUMMONCRITPOWER || attributeType == HotfixEnum.effectAttributeType.PROJECTILECRITPOWER || attributeType == HotfixEnum.effectAttributeType.OTHERCRITPOWER || attributeType == HotfixEnum.effectAttributeType.NORMAL_SUPPRESS || attributeType == HotfixEnum.effectAttributeType.SKILL_SUPPRESS || attributeType == HotfixEnum.effectAttributeType.ULTRA_SUPPRESS || attributeType == HotfixEnum.effectAttributeType.MARK_SUPPRESS || attributeType == HotfixEnum.effectAttributeType.SUMMON_SUPPRESS || attributeType == HotfixEnum.effectAttributeType.PROJECTILE_SUPPRESS || attributeType == HotfixEnum.effectAttributeType.OTHER_SUPPRESS)
		{
			return true;
		}
		NovaLogger.Error($"附加属性表配置错误，elementType:{elementType}不能搭配属性:{attributeType}使用。id:{configId}");
		return false;
	}

	private bool IsDamageTypeCombineAttr(HotfixEnum.effectAttributeType attributeType, HotfixEnum.damageType damageType, int configId)
	{
		if (damageType == HotfixEnum.damageType.NONE)
		{
			return false;
		}
		if (attributeType == HotfixEnum.effectAttributeType.WEP || attributeType == HotfixEnum.effectAttributeType.FEP || attributeType == HotfixEnum.effectAttributeType.SEP || attributeType == HotfixEnum.effectAttributeType.AEP || attributeType == HotfixEnum.effectAttributeType.LEP || attributeType == HotfixEnum.effectAttributeType.DEP)
		{
			return true;
		}
		NovaLogger.Error($"附加属性表配置错误，damageType:{damageType}不能搭配属性:{attributeType}使用。id:{configId}");
		return false;
	}

	public void Clear()
	{
		attributeList.Clear();
		forceCrit = false;
		forceMissDamage = false;
		attributeWithElementOrDamageTypeDict.Clear();
	}
}
