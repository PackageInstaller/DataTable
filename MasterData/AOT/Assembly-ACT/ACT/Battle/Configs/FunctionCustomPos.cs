using System;
using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("获取自定义位置", "Function", new string[] { "custom", "pos", "vector", "position", "rotation", "quaternion" })]
public class FunctionCustomPos : ConfigFunction<Vector3>
{
	public enum CustomPosType
	{
		blackBoardValue,
		spawnPos,
		jumpInbornPos
	}

	[Flags]
	public enum PosModifyType
	{
		None = 0,
		RayProjected2Ground = 0x20
	}

	public CustomPosType customPosType;

	public PosModifyType posModifyType;

	protected override Vector3 Evaluate(ActionMemory memory)
	{
		Vector3 vector = Vector3.zero;
		switch (customPosType)
		{
		case CustomPosType.blackBoardValue:
			return vector;
		case CustomPosType.jumpInbornPos:
			vector = memory.target.entity.GetCompAI().jumpInbornPos;
			break;
		case CustomPosType.spawnPos:
			vector = memory.target.entity.GetCompAI().pos;
			break;
		}
		if (posModifyType.HasFlag(PosModifyType.RayProjected2Ground))
		{
			vector = GroundPosition(vector, 20f);
		}
		return vector;
	}

	public static Vector3 GroundPosition(Vector3 position, float distance)
	{
		Vector3 down = Vector3.down;
		if (Physics.Raycast(new Ray(position, down), out var hitInfo, distance, BattleConsts.enviromentMask))
		{
			return hitInfo.point;
		}
		return position;
	}
}
