using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using LuaInterface;
using UnityEngine;
using UnityEngine.Events;

public class BulletinBoardMgr : MonoBehaviour
{
	private static BulletinBoardMgr _inst;

	private string _cacheFilePath;

	private Dictionary<string, PicLoader> _loaderDic;

	public static BulletinBoardMgr inst => _inst;

	private void Awake()
	{
		if (_inst == null)
		{
			_inst = this;
			_cacheFilePath = Path.Combine(Application.persistentDataPath, "imgCache");
			if (!Directory.Exists(_cacheFilePath))
			{
				Directory.CreateDirectory(_cacheFilePath);
			}
			Debugger.Log("cache file: " + _cacheFilePath);
			_loaderDic = new Dictionary<string, PicLoader>();
		}
	}

	public void ClearCache(string[] folderNameList)
	{
		string[] directories = Directory.GetDirectories(_cacheFilePath);
		foreach (string text in directories)
		{
			string fileName = Path.GetFileName(text);
			bool flag = true;
			int j = 0;
			for (int num = folderNameList.Length; j < num; j++)
			{
				if (fileName == folderNameList[j])
				{
					flag = false;
				}
			}
			if (flag)
			{
				Directory.Delete(text, recursive: true);
				Debugger.Log("clear cache file: " + text);
			}
		}
	}

	public void GetSprite(string folderName, string url, UnityAction<Sprite> callBack)
	{
		string text = Path.Combine(_cacheFilePath, folderName);
		string fileName = GetFileName(url);
		string text2 = Path.Combine(text, fileName);
		if (File.Exists(text2))
		{
			byte[] data = File.ReadAllBytes(text2);
			Texture2D texture2D = new Texture2D(8, 8);
			texture2D.LoadImage(data);
			Sprite sprite = Sprite.Create(texture2D, new Rect(0f, 0f, texture2D.width, texture2D.height), Vector2.zero, 100f);
			sprite.name = url;
			callBack(sprite);
		}
		else
		{
			if (!Directory.Exists(folderName))
			{
				Directory.CreateDirectory(text);
			}
			StartCoroutine(LoadSprite(text2, url, callBack));
		}
	}

	public void GetFocalSpriteCustom(string filePath, UnityAction<Sprite> callBack)
	{
		if (File.Exists(filePath))
		{
			byte[] data = File.ReadAllBytes(filePath);
			Texture2D texture2D = new Texture2D(8, 8);
			texture2D.LoadImage(data);
			Sprite arg = Sprite.Create(texture2D, new Rect(0f, 0f, texture2D.width, texture2D.height), Vector2.zero, 100f);
			callBack(arg);
		}
	}

	private IEnumerator LoadSprite(string filePath, string url, UnityAction<Sprite> callBack)
	{
		PicLoader loader = new PicLoader(url);
		_loaderDic[url] = loader;
		while (true)
		{
			if (loader.IsDispose)
			{
				yield break;
			}
			if (loader.IsDown)
			{
				break;
			}
			yield return new WaitForSeconds(0.1f);
		}
		try
		{
			File.WriteAllBytes(filePath, loader.www.bytes);
		}
		catch (Exception ex)
		{
			Debugger.Log("[ERROR] write " + filePath + " failed \n" + ex.StackTrace);
			if (File.Exists(filePath))
			{
				File.Delete(filePath);
			}
			callBack(null);
			yield break;
		}
		if (!string.IsNullOrEmpty(loader.www.error))
		{
			Debugger.Log("[ERROR] download error url : " + url);
			if (File.Exists(filePath))
			{
				File.Delete(filePath);
			}
			callBack(null);
		}
		else
		{
			Sprite sprite = Sprite.Create(loader.www.texture, new Rect(0f, 0f, loader.www.texture.width, loader.www.texture.height), Vector2.zero, 100f);
			sprite.name = url;
			callBack(sprite);
			loader.Destroy();
			_loaderDic.Remove(url);
		}
	}

	public void StopLoader(string url)
	{
		if (_loaderDic.ContainsKey(url))
		{
			_loaderDic[url].Destroy();
			_loaderDic.Remove(url);
		}
	}

	private string GetFileName(string url)
	{
		return Path.GetFileName(url).Split(new char[1] { '?' })[0];
	}

	private string GetCacheFolderName(string noticeKey, string version)
	{
		return "notice_" + noticeKey + "_" + version;
	}
}
