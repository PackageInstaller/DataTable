using UnityEngine;

namespace pachinko;

public class PaChinKoBaseCollider : MonoBehaviour
{
	[SerializeField]
	private OBJECT_TYPE m_objectType = OBJECT_TYPE.OBSTACLE;

	public OBJECT_TYPE objectType
	{
		get
		{
			return m_objectType;
		}
		set
		{
			m_objectType = value;
		}
	}

	private void Start()
	{
	}

	private void Update()
	{
	}

	private void OnCollisionEnter2D(Collision2D other)
	{
		PaChinKoBaseCollider component = other.transform.GetComponent<PaChinKoBaseCollider>();
		bool flag = false;
		if (component != null)
		{
			flag = component.objectType == OBJECT_TYPE.OBSTACLE;
		}
		if ((m_objectType == OBJECT_TYPE.BALL) & flag)
		{
			AudioManager.Instance.Play("effect", "minigame_activity_4_8", "minigame_activity_4_8_pachinko_touch", useStream: false);
		}
	}
}
