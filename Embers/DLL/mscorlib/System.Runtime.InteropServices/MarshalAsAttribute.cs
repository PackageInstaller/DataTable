namespace System.Runtime.InteropServices;

[StructLayout(LayoutKind.Sequential)]
[ComVisible(true)]
[AttributeUsage(AttributeTargets.Field | AttributeTargets.Parameter | AttributeTargets.ReturnValue, Inherited = false)]
public sealed class MarshalAsAttribute : Attribute
{
	public string MarshalCookie;

	[ComVisible(true)]
	public string MarshalType;

	[ComVisible(true)]
	public Type MarshalTypeRef;

	public Type SafeArrayUserDefinedSubType;

	private UnmanagedType utype;

	public UnmanagedType ArraySubType;

	public VarEnum SafeArraySubType;

	public int SizeConst;

	public int IidParameterIndex;

	public short SizeParamIndex;

	public UnmanagedType Value => utype;

	public MarshalAsAttribute(UnmanagedType unmanagedType)
	{
		utype = unmanagedType;
	}

	internal MarshalAsAttribute Copy()
	{
		return (MarshalAsAttribute)MemberwiseClone();
	}
}
