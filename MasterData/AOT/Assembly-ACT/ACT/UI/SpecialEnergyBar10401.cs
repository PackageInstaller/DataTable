using ACT.Battle;
using ACT.Event;
using Bamboo.ECS;
using TMPro;
using UnityEngine;

namespace ACT.UI;

public class SpecialEnergyBar10401 : SpecialEnergyBar
{
	[SerializeField]
	private TextMeshProUGUI _valueText;

	[SerializeField]
	private Bullet[] _bullets;

	private float _maxEnergy;

	private float _currentEnergy;

	private float _energyPerBullet;

	public override void Init(SpecialEnergyBarData energyBarData, CustomUITransform transform, Entity entity)
	{
		base.Init(energyBarData, transform, entity);
		CompAbility compAbility = entity.GetCompAbility();
		_maxEnergy = compAbility.MaxSpecialEnergy;
		_currentEnergy = compAbility.SpecialEnergyValue;
		_energyPerBullet = _maxEnergy / (float)_bullets.Length;
		UpdateEnergyDisplay();
	}

	public override void OnSpecialEnergyValChange(CharacterSpecialEnergyChangeEvt evt)
	{
		_currentEnergy = evt.value;
		UpdateEnergyDisplay();
	}

	private void UpdateEnergyDisplay()
	{
		if (_valueText != null)
		{
			_valueText.SetText("{0:0}", _currentEnergy);
		}
		UpdateBulletsState();
	}

	private void UpdateBulletsState()
	{
		for (int i = 0; i < _bullets.Length; i++)
		{
			UpdateBulletState(i);
		}
	}

	private void UpdateBulletState(int bulletIndex)
	{
		if (bulletIndex < _bullets.Length && _bullets[bulletIndex] != null)
		{
			Bullet bullet = _bullets[bulletIndex];
			float num = (float)bulletIndex * _energyPerBullet;
			float num2 = num + _energyPerBullet * 0.5f;
			float num3 = (float)(bulletIndex + 1) * _energyPerBullet;
			if (_currentEnergy <= num)
			{
				SetBulletVisibility(bullet, showFill: false, showFilled: false);
			}
			else if (_currentEnergy < num2)
			{
				SetBulletVisibility(bullet, showFill: false, showFilled: false);
			}
			else if (_currentEnergy < num3)
			{
				SetBulletVisibility(bullet, showFill: true, showFilled: false);
			}
			else
			{
				SetBulletVisibility(bullet, showFill: false, showFilled: true);
			}
		}
	}

	private void SetBulletVisibility(Bullet bullet, bool showFill, bool showFilled)
	{
		if (bullet.fill != null)
		{
			bullet.fill.SetActive(showFill);
		}
		if (bullet.filled != null)
		{
			bullet.filled.SetActive(showFilled);
		}
	}
}
