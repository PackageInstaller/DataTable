using System;
using System.Diagnostics;
using System.Reflection;
using System.Text;
using UnityEngine.Scripting;

namespace UnityEngine;

public static class StackTraceUtility
{
	private static string projectFolder = "";

	[RequiredByNativeCode]
	internal static void SetProjectFolder(string folder)
	{
		projectFolder = folder;
		if (!string.IsNullOrEmpty(projectFolder))
		{
			projectFolder = projectFolder.Replace("\\", "/");
		}
	}

	[RequiredByNativeCode]
	public unsafe static string ExtractStackTrace()
	{
		int num = 16384;
		byte* ptr = stackalloc byte[(int)(uint)num];
		int num2 = Debug.ExtractStackTraceNoAlloc(ptr, num, projectFolder);
		if (num2 > 0)
		{
			return new string((sbyte*)ptr, 0, num2, Encoding.UTF8);
		}
		StackTrace stackTrace = new StackTrace(1, fNeedFileInfo: true);
		return ExtractFormattedStackTrace(stackTrace);
	}

	[RequiredByNativeCode]
	internal static void ExtractStringFromExceptionInternal(object exceptiono, out string message, out string stackTrace)
	{
		if (exceptiono == null)
		{
			throw new ArgumentException("ExtractStringFromExceptionInternal called with null exception");
		}
		Exception ex = exceptiono as Exception;
		if (ex == null)
		{
			throw new ArgumentException("ExtractStringFromExceptionInternal called with an exceptoin that was not of type System.Exception");
		}
		StringBuilder stringBuilder = new StringBuilder((ex.StackTrace == null) ? 512 : (ex.StackTrace.Length * 2));
		message = "";
		string text = "";
		while (ex != null)
		{
			text = ((text.Length != 0) ? (ex.StackTrace + "\n" + text) : ex.StackTrace);
			string text2 = ex.GetType().Name;
			string text3 = "";
			if (ex.Message != null)
			{
				text3 = ex.Message;
			}
			if (text3.Trim().Length != 0)
			{
				text2 += ": ";
				text2 += text3;
			}
			message = text2;
			if (ex.InnerException != null)
			{
				text = "Rethrow as " + text2 + "\n" + text;
			}
			ex = ex.InnerException;
		}
		stringBuilder.Append(text + "\n");
		StackTrace stackTrace2 = new StackTrace(1, fNeedFileInfo: true);
		stringBuilder.Append(ExtractFormattedStackTrace(stackTrace2));
		stackTrace = stringBuilder.ToString();
	}

	internal static string ExtractFormattedStackTrace(StackTrace stackTrace)
	{
		StringBuilder stringBuilder = new StringBuilder(255);
		for (int i = 0; i < stackTrace.FrameCount; i++)
		{
			StackFrame frame = stackTrace.GetFrame(i);
			MethodBase method = frame.GetMethod();
			if ((object)method == null)
			{
				continue;
			}
			Type declaringType = method.DeclaringType;
			if ((object)declaringType == null)
			{
				continue;
			}
			string value = declaringType.Namespace;
			if (!string.IsNullOrEmpty(value))
			{
				stringBuilder.Append(value);
				stringBuilder.Append(".");
			}
			stringBuilder.Append(declaringType.Name);
			stringBuilder.Append(":");
			stringBuilder.Append(method.Name);
			stringBuilder.Append("(");
			int j = 0;
			ParameterInfo[] parameters = method.GetParameters();
			bool flag = true;
			for (; j < parameters.Length; j++)
			{
				if (!flag)
				{
					stringBuilder.Append(", ");
				}
				else
				{
					flag = false;
				}
				stringBuilder.Append(parameters[j].ParameterType.Name);
			}
			stringBuilder.Append(")");
			string text = frame.GetFileName();
			if (text != null && (!(declaringType.Name == "Debug") || !(declaringType.Namespace == "UnityEngine")) && (!(declaringType.Name == "Logger") || !(declaringType.Namespace == "UnityEngine")) && (!(declaringType.Name == "DebugLogHandler") || !(declaringType.Namespace == "UnityEngine")) && (!(declaringType.Name == "Assert") || !(declaringType.Namespace == "UnityEngine.Assertions")) && (!(method.Name == "print") || !(declaringType.Name == "MonoBehaviour") || !(declaringType.Namespace == "UnityEngine")))
			{
				stringBuilder.Append(" (at ");
				if (!string.IsNullOrEmpty(projectFolder) && text.Replace("\\", "/").StartsWith(projectFolder))
				{
					text = text.Substring(projectFolder.Length, text.Length - projectFolder.Length);
				}
				stringBuilder.Append(text);
				stringBuilder.Append(":");
				stringBuilder.Append(frame.GetFileLineNumber().ToString());
				stringBuilder.Append(")");
			}
			stringBuilder.Append("\n");
		}
		return stringBuilder.ToString();
	}
}
