namespace System.Runtime.InteropServices;

[ComVisible(true)]
[AttributeUsage(AttributeTargets.Delegate, AllowMultiple = false, Inherited = false)]
public sealed class UnmanagedFunctionPointerAttribute : Attribute
{
	private CallingConvention m_callingConvention;

	public UnmanagedFunctionPointerAttribute(CallingConvention callingConvention)
	{
		m_callingConvention = callingConvention;
	}
}
