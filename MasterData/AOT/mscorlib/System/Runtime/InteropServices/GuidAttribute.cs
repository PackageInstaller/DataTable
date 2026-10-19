namespace System.Runtime.InteropServices;

[ComVisible(true)]
[AttributeUsage(AttributeTargets.Assembly | AttributeTargets.Class | AttributeTargets.Struct | AttributeTargets.Enum | AttributeTargets.Interface | AttributeTargets.Delegate, Inherited = false)]
public sealed class GuidAttribute : Attribute
{
	internal string _val;

	public GuidAttribute(string guid)
	{
		_val = guid;
	}
}
