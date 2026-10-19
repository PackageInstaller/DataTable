using ACT.Battle.Configs;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class WeakBar : UIBehaviour
{
	[SerializeReference]
	private TargetValueMaskBar weakBar;

	[SerializeReference]
	private BetterAnimation animation;

	private EntityUIInfo _entityUIInfo;

	public void Init(EntityUIInfo entityUIInfo)
	{
		_entityUIInfo = entityUIInfo;
		gameObject.SetActive(_entityUIInfo.InWeak);
		weakBar.gameObject.SetActive(_entityUIInfo.PostureType == PostureType.Long);
	}

	public void OnBossRemoveHatred()
	{
	}

	public void OnEnterWeak()
	{
		TargetValueMaskBar targetValueMaskBar = weakBar;
		float value = (weakBar.TargetValue = _entityUIInfo.CurWeakPercentage);
		targetValueMaskBar.Value = value;
		animation.GetSequence("WeakShow").OnPlay((AnimationBuilder _) =>
		{
			gameObject.SetActive(value: true);
		}).Play();
		weakBar.gameObject.SetActive(_entityUIInfo.PostureType == PostureType.Long);
	}

	public void OnExitWeak()
	{
		animation.GetSequence("WeakHide").OnComplete((AnimationBuilder _) =>
		{
			gameObject.SetActive(value: false);
		}).Play();
	}

	public void OnWeakChange()
	{
		if (_entityUIInfo.PostureType == PostureType.Long)
		{
			weakBar.TargetValue = _entityUIInfo.CurWeakPercentage;
		}
	}
}
