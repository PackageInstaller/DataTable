using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class BtnDot : UIBehaviour
{
	[SerializeReference]
	private BetterAnimation _betterAnimation;

	public virtual void Show()
	{
		_betterAnimation.GetSequence("Show").Play();
	}

	public virtual void ShowImmediately()
	{
		_betterAnimation.GetSequence("Show").Play().Complete();
	}

	public virtual void Hide()
	{
		_betterAnimation.GetSequence("Hide").Play();
	}

	public virtual void HideImmediately()
	{
		_betterAnimation.GetSequence("Hide").Play().Complete();
	}
}
