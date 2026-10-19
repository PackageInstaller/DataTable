using System;
using System.Collections.Generic;
using Bamboo.AssetField;
using Cysharp.Threading.Tasks;
using UnityEngine;
using UnityEngine.U2D;

namespace Bamboo.ImageCenter;

public class ImageAssetStation : AssetStation
{
	private bool _canUsed;

	private readonly HashSet<BImage> _images = new HashSet<BImage>();

	public bool IsReleased => _canUsed;

	private ImageManager manager => ImageManager.instance;

	internal ImageAssetStation(int id, AssetStation parent, AssetLoader assetAdapter)
		: base(id, parent, assetAdapter)
	{
		_canUsed = false;
	}

	public void SetToUse()
	{
		_canUsed = false;
	}

	private void SetImageHandle(BImage image, AssetLoadHandle handle)
	{
		if (image == null)
		{
			Release(handle, showError: false);
		}
		else if (!AssetLoadHandleExtensions.IsValid(handle))
		{
			ReleaseImageHandleAndClearImage(image);
			Release(handle, showError: false);
		}
		else
		{
			BindImageHandle(image, handle);
		}
	}

	private void SetImageHandle(BImage image, AssetLoadHandle handle, int sign)
	{
		if (image == null || !image.IsCurrentSign(sign) || !AssetLoadHandleExtensions.IsValid(handle))
		{
			if (image != null && image.IsCurrentSign(sign))
			{
				ReleaseImageHandleAndClearImage(image);
			}
			Release(handle, showError: false);
		}
		else
		{
			SetImageHandle(image, handle);
		}
	}

	private static void ClearImageContent(BImage image)
	{
		if (image != null)
		{
			if ((bool)image.icon)
			{
				image.icon.sprite = null;
			}
			if ((bool)image.rawIcon)
			{
				image.rawIcon.texture = null;
			}
		}
	}

	private void ReleaseImageHandleAndClearImage(BImage image)
	{
		ReleaseImageHandle(image, showError: false);
		ClearImageContent(image);
	}

	public void LoadImage(int configId, int id, BImage image)
	{
		if (image != null)
		{
			if (manager.TryGetImageData(configId, id, out var config, out var imageData))
			{
				SetImageHandle(image, LoadResource(config, imageData, id, configId, id, image));
			}
			else
			{
				ReleaseImageHandleAndClearImage(image);
			}
		}
	}

	[Obsolete("Deprecated atlas compatibility API. Prefer ImageConfig + LoadImage or LoadItemIcon with BImage.")]
	public void LoadSprite(AssetID atlasKey, int spriteId, BImage image)
	{
		if (image != null)
		{
			int getSign = image.GetSign;
			SetImageHandle(image, LoadAtlasSpriteResource(atlasKey, spriteId, spriteId, image, getSign));
		}
	}

	[Obsolete("Deprecated atlas compatibility API. Prefer ImageConfig + LoadImage or LoadItemIcon with BImage.")]
	public void LoadSprite(AssetID atlasKey, int spriteId, int defaultSpriteId, BImage image)
	{
		if (image != null)
		{
			int getSign = image.GetSign;
			SetImageHandle(image, LoadAtlasSpriteResource(atlasKey, spriteId, defaultSpriteId, image, getSign));
		}
	}

	public void LoadImage(int configId, int id, int defultId, BImage image)
	{
		if (image != null)
		{
			if (manager.TryGetImageData(configId, id, out var config, out var imageData))
			{
				SetImageHandle(image, LoadResource(config, imageData, id, configId, id, image));
			}
			else if (manager.TryGetImageData(configId, defultId, out config, out imageData))
			{
				SetImageHandle(image, LoadResource(config, imageData, defultId, configId, id, image));
			}
			else
			{
				ReleaseImageHandleAndClearImage(image);
			}
		}
	}

