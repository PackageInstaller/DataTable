using ACT.Event;
using ACT.Model;
using Bamboo.ECS;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class EnergyBar12701 : EnergyBar
{
	[SerializeField]
	private BetterAnimation _betterAnimation;

	[SerializeField]
	private Image _addImage;

	[SerializeField]
	private Image _removeImage;

	private readonly string _showAnimationName = "Show";

	private readonly string _hideAnimationName = "Hide";

	private readonly string _enterAnimationName = "Enter";

	private readonly string _emptyAnimationName = "Empty";

	private float _valuePercent;

	public override void Init(EnergyBarData energyBarData, CustomUITransform transform, Entity entity)
	{
		base.Init(energyBarData, transform, entity);
		Image addImage = _addImage;
		float fillAmount = (_removeImage.fillAmount = 0f);
		addImage.fillAmount = fillAmount;
		UpdateEnergy(entity.GetCompAbility().CurNormalEnergyPercent);
		RefreshDisplay(entity);
	}

	public override void RefreshDisplay(Entity eb)
	{
		if (Model<EnergyBar12701Model>.Interface.Reduce)
		{
			_betterAnimation.GetSequence(_enterAnimationName).Play();
		}
		else
		{
			_betterAnimation.GetSequence(_emptyAnimationName).Play();
		}
	}

	private void UpdateEnergy(float newVal)
	{
		float num = Mathf.Clamp01(newVal);
		if (!Mathf.Approximately(_valuePercent, num))
		{
			if (_valuePercent < 1f && Mathf.Approximately(num, 1f))
			{
				_betterAnimation.GetSequence(_showAnimationName).Play();
				Model<EnergyBar12701Model>.Interface.SetReduceState(reduce: true);
			}
			if (_valuePercent > 0f && Mathf.Approximately(num, 0f))
			{
				_betterAnimation.GetSequence(_hideAnimationName).Play();
				Model<EnergyBar12701Model>.Interface.SetReduceState(reduce: false);
			}
			_valuePercent = num;
			Image removeImage = _removeImage;
			float fillAmount = (_addImage.fillAmount = _valuePercent);
			removeImage.fillAmount = fillAmount;
		}
	}

	public override void OnEnergyValChange(CharacterNormalEnergyChangeEvt characterUltraEnergyUpdateEvt)
	{
		UpdateEnergy(characterUltraEnergyUpdateEvt.percent);
	}
}
