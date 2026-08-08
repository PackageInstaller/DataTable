using System;

public sealed class CloneAttribute : Attribute
{
	public bool isDeep;

	public bool isIgnore;

	public string copyFucName = "";

	public CloneAttribute(bool isDeep, bool isIgnore, string copyFucName = "")
	{
		this.isDeep = isDeep;
		this.isIgnore = isIgnore;
		this.copyFucName = copyFucName;
	}
}
