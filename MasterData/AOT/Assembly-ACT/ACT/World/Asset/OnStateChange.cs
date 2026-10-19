using System;
using System.Collections.Generic;
using ACT.Event;
using Newtonsoft.Json.Linq;

namespace ACT.World.Asset;

[Serializable]
public class OnStateChange : IInteractEvent, IDataToBake
{
	public List<StateWorldUid> sources = new List<StateWorldUid>();

	ClientEvent IInteractEvent.clientEvent => ClientEvent.Local_ServiceState_Refresh;

	IEnumerable<int> IInteractEvent.checkedSwid
	{
		get
		{
			foreach (StateWorldUid source in sources)
			{
				yield return source.value;
			}
		}
	}

	public void Bake(object baker)
	{
		sources.Bake(baker);
		for (int i = 0; i < sources.Count; i++)
		{
			_ = sources[i];
		}
	}

	public JToken ToToken()
	{
		return new JObject { 
		{
			"sources",
			sources.ToArrayToken()
		} };
	}
}
