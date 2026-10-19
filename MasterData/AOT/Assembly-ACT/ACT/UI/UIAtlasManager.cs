using System.Collections.Generic;
using ACT.Core;
using Bamboo.AssetField;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using UnityEngine.U2D;

namespace ACT.UI;

public class UIAtlasManager : Singleton<UIAtlasManager>
{
	private readonly int spriteNameSuffix = "(Clone)".Length;

	public Dictionary<YooAssetReference, UIAtlas> UIAtlasDic = new Dictionary<YooAssetReference, UIAtlas>();

	private async UniTask<UIAtlas> LoadAtlas(YooAssetReference rAtlasName, bool noSync = false)
	{
		AssetLoadHandle load = AssetStationManager.BattleStation.LoadAsync<SpriteAtlas>(rAtlasName);
		await load;
		UIAtlas value = default;
		if (load.IsValid)
		{
			UIAtlasDic.TryAdd(rAtlasName, value);
			if (UIAtlasDic.TryGetValue(rAtlasName, out value))
			{
				if (value.isLoaded)
				{
					value.RefCount++;
					UIAtlasDic[rAtlasName] = value;
				}
				else
				{
					SpriteAtlas spriteAtlas = load.As<SpriteAtlas>();
					int spriteCount = spriteAtlas.spriteCount;
					Sprite[] array = new Sprite[spriteCount];
					spriteAtlas.GetSprites(array);
					List<int> list = new List<int>(spriteCount);
					Sprite[] array2 = array;
					foreach (Sprite sprite in array2)
					{
						if (int.TryParse(sprite.name.Substring(0, sprite.name.Length - spriteNameSuffix), out var result))
						{
							list.Add(result);
						}
					}
					value = new UIAtlas
					{
						Atlas = spriteAtlas,
						AtlasHanle = load,
						RefCount = 0,
						sprites = list,
						allSprites = array,
						isLoaded = true
					};
					UIAtlasDic[rAtlasName] = value;
				}
			}
			else if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"没有图集 {rAtlasName} 的key");
			}
		}
		else if (LuminApplication.LogEnabled)
		{
			Debug.Log("加载图集Add失败");
		}
		return value;
	}

	public void LoadSprite(YooAssetReference rAtlasRef, int itemId, UIAtlasImage image)
	{
		CoLoadSprite(rAtlasRef, itemId, image).Forget();
	}

	public void LoadSprite(YooAssetReference rAtlasRef, int itemId, int defualtItemId, UIAtlasImage image)
	{
		CoLoadSprite(rAtlasRef, itemId, defualtItemId, image).Forget();
	}

	public async UniTask LoadSpriteAsync(YooAssetReference rAtlasRef, int itemId, UIAtlasImage image)
	{
		await CoLoadSprite(rAtlasRef, itemId, image);
	}

	public async UniTask LoadSpriteAsync(YooAssetReference rAtlasRef, int itemId, int defualtItemId, UIAtlasImage image)
	{
		await CoLoadSprite(rAtlasRef, itemId, defualtItemId, image);
	}

	public async UniTask LoadSpriteByIndexAsync(YooAssetReference rAtlasRef, int index, UIAtlasImage image)
	{
		if (image.isLoaded && image.atlasRefAssetID != null)
		{
			if (UIAtlasDic.TryGetValue(image.atlasRefAssetID, out var value))
			{
				value.RefCount--;
			}
			image.isLoaded = false;
			image.atlasRefAssetID = null;
		}
		Sprite sprite = await CoLoadSpriteByIndex(rAtlasRef, index);
		if (sprite != null)
		{
			image.icon.sprite = sprite;
			image.isLoaded = true;
		}
	}

	public void LoadItemSprite(YooAssetReference rAtlasRef, int itemId, UIAtlasImage image)
	{
		int iconAddress = RuntimeConfigs.data.itemDatas[itemId].iconAddress;
		CoLoadSprite(rAtlasRef, iconAddress, image).Forget();
	}

	public async UniTask CoLoadSprite(YooAssetReference rAtlasRef, int itemId, UIAtlasImage image)
	{
		if (image.isLoaded && image.atlasRefAssetID != null)
		{
			if (rAtlasRef == image.atlasRefAssetID)
			{
				if (UIAtlasDic.TryGetValue(image.atlasRefAssetID, out var value))
				{
					value.RefCount--;
				}
				image.isLoaded = false;
				image.atlasRefAssetID = null;
			}
			else
			{
				image.UnLoad();
			}
		}
		if (!UIAtlasDic.TryGetValue(rAtlasRef, out var value2) || !value2.isLoaded)
		{
			value2 = await LoadAtlas(rAtlasRef);
		}
		GetLocalSprite(itemId, value2, image, rAtlasRef);
	}

	public async UniTask CoLoadSprite(YooAssetReference rAtlasRef, int itemId, int defaultItemId, UIAtlasImage image)
	{
		if (image.isLoaded && image.atlasRefAssetID != null)
		{
			if (rAtlasRef == image.atlasRefAssetID)
			{
				if (UIAtlasDic.TryGetValue(image.atlasRefAssetID, out var value))
				{
					value.RefCount--;
				}
				image.isLoaded = false;
				image.atlasRefAssetID = null;
			}
			else
			{
				image.UnLoad();
			}
		}
		if (!UIAtlasDic.TryGetValue(rAtlasRef, out var value2) || !value2.isLoaded)
		{
			value2 = await LoadAtlas(rAtlasRef);
		}
		GetLocalSprite(itemId, defaultItemId, value2, image, rAtlasRef);
	}

	public async void LoadSpriteNoWait(YooAssetReference rAtlasRef, int itemId, UIAtlasImage image)
	{
		if (image.isLoaded && image.atlasRefAssetID != null)
		{
			if (rAtlasRef == image.atlasRefAssetID)
			{
				if (UIAtlasDic.TryGetValue(image.atlasRefAssetID, out var value))
				{
					value.RefCount--;
				}
				image.isLoaded = false;
				image.atlasRefAssetID = null;
			}
			else
			{
				image.UnLoad();
			}
		}
		if (!UIAtlasDic.TryGetValue(rAtlasRef, out var value2))
		{
			value2 = await LoadAtlas(rAtlasRef, noSync: true);
		}
		GetLocalSprite(itemId, value2, image, rAtlasRef);
	}

	private void GetLocalSprite(int itemId, int defaultItemId, UIAtlas atlas, UIAtlasImage image, YooAssetReference rAtlasRef)
	{
		if (atlas.sprites.Contains(itemId))
		{
			GetLocalSprite(itemId, atlas, image, rAtlasRef);
		}
		else
		{
			GetLocalSprite(defaultItemId, atlas, image, rAtlasRef);
		}
	}

	private void GetLocalSprite(int itemId, UIAtlas atlas, UIAtlasImage image, YooAssetReference rAtlasRef)
	{
		image.RefCount++;
		atlas.RefCount++;
		image.isLoaded = true;
		image.atlasRefAssetID = rAtlasRef;
		if (atlas.sprites.Contains(itemId))
		{
			Sprite sprite = atlas.Atlas.GetSprite(itemId.ToString());
			if ((bool)image.icon)
			{
				image.icon.sprite = sprite;
			}
		}
		else if (LuminApplication.LogEnabled)
		{
			Debug.Log("当前加载图片为空，请检查图集：" + atlas.Atlas.name + "中图片名称=>>>>>>>>>" + itemId);
		}
	}

	public void UnloadSprite(YooAssetReference atlasAddress)
	{
		if (UIAtlasDic.TryGetValue(atlasAddress, out var value))
		{
			value.RefCount--;
			if (value.RefCount <= 0)
			{
				AssetStationManager.BattleStation.Release(value.AtlasHanle);
				UIAtlasDic.Remove(atlasAddress);
			}
		}
		else if (LuminApplication.LogEnabled)
		{
			Debug.LogWarning("没加载图集 为什么要卸载" + atlasAddress);
		}
	}

	public async UniTask<Sprite> LoadSpriteAsync(YooAssetReference rAtlasRef, int itemId)
	{
		return await CoLoadSprite(rAtlasRef, itemId);
	}

	public async UniTask<Sprite> LoadSpriteByIndexAsync(YooAssetReference rAtlasRef, int index)
	{
		return await CoLoadSpriteByIndex(rAtlasRef, index);
	}

	public async UniTask<Sprite> CoLoadSprite(YooAssetReference rAtlasRef, int itemId)
	{
		if (!UIAtlasDic.TryGetValue(rAtlasRef, out var value))
		{
			value = await LoadAtlas(rAtlasRef);
		}
		if (value.sprites.Contains(itemId))
		{
			Sprite sprite = value.Atlas.GetSprite(itemId.ToString());
			value.RefCount++;
			return sprite;
		}
		if (LuminApplication.LogEnabled)
		{
			Debug.Log("当前加载图片为空，请检查图集：" + value.Atlas.name + "中图片名称=>>>>>>>>>" + itemId);
		}
		return null;
	}

	public async UniTask<Sprite> CoLoadSpriteByIndex(YooAssetReference rAtlasRef, int index)
	{
		if (!UIAtlasDic.TryGetValue(rAtlasRef, out var value))
		{
			value = await LoadAtlas(rAtlasRef);
		}
		if (value.allSprites.Length > index)
		{
			value.RefCount++;
			return value.allSprites[index];
		}
		if (LuminApplication.LogEnabled)
		{
			Debug.Log("当前加载图片为空，请检查图集：" + value.Atlas.name + "第=>>>>>>>>>" + index);
		}
		return null;
	}
}
