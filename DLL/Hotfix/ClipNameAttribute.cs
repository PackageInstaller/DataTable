using System;

public class ClipNameAttribute : Attribute
{
	public string ClipName;

	public ClipNameAttribute(string name)
	{
		ClipName = name;
	}
}
