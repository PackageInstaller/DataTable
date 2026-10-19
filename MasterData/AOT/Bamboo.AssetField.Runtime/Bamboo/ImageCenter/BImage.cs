using System;
using Bamboo.AssetField;
using UnityEngine;
using UnityEngine.UI;

namespace Bamboo.ImageCenter;

[Serializable]
public class BImage
{
	internal AssetLoadHandle _handle;

	internal ImageAssetStation _station;

	public bool isRawImage;

	public RawImage rawIcon;

	public Image icon;

	private int _configId;

	private int _id;

	private int _sign;

	public int configId => _configId;

	public int id => _id;

	public int GetSign => ++_sign;

	internal bool IsCurrentSign(int sign)
	{
		return sign == _sign;
	}

	public void UnLoad(Sprite defaultSprite)
	{
		UnLoad(releaseSprite: true, defaultSprite);
	}

	public void UnLoad(bool releaseSprite = false, Sprite defaultSprite = null)
	{
		_sign++;
		_station?.UnloadImageAsync(this);
		if (releaseSprite && (bool)icon)
		{
			icon.sprite = defaultSprite;
		}
		_station = null;
		_configId = 0;
		_id = 0;
	}

	public void LoadImage(Sprite sprite, int sign, int configId, int id, Action action = null)
	{
		if (sign == _sign)
		{
			_configId = configId;
			_id = id;
			if ((bool)icon)
			{
				icon.sprite = sprite;
			}
			action?.Invoke();
		}
	}

	public void LoadImage(Texture texture, int sign, int configId, int id, Action action = null)
	{
		if (sign == _sign)
		{
			_configId = configId;
			_id = id;
			if ((bool)rawIcon)
			{
				rawIcon.texture = texture;
			}
			action?.Invoke();
		}
	}
}
