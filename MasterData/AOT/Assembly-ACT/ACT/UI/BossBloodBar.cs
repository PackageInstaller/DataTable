using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ACT.UI;

public class BossBloodBar : UIBehaviour
{
	[SerializeReference]
	private List<Color> bloodColorConfig;

	[SerializeReference]
	private List<Color> changeColorConfig;

	[SerializeField]
	private Color lastChangeColor;

	[SerializeReference]
	private TargetValueMaskBar bloodBar;

	[SerializeReference]
	private Image curBarImage;

	[SerializeReference]
	private Image nextBarImage;

	[SerializeReference]
	private Image changeImage;

	[SerializeReference]
	private TextMeshProUGUI barNumText;

	[SerializeField]
	private BetterAnimation animation;

	[SerializeReference]
	private PercentParticle bloodParticle;

	private int _totalBarNum;

	private int _fullBarBloodVal;

	private int _lastBarBloodVal;

	private int _basicMaxHp;

	private int _basicBloodNum;

	private int _curMaxHp;

	private int _curHp;

	private bool _initialized;

	private int _curBarIndex;

	private int _characterDamageType;

	internal void SetCharacterDamageType(int characterDamageType)
	{
		_characterDamageType = characterDamageType;
	}

	internal void ApplySnapshot(BossBloodBarSnapshot snapshot, bool animateHpChange)
	{
		gameObject.SetActive(value: true);
		int num = Mathf.Max(1, snapshot.BasicMaxHp);
		int num2 = Mathf.Max(1, snapshot.CurMaxHp);
		int num3 = Mathf.Max(1, snapshot.BasicBloodNum);
		bool num4 = !_initialized || _basicMaxHp != num || _curMaxHp != num2 || _basicBloodNum != num3;
		_characterDamageType = snapshot.CharacterDamageType;
		if (animateHpChange)
		{
			animation.GetSequence("BloodMinusL").Play();
		}
		if (num4)
		{
			SetBarInfo(snapshot);
			_initialized = true;
			return;
		}
		int num5 = Mathf.Clamp(snapshot.CurHp, 0, _curMaxHp);
		if (num5 != _curHp)
		{
			RefreshBloodBar(num5, snapshot.InWeak);
			_curHp = num5;
		}
	}

	public void OnBossRemoveHatred()
	{
		_initialized = false;
		_curHp = 0;
	}

	private void SetBarInfo(BossBloodBarSnapshot snapshot)
	{
		int num = Mathf.Max(1, snapshot.BasicMaxHp);
		int num2 = Mathf.Max(1, snapshot.CurMaxHp);
		int num3 = Mathf.Max(1, snapshot.BasicBloodNum);
		_characterDamageType = snapshot.CharacterDamageType;
		_basicMaxHp = num;
		_basicBloodNum = num3;
		_curMaxHp = num2;
		_fullBarBloodVal = Mathf.CeilToInt((float)num / (float)num3);
		_totalBarNum = Mathf.CeilToInt((float)num2 / (float)_fullBarBloodVal);
		if (num2 % _fullBarBloodVal == 0)
		{
			_lastBarBloodVal = _fullBarBloodVal;
		}
		else
		{
			int num4 = _totalBarNum - 1;
			_lastBarBloodVal = num2 - num4 * _fullBarBloodVal;
		}
		_curHp = Mathf.Clamp(snapshot.CurHp, 0, _curMaxHp);
		RefreshBloodBarOnInit(_curHp);
	}

	private void RefreshBloodBarOnInit(int curHp)
	{
		if (curHp <= 0)
		{
			RefreshBloodBar(0, inWeak: false);
			return;
		}
		float num = (float)curHp / (float)_fullBarBloodVal;
		_curBarIndex = Mathf.CeilToInt(num);
		int barValByBarIndex = GetBarValByBarIndex(_curBarIndex);
		if (num % 1f == 0f)
		{
			TargetValueMaskBar targetValueMaskBar = bloodBar;
			float value = (bloodBar.TargetValue = 1f);
			targetValueMaskBar.Value = value;
		}
		else
		{
			TargetValueMaskBar targetValueMaskBar2 = bloodBar;
			float value = (bloodBar.TargetValue = num % 1f * (float)_fullBarBloodVal / (float)barValByBarIndex);
			targetValueMaskBar2.Value = value;
		}
		barNumText.SetText("x{0:0}", _curBarIndex);
		(Color, Color) barColorByBarIndex = GetBarColorByBarIndex(_curBarIndex);
		curBarImage.color = barColorByBarIndex.Item1;
		nextBarImage.color = barColorByBarIndex.Item2;
		changeImage.color = GetChangeColorByBarIndex(_curBarIndex);
	}

