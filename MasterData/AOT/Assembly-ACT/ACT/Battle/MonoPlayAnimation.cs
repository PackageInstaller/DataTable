using ACT.Event;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

public class MonoPlayAnimation : MonoBehaviour
{
	public Animator animator;

	public bool isControlled;

	public float time;

	public int min;

	public int max;

	private float m_Timer;

	private static readonly int Percent = Animator.StringToHash("percent");

	private static readonly string DefaultClip = "defaultClip";

	private static readonly int StartRandom = Animator.StringToHash("startRandom");

	private bool m_IsTrigger;

	private void Start()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.TriggerObjectEntry, OnTriggerObjectEntry);
		if (!isControlled)
		{
			m_Timer = time;
			m_IsTrigger = true;
		}
	}

	private void OnTriggerObjectEntry(BaseEventContent obj)
	{
		if (!(obj is TriggerEventEntry triggerEventEntry))
		{
			return;
		}
		if (triggerEventEntry.triggerType != TriggerType.triggerExit)
		{
			if (!m_IsTrigger)
			{
				m_Timer = time;
				m_IsTrigger = true;
			}
		}
		else
		{
			m_IsTrigger = false;
		}
	}

	private void OnDestroy()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.TriggerObjectEntry, OnTriggerObjectEntry);
	}

	private void SetFloat()
	{
		int value = Random.Range(min, max);
		if (animator != null)
		{
			animator.SetInteger(Percent, value);
			animator.SetTrigger(StartRandom);
		}
	}

	private void FixedUpdate()
	{
		if (!(m_Timer > 0f))
		{
			return;
		}
		m_Timer -= Time.deltaTime;
		if (m_Timer < 0f)
		{
			SetFloat();
			if (m_IsTrigger)
			{
				m_Timer += time;
			}
		}
	}
}
