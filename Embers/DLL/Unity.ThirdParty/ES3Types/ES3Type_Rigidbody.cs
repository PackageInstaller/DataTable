using UnityEngine;
using UnityEngine.Scripting;

namespace ES3Types;

[ES3Properties(new string[]
{
	"velocity", "angularVelocity", "drag", "angularDrag", "mass", "useGravity", "maxDepenetrationVelocity", "isKinematic", "freezeRotation", "constraints",
	"collisionDetectionMode", "centerOfMass", "inertiaTensorRotation", "inertiaTensor", "detectCollisions", "position", "rotation", "interpolation", "solverIterations", "sleepThreshold",
	"maxAngularVelocity", "solverVelocityIterations"
})]
[Preserve]
public class ES3Type_Rigidbody : ES3ComponentType
{
	public static ES3Type Instance;

	public ES3Type_Rigidbody()
		: base(typeof(Rigidbody))
	{
		Instance = this;
		priority = 1;
	}

	protected override void WriteComponent(object obj, ES3Writer writer)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Expected O, but got Unknown
		//IL_0101: Unknown result type (might be due to invalid IL or missing references)
		//IL_0117: Unknown result type (might be due to invalid IL or missing references)
		//IL_0199: Unknown result type (might be due to invalid IL or missing references)
		Rigidbody val = (Rigidbody)obj;
		writer.WriteProperty("velocity", val.velocity, ES3Type_Vector3.Instance);
		writer.WriteProperty("angularVelocity", val.angularVelocity, ES3Type_Vector3.Instance);
		writer.WriteProperty("drag", val.drag, ES3Type_float.Instance);
		writer.WriteProperty("angularDrag", val.angularDrag, ES3Type_float.Instance);
		writer.WriteProperty("mass", val.mass, ES3Type_float.Instance);
		writer.WriteProperty("useGravity", val.useGravity, ES3Type_bool.Instance);
		writer.WriteProperty("maxDepenetrationVelocity", val.maxDepenetrationVelocity, ES3Type_float.Instance);
		writer.WriteProperty("isKinematic", val.isKinematic, ES3Type_bool.Instance);
		writer.WriteProperty("freezeRotation", val.freezeRotation, ES3Type_bool.Instance);
		writer.WriteProperty("constraints", val.constraints);
		writer.WriteProperty("collisionDetectionMode", val.collisionDetectionMode);
		writer.WriteProperty("centerOfMass", val.centerOfMass, ES3Type_Vector3.Instance);
		writer.WriteProperty("detectCollisions", val.detectCollisions, ES3Type_bool.Instance);
		writer.WriteProperty("position", val.position, ES3Type_Vector3.Instance);
		writer.WriteProperty("rotation", val.rotation, ES3Type_Quaternion.Instance);
		writer.WriteProperty("interpolation", val.interpolation);
		writer.WriteProperty("solverIterations", val.solverIterations, ES3Type_int.Instance);
		writer.WriteProperty("sleepThreshold", val.sleepThreshold, ES3Type_float.Instance);
		writer.WriteProperty("maxAngularVelocity", val.maxAngularVelocity, ES3Type_float.Instance);
		writer.WriteProperty("solverVelocityIterations", val.solverVelocityIterations, ES3Type_int.Instance);
	}

	protected override void ReadComponent<T>(ES3Reader reader, object obj)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Expected O, but got Unknown
		//IL_043f: Unknown result type (might be due to invalid IL or missing references)
		//IL_04e0: Unknown result type (might be due to invalid IL or missing references)
		//IL_042e: Unknown result type (might be due to invalid IL or missing references)
		Rigidbody val = (Rigidbody)obj;
		foreach (string property in reader.Properties)
		{
			switch (property)
			{
			case "velocity":
				val.velocity = reader.Read<Vector3>(ES3Type_Vector3.Instance);
				break;
			case "angularVelocity":
				val.angularVelocity = reader.Read<Vector3>(ES3Type_Vector3.Instance);
				break;
			case "drag":
				val.drag = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "angularDrag":
				val.angularDrag = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "mass":
				val.mass = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "useGravity":
				val.useGravity = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "maxDepenetrationVelocity":
				val.maxDepenetrationVelocity = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "isKinematic":
				val.isKinematic = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "freezeRotation":
				val.freezeRotation = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "constraints":
				val.constraints = reader.Read<RigidbodyConstraints>();
				break;
			case "collisionDetectionMode":
				val.collisionDetectionMode = reader.Read<CollisionDetectionMode>();
				break;
			case "centerOfMass":
				val.centerOfMass = reader.Read<Vector3>(ES3Type_Vector3.Instance);
				break;
			case "inertiaTensorRotation":
				val.inertiaTensorRotation = reader.Read<Quaternion>(ES3Type_Quaternion.Instance);
				break;
			case "inertiaTensor":
			{
				Vector3 vector = reader.Read<Vector3>(ES3Type_Vector3.Instance);
				if (vector != Vector3.zero)
				{
					val.inertiaTensor = vector;
				}
				break;
			}
			case "detectCollisions":
				val.detectCollisions = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "position":
				val.position = reader.Read<Vector3>(ES3Type_Vector3.Instance);
				break;
			case "rotation":
				val.rotation = reader.Read<Quaternion>(ES3Type_Quaternion.Instance);
				break;
			case "interpolation":
				val.interpolation = reader.Read<RigidbodyInterpolation>();
				break;
			case "solverIterations":
				val.solverIterations = reader.Read<int>(ES3Type_int.Instance);
				break;
			case "sleepThreshold":
				val.sleepThreshold = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "maxAngularVelocity":
				val.maxAngularVelocity = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "solverVelocityIterations":
				val.solverVelocityIterations = reader.Read<int>(ES3Type_int.Instance);
				break;
			default:
				reader.Skip();
				break;
			}
		}
	}
}
