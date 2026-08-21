using System;
using System.Collections;
using UnityEngine;

public class CutPicture : MonoBehaviour
{
	private Texture2D tex;

	private Texture2D halfTex;

	public Sprite sp;

	private int screenWidth = Screen.width;

	private int screenHeight = Screen.height;

	private Action callback;

	private void Start()
	{
		tex = new Texture2D(screenWidth, screenHeight, TextureFormat.RGB24, mipChain: true);
		halfTex = new Texture2D(screenWidth / 2, screenHeight / 2, TextureFormat.RGB24, mipChain: true);
	}

	public void StartCutPicture(Action func)
	{
		int width = Screen.width;
		int height = Screen.height;
		if (screenWidth != width || screenHeight != height)
		{
			screenWidth = width;
			screenHeight = height;
			UnityEngine.Object.DestroyImmediate(tex);
			UnityEngine.Object.DestroyImmediate(halfTex);
			tex = new Texture2D(screenWidth, screenHeight, TextureFormat.RGB24, mipChain: true);
			halfTex = new Texture2D(screenWidth / 2, screenHeight / 2, TextureFormat.RGB24, mipChain: true);
		}
		callback = func;
		StartCoroutine(cutPicture());
	}

	private IEnumerator cutPicture()
	{
		yield return new WaitForEndOfFrame();
		tex.ReadPixels(new Rect(0f, 0f, tex.width, tex.height), 0, 0);
		tex.Apply();
		sp = Sprite.Create(tex, new Rect(0f, 0f, tex.width, tex.height), Vector2.one / 2f);
		if (callback != null)
		{
			callback();
		}
	}

	public void Destroy()
	{
		UnityEngine.Object.Destroy(halfTex);
		UnityEngine.Object.Destroy(tex);
		UnityEngine.Object.Destroy(sp);
	}
}
