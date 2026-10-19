using System;
using UnityEngine;

namespace ACT.Battle.Configs;

[Obsolete]
[AbilityTypeMetadata("设置受击", "Action", new string[] { "set", "hited" })]
public class ActionSetHited : ConfigAction
{
	[Tooltip("负值表示禁用CD")]
	public float hitCD;

	public override void Do(ActionMemory memory)
	{
	}
}
