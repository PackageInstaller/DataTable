using ACT.Battle.Configs;
using Bamboo.ECS;
using BehaviorDesigner.Runtime;
using BehaviorDesigner.Runtime.Tasks;

namespace ACT.Battle;

[TaskCategory("ACT/待定要好好想想的")]
[TaskDescription("判断仇恨目标的参数 是否与 给定的参数相等，相等返回结果True，不相等结果返回False , inverser=True表示将结果取反，即 不相等返回True，相等返回False")]
public class CheckHatredParameter : Conditional
{
	public string parameter;

	public bool useSharedValue;

	public SharedString sharedParameter;

	public ConfigAnimParameterType type;

	public float tagetFloat;

	public int targetInt;

	public bool targetBoolean;

	public bool inverser;

	public override TaskStatus OnUpdate()
	{
		if (type == ConfigAnimParameterType.Trigger)
		{
			return TaskStatus.Failure;
		}
		Entity hatredTarget = ((ActBehaviorTree)Owner).Entity.GetCompHatred().hatredTarget;
		if (!hatredTarget.IsValid)
		{
			return TaskStatus.Failure;
		}
		bool flag = false;
		if (!useSharedValue)
		{
			hatredTarget.GetCompMotion().parameters.TryGetValue(parameter, out var value);
			flag = type switch
			{
				ConfigAnimParameterType.Float => value.defaultFloat == tagetFloat, 
				ConfigAnimParameterType.Int => value.defaultInt == targetInt, 
				ConfigAnimParameterType.Bool => value.defaultBool == targetBoolean, 
				_ => flag, 
			};
		}
		else
		{
			hatredTarget.GetCompMotion().parameters.TryGetValue(sharedParameter.Value, out var value2);
			flag = type switch
			{
				ConfigAnimParameterType.Float => value2.defaultFloat == tagetFloat, 
				ConfigAnimParameterType.Int => value2.defaultInt == targetInt, 
				ConfigAnimParameterType.Bool => value2.defaultBool == targetBoolean, 
				_ => flag, 
			};
		}
		if (flag ^ inverser)
		{
			return TaskStatus.Success;
		}
		return TaskStatus.Failure;
	}
}
