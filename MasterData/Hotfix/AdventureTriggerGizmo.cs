using UnityEngine;

public abstract class AdventureTriggerGizmo : LogicEntity
{
	private int _triggerRC;

	private int _triggerFC;

	public int x { get; protected set; }

	public int y { get; protected set; }

	public virtual string triggerName => gameObject.name;

	protected override void OnInit()
	{
		_logger = Singleton<LogManager>.Instance.get_Item("Adventure_Gizmo");
	}

	public virtual void Initialize()
	{
	}

	public virtual void Initialize(int x, int y)
	{
		this.x = x;
		this.y = y;
	}

	public virtual void Release()
	{
		_triggerRC = 0;
		_triggerFC = 0;
	}

	protected virtual void OnTriggerEnter(Collider other)
	{
		if (other.attachedRigidbody.gameObject.tag == "Player")
		{
			_triggerRC++;
			if (_triggerRC == 1)
			{
				TriggerEnter(other.attachedRigidbody.gameObject);
			}
		}
	}

	protected virtual void OnTriggerStay(Collider other)
	{
		if (other.attachedRigidbody.gameObject.tag == "Player" && _triggerFC != Time.frameCount)
		{
			_triggerFC = Time.frameCount;
			TriggerStay(other.attachedRigidbody.gameObject);
		}
	}

	protected virtual void OnTriggerExit(Collider other)
	{
		if (other.attachedRigidbody.gameObject.tag == "Player")
		{
			_triggerRC--;
			if (_triggerRC == 0)
			{
				TriggerExit(other.attachedRigidbody.gameObject);
			}
			if (_triggerRC < 0)
			{
				_triggerRC = 0;
			}
		}
	}

	protected virtual void TriggerEnter(GameObject playerAgent)
	{
	}

	protected virtual void TriggerStay(GameObject playerAgent)
	{
	}

	protected virtual void TriggerExit(GameObject playerAgent)
	{
	}
}
