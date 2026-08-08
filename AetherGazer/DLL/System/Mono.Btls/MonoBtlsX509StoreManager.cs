using System;
using System.IO;
using Mono.Security.X509;

namespace Mono.Btls;

internal static class MonoBtlsX509StoreManager
{
	private static bool initialized;

	private static string machineTrustedRootPath;

	private static string machineIntermediateCAPath;

	private static string machineUntrustedPath;

	private static string userTrustedRootPath;

	private static string userIntermediateCAPath;

	private static string userUntrustedPath;

	private static void Initialize()
	{
		if (initialized)
		{
			return;
		}
		try
		{
			DoInitialize();
		}
		catch (Exception arg)
		{
			Console.Error.WriteLine("MonoBtlsX509StoreManager.Initialize() threw exception: {0}", arg);
		}
		finally
		{
			initialized = true;
		}
	}

	private static void DoInitialize()
	{
		string newCurrentUserPath = X509StoreManager.NewCurrentUserPath;
		userTrustedRootPath = Path.Combine(newCurrentUserPath, "Trust");
		userIntermediateCAPath = Path.Combine(newCurrentUserPath, "CA");
		userUntrustedPath = Path.Combine(newCurrentUserPath, "Disallowed");
		string newLocalMachinePath = X509StoreManager.NewLocalMachinePath;
		machineTrustedRootPath = Path.Combine(newLocalMachinePath, "Trust");
		machineIntermediateCAPath = Path.Combine(newLocalMachinePath, "CA");
		machineUntrustedPath = Path.Combine(newLocalMachinePath, "Disallowed");
	}

	public static string GetStorePath(MonoBtlsX509StoreType type)
	{
		Initialize();
		return type switch
		{
			MonoBtlsX509StoreType.MachineTrustedRoots => machineTrustedRootPath, 
			MonoBtlsX509StoreType.MachineIntermediateCA => machineIntermediateCAPath, 
			MonoBtlsX509StoreType.MachineUntrusted => machineUntrustedPath, 
			MonoBtlsX509StoreType.UserTrustedRoots => userTrustedRootPath, 
			MonoBtlsX509StoreType.UserIntermediateCA => userIntermediateCAPath, 
			MonoBtlsX509StoreType.UserUntrusted => userUntrustedPath, 
			_ => throw new NotSupportedException(), 
		};
	}
}
