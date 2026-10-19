using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("修改闪避中空中数量", "Action", new string[] { "change", "dodge", "in", "air", "count", "move", "movement", "position", "velocity" })]
public class ActionChangeDodgeInAirCount : ConfigAction
{
	public bool isSet;

	public int count;

	public bool isOverCount;

	public override void Do(ActionMemory memory)
	{
		ConfigCharacter config = memory.target.entity.GetConfig();
		CompMotion compMotion = memory.target.entity.GetCompMotion();
		int num = (isSet ? config.dogeInAirCount : (compMotion.dodgeInAirCount + count));
		compMotion.dodgeInAirCount = (isOverCount ? num : Mathf.Clamp(num, 0, config.dogeInAirCount));
	}
}
