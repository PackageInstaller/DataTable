using System.Runtime.InteropServices;

public static class CriAtomExDebug
{
	public struct ResourcesInfo
	{
		public CriAtomEx.ResourceUsage virtualVoiceUsage;

		public CriAtomEx.ResourceUsage sequenceUsage;

		public CriAtomEx.ResourceUsage sequenceTrackUsage;

		public CriAtomEx.ResourceUsage sequenceTrackItemUsage;

		public CriAtomEx.ResourceUsage parameterBlock;

		public CriAtomEx.ResourceUsage beatSyncInfo;

		public CriAtomEx.ResourceUsage beatSyncTransitionSetting;

		public CriAtomEx.ResourceUsage beatSyncJob;
	}

	public static void GetResourcesInfo(out ResourcesInfo resourcesInfo)
	{
		criAtomExDebug_GetResourcesInfo(out resourcesInfo);
	}

	[DllImport("cri_ware_unity", CallingConvention = CallingConvention.Cdecl)]
	private static extern void criAtomExDebug_GetResourcesInfo(out ResourcesInfo resourcesInfo);
}
