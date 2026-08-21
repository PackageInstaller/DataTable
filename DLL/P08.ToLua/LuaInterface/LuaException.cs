using System;
using System.Diagnostics;
using System.Reflection;
using System.Text;
using UnityEngine;

namespace LuaInterface;

public class LuaException : Exception
{
	public static Exception luaStack = null;

	public static string projectFolder = null;

	public static int InstantiateCount = 0;

	public static int SendMsgCount = 0;

	public static IntPtr L = IntPtr.Zero;

	protected string _stack = string.Empty;

	public override string StackTrace => _stack;

	public LuaException(string msg, Exception e = null, int skip = 1)
		: base(msg)
	{
		if (e != null)
		{
			if (e is LuaException)
			{
				_stack = e.StackTrace;
				return;
			}
			StackTrace stackTrace = new StackTrace(e, fNeedFileInfo: true);
			StringBuilder stringBuilder = new StringBuilder();
			ExtractFormattedStackTrace(stackTrace, stringBuilder);
			ExtractFormattedStackTrace(new StackTrace(skip, fNeedFileInfo: true), stringBuilder, stackTrace);
			_stack = stringBuilder.ToString();
		}
		else
		{
			StackTrace trace = new StackTrace(skip, fNeedFileInfo: true);
			StringBuilder stringBuilder2 = new StringBuilder();
			ExtractFormattedStackTrace(trace, stringBuilder2);
			_stack = stringBuilder2.ToString();
		}
	}

	public static Exception GetLastError()
	{
		Exception result = luaStack;
		luaStack = null;
		return result;
	}

	public static void ExtractFormattedStackTrace(StackTrace trace, StringBuilder sb, StackTrace skip = null)
	{
		int num = 0;
		if (skip != null && skip.FrameCount > 0)
		{
			MethodBase method = skip.GetFrame(skip.FrameCount - 1).GetMethod();
			for (int i = 0; i < trace.FrameCount; i++)
			{
				if (trace.GetFrame(i).GetMethod() == method)
				{
					num = i + 1;
					break;
				}
			}
			sb.AppendLineEx();
		}
		for (int j = num; j < trace.FrameCount; j++)
		{
			StackFrame frame = trace.GetFrame(j);
			MethodBase method2 = frame.GetMethod();
			if (method2 == null || method2.DeclaringType == null)
			{
				continue;
			}
			Type declaringType = method2.DeclaringType;
			string text = declaringType.Namespace;
			if ((InstantiateCount == 0 && declaringType == typeof(UnityEngine.Object) && method2.Name == "Instantiate") || (SendMsgCount == 0 && declaringType == typeof(GameObject) && method2.Name == "SendMessage"))
			{
				break;
			}
			if (text != null && text.Length != 0)
			{
				sb.Append(text);
				sb.Append(".");
			}
			sb.Append(declaringType.Name);
			sb.Append(":");
			sb.Append(method2.Name);
			sb.Append("(");
			int k = 0;
			ParameterInfo[] parameters = method2.GetParameters();
			bool flag = true;
			for (; k < parameters.Length; k++)
			{
				if (!flag)
				{
					sb.Append(", ");
				}
				else
				{
					flag = false;
				}
				sb.Append(parameters[k].ParameterType.Name);
			}
			sb.Append(")");
			string fileName = frame.GetFileName();
			if (fileName != null)
			{
				fileName = fileName.Replace('\\', '/');
				sb.Append(" (at ");
				if (fileName.StartsWith(projectFolder))
				{
					fileName = fileName.Substring(projectFolder.Length, fileName.Length - projectFolder.Length);
				}
				sb.Append(fileName);
				sb.Append(":");
				sb.Append(frame.GetFileLineNumber().ToString());
				sb.Append(")");
			}
			if (j != trace.FrameCount - 1)
			{
				sb.Append("\n");
			}
		}
	}

	public static void Init(IntPtr L0)
	{
		L = L0;
		projectFolder = (string)typeof(StackTraceUtility).GetField("projectFolder", BindingFlags.Static | BindingFlags.NonPublic | BindingFlags.GetField).GetValue(null);
		projectFolder = projectFolder.Replace('\\', '/');
	}
}
