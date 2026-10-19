using UnityEngine;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断距离Tance", "Predicate", new string[] { "check", "dis", "tance", "predicate", "condition" })]
public class CheckDisTance : ConfigPredicate
{
	public ConfigFunction<Vector3> target1;

	public ConfigFunction<Vector3> target2;

	public ConfigFunction<float> targetValue;

	public Condition condition;

	public DistanceType distanceType;

	public override bool Check(ActionMemory memory)
	{
		Vector3 vector = target1.Return(memory);
		Vector3 vector2 = target2.Return(memory);
		float num = targetValue.Return(memory);
		float num2 = 0f;
		switch (distanceType)
		{
		case DistanceType.horizontal:
			num2 = Mathf.Abs(vector.x - vector2.x);
			break;
		case DistanceType.vertical:
			num2 = Mathf.Abs(vector.y - vector2.y);
			break;
		case DistanceType.line:
			num2 = (vector - vector2).sqrMagnitude;
			break;
		case DistanceType.forward:
			num2 = Mathf.Abs(vector.z - vector2.z);
			break;
		}
		bool flag = num2 < num;
		switch (condition)
		{
		case Condition.Greater:
		case Condition.GreaterAndEqual:
			flag = !flag;
			break;
		}
		return flag;
	}
}
