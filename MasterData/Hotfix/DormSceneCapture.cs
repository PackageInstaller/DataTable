using System;
using System.IO;
using System.Linq;
using UnityEngine;

public class DormSceneCapture : MonoBehaviour
{
	public Camera indoorSceneCaptureCamera;

	public Camera outdoorSceneCaptureCamera;

	public Vector2Int captureSize = new Vector2Int(512, 512);

	public float spritePixelsPerUnit = 100f;

	private const string kImageExtension = ".png";

	public static DormSceneCapture Instance { get; private set; }

	public static string GetStorageDirectoryPath(string scope)
	{
		string storageDirectoryPath = DownloadStore.GetStorageDirectoryPath(DownloadStore.StorageRegion.Persistent, "DormSceneCapture");
		if (!Directory.Exists(storageDirectoryPath))
		{
			Directory.CreateDirectory(storageDirectoryPath);
		}
		storageDirectoryPath = Path.Combine(storageDirectoryPath, scope);
		if (!Directory.Exists(storageDirectoryPath))
		{
			Directory.CreateDirectory(storageDirectoryPath);
		}
		return storageDirectoryPath;
	}

	private void Awake()
	{
		Instance = this;
	}

	private void OnDestroy()
	{
		if (Instance == this)
		{
			Instance = null;
		}
	}

	public bool CaptureImage(string scope, string imageFileName, bool useOutdoorSceneCamera)
	{
		Camera camera = (useOutdoorSceneCamera ? outdoorSceneCaptureCamera : indoorSceneCaptureCamera);
		RenderTexture renderTexture = new RenderTexture(captureSize.x, captureSize.y, 24, RenderTextureFormat.ARGB32);
		renderTexture.antiAliasing = 1;
		camera.targetTexture = renderTexture;
		camera.allowHDR = false;
		RenderTexture.active = renderTexture;
		camera.Render();
		Texture2D texture2D = new Texture2D(captureSize.x, captureSize.y, TextureFormat.RGBA32, mipChain: false);
		texture2D.ReadPixels(new Rect(0f, 0f, captureSize.x, captureSize.y), 0, 0);
		Color32[] pixels = texture2D.GetPixels32();
		for (int i = 0; i < pixels.Length; i++)
		{
			pixels[i].a = byte.MaxValue;
		}
		texture2D.SetPixels32(pixels);
		texture2D.Apply();
		byte[] bytes = texture2D.EncodeToPNG();
		string text = Path.Combine(GetStorageDirectoryPath(scope), imageFileName + ".png");
		try
		{
			File.WriteAllBytes(text, bytes);
		}
		catch (Exception ex)
		{
			Debug.LogError("[DormSceneCapture] 截图 \"" + text + "\" 保存失败:" + ex.Message);
			return false;
		}
		finally
		{
			RenderTexture.active = null;
			camera.targetTexture = null;
			UnityEngine.Object.DestroyImmediate(texture2D);
			UnityEngine.Object.DestroyImmediate(renderTexture);
		}
		return true;
	}

	public Texture2D LoadCaptureImage(string scope, string imageFileName)
	{
		string text = Path.Combine(GetStorageDirectoryPath(scope), imageFileName + ".png");
		if (!File.Exists(text))
		{
			return null;
		}
		byte[] array = File.ReadAllBytes(text);
		if (array == null || array.Length == 0)
		{
			return null;
		}
		Texture2D texture2D = new Texture2D(2, 2);
		if (!texture2D.LoadImage(array, markNonReadable: true))
		{
			UnityEngine.Object.DestroyImmediate(texture2D);
			return null;
		}
		texture2D.name = imageFileName + ".png";
		Debug.Log("[DormSceneCapture] 加载截图: \"" + text + "\"");
		return texture2D;
	}

	public void ReleaseCaptureImage(Texture2D texture)
	{
		if (texture != null)
		{
			UnityEngine.Object.DestroyImmediate(texture);
			Debug.Log("[DormSceneCapture] 卸载截图: \"" + texture.name + "\"");
		}
	}

	public Sprite LoadCaptureImageSprite(string scope, string imageFileName)
	{
		Texture2D texture2D = LoadCaptureImage(scope, imageFileName);
		if (texture2D == null)
		{
			return null;
		}
		return Sprite.Create(texture2D, new Rect(0f, 0f, texture2D.width, texture2D.height), new Vector2(0.5f, 0.5f), spritePixelsPerUnit);
	}

	public void ReleaseCaptureImageSprite(Sprite sprite)
	{
		if (sprite != null)
		{
			ReleaseCaptureImage(sprite.texture);
		}
	}

	public void CleanCaptureImages(string scope, string[] keepFileNames)
	{
		string[] files = Directory.GetFiles(GetStorageDirectoryPath(scope), "*.png", SearchOption.TopDirectoryOnly);
		foreach (string path in files)
		{
			string fileNameWithoutExtension = Path.GetFileNameWithoutExtension(path);
			if (!keepFileNames.Contains(fileNameWithoutExtension))
			{
				File.Delete(path);
				Debug.Log("[DormSceneCapture] 清理过期截图: \"" + fileNameWithoutExtension + "\"");
			}
		}
	}
}
