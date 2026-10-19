using System;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class EventInfo : IDataToBake
{
	public Pos pos;

	public BehaveEventType behaveEventType = BehaveEventType.Pos;

	[SerializeReference]
	public EventActionBase tarEvent;
}
