using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Runtime.CompilerServices;
using System.Security;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace Cysharp.Threading.Tasks.Internal;

internal static class DiagnosticsExtensions
{
	private static bool displayFilenames = true;

	private static readonly Regex typeBeautifyRegex = new Regex("`.+$", RegexOptions.Compiled);

	private static readonly Dictionary<Type, string> builtInTypeNames = new Dictionary<Type, string>
	{
		{
			typeof(void),
			"void"
		},
		{
			typeof(bool),
			"bool"
		},
		{
			typeof(byte),
			"byte"
		},
		{
			typeof(char),
			"char"
		},
		{
			typeof(decimal),
			"decimal"
		},
		{
			typeof(double),
			"double"
		},
		{
			typeof(float),
			"float"
		},
		{
			typeof(int),
			"int"
		},
		{
			typeof(long),
			"long"
		},
		{
			typeof(object),
			"object"
		},
		{
			typeof(sbyte),
			"sbyte"
		},
		{
			typeof(short),
			"short"
		},
		{
			typeof(string),
			"string"
		},
		{
			typeof(uint),
			"uint"
		},
		{
			typeof(ulong),
			"ulong"
		},
		{
			typeof(ushort),
			"ushort"
		},
		{
			typeof(Task),
			"Task"
		},
		{
			typeof(UniTask),
			"UniTask"
		},
		{
			typeof(UniTaskVoid),
			"UniTaskVoid"
		}
	};

	public static string CleanupAsyncStackTrace(this StackTrace stackTrace)
	{
		if (stackTrace == null)
		{
			return "";
		}
		StringBuilder stringBuilder = new StringBuilder();
		for (int i = 0; i < stackTrace.FrameCount; i++)
		{
			StackFrame frame = stackTrace.GetFrame(i);
			MethodBase method = frame.GetMethod();
			if (IgnoreLine(method))
			{
				continue;
			}
			if (IsAsync(method))
			{
				stringBuilder.Append("async ");
				TryResolveStateMachineMethod(ref method, out var _);
			}
			if (method is MethodInfo methodInfo)
			{
				stringBuilder.Append(BeautifyType(methodInfo.ReturnType, shortName: false));
				stringBuilder.Append(" ");
			}
			stringBuilder.Append(BeautifyType(method.DeclaringType, shortName: false));
			if (!method.IsConstructor)
			{
				stringBuilder.Append(".");
			}
			stringBuilder.Append(method.Name);
			if (method.IsGenericMethod)
			{
				stringBuilder.Append("<");
				Type[] genericArguments = method.GetGenericArguments();
				foreach (Type t in genericArguments)
				{
					stringBuilder.Append(BeautifyType(t, shortName: true));
				}
				stringBuilder.Append(">");
			}
			stringBuilder.Append("(");
			stringBuilder.Append(string.Join(", ", from p in method.GetParameters()
				select BeautifyType(p.ParameterType, shortName: true) + " " + p.Name));
			stringBuilder.Append(")");
			if (displayFilenames && frame.GetILOffset() != -1)
			{
				string text = null;
				try
				{
					text = frame.GetFileName();
				}
				catch (NotSupportedException)
				{
					displayFilenames = false;
				}
				catch (SecurityException)
				{
					displayFilenames = false;
				}
				if (text != null)
				{
					stringBuilder.Append(' ');
					stringBuilder.AppendFormat(CultureInfo.InvariantCulture, "(at {0})", AppendHyperLink(text, frame.GetFileLineNumber().ToString()));
				}
			}
			stringBuilder.AppendLine();
		}
		return stringBuilder.ToString();
	}

	private static bool IsAsync(MethodBase methodInfo)
	{
		Type declaringType = methodInfo.DeclaringType;
		return typeof(IAsyncStateMachine).IsAssignableFrom(declaringType);
	}