	private void RefreshBloodBar(int newVal, bool inWeak)
	{
		newVal = Mathf.Clamp(newVal, 0, _curMaxHp);
		if (newVal == 0)
		{
			_curBarIndex = 0;
			(Color, Color) barColorByBarIndex = GetBarColorByBarIndex(1);
			curBarImage.color = barColorByBarIndex.Item1;
			nextBarImage.color = barColorByBarIndex.Item2;
			changeImage.color = GetChangeColorByBarIndex(1);
			UpdateBarValue(0f, reset: false);
			barNumText.text = "x0";
			return;
		}
		float num = (float)newVal / (float)_fullBarBloodVal;
		int num2 = Mathf.CeilToInt(num);
		int barValByBarIndex = GetBarValByBarIndex(num2);
		if (num2 == _curBarIndex)
		{
			UpdateBarValue(GetFillValue(num, barValByBarIndex), reset: false);
		}
		else if (num2 > _curBarIndex)
		{
			_curBarIndex = num2;
			UpdateBloodBarAppearance(num2);
			UpdateBarValue(GetFillValue(num, barValByBarIndex), reset: true);
		}
		else
		{
			for (int num3 = _curBarIndex; num3 >= num2; num3--)
			{
				if (num3 == _curBarIndex)
				{
					UpdateBarValue(0f, reset: false);
				}
				else if (num3 == num2)
				{
					UpdateBarValue(GetFillValue(num, barValByBarIndex), reset: true);
					UpdateBloodBarAppearance(num3);
				}
				else
				{
					UpdateBarValue(0f, reset: true);
					UpdateBloodBarAppearance(num3);
				}
			}
			_curBarIndex = num2;
		}
		if ((_characterDamageType == 1) & inWeak)
		{
			bloodParticle.Play(leftBase: true, bloodBar.TargetValue);
		}
	}

	private void UpdateBarValue(float newVal, bool reset)
	{
		if (reset)
		{
			TargetValueMaskBar targetValueMaskBar = bloodBar;
			float value = (bloodBar.TargetValue = 1f);
			targetValueMaskBar.Value = value;
		}
		bloodBar.TargetValue = newVal;
	}

	private void UpdateBloodBarAppearance(int barIndex)
	{
		barNumText.SetText("x{0:0}", barIndex);
		(Color, Color) barColorByBarIndex = GetBarColorByBarIndex(barIndex);
		curBarImage.color = barColorByBarIndex.Item1;
		nextBarImage.color = barColorByBarIndex.Item2;
		changeImage.color = GetChangeColorByBarIndex(barIndex);
	}

	public void IgnoreDelayOnce()
	{
	}

	private int GetBarValByBarIndex(int barIndex)
	{
		if (barIndex == _totalBarNum)
		{
			return _lastBarBloodVal;
		}
		return _fullBarBloodVal;
	}

	private float GetFillValue(float barNum, int curBarVal)
	{
		if (!Mathf.Approximately(barNum % 1f, 0f))
		{
			return barNum % 1f * (float)_fullBarBloodVal / (float)curBarVal;
		}
		return 1f;
	}

	private (Color, Color) GetBarColorByBarIndex(int curBarIndex)
	{
		if (curBarIndex == 1)
		{
			List<Color> list = bloodColorConfig;
			return (list[list.Count - 1], Color.clear);
		}
		if (curBarIndex >= 2)
		{
			int num = (bloodColorConfig.Count + curBarIndex - 3) % bloodColorConfig.Count;
			int index = ((num + 1 <= bloodColorConfig.Count - 1) ? (num + 1) : (num + 1 - bloodColorConfig.Count));
			return (bloodColorConfig[index], bloodColorConfig[num]);
		}
		return (Color.clear, Color.clear);
	}

	private Color GetChangeColorByBarIndex(int curBarIndex)
	{
		if (curBarIndex == 1)
		{
			List<Color> list = changeColorConfig;
			return list[list.Count - 1];
		}
		if (curBarIndex >= 2)
		{
			int num = (changeColorConfig.Count + curBarIndex - 3) % changeColorConfig.Count;
			int index = ((num + 1 <= changeColorConfig.Count - 1) ? (num + 1) : (num + 1 - changeColorConfig.Count));
			return changeColorConfig[index];
		}
		return Color.clear;
	}
}
