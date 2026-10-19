using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断该位置的目标2相对到目标1", "Predicate", new string[] { "check", "the", "position", "of", "target", "relative", "to", "retarget", "aim", "predicate" })]
public class CheckThePositionOfTarget2RelativeToTarget1 : ConfigPredicate
{
	public enum CheckFaceDirType
	{
		front,
		back
	}

	public enum CheckCheckThePositionOfTarget2RelativeToTarget1Type
	{
		normal,
		dontCheckTargetFaceDir
	}

	public ConfigFunction<Vector3> target1;

	public ConfigFunction<Vector3> target2;

	public CheckCheckThePositionOfTarget2RelativeToTarget1Type checkCheckThePositionOfTarget2RelativeToTarget1Type;

	public CheckFaceDirType faceDirType;

	public override bool Check(ActionMemory memory)
	{
		bool result = false;
		Vector3 vector = target1.Return(memory);
		Vector3 vector2 = target2.Return(memory);
		bool flag = vector2.x < vector.x;
		switch (checkCheckThePositionOfTarget2RelativeToTarget1Type)
		{
		case CheckCheckThePositionOfTarget2RelativeToTarget1Type.normal:
			switch (faceDirType)
			{
			case CheckFaceDirType.front:
				result = flag == memory.target.entity.IsFaceLeft();
				break;
			case CheckFaceDirType.back:
				result = flag != memory.target.entity.IsFaceLeft();
				break;
			}
			break;
		case CheckCheckThePositionOfTarget2RelativeToTarget1Type.dontCheckTargetFaceDir:
			switch (faceDirType)
			{
			case CheckFaceDirType.front:
				result = vector2.x > vector.x;
				break;
			case CheckFaceDirType.back:
				result = vector2.x < vector.x;
				break;
			}
			break;
		}
		return result;
	}
}
