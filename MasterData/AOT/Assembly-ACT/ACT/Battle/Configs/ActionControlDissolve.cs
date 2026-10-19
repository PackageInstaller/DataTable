using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行控制溶解", "Action", new string[] { "control", "dissolve", "effect", "fx", "particle" })]
public class ActionControlDissolve : ConfigAction
{
	[Tooltip("归一化时间，什么时候溶解")]
	public float duration;

	protected override AbilityAuth defaultAuth => AbilityAuth.Client;

	public override void Do(ActionMemory memory)
	{
	}
}
