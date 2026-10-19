using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class ActIndex : UIBehaviour
{
	[SerializeField]
	protected bool m_IsOn;

	[SerializeField]
	private ActIndexGroup m_Group;

	private BetterAnimation betterAnimation;

	[SerializeField]
	protected string onClipName;

	[SerializeField]
	protected string offClipName;

	public bool isOn => m_IsOn;

	public ActIndexGroup group => m_Group;

	public BetterAnimation BetterAnimation
	{
		get
		{
			if (betterAnimation == null)
			{
				betterAnimation = GetComponent<BetterAnimation>();
			}
			return betterAnimation;
		}
	}

	public void SetStateWithAnimation(bool value)
	{
		if (m_IsOn != value)
		{
			m_IsOn = value;
			PlayAnimation();
		}
	}

	public void SetStateInstant(bool value)
	{
		m_IsOn = value;
		PlayAnimationInstant();
	}

	protected void SetIndexGroup(ActIndexGroup newGroup)
	{
		m_Group = newGroup;
	}

	protected virtual void PlayAnimation()
	{
		BetterAnimation.GetSequence(isOn ? onClipName : offClipName).Play();
	}

	protected virtual void PlayAnimationInstant()
	{
		BetterAnimation.GetSequence(isOn ? onClipName : offClipName).Play().Complete();
	}
}
