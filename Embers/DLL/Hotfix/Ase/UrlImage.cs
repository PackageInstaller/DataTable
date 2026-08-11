using System.Threading.Tasks;
using UnityEngine;
using UnityEngine.UI;

namespace Ase;

public class UrlImage : Image
{
	private string url = "";

	public int timeout = 5;

	public bool autoSetNativeSize = true;

	public float widthLimit = -1f;

	public float heightLimit = -1f;

	public Sprite SpriteCache;

	public UrlImgGroup group;

	public void SetGroup(UrlImgGroup imgGroup)
	{
		group = imgGroup;
	}

	public async Task<UrlImage> SetSpriteUrl(string url)
	{
		if (group == null || string.IsNullOrEmpty(url) || this.url.Equals(url))
		{
			return this;
		}
		this.url = url;
		await group.SetSprite(this, url);
		return this;
	}

	public void DestroySpriteCache()
	{
		base.sprite = null;
		if (SpriteCache != null)
		{
			Object.Destroy(SpriteCache);
		}
	}

	protected override void OnDestroy()
	{
		DestroySpriteCache();
		base.OnDestroy();
	}
}
