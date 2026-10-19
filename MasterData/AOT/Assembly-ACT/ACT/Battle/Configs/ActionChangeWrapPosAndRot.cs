using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("修改Wrap位置并Rot", "Action", new string[] { "change", "wrap", "pos", "and", "rot", "move", "movement", "position", "velocity" })]
public class ActionChangeWrapPosAndRot : ConfigAction
{
	private Vector3 dir;

	private Vector3 targetRotation;

	private Quaternion targetRotate;

	protected override AbilityAuth defaultAuth => AbilityAuth.Owner;

	public override void Do(ActionMemory memory)
	{
		Vector3 position = memory.target.entity.GetRootTransform().position;
		float num = 22f;
		Vector3[] array = new Vector3[4]
		{
			Vector3.down,
			Vector3.up,
			Vector3.left,
			Vector3.right
		};
		foreach (Vector3 direction in array)
		{
			if (Physics.Raycast(new Ray(position, direction), out var hitInfo, 20f, BattleConsts.enviromentMask) && num > hitInfo.distance)
			{
				num = hitInfo.distance;
				dir = direction;
			}
		}
		if (dir == Vector3.down)
		{
			targetRotation = new Vector3(0f, 0f, 0f);
		}
		else if (dir == Vector3.up)
		{
			targetRotation = new Vector3(0f, 0f, 180f);
		}
		else if (dir == Vector3.left)
		{
			targetRotation = new Vector3(0f, 0f, -90f);
		}
		else if (dir == Vector3.right)
		{
			targetRotation = new Vector3(0f, 0f, 90f);
		}
		targetRotate = Quaternion.Euler(targetRotation);
		Transform rootTransform = memory.target.entity.GetRootTransform();
		rootTransform.localRotation = targetRotate;
		position += dir * num;
		rootTransform.position = position;
	}
}
