using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Events;
using UnityEngine.UI;

namespace ACT.UI;

public abstract class SelectableEx : UIBehaviour
{
	[SerializeField]
	private UnityEvent<bool> m_OnInteractableChanged = new UnityEvent<bool>();

	public UnityEvent<bool> OnInteractableChanged => m_OnInteractableChanged;

	public abstract bool IsInteractable();
}
[DisallowMultipleComponent]
[RequireComponent(typeof(Selectable))]
public class SelectableEx<T> : SelectableEx where T : Selectable
{
	private T m_Source;

	public T Source
	{
		get
		{
			if (m_Source == null)
			{
				m_Source = GetComponent<T>();
			}
			return m_Source;
		}
	}

	public bool interactable
	{
		get
		{
			TryInitialize();
			if ((bool)m_Source)
			{
				return m_Source.interactable;
			}
			return false;
		}
		set
		{
			TryInitialize();
			if (!(m_Source == null) && m_Source.interactable != value)
			{
				m_Source.interactable = value;
				OnInteractableChanged?.Invoke(value);
			}
		}
	}

	private void TryInitialize()
	{
		if (m_Source == null)
		{
			m_Source = gameObject.GetComponent<T>();
		}
	}

	public override bool IsInteractable()
	{
		TryInitialize();
		if ((bool)m_Source)
		{
			return m_Source.IsInteractable();
		}
		return false;
	}
}
