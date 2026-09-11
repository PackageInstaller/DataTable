namespace System.Linq.Expressions;

public sealed class LabelTarget
{
	public string Name { get; }

	public Type Type { get; }

	internal LabelTarget(Type type, string name)
	{
		Type = type;
		Name = name;
	}

	public override string ToString()
	{
		if (!string.IsNullOrEmpty(Name))
		{
			return Name;
		}
		return "UnamedLabel";
	}
}
