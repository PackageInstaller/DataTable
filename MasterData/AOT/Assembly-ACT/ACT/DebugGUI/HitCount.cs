using ACT.Event;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.DebugGUI;

public class HitCount : SingleMonitor
{
	private DebugGUITextField timeText;

	private DebugGUIField countText;

	private float time;

	private int m_Count;

	private float m_Timer;

	private int Count
	{
		get
		{
			return m_Count;
		}
		set
		{
			m_Count = value;
			countText.text = m_Count.ToString();
		}
	}

	protected override bool OnInit()
	{
		countText = sigwnd.AddGUI(new DebugGUIField("Hit次数"));
		timeText = new DebugGUITextField("间隔时间（秒）");
		sigwnd.AddGUI(timeText);
		sigwnd.AddGUI(new DebugGUIButton("设置Hit间隔时间", () =>
		{
			SetTime(float.Parse(timeText.text));
		}));
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_EntityGetHit, OnHit);
		return true;
	}

	protected override void OnRemove()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_EntityGetHit, OnHit);
	}

	private void SetTime(float t)
	{
		time = t;
		GUI.FocusControl(null);
	}

	public override void OnUpdate()
	{
		if (Count > 0)
		{
			m_Timer -= Time.fixedDeltaTime * GameManager.timeSystem.globalSpeed;
			if (m_Timer <= 0f)
			{
				Count = 0;
				m_Timer = time;
			}
		}
	}

	private void OnHit(BaseEventContent content)
	{
		if (((UIEntityGetHitEvt)content).cmdHit.caster.IsCharacter())
		{
			m_Timer = time;
			Count++;
		}
	}
}
