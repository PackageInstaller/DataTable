using System;
using System.Collections.Generic;
using ACT.Event;
using Newtonsoft.Json.Linq;

namespace ACT.World.Asset;

[Serializable]
public class StateCheck : IInteractVerification, IDataToBake
{
	public List<InteractRuleState> @if;

	bool IInteractVerification.Verify(IRuleManager ruleManager, LocalStateWorldEvent eventContent)
	{
		foreach (InteractRuleState item in @if)
		{
			if (ruleManager.SharedGetState(item.stateWorldUid) != item.stateId)
			{
				return false;
			}
		}
		return true;
	}

	public void Bake(object baker)
	{
		@if.Bake(baker);
	}

	public JToken ToToken()
	{
		JObject jObject = new JObject();
		JArray value = new JArray();
		jObject.Add("if", value);
		return jObject;
	}
}
