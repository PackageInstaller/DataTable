using System;
using System.IO;
using System.Reflection;
using Microsoft.Win32.SafeHandles;
using UnityEngine.Scripting;

namespace UnityEngine;

internal static class ClassLibraryInitializer
{
	[RequiredByNativeCode]
	private static void Init()
	{
		UnityLogWriter.Init();
	}

	[RequiredByNativeCode]
	private static void InitStdErrWithHandle(IntPtr fileHandle)
	{
		SafeFileHandle safeFileHandle = new SafeFileHandle(fileHandle, ownsHandle: false);
		if (!safeFileHandle.IsInvalid)
		{
			StreamWriter error = new StreamWriter(new FileStream(safeFileHandle, FileAccess.Write))
			{
				AutoFlush = true
			};
			Console.SetError(error);
		}
	}

	[RequiredByNativeCode]
	private static void InitAssemblyRedirections()
	{
		AppDomain.CurrentDomain.AssemblyResolve += delegate(object _, ResolveEventArgs args)
		{
			AssemblyName assemblyName = new AssemblyName(args.Name);
			try
			{
				return AppDomain.CurrentDomain.Load(assemblyName.Name);
			}
			catch
			{
				return (Assembly)null;
			}
		};
	}
}
