#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections;
using System.Collections.Generic;
using System.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;
using Sirenix.Utilities;
using UnityEngine;
using UnityEngine.Networking;

namespace Ase;

public class UrlImgGroup : MonoBehaviour
{
	private Dictionary<string, Texture2D> _cacheTex = new Dictionary<string, Texture2D>();

	private List<Texture2D> _multiDownloadTex = new List<Texture2D>();

	public async Task SetSprite(UrlImage urlImage, string url)
	{
		if (urlImage.SafeIsUnityNull())
		{
			return;
		}
		urlImage.color = new Color(urlImage.color.r, urlImage.color.g, urlImage.color.b, 0f);
		Texture2D value = null;
		if (!_cacheTex.TryGetValue(url, out value))
		{
			AsyncResult<Texture2D> result = new AsyncResult<Texture2D>();
			Executors.RunOnCoroutine(DownSprite(result, url, urlImage.timeout));
			await result;
			value = result.Result;
			if (value == null)
			{
				SetAlphaShow();
				return;
			}
			if (_cacheTex.ContainsKey(url))
			{
				_multiDownloadTex.Add(value);
			}
			else
			{
				_cacheTex.Add(url, value);
			}
		}
		if (urlImage.SafeIsUnityNull())
		{
			return;
		}
		value.hideFlags = HideFlags.HideAndDontSave;
		urlImage.DestroySpriteCache();
		Sprite sprite = Sprite.Create(value, new Rect(0f, 0f, value.width, value.height), new Vector2(0.5f, 0.5f));
		sprite.hideFlags = HideFlags.HideAndDontSave;
		urlImage.SpriteCache = sprite;
		urlImage.sprite = urlImage.SpriteCache;
		if (urlImage.autoSetNativeSize)
		{
			urlImage.SetNativeSize();
		}
		if (urlImage.rectTransform != null)
		{
			if (urlImage.widthLimit > 0f && (float)value.width > urlImage.widthLimit)
			{
				urlImage.rectTransform.localScale = Vector3.one * (urlImage.widthLimit / (float)value.width);
			}
			else if (urlImage.heightLimit > 0f && (float)value.height > urlImage.heightLimit)
			{
				urlImage.rectTransform.localScale = Vector3.one * (urlImage.heightLimit / (float)value.height);
			}
		}
		SetAlphaShow();
		void SetAlphaShow()
		{
			if (!urlImage.SafeIsUnityNull())
			{
				urlImage.color = new Color(urlImage.color.r, urlImage.color.g, urlImage.color.b, 1f);
			}
		}
	}

	private IEnumerator DownSprite(IPromise<Texture2D> promise, string url, int timeout)
	{
		UnityWebRequest request = new UnityWebRequest(url);
		try
		{
			request.timeout = timeout;
			DownloadHandlerTexture texDl = (DownloadHandlerTexture)(object)(request.downloadHandler = (DownloadHandler)new DownloadHandlerTexture(true));
			yield return request.SendWebRequest();
			try
			{
				if (request.isHttpError || request.isNetworkError)
				{
					Log.Error(request.error);
					promise?.SetResult(null);
				}
				else
				{
					promise?.SetResult(texDl.texture);
				}
			}
			catch (Exception ex)
			{
				Log.Error(ex?.ToString() + ex.StackTrace);
				promise?.SetResult(null);
			}
		}
		finally
		{
			((IDisposable)request)?.Dispose();
		}
	}

	private void OnDestroy()
	{
		if (_cacheTex != null)
		{
			foreach (KeyValuePair<string, Texture2D> item in _cacheTex)
			{
				UnityEngine.Object.Destroy(item.Value);
			}
			_cacheTex.Clear();
			_cacheTex = null;
		}
		if (_multiDownloadTex == null)
		{
			return;
		}
		foreach (Texture2D item2 in _multiDownloadTex)
		{
			UnityEngine.Object.Destroy(item2);
		}
		_multiDownloadTex.Clear();
		_multiDownloadTex = null;
	}
}
