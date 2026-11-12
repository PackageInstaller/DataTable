using System;
using System.Collections.Generic;
using Google.Protobuf.Collections;
using Nova.Client;
using Nova.Hotfix;
using TrueSync;

public sealed class AttributeList
{
	public delegate void ValueChangedHandle(HotfixEnum.effectAttributeType attributeType, HotfixEnum.parameterType parameterType, FDP old, FDP diff);

	private class Limit
	{
		public bool IsLimited;

		public bool OnlyLimitPlayer;

		public bool IsLimitedForPercent;

		public bool OnlyLimitPlayerForPercent;

		public FDP Lower { get; } = FDP.MinValue;

		public FDP Upper { get; } = FDP.MaxValue;

		public FDP LowerForPercent { get; } = FDP.MinValue;

		public FDP UpperForPercent { get; } = FDP.MaxValue;

		public Limit()
		{
		}

		public Limit(bool isLimited, FDP low, FDP up, bool onlyLimitPlayer, bool isLimitedForPercent, FDP lowForPercent, FDP upForPercent, bool onlyLimitPlayerForPercent)
		{
			IsLimited = isLimited;
			Lower = low;
			Upper = up;
			OnlyLimitPlayer = onlyLimitPlayer;
			IsLimitedForPercent = isLimitedForPercent;
			LowerForPercent = lowForPercent;
			UpperForPercent = upForPercent;
			OnlyLimitPlayerForPercent = onlyLimitPlayerForPercent;
		}
	}

	private readonly AttributeEntry[] entries = new AttributeEntry[97];

	private readonly Dictionary<HotfixEnum.effectAttributeType, FDP> assignmentValueDict = new Dictionary<HotfixEnum.effectAttributeType, FDP>();

	private bool isBelongToPlayer;

	private static readonly Limit[] limits = new Limit[97];

	public event ValueChangedHandle ValueChangedEvent;

	private static Limit GetLimit(HotfixEnum.effectAttributeType type)
	{
		if (type == HotfixEnum.effectAttributeType.NONE || type == HotfixEnum.effectAttributeType.MAX)
		{
			return null;
		}
		Limit limit = limits[(int)type];
		if (limit != null)
		{
			return limit;
		}
		AttributeLimit attributeLimit = Singleton<HotfixDataController>.Instance.GetAttributeLimit((int)type);
		limit = ((attributeLimit == null) ? new Limit() : new Limit(attributeLimit.IsLimited, FDP.FromMyriad(attributeLimit.Lower), FDP.FromMyriad(attributeLimit.Upper), attributeLimit.IsPlayer, attributeLimit.IsLimitedPre, FDP.FromMyriad(attributeLimit.LowerPre), FDP.FromMyriad(attributeLimit.UpperPre), attributeLimit.IsPlayerPre));
		limits[(int)type] = limit;
		return limit;
	}

	public bool IsAttributeAssignment(HotfixEnum.effectAttributeType type)
	{
		if (type == HotfixEnum.effectAttributeType.NONE || type == HotfixEnum.effectAttributeType.MAX)
		{
			return false;
		}
		return assignmentValueDict.ContainsKey(type);
	}

