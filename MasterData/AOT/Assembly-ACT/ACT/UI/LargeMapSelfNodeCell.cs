using Bamboo.ImageCenter;
using UnityEngine;
using UnityEngine.Events;

namespace ACT.UI;

public class LargeMapSelfNodeCell : MonoBehaviour
{
	public BImage iconImage;

	public GameObject selected;

	public ActButton btn;

	private int _iconTypeId;

	private ImageAssetStation _imageAssetStation;

	public int IconTypeId => _iconTypeId;

	public void Init(int iconTypeId, ImageAssetStation imageAssetStation)
	{
		_iconTypeId = iconTypeId;
		selected.gameObject.SetActive(value: false);
		_imageAssetStation = imageAssetStation;
		_imageAssetStation?.LoadImage(181, iconTypeId, iconImage);
	}

	public void SetSelected(bool select)
	{
		selected.gameObject.SetActive(select);
	}

	public void BindClick(UnityAction action)
	{
		btn.OnClick.RemoveAllListeners();
		btn.OnClick.AddListener(action);
	}

	public void OnDestroy()
	{
		btn?.OnClick.RemoveAllListeners();
	}
}
