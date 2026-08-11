#define ENABLE_ERROR_AND_ABOVE_LOG
using System.Collections.Generic;
using GameFramework;

namespace Ase;

public class ObserverDamageProgressCondition : ObserverConditionBase
{
	protected class DamageProgressGroupParams
	{
		public ObserverConditionParams key;

		public ObserverConditionParams methodType;

		public ObserverConditionParams compare;

		public bool Check(object value)
		{
			switch (key.ParamString)
			{
			case "Damage":
			case "Tenacity":
			case "BulletId":
			case "BulletConfigId":
			case "SkillId":
			case "DefendState":
			case "WeakNessLv":
			case "SiteLevel":
				return CheckInt(value);
			case "EnergyChanged":
			case "CurrentEnergy":
				return CheckFloat(value);
			case "Critical":
			case "Accumulate":
			case "KnockDown":
			case "BossDownState":
			case "ImmuneState":
			case "ParrySuccess":
				return CheckBool(value);
			case "HeroSkillTypeEnum":
				return CheckEnum(value);
			case "BulletLabel":
			case "SkillLabel":
				return CheckArray<string>(value);
			default:
				Log.Error("Damage Param Error:未找到对应key");
				return false;
			}
		}

		private bool CheckInt(object value)
		{
			return ConditionExtensions.CompareValueMethod(methodType.ParamEnum<CompareMethodType>(), (int)value, compare.ParamInt);
		}

		private bool CheckFloat(object value)
		{
			return ConditionExtensions.CompareValueMethod(methodType.ParamEnum<CompareMethodType>(), (float)value, compare.ParamFloat);
		}

		private bool CheckBool(object value)
		{
			return (bool)value == compare.ParamBool;
		}

		private bool CheckEnum(object value)
		{
			return value.ToString() == compare.ParamString;
		}

		private bool CheckString(object value)
		{
			return value.Equals(compare.ParamString);
		}

		private bool CheckArray<T>(object value)
		{
			if (value is ICollection<T> collection)
			{
				foreach (T item in collection)
				{
					if (item.Equals(compare.ParamString))
					{
						return true;
					}
				}
			}
			return false;
		}
	}

	protected override bool IsCondition(IObserverParams param, ObserverConditionParams[] conditionParams)
	{
		if (!(param is ObserverDamageProgressParams observerDamageProgressParams))
		{
			Log.Error("Damage Param TypeError:" + param.GetType());
			return false;
		}
		int num = conditionParams.Length;
		if (num % 3 != 0)
		{
			Log.Error("Damage Param Error:参数数量不对");
			return false;
		}
		DamageProgressGroupParams[] array = new DamageProgressGroupParams[num / 3];
		int num2 = 0;
		for (int i = 0; i < array.Length; i++)
		{
			array[i] = new DamageProgressGroupParams
			{
				key = conditionParams[num2 + i],
				methodType = conditionParams[num2 + i + 1],
				compare = conditionParams[num2 + i + 2]
			};
			num2 += 3;
		}
		bool flag = true;
		DamageProgressGroupParams[] array2 = array;
		foreach (DamageProgressGroupParams damageProgressGroupParams in array2)
		{
			object obj = observerDamageProgressParams.Get(damageProgressGroupParams.key.ParamString);
			if (obj == null)
			{
				return false;
			}
			flag &= damageProgressGroupParams.Check(obj);
		}
		return flag;
	}
}