	public void Init(bool belongToPlayer = false)
	{
		isBelongToPlayer = belongToPlayer;
		SetOriginIntValue(HotfixEnum.effectAttributeType.WEIGHT, 1, FDP.One);
		SetOriginIntValue(HotfixEnum.effectAttributeType.NORMALDMG, 1, FDP.One);
		SetOriginIntValue(HotfixEnum.effectAttributeType.SKILLDMG, 1, FDP.One);
		SetOriginIntValue(HotfixEnum.effectAttributeType.ULTRADMG, 1, FDP.One);
		SetOriginIntValue(HotfixEnum.effectAttributeType.OTHERDMG, 1, FDP.One);
		SetOriginIntValue(HotfixEnum.effectAttributeType.RCDNORMALDMG, 1, FDP.One);
		SetOriginIntValue(HotfixEnum.effectAttributeType.RCDSKILLDMG, 1, FDP.One);
		SetOriginIntValue(HotfixEnum.effectAttributeType.RCDULTRADMG, 1, FDP.One);
		SetOriginIntValue(HotfixEnum.effectAttributeType.RCDOTHERDMG, 1, FDP.One);
		SetOriginIntValue(HotfixEnum.effectAttributeType.ATKSPD_P, 1, FDP.One);
		SetOriginIntValue(HotfixEnum.effectAttributeType.MOVESPEED, 1, FDP.One);
		SetOriginIntValue(HotfixEnum.effectAttributeType.NORMAL_SUPPRESS, 0, FDP.One);
		SetOriginIntValue(HotfixEnum.effectAttributeType.SKILL_SUPPRESS, 0, FDP.One);
		SetOriginIntValue(HotfixEnum.effectAttributeType.ULTRA_SUPPRESS, 0, FDP.One);
		SetOriginIntValue(HotfixEnum.effectAttributeType.MARK_SUPPRESS, 0, FDP.One);
		SetOriginIntValue(HotfixEnum.effectAttributeType.SUMMON_SUPPRESS, 0, FDP.One);
		SetOriginIntValue(HotfixEnum.effectAttributeType.PROJECTILE_SUPPRESS, 0, FDP.One);
		SetOriginIntValue(HotfixEnum.effectAttributeType.OTHER_SUPPRESS, 0, FDP.One);
		SetOriginIntValue(HotfixEnum.effectAttributeType.GENDMG, 1, FDP.One);
		SetOriginIntValue(HotfixEnum.effectAttributeType.FINALDMG, 1, FDP.One);
		SetOriginIntValue(HotfixEnum.effectAttributeType.GENDMGRCD, 1, FDP.One);
		SetOriginIntValue(HotfixEnum.effectAttributeType.TOUGHNESS_DAMAGE_ADJUST, 1, FDP.One);
		SetOriginIntValue(HotfixEnum.effectAttributeType.INTENSITY, 1, FDP.One);
		SetOriginIntValue(HotfixEnum.effectAttributeType.MARKDMG, 1, FDP.One);
		SetOriginIntValue(HotfixEnum.effectAttributeType.RCDMARKDMG, 1, FDP.One);
		SetOriginIntValue(HotfixEnum.effectAttributeType.SUMMONDMG, 1, FDP.One);
		SetOriginIntValue(HotfixEnum.effectAttributeType.RCDSUMMONDMG, 1, FDP.One);
		SetOriginIntValue(HotfixEnum.effectAttributeType.PROJECTILEDMG, 1, FDP.One);
		SetOriginIntValue(HotfixEnum.effectAttributeType.RCDPROJECTILEDMG, 1, FDP.One);
		SetOriginIntValue(HotfixEnum.effectAttributeType.WEERCD, 1, FDP.One);
		SetOriginIntValue(HotfixEnum.effectAttributeType.FEERCD, 1, FDP.One);
		SetOriginIntValue(HotfixEnum.effectAttributeType.SEERCD, 1, FDP.One);
		SetOriginIntValue(HotfixEnum.effectAttributeType.AEERCD, 1, FDP.One);
		SetOriginIntValue(HotfixEnum.effectAttributeType.LEERCD, 1, FDP.One);
		SetOriginIntValue(HotfixEnum.effectAttributeType.DEERCD, 1, FDP.One);
		SetOriginIntValue(HotfixEnum.effectAttributeType.TOUGHNESS_BROKEN_DMG, 1, FDP.One);
		SetOriginIntValue(HotfixEnum.effectAttributeType.ADD_SHIELD_STRENGTHEN, 1, FDP.One);
		SetOriginIntValue(HotfixEnum.effectAttributeType.BE_ADD_SHIELD_STRENGTHEN, 1, FDP.One);
		SetOriginIntValue(HotfixEnum.effectAttributeType.ENV_AMEND, 1, FDP.One);
	}

	private static FDP ComputeAdjustValue(int val, FDP ratio, int fix)
	{
		return val * (FDP.One + ratio / 10000L) + fix;
	}

	private static FDP ComputeAdjustValue(long val, FDP ratio, long fix)
	{
		return val * (FDP.One + ratio / 10000L) + fix;
	}

