using System.Collections.Generic;
using UnityEngine;

namespace ACT.Battle;

public sealed class SkillCountModifierCollection
{
	private sealed class SkillCountModifier
	{
		public string abName;

		public int add;
	}

	private readonly Dictionary<string, SkillCountModifier> _Collection = new Dictionary<string, SkillCountModifier>();

	public int Value { get; private set; }

	public void Add(string abName, int addValue)
	{
		SkillCountModifier value = new SkillCountModifier
		{
			abName = abName,
			add = addValue
		};
		_Collection.Add(abName, value);
	}

	public void Remove(string abName)
	{
		_Collection.Remove(abName);
	}

	public void Clear()
	{
		if (_Collection.Count != 0)
		{
			_Collection.Clear();
		}
	}

	public int GetModifiedValue(int modifiedValue)
	{
		foreach (KeyValuePair<string, SkillCountModifier> item in _Collection)
		{
			modifiedValue += item.Value.add;
		}
		return Mathf.Max(0, modifiedValue);
	}
}
