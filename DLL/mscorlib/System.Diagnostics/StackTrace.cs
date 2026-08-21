using System.Collections.Generic;
using System.Reflection;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading;

namespace System.Diagnostics;

[Serializable]
[ComVisible(true)]
[MonoTODO("Serialized objects are not compatible with .NET")]
public class StackTrace
{
	internal enum TraceFormat
	{
		Normal,
		TrailingNewLine,
		NoResourceLookup
	}

	public const int METHODS_TO_SKIP = 0;

	private const string prefix = "  at ";

	private StackFrame[] frames;

	private readonly StackTrace[] captured_traces;

	private bool debug_info;

	private static bool isAotidSet;

	private static string aotid;

	public virtual int FrameCount
	{
		get
		{
			if (frames != null)
			{
				return frames.Length;
			}
			return 0;
		}
	}

	[MethodImpl((MethodImplOptions)8)]
	public StackTrace()
	{
		init_frames(0, fNeedFileInfo: false);
	}

	[MethodImpl((MethodImplOptions)8)]
	public StackTrace(bool fNeedFileInfo)
	{
		init_frames(0, fNeedFileInfo);
	}

	[MethodImpl((MethodImplOptions)8)]
	public StackTrace(int skipFrames)
	{
		init_frames(skipFrames, fNeedFileInfo: false);
	}

	[MethodImpl((MethodImplOptions)8)]
	public StackTrace(int skipFrames, bool fNeedFileInfo)
	{
		init_frames(skipFrames, fNeedFileInfo);
	}

