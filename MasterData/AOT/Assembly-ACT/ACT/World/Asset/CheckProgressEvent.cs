using ACT.World.Behave;
using UnityEngine;

namespace ACT.World.Asset;

public class CheckProgressEvent : EventActionBase
{
	public float progress;

	public float waitSecond;

	private BehaveControlAnimMoveBehaveEvent m_BehaveEvent;

	private float m_TempTime;

	public override void Enter(BehaveControlBaseBehaveEvent behave)
	{
		base.Enter(behave);
		m_TempTime = 0f;
		m_BehaveEvent = behave as BehaveControlAnimMoveBehaveEvent;
	}

	public override bool Do(BehaveControlBaseBehaveEvent behave)
	{
		if (m_BehaveEvent.fail)
		{
			return true;
		}
		if (m_BehaveEvent.currProgressRate > progress)
		{
			return true;
		}
		if (Mathf.Approximately(m_BehaveEvent.currProgressRate, progress))
		{
			return true;
		}
		if (m_TempTime > waitSecond)
		{
			m_BehaveEvent.Fail();
			return true;
		}
		m_TempTime += Time.deltaTime;
		return false;
	}
}
