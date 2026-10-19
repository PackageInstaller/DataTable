using System.Collections.Generic;
using UnityEngine;

namespace Bamboo.ImageCenter;

public class ImageConfig : ScriptableObject
{
	public bool useSpriteAtlas;

	public string spriteAtlasKey;

	public List<ImageData> imageDatas;
}
