using System.Collections.Generic;
using ACT.Event;
using ACT.World.StateObject;
using Fundamental;

namespace ACT.Model;

public class RaidCheckPointModel : Model<RaidCheckPointModel>
{
	private List<InteractRaidCheckPoint> _checkPoints = new List<InteractRaidCheckPoint>();

	private int _activityCheckPoint;

	protected override void Init()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Scene_Change, ClearCheckPoint);
	}

	protected override void UnInit()
	{
		_checkPoints.Clear();
	}

	public void AddCheckPoint(InteractRaidCheckPoint checkPoint)
	{
		if (!_checkPoints.Contains(checkPoint))
		{
			_checkPoints.Add(checkPoint);
		}
	}

	public void RemoveCheckPoint(InteractRaidCheckPoint checkPoint)
	{
		if (_checkPoints.Contains(checkPoint))
		{
			_checkPoints.Remove(checkPoint);
		}
	}

	private void ClearCheckPoint(BaseEventContent obj)
	{
		_checkPoints.Clear();
	}

	public void ChangeActivityCheckPoint(int swid)
	{
		if (_activityCheckPoint == swid)
		{
			return;
		}
		_activityCheckPoint = swid;
		foreach (InteractRaidCheckPoint checkPoint in _checkPoints)
		{
			if (checkPoint.swid != swid)
			{
				checkPoint.NetEnterState(1);
			}
		}
	}
}
