using UnityEngine;

namespace P08.Gamepad;

public class HIDButtonBandFlag : MonoBehaviour
{
	public bool m_isBandOnJoystickCursor = true;

	private HIDButton m_hidButton;

	private GameObject m_bindingNotice;

	public void SwitchBandButton(bool flag)
	{
		if (m_hidButton == null)
		{
			m_hidButton = base.gameObject.GetComponent<HIDButton>();
		}
		if ((bool)m_hidButton)
		{
			m_hidButton.enabled = flag;
		}
		if (m_bindingNotice == null)
		{
			m_bindingNotice = base.transform.Find("BindingNotice/GameObject").gameObject;
		}
		if ((bool)m_bindingNotice)
		{
			m_bindingNotice.SetActive(flag);
		}
	}
}
