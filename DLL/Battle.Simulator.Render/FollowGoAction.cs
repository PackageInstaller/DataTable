using System.Collections.Generic;
using UnityEngine;

public class FollowGoAction : MonoBehaviour
{
	public GameObject m_followGo;

	public List<GameObject> m_goList = new List<GameObject>();

	public List<float> m_disctance = new List<float>();

	private void LateUpdate()
	{
		if (m_goList.Count != m_disctance.Count)
		{
			base.enabled = false;
			return;
		}
		for (int i = 0; i < m_goList.Count; i++)
		{
			GameObject gameObject = m_goList[i];
			if (!(gameObject == null))
			{
				gameObject.transform.position = new Vector3(gameObject.transform.position.x, m_followGo.transform.position.y + m_disctance[i], gameObject.transform.position.z);
			}
		}
	}
}
