using ACT.Event;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class BossPostureBar : UIBehaviour
{
	[SerializeReference]
	private TargetValueMaskBar postureBar;

	[SerializeReference]
	private BetterAnimation animation;

	[SerializeReference]
	private PercentParticle postureParticle;

	[SerializeReference]
	private PercentParticle postureParticleLite;

	private int _characterDamageType;

	public int CharacterDamageType
	{
		set
		{
			_characterDamageType = value;
		}
	}

	public void OnPostureChange(float posturePercentage, bool inWeak)
	{
		if (posturePercentage < 0f)
		{
			posturePercentage = 0f;
		}
		if (Mathf.Approximately(postureBar.TargetValue, posturePercentage))
		{
			return;
		}
		postureBar.TargetValue = posturePercentage;
		if (_characterDamageType == 2 && !inWeak)
		{
			if (posturePercentage < GameLoader.meta.barShakePercent)
			{
				postureParticleLite.Play(leftBase: true, postureBar.TargetValue);
			}
			else
			{
				postureParticle.Play(leftBase: true, postureBar.TargetValue);
			}
		}
	}

	public void OnBossAddHatred(AddBossHatredEvt addBossHatredEvt)
	{
		_characterDamageType = addBossHatredEvt.damageType;
		float num = addBossHatredEvt.curPosturePercentage;
		if (num < 0f)
		{
			num = 0f;
		}
		TargetValueMaskBar targetValueMaskBar = postureBar;
		float targetValue = (postureBar.Value = num);
		targetValueMaskBar.TargetValue = targetValue;
		animation.GetSequence("PostureEnter").OnPlay((AnimationBuilder builder) =>
		{
			gameObject.SetActive(value: true);
		}).Play();
	}

	public void OnBossRemoveHatred()
	{
	}

	public void Posture2Weak()
	{
		animation.GetSequence("PostureShieldBreak").Play();
	}

	public void Weak2Posture()
	{
		animation.GetSequence("PostureShieldEnter").Play();
	}
}
