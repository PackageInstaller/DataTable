namespace Yarn.Unity;

public class YarnFunctionAttribute : YarnActionAttribute
{
	public YarnFunctionAttribute(string name = null)
	{
		base.Name = name;
	}
}