	public void LoadImageAsync(int configId, int id, BImage image, Action action = null)
	{
		if (image == null)
		{
			return;
		}
		if (manager.TryGetImageData(configId, id, out var config, out var imageData))
		{
			int index = image.GetSign;
			if (CanUseSpriteAtlas(config, image.isRawImage))
			{
				SetImageHandle(image, LoadAsync<SpriteAtlas>(config.spriteAtlasKey, (AssetLoadHandle x) =>
				{
					Sprite sprite = (Sprite)(x.Result = GetSpriteFromAtlas(x.As<SpriteAtlas>(), id));
					image.LoadImage(sprite, index, configId, id, action);
				}));
			}
			else if (image.isRawImage)
			{
				SetImageHandle(image, LoadAsync<Texture>(imageData.key, (AssetLoadHandle x) =>
				{
					image.LoadImage(x.As<Texture>(), index, configId, id, action);
				}));
			}
			else
			{
				SetImageHandle(image, LoadAsync<Sprite>(imageData.key, (AssetLoadHandle x) =>
				{
					image.LoadImage(x.As<Sprite>(), index, configId, id, action);
				}));
			}
		}
		else
		{
			ReleaseImageHandleAndClearImage(image);
		}
	}

	public async UniTask LoadImageAsync(int configId, int id, BImage image)
	{
		if (image == null)
		{
			return;
		}
		if (manager.TryGetImageData(configId, id, out var config, out var imageData))
		{
			int index = image.GetSign;
			AssetLoadHandle icon;
			if (CanUseSpriteAtlas(config, image.isRawImage))
			{
				icon = LoadAsync<SpriteAtlas>(config.spriteAtlasKey);
				await icon;
				if (!icon.IsValid || !image.IsCurrentSign(index))
				{
					if (image.IsCurrentSign(index))
					{
						ReleaseImageHandleAndClearImage(image);
					}
					Release(icon, showError: false);
				}
				else
				{
					Sprite sprite = (Sprite)(icon.Result = GetSpriteFromAtlas(icon.As<SpriteAtlas>(), id));
					image.LoadImage(sprite, index, configId, id);
					SetImageHandle(image, icon, index);
				}
				return;
			}
			if (image.isRawImage)
			{
				icon = LoadAsync<Texture>(imageData.key);
				await icon;
				if (!icon.IsValid || !image.IsCurrentSign(index))
				{
					if (image.IsCurrentSign(index))
					{
						ReleaseImageHandleAndClearImage(image);
					}
					Release(icon, showError: false);
				}
				else
				{
					image.LoadImage(icon.As<Texture>(), index, configId, id);
					SetImageHandle(image, icon, index);
				}
				return;
			}
			icon = LoadAsync<Sprite>(imageData.key);
			await icon;
			if (!icon.IsValid || !image.IsCurrentSign(index))
			{
				if (image.IsCurrentSign(index))
				{
					ReleaseImageHandleAndClearImage(image);
				}
				Release(icon, showError: false);
			}
			else
			{
				image.LoadImage(icon.As<Sprite>(), index, configId, id);
				SetImageHandle(image, icon, index);
			}
		}
		else
		{
			ReleaseImageHandleAndClearImage(image);
		}
	}

	[Obsolete("Deprecated atlas compatibility API. Prefer ImageConfig + LoadImageAsync or LoadItemIconAsync with BImage.")]
	public async UniTask LoadSpriteAsync(AssetID atlasKey, int spriteId, BImage image)
	{
		if (image != null)
		{
			int index = image.GetSign;
			SetImageHandle(image, await LoadAtlasSpriteResourceAsync(atlasKey, spriteId, spriteId, image, index), index);
		}
	}

	[Obsolete("Deprecated atlas compatibility API. Prefer ImageConfig + LoadImageAsync or LoadItemIconAsync with BImage.")]
	public async UniTask LoadSpriteAsync(AssetID atlasKey, int spriteId, int defaultSpriteId, BImage image)
	{
		if (image != null)
		{
			int index = image.GetSign;
			SetImageHandle(image, await LoadAtlasSpriteResourceAsync(atlasKey, spriteId, defaultSpriteId, image, index), index);
		}
	}