	public FDP GetAttributeValue(HotfixEnum.effectAttributeType type)
	{
		if (type == HotfixEnum.effectAttributeType.NONE || type == HotfixEnum.effectAttributeType.MAX)
		{
			return FDP.Zero;
		}
		Limit limit = GetLimit(type);
		if (limit == null)
		{
			return FDP.Zero;
		}
		ref AttributeEntry reference = ref entries[(int)type];
		FDP fDP = reference.GetAmendValue(HotfixEnum.parameterType.PERCENTAGE);
		if (limit.IsLimitedForPercent)
		{
			if (limit.OnlyLimitPlayerForPercent)
			{
				if (isBelongToPlayer)
				{
					fDP = FDP.Clamp(fDP, limit.LowerForPercent, limit.UpperForPercent);
				}
			}
			else
			{
				fDP = FDP.Clamp(fDP, limit.LowerForPercent, limit.UpperForPercent);
			}
		}
		FDP amendValue = reference.GetAmendValue(HotfixEnum.parameterType.ABSOLUTE_VALUE);
		FDP fDP2 = reference.BaseValue * (FDP.One + fDP) + amendValue;
		FDP fDP3 = (assignmentValueDict.TryGetValue(type, out var value) ? value : fDP2);
		if (limit.IsLimited)
		{
			if (limit.OnlyLimitPlayer)
			{
				if (isBelongToPlayer)
				{
					fDP3 = FDP.Clamp(fDP3, limit.Lower, limit.Upper);
				}
			}
			else
			{
				fDP3 = FDP.Clamp(fDP3, limit.Lower, limit.Upper);
			}
		}
		return fDP3;
	}

	public void CopyValueFrom(AttributeList from)
	{
		isBelongToPlayer = from.isBelongToPlayer;
		for (int i = 1; i < 97; i++)
		{
			entries[i].CopyValueFrom(from.entries[i]);
		}
		assignmentValueDict.Clear();
		foreach (KeyValuePair<HotfixEnum.effectAttributeType, FDP> item in from.assignmentValueDict)
		{
			assignmentValueDict.Add(item.Key, item.Value);
		}
	}

	public void AddValueFrom(AttributeList from)
	{
		isBelongToPlayer = from.isBelongToPlayer;
		for (int i = 1; i < 97; i++)
		{
			entries[i].AddValueFrom(from.entries[i]);
		}
		foreach (KeyValuePair<HotfixEnum.effectAttributeType, FDP> item in from.assignmentValueDict)
		{
			if (assignmentValueDict.ContainsKey(item.Key))
			{
				assignmentValueDict.get_Item(item.Key) += item.Value;
			}
			else
			{
				assignmentValueDict.Add(item.Key, item.Value);
			}
		}
	}

	public void Clear()
	{
		for (int i = 1; i < 97; i++)
		{
			entries[i].Clear();
		}
		assignmentValueDict.Clear();
	}

	public void SetOriginIntValue(HotfixEnum.effectAttributeType type, int val, FDP ratio)
	{
		if (type != HotfixEnum.effectAttributeType.NONE && type != HotfixEnum.effectAttributeType.MAX)
		{
			entries[(int)type].SetOrigin(val * ratio);
		}
	}

	public void SetOriginFloatValue(HotfixEnum.effectAttributeType type, FDP val, FDP ratio)
	{
		if (type != HotfixEnum.effectAttributeType.NONE && type != HotfixEnum.effectAttributeType.MAX)
		{
			entries[(int)type].SetOrigin(val * ratio);
		}
	}

	public void SetOriginLongValue(HotfixEnum.effectAttributeType type, long val, FDP ratio)
	{
		if (type != HotfixEnum.effectAttributeType.NONE && type != HotfixEnum.effectAttributeType.MAX)
		{
			entries[(int)type].SetOrigin(FDP.FromLong(val) * ratio);
		}
	}

	public FDP GetOriginValue(HotfixEnum.effectAttributeType type)
	{
		if (type == HotfixEnum.effectAttributeType.NONE || type == HotfixEnum.effectAttributeType.MAX)
		{
			return FDP.Zero;
		}
		return entries[(int)type].Origin;
	}

	public FDP GetBaseValue(HotfixEnum.effectAttributeType type)
	{
		if (type == HotfixEnum.effectAttributeType.NONE || type == HotfixEnum.effectAttributeType.MAX)
		{
			return FDP.Zero;
		}
		return entries[(int)type].BaseValue;
	}

	public void SetAmendValue(HotfixEnum.effectAttributeType type, HotfixEnum.parameterType subType, FDP val)
	{
		if (type != HotfixEnum.effectAttributeType.NONE && type != HotfixEnum.effectAttributeType.MAX)
		{
			entries[(int)type].ChangeValue(subType, val);
		}
	}

