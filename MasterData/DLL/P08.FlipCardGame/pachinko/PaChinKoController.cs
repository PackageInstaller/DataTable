using UnityEngine;

namespace pachinko;

public class PaChinKoController : MonoBehaviour
{
	public GameObject m_followGo;

	public GameObject m_ballGo;

	public void StartGame(Vector2 addForce)
	{
		if (!(m_ballGo == null) && !(m_followGo == null))
		{
			m_ballGo.transform.position = m_followGo.transform.position;
			m_ballGo.SetActive(value: true);
			m_ballGo.GetComponent<Rigidbody2D>().AddForce(addForce);
		}
	}
}
