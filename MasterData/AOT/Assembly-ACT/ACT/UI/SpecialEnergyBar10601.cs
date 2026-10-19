using ACT.Event;
using Bamboo.ECS;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class SpecialEnergyBar10601 : SpecialEnergyBar
{
	private const string AbilityName = "Role_06_01_tag_buff";

	[SerializeField]
	private Image _image;

	[SerializeField]
	private TextMeshProUGUI _stackText;

	private int _stack;

	public override void Init(SpecialEnergyBarData energyBarData, CustomUITransform transform, Entity entity)
	{
		base.Init(energyBarData, transform, entity);
		_stackText.gameObject.SetActive(value: false);
		_image.fillAmount = 0f;
	}

	public override void OnAbilityStackChange(AbilityStackChangeEvt abilityStackChangeEvt)
	{
		if (abilityStackChangeEvt.abilityName == "Role_06_01_tag_buff")
		{
			int curStack = abilityStackChangeEvt.curStack;
			if (curStack > _stack)
			{
				_image.fillAmount = 1f;
			}
			_stackText.gameObject.SetActive(curStack > 0);
			_stackText.SetText("{0:0}", abilityStackChangeEvt.curStack);
			_stack = curStack;
		}
	}

	public override void OnAbilityAdd(AbilityAddEvt abilityAddEvt)
	{
		if (abilityAddEvt.abilityName == "Role_06_01_tag_buff")
		{
			_stackText.gameObject.SetActive(value: true);
			_stackText.SetText("{0:0}", abilityAddEvt.curStack);
		}
	}

	public override void OnAbilityDurationChange(AbilityDurationChangeEvt abilityDurationChangeEvt)
	{
		if (abilityDurationChangeEvt.abilityName == "Role_06_01_tag_buff")
		{
			_image.fillAmount = abilityDurationChangeEvt.DurationPercent;
		}
	}
}
