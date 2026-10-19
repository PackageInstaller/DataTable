namespace System;

[AttributeUsage(AttributeTargets.All, AllowMultiple = true)]
internal class MonoLimitationAttribute : MonoTODOAttribute
{
	public MonoLimitationAttribute(string comment)
		: base(comment)
	{
	}
}
