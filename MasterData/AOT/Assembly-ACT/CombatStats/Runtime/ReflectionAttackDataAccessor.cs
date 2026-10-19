using System;
using System.Collections.Generic;
using System.Globalization;
using System.Reflection;

namespace CombatStats.Runtime;

public sealed class ReflectionAttackDataAccessor : IAttackDataAccessor
{
	private static readonly string[] CharacterIdCandidates = new string[4] { "CharacterId", "CasterId", "SourceCharacterId", "AttackerId" };

	private static readonly string[] CharacterNameCandidates = new string[4] { "CharacterName", "CasterName", "SourceCharacterName", "AttackerName" };

	private static readonly string[] SkillIdCandidates = new string[3] { "SkillId", "skillId", "AbilityId" };

	private static readonly string[] DamageCandidates = new string[4] { "DamageValue", "Damage", "FinalDamage", "Value" };

	private static readonly string[] CritCandidates = new string[4] { "IsCrit", "isCrit", "Critical", "IsCritical" };

	private static readonly string[] TimestampCandidates = new string[3] { "Timestamp", "Time", "ServerTime" };

	public bool TryGetCharacterId(object attackData, out string value)
	{
		return TryGetString(attackData, CharacterIdCandidates, out value);
	}

	public bool TryGetCharacterName(object attackData, out string value)
	{
		return TryGetString(attackData, CharacterNameCandidates, out value);
	}

	public bool TryGetSkillId(object attackData, out int value)
	{
		return TryGetInt(attackData, SkillIdCandidates, out value);
	}

	public bool TryGetDamageValue(object attackData, out long value)
	{
		return TryGetLong(attackData, DamageCandidates, out value);
	}

	public bool TryGetIsCrit(object attackData, out bool value)
	{
		return TryGetBool(attackData, CritCandidates, out value);
	}

	public bool TryGetTimestamp(object attackData, out float value)
	{
		return TryGetFloat(attackData, TimestampCandidates, out value);
	}

	private static bool TryGetString(object target, IReadOnlyList<string> candidates, out string value)
	{
		if (TryGetRawValue(target, candidates, out var value2) && value2 != null)
		{
			value = value2.ToString();
			return !string.IsNullOrWhiteSpace(value);
		}
		value = null;
		return false;
	}

	private static bool TryGetInt(object target, IReadOnlyList<string> candidates, out int value)
	{
		if (TryGetRawValue(target, candidates, out var value2))
		{
			object obj = value2;
			if (obj is int num)
			{
				int num2 = num;
				value = num2;
				return true;
			}
			if (obj is long num3)
			{
				long num4 = num3;
				value = (int)num4;
				return true;
			}
			if (obj is string s && int.TryParse(s, NumberStyles.Integer, CultureInfo.InvariantCulture, out var result))
			{
				value = result;
				return true;
			}
		}
		value = 0;
		return false;
	}

	private static bool TryGetLong(object target, IReadOnlyList<string> candidates, out long value)
	{
		if (TryGetRawValue(target, candidates, out var value2))
		{
			object obj = value2;
			if (obj is int num)
			{
				int num2 = num;
				value = num2;
				return true;
			}
			if (obj is long num3)
			{
				long num4 = num3;
				value = num4;
				return true;
			}
			if (obj is float num5)
			{
				float num6 = num5;
				value = (long)num6;
				return true;
			}
			if (obj is double num7)
			{
				double num8 = num7;
				value = (long)num8;
				return true;
			}
			if (obj is string s && long.TryParse(s, NumberStyles.Integer, CultureInfo.InvariantCulture, out var result))
			{
				value = result;
				return true;
			}
		}
		value = 0L;
		return false;
	}

	private static bool TryGetBool(object target, IReadOnlyList<string> candidates, out bool value)
	{
		if (TryGetRawValue(target, candidates, out var value2))
		{
			object obj = value2;
			if (obj is bool flag)
			{
				bool flag2 = flag;
				value = flag2;
				return true;
			}
			if (obj is string value3 && bool.TryParse(value3, out var result))
			{
				value = result;
				return true;
			}
		}
		value = false;
		return false;
	}

	private static bool TryGetFloat(object target, IReadOnlyList<string> candidates, out float value)
	{
		if (TryGetRawValue(target, candidates, out var value2))
		{
			object obj = value2;
			if (obj is float num)
			{
				float num2 = num;
				value = num2;
				return true;
			}
			if (obj is int num3)
			{
				int num4 = num3;
				value = num4;
				return true;
			}
			if (obj is double num5)
			{
				double num6 = num5;
				value = (float)num6;
				return true;
			}
			if (obj is string s && float.TryParse(s, NumberStyles.Float, CultureInfo.InvariantCulture, out var result))
			{
				value = result;
				return true;
			}
		}
		value = 0f;
		return false;
	}

	private static bool TryGetRawValue(object target, IReadOnlyList<string> candidates, out object value)
	{
		value = null;
		if (target == null)
		{
			return false;
		}
		Type type = target.GetType();
		for (int i = 0; i < candidates.Count; i++)
		{
			string name = candidates[i];
			FieldInfo field = type.GetField(name, BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic);
			if (field != null)
			{
				value = field.GetValue(target);
				return true;
			}
			PropertyInfo property = type.GetProperty(name, BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic);
			if (property != null && property.GetIndexParameters().Length == 0)
			{
				value = property.GetValue(target);
				return true;
			}
		}
		return false;
	}
}
