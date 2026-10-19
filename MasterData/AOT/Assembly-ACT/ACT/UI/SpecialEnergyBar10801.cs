using ACT.Event;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.UI;

public class SpecialEnergyBar10801 : SpecialEnergyBar
{
	private const string NormalBurstMode = "Role_08_01_Freeze_Burstmode";

	private const string UltraBurstMode = "Role_08_01_Burstmode";

	[SerializeField]
	private BetterAnimation _betterAnimation;

	[SerializeField]
	private float _burstTime = 3f;

	private float _ultraBurstModeDuration;

	private float _normalBurstModeDuration;

	private const string max = "Max";

	private const string closed = "Closed";

	private const string loop = "Loop";

	public override void Init(SpecialEnergyBarData energyBarData, CustomUITransform transform, Entity entity)
	{
		base.Init(energyBarData, transform, entity);
		_betterAnimation.GetSequence("Closed").Play();
	}

	public override void OnAbilityAdd(AbilityAddEvt abilityAddEvt)
	{
		string abilityName = abilityAddEvt.abilityName;
		if (abilityName == "Role_08_01_Freeze_Burstmode" || abilityName == "Role_08_01_Burstmode")
		{
			_betterAnimation.GetSequence("Max").Play();
		}
	}

	public override void OnAbilityRemove(AbilityRemoveEvt abilityRemoveEvt)
	{
		string abilityName = abilityRemoveEvt.abilityName;
		if (abilityName == "Role_08_01_Freeze_Burstmode" || abilityName == "Role_08_01_Burstmode")
		{
			_betterAnimation.GetSequence("Closed").Play();
		}
	}

	public override void OnAbilityDurationChange(AbilityDurationChangeEvt abilityDurationChangeEvt)
	{
		if (abilityDurationChangeEvt.abilityName == "Role_08_01_Burstmode")
		{
			if (abilityDurationChangeEvt.curDuration > _ultraBurstModeDuration)
			{
				_betterAnimation.GetSequence("Max").Play();
			}
			if (_ultraBurstModeDuration > _burstTime && abilityDurationChangeEvt.curDuration <= _burstTime)
			{
				_betterAnimation.GetSequence("Loop").SetLoops(-1).Play();
			}
			_ultraBurstModeDuration = abilityDurationChangeEvt.curDuration;
		}
		if (abilityDurationChangeEvt.abilityName == "Role_08_01_Freeze_Burstmode")
		{
			if (_normalBurstModeDuration > _burstTime && abilityDurationChangeEvt.curDuration <= _burstTime)
			{
				_betterAnimation.GetSequence("Loop").SetLoops(-1).Play();
			}
			_normalBurstModeDuration = abilityDurationChangeEvt.curDuration;
		}
	}
}
