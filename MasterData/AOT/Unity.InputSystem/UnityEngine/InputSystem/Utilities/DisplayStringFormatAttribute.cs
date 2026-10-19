using System;

namespace UnityEngine.InputSystem.Utilities;

[AttributeUsage(AttributeTargets.Class, Inherited = true)]
public class DisplayStringFormatAttribute : Attribute
{
	public string formatString { get; set; }

	public DisplayStringFormatAttribute(string formatString)
	{
		this.formatString = formatString;
	}
}
