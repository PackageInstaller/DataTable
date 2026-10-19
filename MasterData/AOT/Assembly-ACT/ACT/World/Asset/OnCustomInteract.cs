using System;
using System.Collections.Generic;
using ACT.Event;
using Newtonsoft.Json.Linq;

namespace ACT.World.Asset;

[Serializable]
public class OnCustomInteract : IInteractEvent, IDataToBake
{
	public StateWorldUid worldUid = int.MinValue;

	public string eventName;

	ClientEvent IInteractEvent.clientEvent => ClientEvent.Local_CustomInteractEvent;

	IEnumerable<int> IInteractEvent.checkedSwid
	{
		get
		{
			yield return worldUid.value;
		}
	}

	public JToken ToToken()
	{
		return new JObject
		{
			{ "worldUid", worldUid.value },
			{ "eventName", eventName }
		};
	}
}
