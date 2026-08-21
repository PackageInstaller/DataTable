namespace Yarn.Unity;

public class YarnCommandAttribute : YarnActionAttribute
{
	public string Injector { get; set; }

	public YarnCommandAttribute(string name = null)
	{
		base.Name = name;
	}
}
