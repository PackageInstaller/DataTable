using System;

namespace UnityEngineInternal;

[Serializable]
[AttributeUsage(AttributeTargets.Method)]
public class TypeInferenceRuleAttribute : Attribute
{
	private readonly string _rule;

	public TypeInferenceRuleAttribute(TypeInferenceRules rule)
		: this(rule.ToString())
	{
	}

	public TypeInferenceRuleAttribute(string rule)
	{
		_rule = rule;
	}

	public override string ToString()
	{
		return _rule;
	}
}
