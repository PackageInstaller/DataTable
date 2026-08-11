using UnityEngine;
using UnityEngine.Scripting;

namespace ES3Types;

[Preserve]
[ES3Properties(new string[] { "center", "radius", "enabled", "isTrigger", "contactOffset", "sharedMaterial" })]
public class ES3Type_SphereCollider : ES3ComponentType
{
	public static ES3Type Instance;

	public ES3Type_SphereCollider()
		: base(typeof(SphereCollider))
	{
		Instance = this;
	}

	protected override void WriteComponent(object obj, ES3Writer writer)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Expected O, but got Unknown
		SphereCollider val = (SphereCollider)obj;
		writer.WriteProperty("center", val.center, ES3Type_Vector3.Instance);
		writer.WriteProperty("radius", val.radius, ES3Type_float.Instance);
		writer.WriteProperty("enabled", ((Collider)val).enabled, ES3Type_bool.Instance);
		writer.WriteProperty("isTrigger", ((Collider)val).isTrigger, ES3Type_bool.Instance);
		writer.WriteProperty("contactOffset", ((Collider)val).contactOffset, ES3Type_float.Instance);
		writer.WritePropertyByRef("material", (Object)(object)((Collider)val).sharedMaterial);
	}

	protected override void ReadComponent<T>(ES3Reader reader, object obj)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Expected O, but got Unknown
		SphereCollider val = (SphereCollider)obj;
		foreach (string property in reader.Properties)
		{
			switch (property)
			{
			case "center":
				val.center = reader.Read<Vector3>(ES3Type_Vector3.Instance);
				break;
			case "radius":
				val.radius = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "enabled":
				((Collider)val).enabled = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "isTrigger":
				((Collider)val).isTrigger = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "contactOffset":
				((Collider)val).contactOffset = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "material":
				((Collider)val).sharedMaterial = reader.Read<PhysicMaterial>();
				break;
			default:
				reader.Skip();
				break;
			}
		}
	}
}
