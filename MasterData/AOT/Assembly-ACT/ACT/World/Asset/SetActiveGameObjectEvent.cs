using ACT.World.Behave;
using UnityEngine;

namespace ACT.World.Asset;

public class SetActiveGameObjectEvent : DoActionBase
{
	public bool active;

	public string path;

	private Transform m_Temp;

	public override bool Do(BehaveControlBaseBehaveEvent behave)
	{
		if (m_Temp == null)
		{
			m_Temp = behave.transform.Find(path);
		}
		m_Temp.gameObject.SetActive(active);
		return true;
	}
}
