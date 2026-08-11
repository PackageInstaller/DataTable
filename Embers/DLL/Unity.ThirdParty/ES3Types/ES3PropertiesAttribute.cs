using System;

namespace ES3Types;

[AttributeUsage(AttributeTargets.Class)]
public class ES3PropertiesAttribute : Attribute
{
	public readonly string[] members;

	public ES3PropertiesAttribute(params string[] members)
	{
		this.members = members;
	}
}
