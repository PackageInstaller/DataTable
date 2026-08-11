using UnityEngine;
using UnityEngine.Scripting;

namespace ES3Types;

[ES3Properties(new string[] { "size", "density", "isTrigger", "usedByEffector", "offset", "sharedMaterial", "enabled" })]
[Preserve]
public class ES3Type_BoxCollider2D : ES3ComponentType
{
	public static ES3Type Instance;

	public ES3Type_BoxCollider2D()
		: base(typeof(BoxCollider2D))
	{
		Instance = this;
	}

	protected override void WriteComponent(object obj, ES3Writer writer)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Expected O, but got Unknown
		BoxCollider2D val = (BoxCollider2D)obj;
		writer.WriteProperty("size", val.size);
		if ((Object)(object)((Collider2D)val).attachedRigidbody != null && ((Collider2D)val).attachedRigidbody.useAutoMass)
		{
			writer.WriteProperty("density", ((Collider2D)val).density);
		}
		writer.WriteProperty("isTrigger", ((Collider2D)val).isTrigger);
		writer.WriteProperty("usedByEffector", ((Collider2D)val).usedByEffector);
		writer.WriteProperty("offset", ((Collider2D)val).offset);
		writer.WritePropertyByRef("sharedMaterial", (Object)(object)((Collider2D)val).sharedMaterial);
		writer.WriteProperty("enabled", ((Behaviour)(object)val).enabled);
	}

	protected override void ReadComponent<T>(ES3Reader reader, object obj)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Expected O, but got Unknown
		BoxCollider2D val = (BoxCollider2D)obj;
		foreach (string property in reader.Properties)
		{
			switch (property)
			{
			case "size":
				val.size = reader.Read<Vector2>();
				break;
			case "density":
				((Collider2D)val).density = reader.Read<float>();
				break;
			case "isTrigger":
				((Collider2D)val).isTrigger = reader.Read<bool>();
				break;
			case "usedByEffector":
				((Collider2D)val).usedByEffector = reader.Read<bool>();
				break;
			case "offset":
				((Collider2D)val).offset = reader.Read<Vector2>();
				break;
			case "sharedMaterial":
				((Collider2D)val).sharedMaterial = reader.Read<PhysicsMaterial2D>();
				break;
			case "enabled":
				((Behaviour)(object)val).enabled = reader.Read<bool>();
				break;
			default:
				reader.Skip();
				break;
			}
		}
	}
}
