namespace System;

[AttributeUsage(AttributeTargets.All, AllowMultiple = true)]
internal class MonoNotSupportedAttribute : MonoTODOAttribute
{
	public MonoNotSupportedAttribute(string comment)
		: base(comment)
	{
	}
}