	[Obsolete("Deprecated atlas compatibility API. Prefer ImageConfig + LoadImageAsync with BImage.")]
	public async UniTask LoadSpriteByIndexAsync(AssetID atlasKey, int index, BImage image)
	{
		if (image != null)
		{
			int sign = image.GetSign;
			SetImageHandle(image, await LoadAtlasSpriteResourceByIndexAsync(atlasKey, index, image, sign), sign);
		}
	}

	[Obsolete("Deprecated atlas compatibility API. Prefer station-owned BImage loading through ImageConfig.")]
	public async UniTask<Sprite> LoadSpriteAsync(AssetID atlasKey, int spriteId)
	{
		AssetLoadHandle handle = LoadAsync<SpriteAtlas>(atlasKey);
		await handle;
		if (!handle.IsValid)
		{
			return null;
		}
		return (Sprite)(handle.Result = GetSpriteFromAtlas(handle.As<SpriteAtlas>(), spriteId));
	}

	public void UnloadImageAsync(BImage image)
	{
		ReleaseImageHandle(image);
	}

	public void UnloadImage(BImage image, bool releaseSprite = false, Sprite defaultSprite = null)
	{
		if (image != null)
		{
			UnloadImageAsync(image);
			if (releaseSprite && (bool)image.icon)
			{
				image.icon.sprite = defaultSprite;
			}
		}
	}

	[Obsolete("Deprecated atlas compatibility API. Prefer BImage.UnLoad or ImageAssetStation station release.")]
	public void UnloadSprite(AssetID atlasKey)
	{
		if (atlasKey != null && atlasKey.IsValid())
		{
			Release(atlasKey.GUID, showError: false);
		}
	}

	public void ReleaseStation()
	{
		UnloadAll();
		foreach (BImage item in new List<BImage>(_images))
		{
			UnbindImageHandle(item);
		}
		_images.Clear();
		_canUsed = true;
	}

	private void BindImageHandle(BImage image, AssetLoadHandle handle)
	{
		ReleaseImageHandle(image, showError: false);
		image._station = this;
		image._handle = handle;
		_images.Add(image);
	}

	private void ReleaseImageHandle(BImage image, bool showError = true)
	{
		AssetLoadHandle handle = UnbindImageHandle(image, out var station);
		if (AssetLoadHandleExtensions.IsValid(handle))
		{
			(station ?? this).Release(handle, showError);
		}
	}

	private AssetLoadHandle UnbindImageHandle(BImage image)
	{
		ImageAssetStation station;
		return UnbindImageHandle(image, out station);
	}

	private AssetLoadHandle UnbindImageHandle(BImage image, out ImageAssetStation station)
	{
		station = null;
		if (image == null)
		{
			return default;
		}
		AssetLoadHandle handle = image._handle;
		station = image._station;
		if (station != null)
		{
			station._images.Remove(image);
		}
		image._handle = default;
		image._station = null;
		return handle;
	}

	private AssetLoadHandle LoadResource(ImageConfig config, ImageData imageData, int spriteId, int configId, int id, BImage image)
	{
		AssetLoadHandle assetLoadHandle = default;
		int getSign = image.GetSign;
		if (CanUseSpriteAtlas(config, image.isRawImage))
		{
			assetLoadHandle = Load<SpriteAtlas>(config.spriteAtlasKey);
			Sprite sprite = (Sprite)(assetLoadHandle.Result = GetSpriteFromAtlas(assetLoadHandle.As<SpriteAtlas>(), spriteId));
			image.LoadImage(sprite, getSign, configId, id);
		}
		else if (image.isRawImage)
		{
			assetLoadHandle = Load<Texture>(imageData.key);
			image.LoadImage(assetLoadHandle.As<Texture>(), getSign, configId, id);
		}
		else
		{
			assetLoadHandle = Load<Sprite>(imageData.key);
			image.LoadImage(assetLoadHandle.As<Sprite>(), getSign, configId, id);
		}
		return assetLoadHandle;
	}

