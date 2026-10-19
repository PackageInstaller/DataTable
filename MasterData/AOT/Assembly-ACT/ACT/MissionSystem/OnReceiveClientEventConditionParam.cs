using System;
using ACT.Event;

namespace ACT.MissionSystem;

[Serializable]
public class OnReceiveClientEventConditionParam
{
	public ClientEvent clientEvent;
}
