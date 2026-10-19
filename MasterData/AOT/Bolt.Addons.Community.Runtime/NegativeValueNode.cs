using Unity.VisualScripting;
using UnityEngine;

[TypeIcon(typeof(Negate))]
[UnitTitle("Negate")]
[UnitCategory("Community\\Math")]
public class NegativeValueNode : Unit
{
	[Inspectable]
	[UnitHeaderInspectable]
	public NegateType type;

	[DoNotSerialize]
	public ValueInput Float;

	[DoNotSerialize]
	public ValueInput Int;

	[DoNotSerialize]
	public ValueInput Vector2;

	[DoNotSerialize]
	public ValueInput Vector3;

	[DoNotSerialize]
	public ValueOutput output;

	protected override void Definition()
	{
		switch (type)
		{
		case NegateType.Float:
			Float = ValueInput<float>("Float");
			break;
		case NegateType.Int:
			Int = ValueInput<int>("Int");
			break;
		case NegateType.Vector2:
			Vector2 = ValueInput<Vector2>("Vector2");
			break;
		case NegateType.Vector3:
			Vector3 = ValueInput<Vector3>("Vector3");
			break;
		default:
			Float = ValueInput<float>("Float");
			break;
		}
		output = ValueOutput("output", GetNegativeValue);
	}

	private object GetNegativeValue(Flow flow)
	{
		return type switch
		{
			NegateType.Float => (object)(0f - flow.GetValue<float>(Float)), 
			NegateType.Int => -flow.GetValue<int>(Int), 
			NegateType.Vector2 => -flow.GetValue<Vector2>(Vector2), 
			NegateType.Vector3 => -flow.GetValue<Vector3>(Vector3), 
			_ => 0f - flow.GetValue<float>(Float), 
		};
	}
}
