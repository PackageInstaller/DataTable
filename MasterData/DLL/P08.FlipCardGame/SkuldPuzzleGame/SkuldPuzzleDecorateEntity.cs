using UnityEngine;
using UnityEngine.UI;

namespace SkuldPuzzleGame;

public class SkuldPuzzleDecorateEntity : MonoBehaviour
{
	public SkuldPuzzleDecorateData decorateData;

	public Sprite decorateSprite;

	[SerializeField]
	private Image decorateImage;

	private SkuldPuzzleChipBlockEntity chipEntity;

	public void InitData(SkuldPuzzleDecorateData decorateData, SkuldPuzzleChipBlockEntity parentChipEntity = null)
	{
		this.decorateData = decorateData;
		chipEntity = parentChipEntity;
		RefreshDecorateShow();
	}

	public void RefreshDecorateShow()
	{
		decorateImage.sprite = SkuldPuzzleTools.GetPuzzleSprite(decorateData.spritePath);
		decorateImage.SetNativeSize();
		RefreshLayout();
		decorateImage.transform.localEulerAngles = new Vector3(0f, 0f, decorateData.rotateValue);
	}

	public void RefreshLayout()
	{
		base.transform.localPosition = new Vector2(decorateData.x, decorateData.y);
		base.transform.localScale = decorateData.scale * Vector3.one;
	}

	public void Dispose()
	{
		if ((bool)base.gameObject)
		{
			Object.DestroyImmediate(base.gameObject);
		}
	}
}
