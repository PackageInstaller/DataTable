using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

[DisallowMultipleComponent]
public class UIInteractableColor : MonoBehaviour
{
	private bool m_LastInteractable;

	private SelectableEx m_SelectableEx;

	[SerializeField]
	private Color m_NormalColor = Color.white;

	[SerializeField]
	private Color m_DisableColor = Color.white;

	[SerializeField]
	private List<Graphic> m_Graphics = new List<Graphic>();

	private void Awake()
	{
		m_SelectableEx = GetComponent<SelectableEx>();
		m_SelectableEx.OnInteractableChanged.AddListener(OnInteractableChanged);
	}

	private void OnEnable()
	{
		m_LastInteractable = m_SelectableEx.IsInteractable();
		UpdateColor(m_LastInteractable);
	}

	private void OnInteractableChanged(bool arg0)
	{
		foreach (Graphic graphic in m_Graphics)
		{
			graphic.color = (arg0 ? m_NormalColor : m_DisableColor);
		}
	}

	private void Update()
	{
		if (m_LastInteractable != m_SelectableEx.IsInteractable())
		{
			m_LastInteractable = m_SelectableEx.IsInteractable();
			UpdateColor(m_LastInteractable);
		}
	}

	private void UpdateColor(bool isInteractable)
	{
		foreach (Graphic graphic in m_Graphics)
		{
			graphic.color = (isInteractable ? m_NormalColor : m_DisableColor);
		}
	}
}
