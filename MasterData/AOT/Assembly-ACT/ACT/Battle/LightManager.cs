using ACT.Event;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

public class LightManager : Singleton<LightManager>
{
	private Light m_MainLight;

	public override ContextType ContextType => ContextType.GLOBAL;

	public override void Init()
	{
		m_MainLight = GameObject.Find("GameLoader/Directional Light").GetComponent<Light>();
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Open_MainLight, OpenMainLight);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Close_MainLight, CloseMainLight);
	}

	public override void UnInit()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Open_MainLight, OpenMainLight);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Close_MainLight, CloseMainLight);
	}

	private void OpenMainLight(BaseEventContent obj)
	{
		if (!(m_MainLight == null) && !m_MainLight.gameObject.activeSelf)
		{
			m_MainLight.gameObject.SetActive(value: true);
		}
	}

	private void CloseMainLight(BaseEventContent obj)
	{
		if (!(m_MainLight == null) && m_MainLight.gameObject.activeSelf)
		{
			m_MainLight.gameObject.SetActive(value: false);
		}
	}
}
