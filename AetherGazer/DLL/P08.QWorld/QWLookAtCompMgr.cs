using System.Collections.Generic;

public class QWLookAtCompMgr
{
	public static QWLookAtCompMgr Instance;

	private Dictionary<QWLookAtComponent, QWLookAtComponent> m_comps = new Dictionary<QWLookAtComponent, QWLookAtComponent>();

	public void Init()
	{
		Instance = this;
	}

	public void Registor(QWLookAtComponent comp)
	{
		if (!m_comps.ContainsKey(comp))
		{
			if (comp.eBoneType == QWLookAtComponent.EBoneType.Head)
			{
				m_comps.Add(comp, comp);
			}
			else
			{
				m_comps.Add(comp, comp);
			}
		}
	}

	public void UnRegistor(QWLookAtComponent comp)
	{
		if (m_comps.ContainsKey(comp))
		{
			m_comps.Remove(comp);
		}
	}

	public void LateUpdate()
	{
		foreach (KeyValuePair<QWLookAtComponent, QWLookAtComponent> comp in m_comps)
		{
			if (comp.Value != null)
			{
				comp.Value.Manual_LateUpdate();
			}
		}
	}

	public void Dispose()
	{
		Instance = null;
		m_comps.Clear();
	}
}
