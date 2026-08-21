using UnityEngine;
using UnityEngine.Scripting;

namespace ES3Types;

[Preserve]
[ES3Properties(new string[] { "dynamicFriction", "staticFriction", "bounciness", "frictionCombine", "bounceCombine" })]
public class ES3Type_PhysicMaterial : ES3ObjectType
{
	public static ES3Type Instance;

	public ES3Type_PhysicMaterial()
		: base(typeof(PhysicMaterial))
	{
		Instance = this;
	}

	protected override void WriteObject(object obj, ES3Writer writer)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Expected O, but got Unknown
		//IL_005f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0075: Unknown result type (might be due to invalid IL or missing references)
		PhysicMaterial val = (PhysicMaterial)obj;
		writer.WriteProperty("dynamicFriction", val.dynamicFriction, ES3Type_float.Instance);
		writer.WriteProperty("staticFriction", val.staticFriction, ES3Type_float.Instance);
		writer.WriteProperty("bounciness", val.bounciness, ES3Type_float.Instance);
		writer.WriteProperty("frictionCombine", val.frictionCombine);
		writer.WriteProperty("bounceCombine", val.bounceCombine);
	}

	protected override void ReadObject<T>(ES3Reader reader, object obj)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Expected O, but got Unknown
		//IL_00a2: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b0: Unknown result type (might be due to invalid IL or missing references)
		PhysicMaterial val = (PhysicMaterial)obj;
		foreach (string property in reader.Properties)
		{
			switch (property)
			{
			case "dynamicFriction":
				val.dynamicFriction = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "staticFriction":
				val.staticFriction = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "bounciness":
				val.bounciness = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "frictionCombine":
				val.frictionCombine = reader.Read<PhysicMaterialCombine>();
				break;
			case "bounceCombine":
				val.bounceCombine = reader.Read<PhysicMaterialCombine>();
				break;
			default:
				reader.Skip();
				break;
			}
		}
	}

	protected override object ReadObject<T>(ES3Reader reader)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Expected O, but got Unknown
		PhysicMaterial val = new PhysicMaterial();
		ReadObject<T>(reader, val);
		return val;
	}
}
