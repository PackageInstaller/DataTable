using System.Collections.Generic;
using GameFramework.Runtime;

namespace Ase;

public class MapItemStateChangeMessager : MessageBase
{
	public int uid;

	public Dictionary<string, MapDataNodeParadoxParameter> paradoxMsg = new Dictionary<string, MapDataNodeParadoxParameter>();

	public MapItemStateChangeMessager(object sender, int uid, Dictionary<string, MapDataNodeParadoxParameter> paradoxMsg)
		: base(sender)
	{
		this.uid = uid;
		this.paradoxMsg = paradoxMsg;
	}
}
