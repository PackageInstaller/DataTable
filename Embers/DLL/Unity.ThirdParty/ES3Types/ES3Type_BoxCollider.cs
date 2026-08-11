using UnityEngine;
using UnityEngine.Scripting;

namespace ES3Types;

[Preserve]
[ES3Properties(new string[] { "center", "size", "enabled", "isTrigger", "contactOffset", "sharedMaterial" })]
public class ES3Type_BoxCollider : ES3ComponentType
{
	public static ES3Type Instance;

	public ES3Type_BoxCollider()
		: base(typeof(BoxCollider))
	{
		Instance = this;
	}

	protected override void WriteComponent(object obj, ES3Writer writer)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Expected O, but got Unknown
		BoxCollider val = (BoxCollider)obj;
		writer.WriteProperty("center", val.center);
		writer.WriteProperty("size", val.size);
		writer.WriteProperty("enabled", ((Collider)val).enabled);
		writer.WriteProperty("isTrigger", ((Collider)val).isTrigger);
		writer.WriteProperty("contactOffset", ((Collider)val).contactOffset);
		writer.WritePropertyByRef("material", (Object)(object)((Collider)val).sharedMaterial);
	}

	protected override void ReadComponent<T>(ES3Reader reader, object obj)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Expected O, but got Unknown
		BoxCollider val = (BoxCollider)obj;
		foreach (string property in reader.Properties)
		{
			switch (property)
			{
			case "center":
				val.center = reader.Read<Vector3>();
				break;
			case "size":
				val.size = reader.Read<Vector3>();
				break;
			case "enabled":
				((Collider)val).enabled = reader.Read<bool>();
				break;
			case "isTrigger":
				((Collider)val).isTrigger = reader.Read<bool>();
				break;
			case "contactOffset":
				((Collider)val).contactOffset = reader.Read<float>();
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
