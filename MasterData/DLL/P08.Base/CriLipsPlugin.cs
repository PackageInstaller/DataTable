using System.Runtime.InteropServices;

public static class CriLipsPlugin
{
	private const string scriptVersionString = "3.2.9";

	private static int initializationCount;

	public static void InitializeLibrary()
	{
		initializationCount++;
		if (initializationCount == 1)
		{
			if (IsLibraryInitialized())
			{
				FinalizeLibrary();
				initializationCount = 1;
			}
			criLipsUnity_Initialize();
		}
	}

	public static void FinalizeLibrary()
	{
		initializationCount--;
		if (initializationCount < 0)
		{
			initializationCount = 0;
			if (!IsLibraryInitialized())
			{
				return;
			}
		}
		if (initializationCount == 0)
		{
			CriDisposableObjectManager.DisposeAll(CriDisposableObjectManager.ModuleType.Lips);
			criLipsUnity_Finalize();
		}
	}

	public static bool IsLibraryInitialized()
	{
		return criLipsUnity_IsInitialized();
	}

	[DllImport("cri_lips_unity", CallingConvention = CallingConvention.Cdecl)]
	internal static extern void criLipsUnity_Initialize();

	[DllImport("cri_lips_unity", CallingConvention = CallingConvention.Cdecl)]
	internal static extern void criLipsUnity_Finalize();

	[DllImport("cri_lips_unity", CallingConvention = CallingConvention.Cdecl)]
	internal static extern bool criLipsUnity_IsInitialized();
}
