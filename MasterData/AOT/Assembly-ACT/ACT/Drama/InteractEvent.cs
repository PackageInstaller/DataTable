using System;
using System.Collections.Generic;
using ACT.Drama.Conversation;
using ACT.UI;
using Cysharp.Threading.Tasks;

namespace ACT.Drama;

public class InteractEvent
{
	public int priority;

	public XNodeInteractType interactType;

	public int iconId = -1;

	public int contentId;

	public List<BaseEvent> events = new List<BaseEvent>();

	public virtual async UniTask OnInteract(object context)
	{
		for (int i = 0; i < events.Count; i++)
		{
			if (events[i] == null)
			{
				if (!LuminApplication.LogEnabled)
				{
				}
			}
			else
			{
				events[i].Init(context);
				await events[i].DoEvent();
			}
		}
	}

	public void CreateLeaveEvent()
	{
		CloseUIEvent closeUIEvent = new CloseUIEvent();
		closeUIEvent.uiType = Enum.GetName(typeof(UI_TYPE), 33);
		List<BaseEvent> list = new List<BaseEvent>();
		list.Add(closeUIEvent);
		priority = 99;
		interactType = XNodeInteractType.Button;
		iconId = 0;
		contentId = 11000001;
		events = list;
	}
}
