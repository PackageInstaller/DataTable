using System.Collections.Generic;

namespace Ase.ECS;

public class EventInfo
{
	public int ConfigId;

	public List<EventParameter> Params = new List<EventParameter>();
}