	private static bool TryResolveStateMachineMethod(ref MethodBase method, out Type declaringType)
	{
		declaringType = method.DeclaringType;
		Type declaringType2 = declaringType.DeclaringType;
		if (declaringType2 == null)
		{
			return false;
		}
		MethodInfo[] methods = declaringType2.GetMethods(BindingFlags.DeclaredOnly | BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic);
		if (methods == null)
		{
			return false;
		}
		MethodInfo[] array = methods;
		foreach (MethodInfo methodInfo in array)
		{
			IEnumerable<StateMachineAttribute> customAttributes = methodInfo.GetCustomAttributes<StateMachineAttribute>(inherit: false);
			if (customAttributes == null)
			{
				continue;
			}
			foreach (StateMachineAttribute item in customAttributes)
			{
				if (item.StateMachineType == declaringType)
				{
					method = methodInfo;
					declaringType = methodInfo.DeclaringType;
					return item is IteratorStateMachineAttribute;
				}
			}
		}
		return false;
	}

	private static string BeautifyType(Type t, bool shortName)
	{
		if (builtInTypeNames.TryGetValue(t, out var value))
		{
			return value;
		}
		if (t.IsGenericParameter)
		{
			return t.Name;
		}
		if (t.IsArray)
		{
			return BeautifyType(t.GetElementType(), shortName) + "[]";
		}
		string fullName = t.FullName;
		if (fullName != null && fullName.StartsWith("System.ValueTuple"))
		{
			return "(" + string.Join(", ", from x in t.GetGenericArguments()
				select BeautifyType(x, shortName: true)) + ")";
		}
		if (!t.IsGenericType)
		{
			string text;
			if (!shortName)
			{
				text = t.FullName.Replace("Cysharp.Threading.Tasks.Triggers.", "").Replace("Cysharp.Threading.Tasks.Internal.", "").Replace("Cysharp.Threading.Tasks.", "");
				if (text == null)
				{
					return t.Name;
				}
			}
			else
			{
				text = t.Name;
			}
			return text;
		}
		string text2 = string.Join(", ", from x in t.GetGenericArguments()
			select BeautifyType(x, shortName: true));
		string text3 = t.GetGenericTypeDefinition().FullName;
		if (text3 == "System.Threading.Tasks.Task`1")
		{
			text3 = "Task";
		}
		return typeBeautifyRegex.Replace(text3, "").Replace("Cysharp.Threading.Tasks.Triggers.", "").Replace("Cysharp.Threading.Tasks.Internal.", "")
			.Replace("Cysharp.Threading.Tasks.", "") + "<" + text2 + ">";
	}

	private static bool IgnoreLine(MethodBase methodInfo)
	{
		string fullName = methodInfo.DeclaringType.FullName;
		if (fullName == "System.Threading.ExecutionContext")
		{
			return true;
		}
		if (fullName.StartsWith("System.Runtime.CompilerServices"))
		{
			return true;
		}
		if (fullName.StartsWith("Cysharp.Threading.Tasks.CompilerServices"))
		{
			return true;
		}
		if (fullName == "System.Threading.Tasks.AwaitTaskContinuation")
		{
			return true;
		}
		if (fullName.StartsWith("System.Threading.Tasks.Task"))
		{
			return true;
		}
		if (fullName.StartsWith("Cysharp.Threading.Tasks.UniTaskCompletionSourceCore"))
		{
			return true;
		}
		if (fullName.StartsWith("Cysharp.Threading.Tasks.AwaiterActions"))
		{
			return true;
		}
		return false;
	}

	private static string AppendHyperLink(string path, string line)
	{
		FileInfo fileInfo = new FileInfo(path);
		if (fileInfo.Directory == null)
		{
			return fileInfo.Name;
		}
		string text = fileInfo.FullName.Replace(Path.DirectorySeparatorChar, '/').Replace(PlayerLoopHelper.ApplicationDataPath, "");
		string text2 = "Assets/" + text;
		return "<a href=\"" + text2 + "\" line=\"" + line + "\">" + text2 + ":" + line + "</a>";
	}
}
