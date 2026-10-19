using Bamboo.ImageCenter;
using UnityEngine;

namespace ACT.UI;

public abstract class MiniMapNormalIcon : MiniMapIcon
{
	public BImage normalAtlasImage;

	public override void SetIsTrack(bool isTrack)
	{
		base.SetIsTrack(isTrack);
		normalAtlasImage.icon.maskable = !isTrack;
	}

	protected void UpdateImageScale()
	{
		normalAtlasImage.icon.transform.localScale = Vector3.one * GameLoader.meta.mapConfig.GetMapIconScale(type);
	}
}
