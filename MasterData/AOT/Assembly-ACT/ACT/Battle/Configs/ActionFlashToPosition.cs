using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行闪现到位置", "Action", new string[] { "flash", "to", "position", "move", "movement", "velocity" })]
public class ActionFlashToPosition : ConfigAction
{
	public ConfigFunction<Vector3> flashPos;

	protected override AbilityAuth defaultAuth => AbilityAuth.Owner;

	public override void Do(ActionMemory memory)
	{
		Vector3 pos = flashPos.Return(memory);
		memory.target.entity.Teleport(pos);
	}
}
