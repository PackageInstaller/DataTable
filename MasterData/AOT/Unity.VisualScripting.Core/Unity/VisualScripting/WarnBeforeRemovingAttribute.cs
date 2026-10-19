using System;

namespace Unity.VisualScripting;

[AttributeUsage(AttributeTargets.Property | AttributeTargets.Field, AllowMultiple = false, Inherited = true)]
public sealed class WarnBeforeRemovingAttribute : Attribute
{
	public string warningTitle { get; }

	public string warningMessage { get; }

	public WarnBeforeRemovingAttribute(string warningTitle, string warningMessage)
	{
		this.warningTitle = warningTitle;
		this.warningMessage = warningMessage;
	}
}
