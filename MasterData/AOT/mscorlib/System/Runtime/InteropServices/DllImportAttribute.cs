using System.Reflection;

namespace System.Runtime.InteropServices;

[AttributeUsage(AttributeTargets.Method, Inherited = false)]
[ComVisible(true)]
public sealed class DllImportAttribute : Attribute
{
	internal string _val;

	public string EntryPoint;

	public CharSet CharSet;

	public bool SetLastError;

	public bool ExactSpelling;

	public bool PreserveSig;

	public CallingConvention CallingConvention;

	public bool BestFitMapping;

	public bool ThrowOnUnmappableChar;

	public string Value => _val;

	internal static Attribute GetCustomAttribute(RuntimeMethodInfo method)
	{
		if ((method.Attributes & MethodAttributes.PinvokeImpl) == 0)
		{
			return null;
		}
		string dllName = null;
		_ = method.MetadataToken;
		PInvokeAttributes flags = PInvokeAttributes.CharSetNotSpec;
		method.GetPInvoke(out flags, out var entryPoint, out dllName);
		CharSet charSet = CharSet.None;
		switch (flags & PInvokeAttributes.CharSetMask)
		{
		case PInvokeAttributes.CharSetNotSpec:
			charSet = CharSet.None;
			break;
		case PInvokeAttributes.CharSetAnsi:
			charSet = CharSet.Ansi;
			break;
		case PInvokeAttributes.CharSetUnicode:
			charSet = CharSet.Unicode;
			break;
		case PInvokeAttributes.CharSetMask:
			charSet = CharSet.Auto;
			break;
		}
		CallingConvention callingConvention = CallingConvention.Cdecl;
		switch (flags & PInvokeAttributes.CallConvMask)
		{
		case PInvokeAttributes.CallConvWinapi:
			callingConvention = CallingConvention.Winapi;
			break;
		case PInvokeAttributes.CallConvCdecl:
			callingConvention = CallingConvention.Cdecl;
			break;
		case PInvokeAttributes.CallConvStdcall:
			callingConvention = CallingConvention.StdCall;
			break;
		case PInvokeAttributes.CallConvThiscall:
			callingConvention = CallingConvention.ThisCall;
			break;
		case PInvokeAttributes.CallConvFastcall:
			callingConvention = CallingConvention.FastCall;
			break;
		}
		bool exactSpelling = (flags & PInvokeAttributes.NoMangle) != 0;
		bool setLastError = (flags & PInvokeAttributes.SupportsLastError) != 0;
		bool bestFitMapping = (flags & PInvokeAttributes.BestFitMask) == PInvokeAttributes.BestFitEnabled;
		bool throwOnUnmappableChar = (flags & PInvokeAttributes.ThrowOnUnmappableCharMask) == PInvokeAttributes.ThrowOnUnmappableCharEnabled;
		bool preserveSig = (method.GetMethodImplementationFlags() & MethodImplAttributes.PreserveSig) != 0;
		return new DllImportAttribute(dllName, entryPoint, charSet, exactSpelling, setLastError, preserveSig, callingConvention, bestFitMapping, throwOnUnmappableChar);
	}

	internal static bool IsDefined(RuntimeMethodInfo method)
	{
		return (method.Attributes & MethodAttributes.PinvokeImpl) != 0;
	}

	internal DllImportAttribute(string dllName, string entryPoint, CharSet charSet, bool exactSpelling, bool setLastError, bool preserveSig, CallingConvention callingConvention, bool bestFitMapping, bool throwOnUnmappableChar)
	{
		_val = dllName;
		EntryPoint = entryPoint;
		CharSet = charSet;
		ExactSpelling = exactSpelling;
		SetLastError = setLastError;
		PreserveSig = preserveSig;
		CallingConvention = callingConvention;
		BestFitMapping = bestFitMapping;
		ThrowOnUnmappableChar = throwOnUnmappableChar;
	}

	public DllImportAttribute(string dllName)
	{
		_val = dllName;
	}
}
