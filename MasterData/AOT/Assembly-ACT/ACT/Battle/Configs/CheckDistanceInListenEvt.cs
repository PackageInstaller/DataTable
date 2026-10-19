using ACT.Utility;
using Bamboo.ECS;

namespace ACT.Battle.Configs;

[AbilityTypeMetadata("判断距离中事件", "Predicate", new string[] { "check", "distance", "in", "listen", "evt", "vector", "position", "rotation", "quaternion", "predicate" })]
public class CheckDistanceInListenEvt : ConfigPredicate
{
	public DistanceType distanceType;

	public ConfigFunction<float> distanceFunction;

	public Condition condition;

	public override bool Check(ActionMemory memory)
	{
		bool result = false;
		if (memory.evt is IGetAttackData getAttackData)
		{
			Entity attackee = getAttackData.GetAttackData().attackee;
			Entity attacker = getAttackData.GetAttackData().attacker;
			float twoPointDistance = AbilityUtility.GetTwoPointDistance(attackee, attacker, distanceType);
			float b = distanceFunction.Return(memory);
			result = AbilityUtility.GetTwoFloatCondition(twoPointDistance, b, condition);
		}
		return result;
	}
}
