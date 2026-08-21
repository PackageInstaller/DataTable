using System;
using System.IO;
using UnityEngine;

public class ScreenSnap
{
	private int _width;

	private int _height;

	private TextureFormat _format;

	private Texture2D _tex;

	public Sprite _sp;

	private static string lastPath = string.Empty;

	public ScreenSnap(int width, int height, TextureFormat format = TextureFormat.RGB24)
	{
		_width = width;
		_height = height;
		_format = format;
		_tex = new Texture2D(_width, _height, _format, mipChain: true);
	}

	public void Take()
	{
		Debug.Log($"tex[w={_tex.width}, h={_tex.height}], screen[w={Screen.width}, h={Screen.height}], rt[w={(RenderTexture.active ? RenderTexture.active.width : (-1))}, h={(RenderTexture.active ? RenderTexture.active.height : (-1))}]");
		_tex.ReadPixels(new Rect(0f, 0f, _width, _height), 0, 0);
		_tex.Apply();
		_sp = Sprite.Create(_tex, new Rect(0f, 0f, _width, _height), Vector2.one / 2f, 100f, 1u, SpriteMeshType.FullRect);
	}

	public bool SaveSnap(string savePath)
	{
		bool result = true;
		try
		{
			if (!string.IsNullOrEmpty(lastPath))
			{
				string directoryName = Path.GetDirectoryName(lastPath);
				if (Directory.Exists(directoryName))
				{
					Directory.Delete(directoryName, recursive: true);
				}
			}
			lastPath = savePath;
			string directoryName2 = Path.GetDirectoryName(savePath);
			if (!Directory.Exists(directoryName2))
			{
				Directory.CreateDirectory(directoryName2);
			}
			byte[] bytes = _tex.EncodeToJPG();
			File.WriteAllBytes(savePath, bytes);
		}
		catch (Exception ex)
		{
			Debug.LogError(ex.ToString());
			result = false;
		}
		return result;
	}

	public static bool SaveTexture(string savePath, Texture2D texture)
	{
		bool result = true;
		try
		{
			if (!string.IsNullOrEmpty(lastPath))
			{
				string directoryName = Path.GetDirectoryName(lastPath);
				if (Directory.Exists(directoryName))
				{
					Directory.Delete(directoryName, recursive: true);
				}
			}
			lastPath = savePath;
			string directoryName2 = Path.GetDirectoryName(savePath);
			if (!Directory.Exists(directoryName2))
			{
				Directory.CreateDirectory(directoryName2);
			}
			byte[] bytes = texture.EncodeToJPG();
			File.WriteAllBytes(savePath, bytes);
		}
		catch (Exception ex)
		{
			Debug.LogError(ex.ToString());
			result = false;
		}
		return result;
	}

	public static bool SaveRenderTexture(string savePath, RenderTexture texture)
	{
		bool result = true;
		try
		{
			if (!string.IsNullOrEmpty(lastPath))
			{
				string directoryName = Path.GetDirectoryName(lastPath);
				if (Directory.Exists(directoryName))
				{
					Directory.Delete(directoryName, recursive: true);
				}
			}
			lastPath = savePath;
			string directoryName2 = Path.GetDirectoryName(savePath);
			if (!Directory.Exists(directoryName2))
			{
				Directory.CreateDirectory(directoryName2);
			}
			RenderTexture active = RenderTexture.active;
			RenderTexture.active = texture;
			Texture2D texture2D = new Texture2D(texture.width, texture.height);
			texture2D.ReadPixels(new Rect(0f, 0f, texture.width, texture.height), 0, 0);
			texture2D.Apply();
			RenderTexture.active = active;
			byte[] bytes = texture2D.EncodeToJPG();
			File.WriteAllBytes(savePath, bytes);
		}
		catch (Exception ex)
		{
			Debug.LogError(ex.ToString());
			result = false;
		}
		return result;
	}

	public Sprite GetSprite()
	{
		return _sp;
	}
}
