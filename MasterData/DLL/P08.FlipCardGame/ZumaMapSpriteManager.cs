using UnityEngine;

public class ZumaMapSpriteManager : MonoBehaviour
{
	public string mapImgPath = "TextureConfig/VersionUI/CORGUI_3_11/SandPlay_3_11/SandPlay_3_11_Zuma/";

	public Sprite GetMapBgSprite(int difficult)
	{
		return AtlasManager.GetSpriteWithoutAtlas(mapImgPath + "SandPlay_Com_BG_" + difficult);
	}

	public Sprite GetMapBgSpriteRight(int difficult)
	{
		return AtlasManager.GetSpriteWithoutAtlas(mapImgPath + "SandPlay_Com_BG_" + difficult + "_R");
	}

	public Sprite GetMapBgSpriteLeft(int difficult)
	{
		return AtlasManager.GetSpriteWithoutAtlas(mapImgPath + "SandPlay_Com_BG_" + difficult + "_L");
	}

	public Sprite GetMapBgSpriteBottom(int difficult)
	{
		return AtlasManager.GetSpriteWithoutAtlas(mapImgPath + "SandPlay_Com_BG_" + difficult + "_D");
	}

	public Sprite GetShootFootBgSprite(int difficult)
	{
		return AtlasManager.GetSpriteWithoutAtlas(mapImgPath + "SandPlay_Com_hero_foot_" + difficult);
	}

	public Sprite GetRouteSprite(string mapName)
	{
		return AtlasManager.GetSpriteWithoutAtlas(mapImgPath + mapName);
	}

	public Sprite GetHideSprite(string hideName)
	{
		return AtlasManager.GetSpriteWithoutAtlas(mapImgPath + hideName);
	}
}