	[MethodImpl((MethodImplOptions)8)]
	private void init_frames(int skipFrames, bool fNeedFileInfo)
	{
		if (skipFrames < 0)
		{
			throw new ArgumentOutOfRangeException("< 0", "skipFrames");
		}
		List<StackFrame> list = new List<StackFrame>();
		skipFrames += 2;
		StackFrame stackFrame;
		while ((stackFrame = new StackFrame(skipFrames, fNeedFileInfo)) != null && stackFrame.GetMethod() != null)
		{
			list.Add(stackFrame);
			skipFrames++;
		}
		debug_info = fNeedFileInfo;
		frames = list.ToArray();
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern StackFrame[] get_trace(Exception e, int skipFrames, bool fNeedFileInfo);

	public StackTrace(Exception e)
		: this(e, 0, fNeedFileInfo: false)
	{
	}

	public StackTrace(Exception e, bool fNeedFileInfo)
		: this(e, 0, fNeedFileInfo)
	{
	}

	public StackTrace(Exception e, int skipFrames)
		: this(e, skipFrames, fNeedFileInfo: false)
	{
	}

	public StackTrace(Exception e, int skipFrames, bool fNeedFileInfo)
	{
		if (e == null)
		{
			throw new ArgumentNullException("e");
		}
		if (skipFrames < 0)
		{
			throw new ArgumentOutOfRangeException("< 0", "skipFrames");
		}
		frames = get_trace(e, skipFrames, fNeedFileInfo);
		captured_traces = e.captured_traces;
	}

	public StackTrace(StackFrame frame)
	{
		frames = new StackFrame[1];
		frames[0] = frame;
	}

	[Obsolete]
	[MonoLimitation("Not possible to create StackTraces from other threads")]
	public StackTrace(Thread targetThread, bool needFileInfo)
	{
		if (targetThread == Thread.CurrentThread)
		{
			init_frames(0, needFileInfo);
			return;
		}
		throw new NotImplementedException();
	}

	internal StackTrace(StackFrame[] frames)
	{
		this.frames = frames;
	}

	public virtual StackFrame GetFrame(int index)
	{
		if (index < 0 || index >= FrameCount)
		{
			return null;
		}
		return frames[index];
	}

	[ComVisible(false)]
	public virtual StackFrame[] GetFrames()
	{
		if (captured_traces == null)
		{
			return frames;
		}
		List<StackFrame> list = new List<StackFrame>();
		StackTrace[] array = captured_traces;
		foreach (StackTrace stackTrace in array)
		{
			for (int j = 0; j < stackTrace.FrameCount; j++)
			{
				list.Add(stackTrace.GetFrame(j));
			}
		}
		list.AddRange(frames);
		return list.ToArray();
	}

	private static string GetAotId()
	{
		if (!isAotidSet)
		{
			byte[] aotId = RuntimeAssembly.GetAotId();
			if (aotId != null)
			{
				aotid = new Guid(aotId).ToString("N");
			}
			isAotidSet = true;
		}
		return aotid;
	}

	private bool AddFrames(StringBuilder sb, bool separator, out bool isAsync)
	{
		isAsync = false;
		bool flag = false;
		for (int i = 0; i < FrameCount; i++)
		{
			StackFrame frame = GetFrame(i);
			if (frame.GetMethod() == null)
			{
				if (flag | separator)
				{
					sb.Append(Environment.NewLine);
				}
				sb.Append("  at ");
				string internalMethodName = frame.GetInternalMethodName();
				if (internalMethodName != null)
				{
					sb.Append(internalMethodName);
				}
				else
				{
					sb.AppendFormat("<0x{0:x5} + 0x{1:x5}> <unknown method>", frame.GetMethodAddress(), frame.GetNativeOffset());
				}
			}
			else
			{
				GetFullNameForStackTrace(sb, frame.GetMethod(), flag | separator, out var skipped, out isAsync);
				if (skipped)
				{
					continue;
				}
				if (frame.GetILOffset() == -1)
				{
					sb.AppendFormat(" <0x{0:x5} + 0x{1:x5}>", frame.GetMethodAddress(), frame.GetNativeOffset());
					if (frame.GetMethodIndex() != 16777215)
					{
						sb.AppendFormat(" {0}", frame.GetMethodIndex());
					}
				}
				else
				{
					sb.AppendFormat(" [0x{0:x5}]", frame.GetILOffset());
				}
				string text = frame.GetSecureFileName();
				if (text[0] == '<')
				{
					string arg = frame.GetMethod().Module.ModuleVersionId.ToString("N");
					string aotId = GetAotId();
					text = ((frame.GetILOffset() == -1 && aotId != null) ? $"<{arg}#{aotId}>" : $"<{arg}>");
				}
				sb.AppendFormat(" in {0}:{1} ", text, frame.GetFileLineNumber());
			}
			flag = true;
		}
		return flag;
	}

	private void GetFullNameForStackTrace(StringBuilder sb, MethodBase mi, bool needsNewLine, out bool skipped, out bool isAsync)
	{
		Type declaringType = mi.DeclaringType;
		if (declaringType.IsGenericType && !declaringType.IsGenericTypeDefinition)
		{
			declaringType = declaringType.GetGenericTypeDefinition();
			MethodInfo[] methods = declaringType.GetMethods(BindingFlags.DeclaredOnly | BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic);
			foreach (MethodInfo methodInfo in methods)
			{
				if (methodInfo.MetadataToken == mi.MetadataToken)
				{
					mi = methodInfo;
					break;
				}
			}
		}
		isAsync = typeof(IAsyncStateMachine).IsAssignableFrom(declaringType);
		skipped = mi.IsDefined(typeof(StackTraceHiddenAttribute)) || declaringType.IsDefined(typeof(StackTraceHiddenAttribute));
		if (skipped)
		{
			return;
		}
		if (isAsync)
		{
			ConvertAsyncStateMachineMethod(ref mi, ref declaringType);
		}
		if (needsNewLine)
		{
			sb.Append(Environment.NewLine);
		}
		sb.Append("  at ");
		sb.Append(declaringType.ToString());
		sb.Append(".");
		sb.Append(mi.Name);
		if (mi.IsGenericMethod)
		{
			mi = ((MethodInfo)mi).GetGenericMethodDefinition();
			Type[] genericArguments = mi.GetGenericArguments();
			sb.Append("[");
			for (int j = 0; j < genericArguments.Length; j++)
			{
				if (j > 0)
				{
					sb.Append(",");
				}
				sb.Append(genericArguments[j].Name);
			}
			sb.Append("]");
		}
		ParameterInfo[] parameters = mi.GetParameters();
		sb.Append(" (");
		for (int k = 0; k < parameters.Length; k++)
		{
			if (k > 0)
			{
				sb.Append(", ");
			}
			Type type = parameters[k].ParameterType;
			if (type.IsGenericType && !type.IsGenericTypeDefinition)
			{
				type = type.GetGenericTypeDefinition();
			}
			sb.Append(type.ToString());
			if (parameters[k].Name != null)
			{
				sb.Append(" ");
				sb.Append(parameters[k].Name);
			}
		}
		sb.Append(")");
	}

	private static void ConvertAsyncStateMachineMethod(ref MethodBase method, ref Type declaringType)
	{
		Type declaringType2 = declaringType.DeclaringType;
		if (declaringType2 == null)
		{
			return;
		}
		MethodInfo[] methods = declaringType2.GetMethods(BindingFlags.DeclaredOnly | BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic);
		if (methods == null)
		{
			return;
		}
		MethodInfo[] array = methods;
		foreach (MethodInfo methodInfo in array)
		{
			IEnumerable<AsyncStateMachineAttribute> customAttributes = methodInfo.GetCustomAttributes<AsyncStateMachineAttribute>();
			if (customAttributes == null)
			{
				continue;
			}
			foreach (AsyncStateMachineAttribute item in customAttributes)
			{
				if (item.StateMachineType == declaringType)
				{
					method = methodInfo;
					declaringType = methodInfo.DeclaringType;
					return;
				}
			}
		}
	}

	public override string ToString()
	{
		StringBuilder stringBuilder = new StringBuilder();
		bool flag = false;
		if (captured_traces != null)
		{
			StackTrace[] array = captured_traces;
			for (int i = 0; i < array.Length; i++)
			{
				flag = array[i].AddFrames(stringBuilder, flag, out var isAsync);
				if (flag && !isAsync)
				{
					stringBuilder.Append(Environment.NewLine);
					stringBuilder.Append("--- End of stack trace from previous location where exception was thrown ---");
					stringBuilder.Append(Environment.NewLine);
				}
			}
		}
		AddFrames(stringBuilder, flag, out var _);
		return stringBuilder.ToString();
	}

	internal string ToString(TraceFormat traceFormat)
	{
		return ToString();
	}
}
