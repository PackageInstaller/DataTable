using UnityEngine;
using UnityEngine.Scripting;

namespace ES3Types;

[Preserve]
[ES3Properties(new string[]
{
	"enabled", "shapeType", "randomDirectionAmount", "sphericalDirectionAmount", "alignToDirection", "radius", "angle", "length", "box", "meshShapeType",
	"mesh", "meshRenderer", "skinnedMeshRenderer", "useMeshMaterialIndex", "meshMaterialIndex", "useMeshColors", "normalOffset", "meshScale", "arc"
})]
public class ES3Type_ShapeModule : ES3Type
{
	public static ES3Type Instance;

	public ES3Type_ShapeModule()
		: base(typeof(ShapeModule))
	{
		Instance = this;
	}

	public override void Write(object obj, ES3Writer writer)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_002b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0106: Unknown result type (might be due to invalid IL or missing references)
		ShapeModule val = (ShapeModule)obj;
		writer.WriteProperty("enabled", ((ShapeModule)(ref val)).enabled, ES3Type_bool.Instance);
		writer.WriteProperty("shapeType", ((ShapeModule)(ref val)).shapeType);
		writer.WriteProperty("randomDirectionAmount", ((ShapeModule)(ref val)).randomDirectionAmount, ES3Type_float.Instance);
		writer.WriteProperty("sphericalDirectionAmount", ((ShapeModule)(ref val)).sphericalDirectionAmount, ES3Type_float.Instance);
		writer.WriteProperty("alignToDirection", ((ShapeModule)(ref val)).alignToDirection, ES3Type_bool.Instance);
		writer.WriteProperty("radius", ((ShapeModule)(ref val)).radius, ES3Type_float.Instance);
		writer.WriteProperty("angle", ((ShapeModule)(ref val)).angle, ES3Type_float.Instance);
		writer.WriteProperty("length", ((ShapeModule)(ref val)).length, ES3Type_float.Instance);
		writer.WriteProperty("scale", ((ShapeModule)(ref val)).scale, ES3Type_Vector3.Instance);
		writer.WriteProperty("meshShapeType", ((ShapeModule)(ref val)).meshShapeType);
		writer.WritePropertyByRef("mesh", ((ShapeModule)(ref val)).mesh);
		writer.WritePropertyByRef("meshRenderer", ((ShapeModule)(ref val)).meshRenderer);
		writer.WritePropertyByRef("skinnedMeshRenderer", ((ShapeModule)(ref val)).skinnedMeshRenderer);
		writer.WriteProperty("useMeshMaterialIndex", ((ShapeModule)(ref val)).useMeshMaterialIndex, ES3Type_bool.Instance);
		writer.WriteProperty("meshMaterialIndex", ((ShapeModule)(ref val)).meshMaterialIndex, ES3Type_int.Instance);
		writer.WriteProperty("useMeshColors", ((ShapeModule)(ref val)).useMeshColors, ES3Type_bool.Instance);
		writer.WriteProperty("normalOffset", ((ShapeModule)(ref val)).normalOffset, ES3Type_float.Instance);
		writer.WriteProperty("arc", ((ShapeModule)(ref val)).arc, ES3Type_float.Instance);
	}

	public override object Read<T>(ES3Reader reader)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_000a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0015: Unknown result type (might be due to invalid IL or missing references)
		ShapeModule val = default(ShapeModule);
		ReadInto<T>(reader, val);
		return val;
	}

	public override void ReadInto<T>(ES3Reader reader, object obj)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_02ca: Unknown result type (might be due to invalid IL or missing references)
		//IL_037d: Unknown result type (might be due to invalid IL or missing references)
		ShapeModule val = (ShapeModule)obj;
		string text;
		while ((text = reader.ReadPropertyName()) != null)
		{
			switch (text)
			{
			case "enabled":
				((ShapeModule)(ref val)).enabled = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "shapeType":
				((ShapeModule)(ref val)).shapeType = reader.Read<ParticleSystemShapeType>();
				break;
			case "randomDirectionAmount":
				((ShapeModule)(ref val)).randomDirectionAmount = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "sphericalDirectionAmount":
				((ShapeModule)(ref val)).sphericalDirectionAmount = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "alignToDirection":
				((ShapeModule)(ref val)).alignToDirection = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "radius":
				((ShapeModule)(ref val)).radius = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "angle":
				((ShapeModule)(ref val)).angle = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "length":
				((ShapeModule)(ref val)).length = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "scale":
				((ShapeModule)(ref val)).scale = reader.Read<Vector3>(ES3Type_Vector3.Instance);
				break;
			case "meshShapeType":
				((ShapeModule)(ref val)).meshShapeType = reader.Read<ParticleSystemMeshShapeType>();
				break;
			case "mesh":
				((ShapeModule)(ref val)).mesh = reader.Read<Mesh>();
				break;
			case "meshRenderer":
				((ShapeModule)(ref val)).meshRenderer = reader.Read<MeshRenderer>();
				break;
			case "skinnedMeshRenderer":
				((ShapeModule)(ref val)).skinnedMeshRenderer = reader.Read<SkinnedMeshRenderer>();
				break;
			case "useMeshMaterialIndex":
				((ShapeModule)(ref val)).useMeshMaterialIndex = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "meshMaterialIndex":
				((ShapeModule)(ref val)).meshMaterialIndex = reader.Read<int>(ES3Type_int.Instance);
				break;
			case "useMeshColors":
				((ShapeModule)(ref val)).useMeshColors = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "normalOffset":
				((ShapeModule)(ref val)).normalOffset = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "arc":
				((ShapeModule)(ref val)).arc = reader.Read<float>(ES3Type_float.Instance);
				break;
			default:
				reader.Skip();
				break;
			}
		}
	}
}
