using UnityEngine;
using ZumaGame;

public class ZumaTrackHideEntity : MonoBehaviour
{
	public SpriteRenderer imgSprite;

	public ZumaHideData zumaHideData;

	public void Init(ZumaHideData zumaHideData)
	{
		this.zumaHideData = zumaHideData;
		base.transform.position = zumaHideData.imgPos;
		imgSprite.sprite = AtlasManager.GetSpriteWithoutAtlas(PathConst.mapImgPath + zumaHideData.imgName);
		imgSprite.transform.eulerAngles = zumaHideData.imgAngle;
	}

	public bool CheckIsInRange(float progress)
	{
		if (progress >= zumaHideData.beginProcess && progress <= zumaHideData.endProcess)
		{
			return true;
		}
		return false;
	}

	public void Dispose()
	{
		if ((bool)base.gameObject)
		{
			Object.DestroyImmediate(base.gameObject);
		}
	}
}
