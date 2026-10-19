using System;

namespace BehaviorDesigner.Runtime.Tasks;

[AttributeUsage(AttributeTargets.Class, AllowMultiple = false, Inherited = false)]
public class HelpURLAttribute : Attribute
{
	private readonly string mURL;

	public string URL => mURL;

	public HelpURLAttribute(string url)
	{
		mURL = url;
	}
}
