using System;
using System.IO;
using System.Runtime.CompilerServices;
using System.Text;
using UnityEngine.Bindings;

namespace UnityEngine;

[NativeHeader("Runtime/Export/Logging/UnityLogWriter.bindings.h")]
internal class UnityLogWriter : TextWriter
{
	public override Encoding Encoding => Encoding.UTF8;

	[ThreadAndSerializationSafe]
	public static void WriteStringToUnityLog(string s)
	{
		if (s != null)
		{
			WriteStringToUnityLogImpl(s);
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(IsThreadSafe = true)]
	private static extern void WriteStringToUnityLogImpl(string s);

	public static void Init()
	{
		Console.SetOut(new UnityLogWriter());
	}

	public override void Write(char value)
	{
		WriteStringToUnityLog(value.ToString());
	}

	public override void Write(string s)
	{
		WriteStringToUnityLog(s);
	}

	public override void Write(char[] buffer, int index, int count)
	{
		WriteStringToUnityLogImpl(new string(buffer, index, count));
	}
}
