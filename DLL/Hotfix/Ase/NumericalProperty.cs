using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class NumericalProperty
{
	public static List<string> MainPropertyKey = new List<string> { "Hp", "HpRadio", "FixHp", "Attack", "AttackRadio", "FixAttack", "Defence", "DefenceRadio", "FixDefence" };

	private NumericalBase owner;

	private ObservableDictionary<string, float> numericalDic = new ObservableDictionary<string, float>();

	public ObservableDictionary<string, float> Numericals => numericalDic;

	public NumericalProperty()
	{
	}

	public NumericalProperty(NumericalBase parent)
	{
		owner = parent;
	}

	public void Attach(NumericalProperty property)
	{
		foreach (KeyValuePair<string, float> item in property.numericalDic)
		{
			AddProperty(item.Key, item.Value);
		}
	}

	public bool HasProperty(string key)
	{
		return numericalDic.ContainsKey(key);
	}

	public void AddProperty(string key, float value)
	{
		if (HasProperty(key))
		{
			numericalDic[key] += value;
		}
		else
		{
			numericalDic.Add(key, value);
		}
	}

	public void ReplaceProperty(string key, float value)
	{
		if (HasProperty(key))
		{
			numericalDic[key] = value;
		}
		else
		{
			numericalDic.Add(key, value);
		}
	}

	public float GetProperty(string key, float defaultValue = 0f)
	{
		if (HasProperty(key))
		{
			return numericalDic[key];
		}
		return defaultValue;
	}

	public float GetFixProperty(string key, float defaultValue = 0f)
	{
		string key2 = "Fix" + key;
		if (HasProperty(key2))
		{
			return numericalDic[key2];
		}
		return defaultValue;
	}

	public float GetPropertyContainRadio(string key, float defaultValue = 0f)
	{
		if (HasProperty(key))
		{
			return numericalDic[key] + GetPropertyByRadio(key, defaultValue);
		}
		return defaultValue;
	}

	public float GetPropertyByRadio(string key, float defaultValue = 0f)
	{
		if (HasProperty(key))
		{
			string text = key + "Radio";
			float num = 0f;
			if (!key.Equals("Crit") && HasProperty(text))
			{
				num = numericalDic[text];
			}
			float num2 = 0f;
			if (owner != null && owner is HeroModel heroModel)
			{
				string key2 = $"{heroModel.Attribute}Character{text}";
				if (HasProperty(key2))
				{
					num2 = numericalDic[key2];
				}
			}
			return numericalDic[key] * (num + num2);
		}
		return defaultValue;
	}

	public float GetTotalProperty(string key)
	{
		float propertyContainRadio = GetPropertyContainRadio(key);
		float fixProperty = GetFixProperty(key);
		return propertyContainRadio + fixProperty;
	}

	public float GetBattleProperty(string key)
	{
		if (MainPropertyKey.Contains(key))
		{
			return GetProperty(key);
		}
		return GetTotalProperty(key);
	}

	public void Remove(string key)
	{
		if (numericalDic.ContainsKey(key))
		{
			numericalDic.Remove(key);
		}
	}

	public void Debug(string tag1, string tag2)
	{
	}

	public void Clear()
	{
		numericalDic.Clear();
	}
}
