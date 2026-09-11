using System.Collections.Generic;

namespace Oath;

public class OathEventContext
{
	public List<OathInteractionBaseData> interationEventList;

	public List<OathInteractionBaseData> independentEventList;

	public void AddEvent(OathInteractionBaseData eventData)
	{
		if (eventData.IsIndependent)
		{
			AddIndependentEvent(eventData);
		}
		else
		{
			AddNormalEvent(eventData);
		}
	}

	private void AddNormalEvent(OathInteractionBaseData eventData)
	{
		if (interationEventList == null)
		{
			interationEventList = new List<OathInteractionBaseData>();
		}
		interationEventList.Add(eventData);
	}

	public void ClearEvent(int nodeID)
	{
		if (interationEventList == null)
		{
			return;
		}
		for (int num = interationEventList.Count - 1; num >= 0; num--)
		{
			if (interationEventList[num].nodeID == nodeID)
			{
				interationEventList.RemoveAt(num);
			}
		}
	}

	public void ClearEvent()
	{
		if (interationEventList != null)
		{
			interationEventList.Clear();
		}
		interationEventList = null;
	}

	public void EventProcess()
	{
		if (interationEventList == null || interationEventList.Count <= 0)
		{
			return;
		}
		OathInteractionBaseData oathInteractionBaseData = null;
		foreach (OathInteractionBaseData interationEvent in interationEventList)
		{
			if (!interationEvent.IsInit)
			{
				interationEvent.OnStart();
			}
			if (!interationEvent.IsFinish)
			{
				interationEvent.OnUpdate();
			}
			if (interationEvent.IsFinish && !interationEvent.IsDispose)
			{
				oathInteractionBaseData = interationEvent;
			}
		}
		oathInteractionBaseData?.OnFinish();
	}

	private void AddIndependentEvent(OathInteractionBaseData eventData)
	{
		if (independentEventList == null)
		{
			independentEventList = new List<OathInteractionBaseData>();
		}
		independentEventList.Add(eventData);
	}

	public void ClearIndependentEvent(int nodeID)
	{
		if (independentEventList == null)
		{
			return;
		}
		for (int num = independentEventList.Count - 1; num >= 0; num--)
		{
			if (independentEventList[num].nodeID == nodeID)
			{
				independentEventList.RemoveAt(num);
			}
		}
	}

	public void CleaIndependentrEvent()
	{
		if (independentEventList != null)
		{
			independentEventList.Clear();
		}
		independentEventList = null;
	}

	public void EventIndependentProcess()
	{
		if (independentEventList == null || independentEventList.Count <= 0)
		{
			return;
		}
		OathInteractionBaseData oathInteractionBaseData = null;
		foreach (OathInteractionBaseData independentEvent in independentEventList)
		{
			if (!independentEvent.IsInit)
			{
				independentEvent.OnStart();
			}
			if (!independentEvent.IsFinish)
			{
				independentEvent.OnUpdate();
			}
			if (independentEvent.IsFinish && !independentEvent.IsDispose)
			{
				oathInteractionBaseData = independentEvent;
			}
		}
		oathInteractionBaseData?.OnFinish();
	}
}
