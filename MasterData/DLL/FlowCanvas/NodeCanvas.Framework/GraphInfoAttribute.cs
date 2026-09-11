using System;

namespace NodeCanvas.Framework;

[AttributeUsage(AttributeTargets.Class)]
public class GraphInfoAttribute : Attribute
{
	public string packageName;

	public string docsURL;

	public string resourcesURL;

	public string forumsURL;
}
