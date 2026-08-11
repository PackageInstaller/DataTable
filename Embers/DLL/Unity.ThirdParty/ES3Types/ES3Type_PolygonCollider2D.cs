using UnityEngine;
using UnityEngine.Scripting;

namespace ES3Types;

[Preserve]
[ES3Properties(new string[] { "points", "pathCount", "paths", "density", "isTrigger", "usedByEffector", "offset", "sharedMaterial", "enabled" })]
public class ES3Type_PolygonCollider2D : ES3ComponentType
{
	public static ES3Type Instance;

	public ES3Type_PolygonCollider2D()
		: base(typeof(PolygonCollider2D))
	{
		Instance = this;
	}

	protected override void WriteComponent(object obj, ES3Writer writer)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Expected O, but got Unknown
		PolygonCollider2D val = (PolygonCollider2D)obj;
		writer.WriteProperty("points", val.points, ES3Type_Vector2Array.Instance);
		writer.WriteProperty("pathCount", val.pathCount, ES3Type_int.Instance);
		for (int i = 0; i < val.pathCount; i++)
		{
			writer.WriteProperty("path" + i, val.GetPath(i), ES3Type_Vector2Array.Instance);
		}
		if ((Object)(object)((Collider2D)val).attachedRigidbody != null && ((Collider2D)val).attachedRigidbody.useAutoMass)
		{
			writer.WriteProperty("density", ((Collider2D)val).density, ES3Type_float.Instance);
		}
		writer.WriteProperty("isTrigger", ((Collider2D)val).isTrigger, ES3Type_bool.Instance);
		writer.WriteProperty("usedByEffector", ((Collider2D)val).usedByEffector, ES3Type_bool.Instance);
		writer.WriteProperty("offset", ((Collider2D)val).offset, ES3Type_Vector2.Instance);
		writer.WriteProperty("sharedMaterial", ((Collider2D)val).sharedMaterial);
		writer.WriteProperty("enabled", ((Behaviour)(object)val).enabled, ES3Type_bool.Instance);
	}

	protected override void ReadComponent<T>(ES3Reader reader, object obj)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Expected O, but got Unknown
		PolygonCollider2D val = (PolygonCollider2D)obj;
		foreach (string property in reader.Properties)
		{
			switch (property)
			{
			case "points":
				val.points = reader.Read<Vector2[]>(ES3Type_Vector2Array.Instance);
				break;
			case "pathCount":
			{
				int num = reader.Read<int>(ES3Type_int.Instance);
				for (int i = 0; i < num; i++)
				{
					val.SetPath(i, reader.ReadProperty<Vector2[]>(ES3Type_Vector2Array.Instance));
				}
				break;
			}
			case "density":
				((Collider2D)val).density = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "isTrigger":
				((Collider2D)val).isTrigger = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "usedByEffector":
				((Collider2D)val).usedByEffector = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "offset":
				((Collider2D)val).offset = reader.Read<Vector2>(ES3Type_Vector2.Instance);
				break;
			case "sharedMaterial":
				((Collider2D)val).sharedMaterial = reader.Read<PhysicsMaterial2D>(ES3Type_PhysicsMaterial2D.Instance);
				break;
			case "enabled":
				((Behaviour)(object)val).enabled = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			default:
				reader.Skip();
				break;
			}
		}
	}
}
