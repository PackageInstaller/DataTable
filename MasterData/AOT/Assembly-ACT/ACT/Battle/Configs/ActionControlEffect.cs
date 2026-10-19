using System.Collections.Generic;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行控制特效", "Action", new string[] { "control", "effect", "fx", "particle" })]
public class ActionControlEffect : ConfigAction
{
	[Header("是否显示特效")]
	public bool isShow;

	public override void Do(ActionMemory memory)
	{
		List<EffectRuntimeItem> myEffects = memory.owner.GetCompEffect().myEffects;
		for (int i = 0; i < myEffects.Count; i++)
		{
			if (myEffects[i].isChangeWithEntity && myEffects[i].go != null)
			{
				myEffects[i].go.SetActive(isShow);
			}
		}
	}
}
