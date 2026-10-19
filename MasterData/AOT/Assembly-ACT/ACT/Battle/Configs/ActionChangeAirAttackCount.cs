using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("修改空中攻击数量", "Action", new string[] { "change", "air", "attack", "count", "damage", "hit" })]
public class ActionChangeAirAttackCount : ConfigAction
{
	public bool isSet;

	public int count;

	public bool isOverCount;

	public override void Do(ActionMemory memory)
	{
		CompMotion compMotion = memory.target.entity.GetCompMotion();
		ConfigCharacter config = memory.target.entity.GetConfig();
		int num = (isSet ? config.airAttackCount : (compMotion.airAttackCount + count));
		compMotion.airAttackCount = (isOverCount ? num : Mathf.Clamp(num, 0, config.airAttackCount));
	}
}