	public AssetLoadHandle LoadResource(int configId, int id, bool isRawImage)
	{
		AssetLoadHandle result = default;
		if (manager.TryGetImageData(configId, id, out var config, out var imageData))
		{
			if (!CanUseSpriteAtlas(config, isRawImage))
			{
				result = ((!isRawImage) ? Load<Sprite>(imageData.key) : Load<Texture>(imageData.key));
			}
			else
			{
				result = Load<SpriteAtlas>(config.spriteAtlasKey);
				result.Result = GetSpriteFromAtlas(result.As<SpriteAtlas>(), id);
			}
		}
		return result;
	}

	private AssetLoadHandle LoadAtlasSpriteResource(AssetID atlasKey, int spriteId, int defaultSpriteId, BImage image, int sign)
	{
		AssetLoadHandle result = Load<SpriteAtlas>(atlasKey);
		if (!result.IsValid)
		{
			return result;
		}
		Sprite spriteFromAtlas = GetSpriteFromAtlas(result.As<SpriteAtlas>(), spriteId);
		if (spriteFromAtlas == null && spriteId != defaultSpriteId)
		{
			spriteFromAtlas = GetSpriteFromAtlas(result.As<SpriteAtlas>(), defaultSpriteId);
		}
		result.Result = spriteFromAtlas;
		image.LoadImage(spriteFromAtlas, sign, 0, spriteId);
		return result;
	}

	private async UniTask<AssetLoadHandle> LoadAtlasSpriteResourceAsync(AssetID atlasKey, int spriteId, int defaultSpriteId, BImage image, int sign)
	{
		AssetLoadHandle handle = LoadAsync<SpriteAtlas>(atlasKey);
		await handle;
		if (!handle.IsValid)
		{
			return handle;
		}
		Sprite spriteFromAtlas = GetSpriteFromAtlas(handle.As<SpriteAtlas>(), spriteId);
		if (spriteFromAtlas == null && spriteId != defaultSpriteId)
		{
			spriteFromAtlas = GetSpriteFromAtlas(handle.As<SpriteAtlas>(), defaultSpriteId);
		}
		handle.Result = spriteFromAtlas;
		image.LoadImage(spriteFromAtlas, sign, 0, spriteId);
		return handle;
	}

	private async UniTask<AssetLoadHandle> LoadAtlasSpriteResourceByIndexAsync(AssetID atlasKey, int index, BImage image, int sign)
	{
		AssetLoadHandle handle = LoadAsync<SpriteAtlas>(atlasKey);
		await handle;
		if (!handle.IsValid)
		{
			return handle;
		}
		SpriteAtlas spriteAtlas = handle.As<SpriteAtlas>();
		Sprite sprite = null;
		if (spriteAtlas != null && index >= 0 && index < spriteAtlas.spriteCount)
		{
			Sprite[] array = new Sprite[spriteAtlas.spriteCount];
			spriteAtlas.GetSprites(array);
			sprite = array[index];
		}
		handle.Result = sprite;
		image.LoadImage(sprite, sign, 0, index);
		return handle;
	}

	private static bool CanUseSpriteAtlas(ImageConfig config, bool isRawImage)
	{
		if (!isRawImage && config != null && config.useSpriteAtlas)
		{
			return !string.IsNullOrEmpty(config.spriteAtlasKey);
		}
		return false;
	}

	private static Sprite GetSpriteFromAtlas(SpriteAtlas atlas, int spriteId)
	{
		if (!(atlas != null))
		{
			return null;
		}
		return atlas.GetSprite(spriteId.ToString());
	}
}
