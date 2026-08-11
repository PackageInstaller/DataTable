public struct ShaderPropertyInfo
{
	public enum Type
	{
		Color,
		Texture,
		Float,
		Range,
		Vector,
		Int
	}

	public string name;

	public Type type;

	public string GetName()
	{
		return name;
	}
}