	public FDP GetAmendValue(HotfixEnum.effectAttributeType type, HotfixEnum.parameterType subType, bool applyPercentLimit = false)
	{
		if (type == HotfixEnum.effectAttributeType.NONE || type == HotfixEnum.effectAttributeType.MAX)
		{
			return FDP.Zero;
		}
		FDP fDP = entries[(int)type].GetAmendValue(subType);
		if (applyPercentLimit && subType == HotfixEnum.parameterType.PERCENTAGE)
		{
			Limit limit = GetLimit(type);
			if (limit != null && limit.IsLimitedForPercent)
			{
				if (limit.OnlyLimitPlayerForPercent)
				{
					if (isBelongToPlayer)
					{
						fDP = FDP.Clamp(fDP, limit.LowerForPercent, limit.UpperForPercent);
					}
				}
				else
				{
					fDP = FDP.Clamp(fDP, limit.LowerForPercent, limit.UpperForPercent);
				}
			}
		}
		return fDP;
	}

	public void SetOriginIntValueAdjust(HotfixEnum.effectAttributeType type, int val, FDP ratio, int adjustRatio, int adjustFix)
	{
		if (type != HotfixEnum.effectAttributeType.NONE && type != HotfixEnum.effectAttributeType.MAX)
		{
			ref AttributeEntry reference = ref entries[(int)type];
			FDP fDP = ComputeAdjustValue(val, adjustRatio, adjustFix);
			reference.SetOrigin(fDP * ratio);
		}
	}

	public void SetOriginLongValueAdjust(HotfixEnum.effectAttributeType type, long val, FDP ratio, int adjustRatio, long adjustFix)
	{
		if (type != HotfixEnum.effectAttributeType.NONE && type != HotfixEnum.effectAttributeType.MAX)
		{
			ref AttributeEntry reference = ref entries[(int)type];
			FDP fDP = ComputeAdjustValue(val, adjustRatio, adjustFix);
			reference.SetOrigin(fDP * ratio);
		}
	}

	public void SetOriginIntFloatValue(HotfixEnum.effectAttributeType type, int val, FDP ratio)
	{
		if (type != HotfixEnum.effectAttributeType.NONE && type != HotfixEnum.effectAttributeType.MAX)
		{
			entries[(int)type].SetOrigin(FDP.FromMyriad(val) * ratio);
		}
	}

	public void ChangeValue(int firstSubType, int secondSubType, FDP value)
	{
		if (firstSubType != 0 && firstSubType != 97)
		{
			ref AttributeEntry reference = ref entries[firstSubType];
			FDP attributeValue = GetAttributeValue((HotfixEnum.effectAttributeType)firstSubType);
			reference.ChangeValue((HotfixEnum.parameterType)secondSubType, value);
			ValueChangedEvent?.Invoke((HotfixEnum.effectAttributeType)firstSubType, (HotfixEnum.parameterType)secondSubType, attributeValue, GetAttributeValue((HotfixEnum.effectAttributeType)firstSubType));
		}
	}

	public void ChangeAssignmentValue(int firstSubType, int secondSubType, FDP value, bool assign)
	{
		if (firstSubType != 0 && firstSubType != 97)
		{
			FDP fDP = GetAttributeValue((HotfixEnum.effectAttributeType)firstSubType);
			FDP zero = FDP.Zero;
			if (assign)
			{
				zero = secondSubType switch
				{
					2 => fDP * value, 
					3 => value, 
					_ => zero, 
				};
				assignmentValueDict.set_Item((HotfixEnum.effectAttributeType)firstSubType, zero);
			}
			else
			{
				fDP = (assignmentValueDict.TryGetValue((HotfixEnum.effectAttributeType)firstSubType, out var value2) ? value2 : FDP.Zero);
				zero = GetAttributeValue((HotfixEnum.effectAttributeType)firstSubType);
				assignmentValueDict.Remove((HotfixEnum.effectAttributeType)firstSubType);
			}
			ValueChangedEvent?.Invoke((HotfixEnum.effectAttributeType)firstSubType, (HotfixEnum.parameterType)secondSubType, fDP, zero);
		}
	}

	public FDP GetHarmElementValue(HotfixEnum.elementType type)
	{
		return type switch
		{
			HotfixEnum.elementType.WE => GetAttributeValue(HotfixEnum.effectAttributeType.WEE), 
			HotfixEnum.elementType.FE => GetAttributeValue(HotfixEnum.effectAttributeType.FEE), 
			HotfixEnum.elementType.SE => GetAttributeValue(HotfixEnum.effectAttributeType.SEE), 
			HotfixEnum.elementType.AE => GetAttributeValue(HotfixEnum.effectAttributeType.AEE), 
			HotfixEnum.elementType.LE => GetAttributeValue(HotfixEnum.effectAttributeType.LEE), 
			HotfixEnum.elementType.DE => GetAttributeValue(HotfixEnum.effectAttributeType.DEE), 
			_ => throw new ArgumentOutOfRangeException("type", type, null), 
		};
	}

