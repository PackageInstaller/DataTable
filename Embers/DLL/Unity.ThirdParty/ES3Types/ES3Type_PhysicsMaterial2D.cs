using UnityEngine;
using UnityEngine.Scripting;

namespace ES3Types;

[ES3Properties(new string[] { "bounciness", "friction" })]
[Preserve]
public class ES3Type_PhysicsMaterial2D : ES3ObjectType
{
	public static ES3Type Instance;

	public ES3Type_PhysicsMaterial2D()
		: base(typeof(PhysicsMaterial2D))
	{
		Instance = this;
	}

	protected override void WriteObject(object obj, ES3Writer writer)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Expected O, but got Unknown
		PhysicsMaterial2D val = (PhysicsMaterial2D)obj;
		writer.WriteProperty("bounciness", val.bounciness, ES3Type_float.Instance);
		writer.WriteProperty("friction", val.friction, ES3Type_float.Instance);
	}

	protected override void ReadObject<T>(ES3Reader reader, object obj)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Expected O, but got Unknown
		PhysicsMaterial2D val = (PhysicsMaterial2D)obj;
		foreach (string property in reader.Properties)
		{
			if (!(property == "bounciness"))
			{
				if (property == "friction")
				{
					val.friction = reader.Read<float>(ES3Type_float.Instance);
				}
				else
				{
					reader.Skip();
				}
			}
			else
			{
				val.bounciness = reader.Read<float>(ES3Type_float.Instance);
			}
		}
	}

	protected override object ReadObject<T>(ES3Reader reader)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Expected O, but got Unknown
		PhysicsMaterial2D val = new PhysicsMaterial2D();
		ReadObject<T>(reader, val);
		return val;
	}
}
