using System.Reflection;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Security;
using System.Text;

namespace System.Diagnostics;

[Serializable]
[StructLayout(LayoutKind.Sequential)]
[MonoTODO("Serialized objects are not compatible with MS.NET")]
[ComVisible(true)]
public class StackFrame
{
	public const int OFFSET_UNKNOWN = -1;

	private int ilOffset = -1;

	private int nativeOffset = -1;

	private long methodAddress;

	private uint methodIndex;

	private MethodBase methodBase;

	private string fileName;

	private int lineNumber;

	private int columnNumber;

	private string internalMethodName;

	[MethodImpl((MethodImplOptions)4096)]
	private static extern bool get_frame_info(int skip, bool needFileInfo, out MethodBase method, out int iloffset, out int native_offset, out string file, out int line, out int column);

	public StackFrame()
	{
		get_frame_info(2, needFileInfo: false, out methodBase, out ilOffset, out nativeOffset, out fileName, out lineNumber, out columnNumber);
	}

	[MethodImpl((MethodImplOptions)8)]
	public StackFrame(int skipFrames)
	{
		get_frame_info(skipFrames + 2, needFileInfo: false, out methodBase, out ilOffset, out nativeOffset, out fileName, out lineNumber, out columnNumber);
	}

	[MethodImpl((MethodImplOptions)8)]
	public StackFrame(int skipFrames, bool fNeedFileInfo)
	{
		get_frame_info(skipFrames + 2, fNeedFileInfo, out methodBase, out ilOffset, out nativeOffset, out fileName, out lineNumber, out columnNumber);
	}

	public virtual int GetFileLineNumber()
	{
		return lineNumber;
	}

	public virtual string GetFileName()
	{
		return fileName;
	}

	internal string GetSecureFileName()
	{
		string result = "<filename unknown>";
		if (fileName == null)
		{
			return result;
		}
		try
		{
			result = GetFileName();
		}
		catch (SecurityException)
		{
		}
		return result;
	}

	public virtual int GetILOffset()
	{
		return ilOffset;
	}

	public virtual MethodBase GetMethod()
	{
		return methodBase;
	}

	public virtual int GetNativeOffset()
	{
		return nativeOffset;
	}

	internal long GetMethodAddress()
	{
		return methodAddress;
	}

	internal uint GetMethodIndex()
	{
		return methodIndex;
	}

	internal string GetInternalMethodName()
	{
		return internalMethodName;
	}

	public override string ToString()
	{
		StringBuilder stringBuilder = new StringBuilder();
		if (methodBase == null)
		{
			stringBuilder.Append(Locale.GetText("<unknown method>"));
		}
		else
		{
			stringBuilder.Append(methodBase.Name);
		}
		stringBuilder.Append(Locale.GetText(" at "));
		if (ilOffset == -1)
		{
			stringBuilder.Append(Locale.GetText("<unknown offset>"));
		}
		else
		{
			stringBuilder.Append(Locale.GetText("offset "));
			stringBuilder.Append(ilOffset);
		}
		stringBuilder.Append(Locale.GetText(" in file:line:column "));
		stringBuilder.Append(GetSecureFileName());
		stringBuilder.AppendFormat(":{0}:{1}", lineNumber, columnNumber);
		return stringBuilder.ToString();
	}
}
