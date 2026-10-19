using System.Collections.Generic;
using UnityEngine;

namespace ACT.UI;

[CreateAssetMenu(menuName = "ACT/UI/Text Animator Tag Config")]
public class TextAnimatorTagConfig : ScriptableObject
{
	public List<TextAnimatorTagParserRuleBase> rules = new List<TextAnimatorTagParserRuleBase>();

	public bool HasSameRules(List<TextAnimatorTagParserRuleBase> cachedRules)
	{
		if (rules == null)
		{
			if (cachedRules != null)
			{
				return cachedRules.Count == 0;
			}
			return true;
		}
		if (cachedRules == null)
		{
			return false;
		}
		int num = 0;
		for (int i = 0; i < rules.Count; i++)
		{
			TextAnimatorTagParserRuleBase textAnimatorTagParserRuleBase = rules[i];
			if ((bool)textAnimatorTagParserRuleBase)
			{
				if (num >= cachedRules.Count || cachedRules[num] != textAnimatorTagParserRuleBase)
				{
					return false;
				}
				num++;
			}
		}
		return num == cachedRules.Count;
	}

	public void BuildParserCache(List<ITagParserBase> parsers, List<TextAnimatorTagParserRuleBase> cachedRules)
	{
		parsers.Clear();
		cachedRules.Clear();
		if (rules == null)
		{
			return;
		}
		for (int i = 0; i < rules.Count; i++)
		{
			TextAnimatorTagParserRuleBase textAnimatorTagParserRuleBase = rules[i];
			if ((bool)textAnimatorTagParserRuleBase)
			{
				ITagParserBase tagParserBase = textAnimatorTagParserRuleBase.CreateParser();
				if (tagParserBase != null)
				{
					parsers.Add(tagParserBase);
					cachedRules.Add(textAnimatorTagParserRuleBase);
				}
			}
		}
	}
}
