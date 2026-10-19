using System.Collections.Generic;
using Bamboo.AssetField;
using UnityEngine;
using UnityEngine.U2D;

public struct UIAtlas
{
	public SpriteAtlas Atlas;

	public AssetLoadHandle AtlasHanle;

	public List<int> sprites;

	public Sprite[] allSprites;

	public int RefCount;

	public bool isLoaded;
}