	public FDP GetResistanceElementValue(HotfixEnum.elementType type)
	{
		return type switch
		{
			HotfixEnum.elementType.WE => GetAttributeValue(HotfixEnum.effectAttributeType.WER), 
			HotfixEnum.elementType.FE => GetAttributeValue(HotfixEnum.effectAttributeType.FER), 
			HotfixEnum.elementType.SE => GetAttributeValue(HotfixEnum.effectAttributeType.SER), 
			HotfixEnum.elementType.AE => GetAttributeValue(HotfixEnum.effectAttributeType.AER), 
			HotfixEnum.elementType.LE => GetAttributeValue(HotfixEnum.effectAttributeType.LER), 
			HotfixEnum.elementType.DE => GetAttributeValue(HotfixEnum.effectAttributeType.DER), 
			_ => throw new ArgumentOutOfRangeException("type", type, null), 
		};
	}

	public FDP GetPentrateElementValue(HotfixEnum.elementType type)
	{
		return type switch
		{
			HotfixEnum.elementType.WE => GetAttributeValue(HotfixEnum.effectAttributeType.WEP), 
			HotfixEnum.elementType.FE => GetAttributeValue(HotfixEnum.effectAttributeType.FEP), 
			HotfixEnum.elementType.SE => GetAttributeValue(HotfixEnum.effectAttributeType.SEP), 
			HotfixEnum.elementType.AE => GetAttributeValue(HotfixEnum.effectAttributeType.AEP), 
			HotfixEnum.elementType.LE => GetAttributeValue(HotfixEnum.effectAttributeType.LEP), 
			HotfixEnum.elementType.DE => GetAttributeValue(HotfixEnum.effectAttributeType.DEP), 
			_ => throw new ArgumentOutOfRangeException("type", type, null), 
		};
	}

	public FDP GetIgnoringInjuredElementValue(HotfixEnum.elementType type)
	{
		return type switch
		{
			HotfixEnum.elementType.WE => GetAttributeValue(HotfixEnum.effectAttributeType.WEI), 
			HotfixEnum.elementType.FE => GetAttributeValue(HotfixEnum.effectAttributeType.FEI), 
			HotfixEnum.elementType.SE => GetAttributeValue(HotfixEnum.effectAttributeType.SEI), 
			HotfixEnum.elementType.AE => GetAttributeValue(HotfixEnum.effectAttributeType.AEI), 
			HotfixEnum.elementType.LE => GetAttributeValue(HotfixEnum.effectAttributeType.LEI), 
			HotfixEnum.elementType.DE => GetAttributeValue(HotfixEnum.effectAttributeType.DEI), 
			_ => throw new ArgumentOutOfRangeException("type", type, null), 
		};
	}

	public FDP GetInjuredElementValue(HotfixEnum.elementType type)
	{
		return type switch
		{
			HotfixEnum.elementType.WE => GetAttributeValue(HotfixEnum.effectAttributeType.WEERCD), 
			HotfixEnum.elementType.FE => GetAttributeValue(HotfixEnum.effectAttributeType.FEERCD), 
			HotfixEnum.elementType.SE => GetAttributeValue(HotfixEnum.effectAttributeType.SEERCD), 
			HotfixEnum.elementType.AE => GetAttributeValue(HotfixEnum.effectAttributeType.AEERCD), 
			HotfixEnum.elementType.LE => GetAttributeValue(HotfixEnum.effectAttributeType.LEERCD), 
			HotfixEnum.elementType.DE => GetAttributeValue(HotfixEnum.effectAttributeType.DEERCD), 
			_ => throw new ArgumentOutOfRangeException("type", type, null), 
		};
	}

	public void CopyOwnerValue(AttributeList owner, FDP ratio)
	{
		if (owner != null)
		{
			for (int i = 1; i < 97; i++)
			{
				entries[i].SetOrigin(owner.GetAttributeValue((HotfixEnum.effectAttributeType)i) * ratio);
			}
		}
	}

	public void WriteMessage(RepeatedField<Recorder.Types.Attribute> attributes)
	{
		attributes.Clear();
		for (int i = 1; i < 97; i++)
		{
			attributes.Add(entries[i].ToMessage());
		}
	}
}
