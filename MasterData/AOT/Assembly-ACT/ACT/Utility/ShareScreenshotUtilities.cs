using System;
using System.IO;
using System.Threading;
using ACT.Event;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

namespace ACT.Utility;

public static class ShareScreenshotUtilities
{
	private static bool isCapturing;

	private static ShareScreenshotResult activeScreenshot;

	public static string DefaultScreenshotPath => Path.Combine(Application.persistentDataPath, "LatestScreenshot.png");

	public static async UniTask<ShareScreenshotResult> CaptureFullScreenAsync(MonoBehaviour runner, string outputPath = null, CancellationToken cancellationToken = default(CancellationToken))
	{
		if (!runner)
		{
			throw new ArgumentNullException("runner");
		}
		cancellationToken.ThrowIfCancellationRequested();
		if (isCapturing || activeScreenshot != null || ScreenShotPass.IsFinalOutputCaptureRequested || ScreenShotPass.IsFinalOutputCaptureCompleted)
		{
			throw new InvalidOperationException("The previous share screenshot has not been released.");
		}
		string resolvedPath = Path.GetFullPath(string.IsNullOrWhiteSpace(outputPath) ? DefaultScreenshotPath : outputPath);
		using CancellationTokenSource linkedCancellation = CancellationTokenSource.CreateLinkedTokenSource(cancellationToken, runner.GetCancellationTokenOnDestroy());
		CancellationToken token = linkedCancellation.Token;
		isCapturing = true;
		bool requested = false;
		try
		{
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.ShareScreenShot, new ShareScreenshotEvent
			{
				Start = true
			});
			ScreenShotPass.RequestFinalOutputCapture();
			requested = true;
			await UniTask.NextFrame(token);
			token.ThrowIfCancellationRequested();
			RenderTexture finalOutputTexture = ScreenShotPass.FinalOutputTexture;
			if (!ScreenShotPass.IsFinalOutputCaptureCompleted || !finalOutputTexture || !finalOutputTexture.IsCreated())
			{
				throw new InvalidOperationException("The final-output screenshot was not captured in the requested frame.");
			}
			WritePng(resolvedPath, finalOutputTexture);
			activeScreenshot = new ShareScreenshotResult(resolvedPath, finalOutputTexture);
		}
		catch
		{
			if (requested)
			{
				ScreenShotPass.ReleaseFinalOutputCapture();
			}
			throw;
		}
		finally
		{
			isCapturing = false;
			try
			{
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.ShareScreenShot, new ShareScreenshotEvent
				{
					Start = false
				});
			}
			catch
			{
				activeScreenshot?.Dispose();
				throw;
			}
		}
		return activeScreenshot;
	}

	private static void WritePng(string outputPath, RenderTexture source)
	{
		RenderTexture active = RenderTexture.active;
		Texture2D texture2D = null;
		try
		{
			RenderTexture.active = source;
			texture2D = new Texture2D(source.width, source.height, TextureFormat.RGBA32, mipChain: false, linear: true);
			texture2D.ReadPixels(new Rect(0f, 0f, source.width, source.height), 0, 0, recalculateMipMaps: false);
			texture2D.Apply(updateMipmaps: false, makeNoLongerReadable: false);
			byte[] array = texture2D.EncodeToPNG();
			if (array == null || array.Length == 0)
			{
				throw new InvalidOperationException("Failed to encode the screenshot.");
			}
			string directoryName = Path.GetDirectoryName(outputPath);
			if (!string.IsNullOrEmpty(directoryName))
			{
				Directory.CreateDirectory(directoryName);
			}
			File.WriteAllBytes(outputPath, array);
		}
		finally
		{
			RenderTexture.active = active;
			if ((bool)texture2D)
			{
				CoreUtils.Destroy(texture2D);
			}
		}
	}

	internal static void Release(ShareScreenshotResult screenshot)
	{
		if (activeScreenshot == screenshot)
		{
			ScreenShotPass.ReleaseFinalOutputCapture();
			activeScreenshot = null;
		}
	}
}
