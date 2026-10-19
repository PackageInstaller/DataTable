using System.Collections.Generic;
using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行Actionrefresh特效中Pool", "Action", new string[] { "actionrefresh", "effect", "in", "pool", "fx", "particle" })]
public class ActionrefreshEffectInPool : ConfigAction
{
	public override void Do(ActionMemory memory)
	{
		List<EffectRuntimeItem> myEffects = memory.owner.GetCompEffect().myEffects;
		for (int i = 0; i < myEffects.Count; i++)
		{
			myEffects[i].isChangeWithEntity = false;
		}
	}
}
