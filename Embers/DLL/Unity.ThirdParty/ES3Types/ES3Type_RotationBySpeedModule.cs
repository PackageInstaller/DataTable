using UnityEngine;
using UnityEngine.Scripting;

namespace ES3Types;

[Preserve]
[ES3Properties(new string[] { "enabled", "x", "xMultiplier", "y", "yMultiplier", "z", "zMultiplier", "separateAxes", "range" })]
public class ES3Type_RotationBySpeedModule : ES3Type
{
	public static ES3Type Instance;

	public ES3Type_RotationBySpeedModule()
		: base(typeof(RotationBySpeedModule))
	{
		Instance = this;
	}

	public override void Write(object obj, ES3Writer writer)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_002b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0063: Unknown result type (might be due to invalid IL or missing references)
		//IL_009b: Unknown result type (might be due to invalid IL or missing references)
		RotationBySpeedModule val = (RotationBySpeedModule)obj;
		writer.WriteProperty("enabled", ((RotationBySpeedModule)(ref val)).enabled, ES3Type_bool.Instance);
		writer.WriteProperty("x", ((RotationBySpeedModule)(ref val)).x, ES3Type_MinMaxCurve.Instance);
		writer.WriteProperty("xMultiplier", ((RotationBySpeedModule)(ref val)).xMultiplier, ES3Type_float.Instance);
		writer.WriteProperty("y", ((RotationBySpeedModule)(ref val)).y, ES3Type_MinMaxCurve.Instance);
		writer.WriteProperty("yMultiplier", ((RotationBySpeedModule)(ref val)).yMultiplier, ES3Type_float.Instance);
		writer.WriteProperty("z", ((RotationBySpeedModule)(ref val)).z, ES3Type_MinMaxCurve.Instance);
		writer.WriteProperty("zMultiplier", ((RotationBySpeedModule)(ref val)).zMultiplier, ES3Type_float.Instance);
		writer.WriteProperty("separateAxes", ((RotationBySpeedModule)(ref val)).separateAxes, ES3Type_bool.Instance);
		writer.WriteProperty("range", ((RotationBySpeedModule)(ref val)).range, ES3Type_Vector2.Instance);
	}

	public override object Read<T>(ES3Reader reader)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_000a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0015: Unknown result type (might be due to invalid IL or missing references)
		RotationBySpeedModule val = default(RotationBySpeedModule);
		ReadInto<T>(reader, val);
		return val;
	}

	public override void ReadInto<T>(ES3Reader reader, object obj)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_019a: Unknown result type (might be due to invalid IL or missing references)
		//IL_016f: Unknown result type (might be due to invalid IL or missing references)
		//IL_01c2: Unknown result type (might be due to invalid IL or missing references)
		RotationBySpeedModule val = (RotationBySpeedModule)obj;
		string text;
		while ((text = reader.ReadPropertyName()) != null)
		{
			switch (text)
			{
			case "enabled":
				((RotationBySpeedModule)(ref val)).enabled = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "x":
				((RotationBySpeedModule)(ref val)).x = reader.Read<MinMaxCurve>(ES3Type_MinMaxCurve.Instance);
				break;
			case "xMultiplier":
				((RotationBySpeedModule)(ref val)).xMultiplier = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "y":
				((RotationBySpeedModule)(ref val)).y = reader.Read<MinMaxCurve>(ES3Type_MinMaxCurve.Instance);
				break;
			case "yMultiplier":
				((RotationBySpeedModule)(ref val)).yMultiplier = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "z":
				((RotationBySpeedModule)(ref val)).z = reader.Read<MinMaxCurve>(ES3Type_MinMaxCurve.Instance);
				break;
			case "zMultiplier":
				((RotationBySpeedModule)(ref val)).zMultiplier = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "separateAxes":
				((RotationBySpeedModule)(ref val)).separateAxes = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "range":
				((RotationBySpeedModule)(ref val)).range = reader.Read<Vector2>(ES3Type_Vector2.Instance);
				break;
			default:
				reader.Skip();
				break;
			}
		}
	}
}
