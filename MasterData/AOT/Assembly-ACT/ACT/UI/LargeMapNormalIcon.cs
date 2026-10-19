using ACT.Config;
using ACT.Core;
using Bamboo.ImageCenter;
using DG.Tweening;
using UnityEngine;

namespace ACT.UI;

public class LargeMapNormalIcon : LargeMapIcon
{
	public BImage normalAtlasImage;

	public RectTransform accurateSelectCircle;

	private float _fixedScale;

	private bool _forbidShow;

	public void SetFixedScale(float fixedScale)
	{
		_fixedScale = fixedScale;
	}

	public void SetForbidShow(bool forbidShow)
	{
		_forbidShow = forbidShow;
	}

	public override void UpdateScale(float mapScale)
	{
		SetScale(_fixedScale / mapScale);
		MapIconData data = CoreUtils.GetData((int)type, RuntimeConfigs.data.mapIconDatas);
		if (data != null && data.scaleType == 2)
		{
			SetIsFade(mapScale <= 0.33f);
		}
	}

	public override void SetIsFade(bool fade)
	{
		base.SetIsFade(fade);
		if (_forbidShow)
		{
			transform.gameObject.SetActive(value: false);
		}
		else
		{
			transform.gameObject.SetActive(!fade);
		}
	}

	public override void AccurateSelectEffect()
	{
		base.AccurateSelectEffect();
		accurateSelectCircle.DOScale(Vector3.one, 0.1f).OnPlay(() =>
		{
			accurateSelectCircle.gameObject.SetActive(value: true);
		}).ChangeStartValue(Vector3.zero)
			.SetEase(Ease.InOutBack);
	}

	public override void DeAccurateSelectEffect()
	{
		base.DeAccurateSelectEffect();
		accurateSelectCircle.gameObject.SetActive(value: false);
		accurateSelectCircle.localScale = Vector3.one;
	}

	public override void VagueSelectEffect()
	{
		base.VagueSelectEffect();
		accurateSelectCircle.DOScale(Vector3.one * 1.5f, 0.1f).OnPlay(() =>
		{
			accurateSelectCircle.gameObject.SetActive(value: true);
		}).ChangeStartValue(Vector3.zero)
			.SetEase(Ease.InOutBack);
	}

	public override void DeVagueSelectEffect()
	{
		base.DeVagueSelectEffect();
		accurateSelectCircle.gameObject.SetActive(value: false);
		accurateSelectCircle.localScale = Vector3.one;
	}

	protected void UpdateImageScale()
	{
		normalAtlasImage.icon.transform.localScale = Vector3.one * GameLoader.meta.mapConfig.GetMapIconScale(type);
	}
}
