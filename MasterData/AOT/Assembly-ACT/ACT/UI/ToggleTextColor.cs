using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ACT.UI;

[DisallowMultipleComponent]
[RequireComponent(typeof(Toggle))]
public class ToggleTextColor : UIBehaviour
{
	[SerializeField]
	private TMP_Text m_Text;

	[SerializeField]
	private Color m_NormalColor = Color.white;

	[SerializeField]
	private Color m_SelectedColor = Color.white;

	private Toggle m_Toggle;

	protected override void Awake()
	{
		base.Awake();
		if (m_Text == null)
		{
			m_Text = GetComponentInChildren<TMP_Text>();
		}
	}

	protected override void OnEnable()
	{
		base.OnEnable();
		if (m_Toggle == null)
		{
			m_Toggle = GetComponent<Toggle>();
		}
		m_Toggle.onValueChanged.AddListener(Apply);
		Apply(m_Toggle.isOn);
	}

	protected override void OnDisable()
	{
		if (m_Toggle != null)
		{
			m_Toggle.onValueChanged.RemoveListener(Apply);
		}
		base.OnDisable();
	}

	private void Apply(bool isOn)
	{
		if (!(m_Text == null))
		{
			m_Text.color = (isOn ? m_SelectedColor : m_NormalColor);
		}
	}
}
