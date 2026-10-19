using UnityEngine;

namespace ACT.UI;

public abstract class EnergyWidget : MonoBehaviour
{
	[SerializeReference]
	protected BetterAnimation betterAnimation;

	private readonly string _showAnimationName = "Show";

	private readonly string _hideAnimationName = "Hide";

	private readonly string _emptyAnimationName = "Empty";

	private bool _fill;

	protected float _val;

	public void OnBattleChange(float newVal)
	{
		newVal = Mathf.Clamp01(newVal);
		if (Mathf.Approximately(1f, newVal))
		{
			betterAnimation.GetSequence(_showAnimationName).Play();
		}
		else
		{
			betterAnimation.GetSequence(_emptyAnimationName).Play();
		}
	}

	public void Fill()
	{
		if (!_fill)
		{
			_fill = true;
			betterAnimation.GetSequence(_showAnimationName).Play();
		}
	}

	public void UnFill()
	{
		if (_fill)
		{
			_fill = false;
			betterAnimation.GetSequence(_hideAnimationName).Play();
		}
	}

	public virtual void UpdateVal(float newVal)
	{
		newVal = Mathf.Clamp01(newVal);
		if (!Mathf.Approximately(_val, newVal))
		{
			if (_val < 1f && Mathf.Approximately(newVal, 1f))
			{
				Fill();
			}
			else if (Mathf.Approximately(_val, 1f) && newVal < 1f)
			{
				UnFill();
			}
			_val = newVal;
		}
	}
}
