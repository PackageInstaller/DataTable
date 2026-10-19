using UnityEngine;

namespace ACT.UI;

public class BattlePassRewardUIComponent : ItemUIComponentBase
{
	[SerializeField]
	private BetterAnimation _completedAnim;

	[SerializeField]
	private GameObject _lock;

	[SerializeField]
	private GameObject _canClaimed;

	[SerializeField]
	private GameObject m_DoubleRewardTag;

	private bool _isLock;

	private bool _canClaim;

	public bool IsLock
	{
		get
		{
			return _lock;
		}
		set
		{
			_lock.SetActive(value);
			_isLock = value;
		}
	}

	public bool CanClaim
	{
		get
		{
			return _canClaim;
		}
		set
		{
			_canClaimed.SetActive(value);
			_canClaim = value;
		}
	}

	protected override void UpdateUniversalItemTag()
	{
		SetUniversalItemExtraTag(m_DoubleRewardTag);
	}

	public override void UpdatePerformance()
	{
		base.UpdatePerformance();
	}

	protected override void SetComplete()
	{
		if ((bool)m_CompleteObject)
		{
			if (IsFirstComplete)
			{
				m_CompleteObject.SetActive(value: true);
				_completedAnim.GetSequence("Reward").Play();
			}
			else
			{
				m_CompleteObject.SetActive(IsComplete || m_InitType == InitType.RewardItemReceived);
			}
		}
	}

	protected override void UpdateRedPoint()
	{
		if ((bool)m_redPointObject)
		{
			bool active = m_InitType == InitType.RewardItem && !_isLock && !IsComplete;
			m_redPointObject.gameObject.SetActive(active);
		}
	}
}
