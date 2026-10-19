using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine.Android;

[StaticAccessor("AndroidAssetPacksBindingsHelpers", StaticAccessorType.DoubleColon)]
[NativeHeader("Modules/AndroidJNI/Public/AndroidAssetPacksBindingsHelpers.h")]
public static class AndroidAssetPacks
{
	private class AssetPackManagerDownloadStatusCallback : AndroidJavaProxy
	{
		private Action<AndroidAssetPackInfo> m_Callback;

		private string[] m_AssetPacks;

		public AssetPackManagerDownloadStatusCallback(Action<AndroidAssetPackInfo> callback, string[] assetPacks)
			: base("com.unity3d.player.IAssetPackManagerDownloadStatusCallback")
		{
			m_Callback = callback;
			m_AssetPacks = assetPacks;
		}

		[Preserve]
		private void onStatusUpdate(string assetPackName, int assetPackStatus, long assetPackSize, long assetPackBytesDownloaded, int assetPackTransferProgress, int assetPackErrorCode)
		{
			if (m_AssetPacks.Contains(assetPackName))
			{
				AndroidAssetPackInfo obj = new AndroidAssetPackInfo(assetPackName, (AndroidAssetPackStatus)assetPackStatus, (ulong)assetPackSize, (ulong)assetPackBytesDownloaded, (float)assetPackTransferProgress / 100f, (AndroidAssetPackError)assetPackErrorCode);
				m_Callback?.Invoke(obj);
			}
		}
	}

	private class AssetPackManagerMobileDataConfirmationCallback : AndroidJavaProxy
	{
		private Action<AndroidAssetPackUseMobileDataRequestResult> m_Callback;

		public AssetPackManagerMobileDataConfirmationCallback(Action<AndroidAssetPackUseMobileDataRequestResult> callback)
			: base("com.unity3d.player.IAssetPackManagerMobileDataConfirmationCallback")
		{
			m_Callback = callback;
		}

		[Preserve]
		private void onMobileDataConfirmationResult(bool allowed)
		{
			m_Callback?.Invoke(new AndroidAssetPackUseMobileDataRequestResult(allowed));
		}
	}

	private class AssetPackManagerStatusQueryCallback : AndroidJavaProxy
	{
		private Action<ulong, AndroidAssetPackState[]> m_Callback;

		private List<string> m_AssetPackNames;

		private List<AndroidAssetPackState> m_States;

		private long m_Size;

		public AssetPackManagerStatusQueryCallback(Action<ulong, AndroidAssetPackState[]> callback, string[] assetPacks)
			: base("com.unity3d.player.IAssetPackManagerStatusQueryCallback")
		{
			m_Callback = callback;
			m_AssetPackNames = assetPacks.ToList();
			m_States = new List<AndroidAssetPackState>();
			m_Size = 0L;
		}

		[Preserve]
		private void onStatusResult(long totalBytes, string[] assetPackNames, int[] assetPackStatuses, int[] assetPackErrorCodes)
		{
			if (m_Callback != null)
			{
				int num = assetPackNames.Length;
				bool flag = num == m_AssetPackNames.Count;
				for (int i = 0; i < num; i++)
				{
					m_States.Add(new AndroidAssetPackState(assetPackNames[i], (AndroidAssetPackStatus)assetPackStatuses[i], (AndroidAssetPackError)assetPackErrorCodes[i]));
					m_AssetPackNames.Remove(assetPackNames[i]);
				}
				m_Size += totalBytes;
				if (flag)
				{
					m_Callback((ulong)m_Size, m_States.ToArray());
					return;
				}
				GetAssetPackManager().Call("getAssetPackStates", m_AssetPackNames.ToArray(), this);
			}
		}
	}

	private static AndroidJavaObject s_JavaPlayAssetDeliveryWrapper;

	private static bool s_ApiMissing;

	private static AndroidJavaObject GetAssetPackManager()
	{
		if (s_JavaPlayAssetDeliveryWrapper == null)
		{
			using AndroidJavaClass androidJavaClass = new AndroidJavaClass("com.unity3d.player.PlayAssetDeliveryUnityWrapper");
			s_JavaPlayAssetDeliveryWrapper = androidJavaClass.CallStatic<AndroidJavaObject>("getInstance", Array.Empty<object>());
			s_ApiMissing = s_JavaPlayAssetDeliveryWrapper.Call<bool>("playCoreApiMissing", Array.Empty<object>());
		}
		if (s_ApiMissing)
		{
			throw new InvalidOperationException("PlayAssetDelivery AssetPackManager API is not available! Make sure your gradle project includes \"com.google.android.play:asset-delivery\" dependency.");
		}
		return s_JavaPlayAssetDeliveryWrapper;
	}
}
