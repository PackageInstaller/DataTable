using System.Runtime.InteropServices;

public class CriFs
{
	private class NativeMethods
	{
		[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
		internal static extern int criFs_GetNumUsedBinders(ref int curNum, ref int maxNum, ref int limit);

		[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
		internal static extern int criFs_GetNumUsedLoaders(ref int curNum, ref int maxNum, ref int limit);

		[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
		internal static extern int criFs_GetNumUsedGroupLoaders(ref int curNum, ref int maxNum, ref int limit);

		[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
		internal static extern int criFs_GetNumUsedStdioHandles(ref int curNum, ref int maxNum, ref int limit);

		[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
		internal static extern int criFs_GetNumUsedInstallers(ref int curNum, ref int maxNum, ref int limit);

		[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
		internal static extern int criFs_GetNumBinds(ref int curNum, ref int maxNum, ref int limit);

		[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
		internal static extern int criFs_GetNumOpenedFiles(ref int curNum, ref int maxNum, ref int limit);

		[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
		internal static extern int criFs_GetMaxPathLength(ref int length);
	}

	public static bool GetNumUsedBinders(out int curNum, out int maxNum, out int limit)
	{
		curNum = (maxNum = (limit = 0));
		return NativeMethods.criFs_GetNumUsedBinders(ref curNum, ref maxNum, ref limit) == 0;
	}

	public static bool GetNumUsedLoaders(out int curNum, out int maxNum, out int limit)
	{
		curNum = (maxNum = (limit = 0));
		return NativeMethods.criFs_GetNumUsedLoaders(ref curNum, ref maxNum, ref limit) == 0;
	}

	public static bool GetNumUsedInstallers(out int curNum, out int maxNum, out int limit)
	{
		curNum = (maxNum = (limit = 0));
		return NativeMethods.criFs_GetNumUsedInstallers(ref curNum, ref maxNum, ref limit) == 0;
	}

	public static bool GetNumBinds(out int curNum, out int maxNum, out int limit)
	{
		curNum = (maxNum = (limit = 0));
		return NativeMethods.criFs_GetNumBinds(ref curNum, ref maxNum, ref limit) == 0;
	}

	public static bool GetNumOpenedFiles(out int curNum, out int maxNum, out int limit)
	{
		curNum = (maxNum = (limit = 0));
		return NativeMethods.criFs_GetNumOpenedFiles(ref curNum, ref maxNum, ref limit) == 0;
	}

	public static bool GetMaxPathLength(out int length)
	{
		length = 0;
		return NativeMethods.criFs_GetMaxPathLength(ref length) == 0;
	}
}
