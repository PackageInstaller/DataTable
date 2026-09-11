using UnityEngine;

[CreateAssetMenu(menuName = "SummerRace/ModularVehicle/Wheel Module", fileName = "WheelModule")]
public class WheelModuleDefinition : ModuleDefinition
{
	[Header("Wheel Geometry")]
	[Min(0.05f)]
	public float radius = 0.35f;

	[Min(0.05f)]
	public float width = 0.2f;

	[Header("Wheel Physics")]
	[Min(0.05f)]
	public float grip = 1f;

	[Min(0f)]
	public float suspensionLength = 0.35f;

	[Min(0f)]
	public float springStrength = 450f;

	[Min(0f)]
	public float damping = 45f;

	[Min(0f)]
	public float maxMotorTorque = 900f;

	[Min(0f)]
	public float maxAngularVelocity = 26f;

	[Min(0f)]
	public float rollingResistance = 0.7f;

	[Header("Config")]
	public bool steerable;

	public bool powered = true;

	[Header("SummerRace Compatibility")]
	public string wheelName = "Wheel";

	public override VehicleMountType MountType => VehicleMountType.Wheel;
}
