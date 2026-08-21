using UnityEngine;

public class UIRedPoint : MonoBehaviour
{
	private Animator m_NewAnim;

	private Animator m_DefaultAnim;

	[SerializeField]
	private GameObject DefaultRed;

	[SerializeField]
	private GameObject NewRed;

	private string m_DebugName;

	private UIRedPointStyle m_RedPointStyle;

	private RectTransform parentTrans;

	private RectTransform m_rectTrans;

	public Animator Anim
	{
		get
		{
			if (NewRed != null && NewRed.activeInHierarchy)
			{
				return m_NewAnim;
			}
			return m_DefaultAnim;
		}
		private set
		{
		}
	}

	public string DebugName => m_DebugName;

	private RectTransform M_ParentTrans
	{
		get
		{
			if (parentTrans == null)
			{
				parentTrans = base.transform.parent.GetComponent<RectTransform>();
			}
			return parentTrans;
		}
	}

	private RectTransform M_RectTrans
	{
		get
		{
			if (m_rectTrans == null)
			{
				m_rectTrans = GetComponent<RectTransform>();
			}
			return m_rectTrans;
		}
	}

	public void OnEnable()
	{
		if ((bool)Anim)
		{
			float time = RedPointMgr.Instance.GetTime();
			if (NewRed != null && NewRed.activeInHierarchy)
			{
				Anim.Play("Fx_NewRed_cx", 0, time);
			}
			else
			{
				Anim.Play("CommonNotice", 0, time);
			}
		}
		if (CanEnqueue())
		{
			RedPointMgr.Instance?.Add(this);
		}
	}

	public void OnDisable()
	{
		if (CanEnqueue())
		{
			RedPointMgr.Instance?.Remove(this);
		}
	}

	private void OnDestroy()
	{
		if (CanEnqueue())
		{
			RedPointMgr.Instance?.Remove(this);
		}
	}

	public bool CanEnqueue()
	{
		if (m_NewAnim != null || m_DefaultAnim != null)
		{
			return true;
		}
		return false;
	}

	public void Awake()
	{
		if (DefaultRed != null)
		{
			m_DefaultAnim = DefaultRed.GetComponent<Animator>();
		}
		if (NewRed != null)
		{
			m_NewAnim = NewRed.GetComponent<Animator>();
		}
	}

	public void ShowRed(UIRedPointStyle redPointStyle)
	{
		switch (redPointStyle)
		{
		case UIRedPointStyle.None:
			ChangeRedActive(base.gameObject, status: false);
			break;
		case UIRedPointStyle.New:
			ChangeRedActive(base.gameObject, status: true);
			ChangeRedActive(DefaultRed, status: false);
			ChangeRedActive(NewRed, status: true);
			break;
		default:
			ChangeRedActive(base.gameObject, status: true);
			ChangeRedActive(DefaultRed, status: true);
			ChangeRedActive(NewRed, status: false);
			break;
		}
		m_RedPointStyle = redPointStyle;
	}

	public void SetPosition(float x, float y)
	{
		if (M_ParentTrans != null)
		{
			M_RectTrans.localPosition = new Vector3(x, y, 0f);
		}
	}

	public void SetScale(float x, float y)
	{
		if (M_ParentTrans != null)
		{
			M_RectTrans.localScale = new Vector3(x, y, 1f);
		}
	}

	public void SetPositionAxis(float value, int axis)
	{
		if (M_ParentTrans != null)
		{
			Vector3 localPosition = M_RectTrans.localPosition;
			switch (axis)
			{
			case 1:
				M_RectTrans.localPosition = new Vector3(value, localPosition.y, 0f);
				break;
			case 2:
				M_RectTrans.localPosition = new Vector3(localPosition.x, value, 0f);
				break;
			}
		}
	}

	public void SetScaleAxis(float value, int axis)
	{
		if (M_ParentTrans != null)
		{
			Vector3 localScale = M_RectTrans.localScale;
			switch (axis)
			{
			case 1:
				M_RectTrans.localScale = new Vector3(value, localScale.y, 1f);
				break;
			case 2:
				M_RectTrans.localScale = new Vector3(localScale.x, value, 1f);
				break;
			}
		}
	}

	private void ChangeRedActive(GameObject target, bool status)
	{
		if (status && target != null && !target.activeSelf)
		{
			target.SetActive(value: true);
		}
		if (!status && target != null && target.activeSelf)
		{
			target.SetActive(value: false);
		}
	}

	public void SetDebugName(string debugName)
	{
		m_DebugName = debugName;
	}
}
