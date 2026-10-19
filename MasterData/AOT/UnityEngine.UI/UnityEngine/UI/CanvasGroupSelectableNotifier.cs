namespace UnityEngine.UI;

[ExecuteAlways]
[AddComponentMenu("")]
[DisallowMultipleComponent]
internal sealed class CanvasGroupSelectableNotifier : MonoBehaviour
{
	private CanvasGroup m_Group;

	private int m_NonAlphaState;

	private bool m_HasState;

	internal static void Ensure(CanvasGroup group)
	{
		if (!(group == null) && !group.TryGetComponent<CanvasGroupSelectableNotifier>(out var _))
		{
			group.gameObject.AddComponent<CanvasGroupSelectableNotifier>();
		}
	}

	private void Awake()
	{
		hideFlags |= HideFlags.DontSave | HideFlags.HideInInspector;
		m_Group = GetComponent<CanvasGroup>();
	}

	private void OnEnable()
	{
		if (m_Group == null)
		{
			m_Group = GetComponent<CanvasGroup>();
		}
		CacheState();
	}

	private void OnCanvasGroupChanged()
	{
		if (m_Group == null)
		{
			m_Group = GetComponent<CanvasGroup>();
		}
		if (!(m_Group == null))
		{
			int num = Selectable.PackCanvasGroupNonAlphaState(m_Group);
			if (!m_HasState || num != m_NonAlphaState)
			{
				m_NonAlphaState = num;
				m_HasState = true;
				Selectable.NotifyCanvasGroupNonAlphaChanged(m_Group);
			}
		}
	}

	private void CacheState()
	{
		if (m_Group == null)
		{
			m_HasState = false;
			return;
		}
		m_NonAlphaState = Selectable.PackCanvasGroupNonAlphaState(m_Group);
		m_HasState = true;
	}
}
