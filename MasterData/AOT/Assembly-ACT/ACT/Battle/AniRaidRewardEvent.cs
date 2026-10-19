using System;
using UnityEngine;

namespace ACT.Battle;

public class AniRaidRewardEvent : MonoBehaviour
{
	private Action m_reward;

	public void SetReward(Action rewad)
	{
		m_reward = (Action)Delegate.Combine(m_reward, rewad);
	}

	public void GetReward()
	{
		m_reward?.Invoke();
	}
}
