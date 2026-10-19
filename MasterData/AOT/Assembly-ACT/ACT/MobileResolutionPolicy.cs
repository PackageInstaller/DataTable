using System;
using UnityEngine;
using UnityEngine.Rendering.Universal;

namespace ACT;

internal static class MobileResolutionPolicy
{
	private enum DeviceBucket
	{
		Phone,
		Foldable,
		Tablet
	}

	private const string LogPrefix = "[MobileResolutionPolicy]";

	private const int PhoneReferenceHeight = 1080;

	private const int TabletReferenceHeight = 1440;

	private const float MinContentAspect = 1.7777778f;

	private const float MinReliableDpi = 120f;

	private const int AndroidTabletMinSmallestWidthDp = 600;

	private const float AndroidTabletMinDiagonalInches = 7f;

	internal static void RefreshRuntimeState()
	{
		int width = Screen.width;
		int height = Screen.height;
		Resolution currentResolution = Screen.currentResolution;
		int width2 = currentResolution.width;
		int height2 = currentResolution.height;
		float dpi = Screen.dpi;
		ScreenOrientation orientation = Screen.orientation;
		DeviceBucket deviceBucket = ResolveDeviceBucket(width, height, width2, height2, dpi, out var reason);
		int maxReferenceHeight = GetMaxReferenceHeight(deviceBucket);
		Debug.Log("[MobileResolutionPolicy] Refresh: " + $"screen={width}x{height}, " + $"display={width2}x{height2}, " + $"dpi={dpi:F1}, orientation={orientation}, " + $"deviceModel=\"{SystemInfo.deviceModel}\", deviceType={SystemInfo.deviceType}, " + "operatingSystem=\"" + SystemInfo.operatingSystem + "\", " + $"bucket={deviceBucket}, reason=\"{reason}\", referenceHeight={maxReferenceHeight}");
		SetRenderReferenceHeight(maxReferenceHeight);
	}

	private static DeviceBucket ResolveDeviceBucket(int screenWidth, int screenHeight, int displayWidth, int displayHeight, float dpi, out string reason)
	{
		int num = Mathf.Max(Mathf.Min(screenWidth, screenHeight), Mathf.Min(displayWidth, displayHeight));
		int num2 = Mathf.Max(Mathf.Max(screenWidth, screenHeight), Mathf.Max(displayWidth, displayHeight));
		if (num <= 1080)
		{
			reason = $"shortSide={num} <= phoneReferenceHeight={1080}";
			return DeviceBucket.Phone;
		}
		float num3 = (float)num2 / (float)num;
		if (num3 >= 1.7777778f)
		{
			reason = $"landscapeAspect={num3:F3} >= minContentAspect={1.7777778f:F3}";
			return DeviceBucket.Phone;
		}
		bool flag = IsTabletClassLargeScreen(num, num2, dpi, out var reason2);
		reason = reason2;
		if (!flag)
		{
			return DeviceBucket.Foldable;
		}
		return DeviceBucket.Tablet;
	}

	private static bool IsTabletClassLargeScreen(int shortSide, int longSide, float dpi, out string reason)
	{
		if (TryGetAndroidSmallestScreenWidthDp(out var smallestScreenWidthDp))
		{
			bool flag = smallestScreenWidthDp >= 600;
			reason = $"androidSmallestScreenWidthDp={smallestScreenWidthDp} " + string.Format("{0} {1}", flag ? ">=" : "<", 600);
			return flag;
		}
		if (dpi >= 120f)
		{
			float num = Mathf.Sqrt(shortSide * shortSide + longSide * longSide) / dpi;
			bool flag2 = num >= 7f;
			reason = $"androidSmallestScreenWidthDp unavailable, diagonalInches={num:F2} " + string.Format("{0} {1:F1}, dpi={2:F1}", flag2 ? ">=" : "<", 7f, dpi);
			return flag2;
		}
		reason = $"androidSmallestScreenWidthDp unavailable, dpi={dpi:F1} < minReliableDpi={120f:F1}";
		return false;
	}

	private static bool TryGetAndroidSmallestScreenWidthDp(out int smallestScreenWidthDp)
	{
		smallestScreenWidthDp = 0;
		try
		{
			using AndroidJavaClass androidJavaClass = new AndroidJavaClass("com.unity3d.player.UnityPlayer");
			using AndroidJavaObject androidJavaObject = androidJavaClass.GetStatic<AndroidJavaObject>("currentActivity");
			using AndroidJavaObject androidJavaObject2 = androidJavaObject.Call<AndroidJavaObject>("getResources", Array.Empty<object>());
			using AndroidJavaObject androidJavaObject3 = androidJavaObject2.Call<AndroidJavaObject>("getConfiguration", Array.Empty<object>());
			smallestScreenWidthDp = androidJavaObject3.Get<int>("smallestScreenWidthDp");
			return smallestScreenWidthDp > 0;
		}
		catch (Exception ex)
		{
			Debug.LogWarning("[MobileResolutionPolicy] Failed to read Android smallestScreenWidthDp: " + ex.Message);
			return false;
		}
	}

	private static int GetMaxReferenceHeight(DeviceBucket bucket)
	{
		if (bucket != DeviceBucket.Tablet)
		{
			return 1080;
		}
		return 1440;
	}

	private static void SetRenderReferenceHeight(int height)
	{
		UniversalRenderPipelineAsset asset = UniversalRenderPipeline.asset;
		if (asset != null)
		{
			int heightPixels = asset.heightPixels;
			asset.heightPixels = height;
			Debug.Log(string.Format("{0} URP heightPixels: {1} -> {2}", "[MobileResolutionPolicy]", heightPixels, asset.heightPixels));
		}
		else
		{
			Debug.LogWarning(string.Format("{0} URP asset is null; cannot set heightPixels={1}.", "[MobileResolutionPolicy]", height));
		}
	}
}
