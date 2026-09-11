namespace System.Diagnostics;

[Serializable]
[AttributeUsage(AttributeTargets.Class | AttributeTargets.Method, AllowMultiple = true)]
public sealed class ConditionalAttribute : Attribute
{
	public string ConditionString { get; }

	public ConditionalAttribute(string conditionString)
	{
		ConditionString = conditionString;
	}
}
