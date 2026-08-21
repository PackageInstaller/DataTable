using System.Runtime.CompilerServices;

namespace System.Diagnostics.CodeAnalysis;

[AttributeUsage(AttributeTargets.All, Inherited = false, AllowMultiple = true)]
[Conditional("CODE_ANALYSIS")]
public sealed class SuppressMessageAttribute : Attribute
{
	[CompilerGenerated]
	private readonly string _003CCategory_003Ek__BackingField;

	[CompilerGenerated]
	private readonly string _003CCheckId_003Ek__BackingField;

	[CompilerGenerated]
	private string _003CJustification_003Ek__BackingField;

	public string Justification
	{
		[CompilerGenerated]
		set
		{
			_003CJustification_003Ek__BackingField = value;
		}
	}

	public SuppressMessageAttribute(string category, string checkId)
	{
		_003CCategory_003Ek__BackingField = category;
		_003CCheckId_003Ek__BackingField = checkId;
	}
}
