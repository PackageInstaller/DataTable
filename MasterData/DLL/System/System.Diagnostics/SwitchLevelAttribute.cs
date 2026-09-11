namespace System.Diagnostics;

[AttributeUsage(AttributeTargets.Class)]
public sealed class SwitchLevelAttribute : Attribute
{
	private Type type;

	public Type SwitchLevelType
	{
		set
		{
			if (value == null)
			{
				throw new ArgumentNullException("value");
			}
			type = value;
		}
	}

	public SwitchLevelAttribute(Type switchLevelType)
	{
		SwitchLevelType = switchLevelType;
	}
}
