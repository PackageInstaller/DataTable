using UnityEngine;

public class DisplayLockOnByThrown : MonoBehaviour
{
	private AttachPointSetup m_attachPointSetup;

	private Transform m_lockEffect;

	private float m_appearTime;

	private Transform LockEffect
	{
		get
		{
			if (m_lockEffect == null)
			{
				m_lockEffect = Asset.Instantiate("Effect/Buff/General/fx_general_lock_hit_point").transform;
			}
			return m_lockEffect;
		}
	}

	public void DisplayLockEffect()
	{
		if (m_attachPointSetup == null)
		{
			m_attachPointSetup = U3DUtil.Get<AttachPointSetup>(base.gameObject);
		}
		Transform attachPoint = m_attachPointSetup.GetAttachPoint(En_BaseAttachPointType.HitPoint);
		LockEffect.localScale = Vector3.one;
		LockEffect.SetParent(attachPoint, worldPositionStays: false);
		LockEffect.localPosition = Vector3.zero;
		LockEffect.gameObject.SetActive(value: true);
		m_appearTime = 0.5f;
	}

	private void Update()
	{
		if (!(m_appearTime <= 0f))
		{
			m_appearTime -= Time.deltaTime;
			if (m_appearTime <= 0f)
			{
				LockEffect.gameObject.SetActive(value: false);
			}
		}
	}
}
