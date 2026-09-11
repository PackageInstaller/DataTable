using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Events;
using UnityEngine.UI;

public class InputFieldExt : MonoBehaviour
{
	private new Transform transform;

	private Text inputText;

	private Text placeholder;

	private EventTrigger _eventTrigger;

	public EventTrigger eventTrigger
	{
		get
		{
			if (_eventTrigger == null)
			{
				_eventTrigger = GetComponent<EventTrigger>();
			}
			return _eventTrigger;
		}
	}

	private void Awake()
	{
		transform = base.gameObject.GetComponent<Transform>();
		inputText = transform.Find("Text").GetComponent<Text>();
		placeholder = transform.Find("Placeholder").GetComponent<Text>();
	}

	private void Start()
	{
		AddEventTrigger(EventTriggerType.Select, OnSelect);
		AddEventTrigger(EventTriggerType.Deselect, OnDeselect);
	}

	private void Update()
	{
	}

	public void AddEventTrigger(EventTriggerType eventType, UnityAction<BaseEventData> unityAction)
	{
		if (eventTrigger == null)
		{
			base.gameObject.AddComponent<EventTrigger>();
		}
		UnityAction<BaseEventData> call = unityAction.Invoke;
		if (eventTrigger.triggers.Count != 0)
		{
			for (int i = 0; i < eventTrigger.triggers.Count; i++)
			{
				if (eventTrigger.triggers[i].eventID == eventType)
				{
					eventTrigger.triggers[i].callback.AddListener(unityAction);
					return;
				}
			}
		}
		EventTrigger.Entry entry = new EventTrigger.Entry();
		entry.eventID = eventType;
		entry.callback.AddListener(call);
		eventTrigger.triggers.Add(entry);
	}

	private void OnSelect(BaseEventData baseEventData)
	{
		placeholder.text = "";
	}

	private void OnDeselect(BaseEventData baseEventData)
	{
		if (inputText.text == "")
		{
			object[] array = LuaHelper.CallFunction("GetTips", "NOT_ENTER_NICK_UID");
			placeholder.text = array[0].ToString();
		}
	}
}
