using ACT.Core;
using ACT.Utility;
using Bamboo.ImageCenter;
using Bamboo.NumberString;
using TMPro;
using UnityEngine;

namespace ACT.UI;

public class PickUpCoinItem : BaseUIComponent
{
	public CanvasGroup canvasGroup;

	public TextMeshProUGUI coinNum;

	public BetterAnimation anim;

	public BImage itemIcon;

	private float _coinStartRemainTime;

	private int _coinDisplayCount;

	public float _coinRemainTime;

	private bool _remainFinish = true;

	private bool _isHiding;

	public bool remainFinish => _remainFinish;

	public void RefreshData(int addCount)
	{
		_coinDisplayCount += addCount;
		_coinStartRemainTime = Time.unscaledTime;
		canvasGroup.alpha = 0f;
		_remainFinish = false;
		_isHiding = false;
	}

	public void RefreshDisplay(ItemAchieveinfo itemData, ImageAssetStation station)
	{
		if (!gameObject.activeInHierarchy)
		{
			gameObject.SetActive(value: true);
		}
		if (!canvasGroup.alpha.Equals(1f))
		{
			int num = CoreUtils.GetData(itemData.itemId, RuntimeConfigs.data.itemDatas)?.iconAddress ?? (-1);
			if (num == -1 && LuminApplication.LogEnabled)
			{
				Debug.LogError($"道具id为{itemData.itemId}表数据找不到");
			}
			station?.LoadItemIcon(num, itemIcon);
			anim?.StopAnimation();
			anim?.GetSequence("GoldShow").OnComplete((AnimationBuilder _) =>
			{
				canvasGroup.alpha = 1f;
			}).Play();
		}
		coinNum.SetText(_coinDisplayCount.FastToString());
	}

	private void Update()
	{
		if (!_remainFinish && Time.unscaledTime > _coinStartRemainTime + _coinRemainTime && !_isHiding)
		{
			Hide();
		}
	}

	private void Hide()
	{
		_isHiding = true;
		_coinDisplayCount = 0;
		anim?.GetSequence("GoldHide").OnComplete((AnimationBuilder _) =>
		{
			_remainFinish = true;
			canvasGroup.alpha = 0f;
		}).Play();
	}

	public void ClearData()
	{
		_coinDisplayCount = 0;
		canvasGroup.alpha = 0f;
		_remainFinish = true;
		_isHiding = false;
	}
}
