using UnityEngine;

namespace pachinko;

public class PaChinKoHorizonalMoveCollider : PaChinKoBaseCollider
{
	public bool m_moveLeft = true;

	public float m_moveSpeed = 0.2f;

	private void Start()
	{
	}

	private void Update()
	{
		base.transform.Translate(Vector3.right * (m_moveLeft ? 1 : (-1)) * m_moveSpeed * Time.deltaTime);
	}

	private void OnCollisionEnter2D(Collision2D collision)
	{
		PaChinKoBaseCollider component = collision.gameObject.GetComponent<PaChinKoBaseCollider>();
		if (component != null && component.objectType == OBJECT_TYPE.WALL)
		{
			m_moveLeft = !m_moveLeft;
		}
	}
}
