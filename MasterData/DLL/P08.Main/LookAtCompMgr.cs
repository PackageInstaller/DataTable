using System.Collections.Generic;
using UnityEngine;

public class LookAtCompMgr : MonoBehaviour
{
	public static LookAtCompMgr m_instance;

	private List<LookAtComponent> m_comps = new List<LookAtComponent>();

	public static LookAtCompMgr instance
	{
		get
		{
			if (m_instance == null)
			{
				m_instance = new GameObject("LookAtCompMgr").AddComponent<LookAtCompMgr>();
			}
			return m_instance;
		}
	}

	public void Registor(LookAtComponent comp)
	{
		if (!m_comps.Contains(comp))
		{
			if (comp.eBoneType == LookAtComponent.EBoneType.Head)
			{
				m_comps.Insert(0, comp);
			}
			else
			{
				m_comps.Add(comp);
			}
		}
	}

	public void UnRegistor(LookAtComponent comp)
	{
		if (m_comps.Contains(comp))
		{
			m_comps.Remove(comp);
		}
	}

	private void LateUpdate()
	{
		for (int i = 0; i < m_comps.Count; i++)
		{
			if (null != m_comps[i])
			{
				m_comps[i].Manual_LateUpdate();
			}
		}
	}
}
