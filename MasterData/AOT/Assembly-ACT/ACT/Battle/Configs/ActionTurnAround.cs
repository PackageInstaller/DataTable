using ACT.MultiPlayer;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("执行TurnAround", "Action", new string[] { "turn", "around" })]
public class ActionTurnAround : ConfigAction
{
	public override void Do(ActionMemory memory)
	{
		Entity owner = memory.owner;
		if (LuminApplication.LogEnabled)
		{
			Debug.Log("Before Turning: " + owner.GetFaceDir());
		}
		owner.SetFaceLeft(owner.GetFaceDir() != FaceDir.Left);
		if (LuminApplication.LogEnabled)
		{
			Debug.Log("After Turning: " + owner.GetFaceDir());
		}
	}
}
