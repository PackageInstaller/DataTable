using UnityEngine;
using UnityEngine.Scripting;

namespace ES3Types;

[Preserve]
[ES3Properties(new string[] { "enabled", "x", "xMultiplier", "y", "yMultiplier", "z", "zMultiplier", "separateAxes" })]
public class ES3Type_RotationOverLifetimeModule : ES3Type
{
	public static ES3Type Instance;

	public ES3Type_RotationOverLifetimeModule()
		: base(typeof(RotationOverLifetimeModule))
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
		RotationOverLifetimeModule val = (RotationOverLifetimeModule)obj;
		writer.WriteProperty("enabled", ((RotationOverLifetimeModule)(ref val)).enabled, ES3Type_bool.Instance);
		writer.WriteProperty("x", ((RotationOverLifetimeModule)(ref val)).x, ES3Type_MinMaxCurve.Instance);
		writer.WriteProperty("xMultiplier", ((RotationOverLifetimeModule)(ref val)).xMultiplier, ES3Type_float.Instance);
		writer.WriteProperty("y", ((RotationOverLifetimeModule)(ref val)).y, ES3Type_MinMaxCurve.Instance);
		writer.WriteProperty("yMultiplier", ((RotationOverLifetimeModule)(ref val)).yMultiplier, ES3Type_float.Instance);
		writer.WriteProperty("z", ((RotationOverLifetimeModule)(ref val)).z, ES3Type_MinMaxCurve.Instance);
		writer.WriteProperty("zMultiplier", ((RotationOverLifetimeModule)(ref val)).zMultiplier, ES3Type_float.Instance);
		writer.WriteProperty("separateAxes", ((RotationOverLifetimeModule)(ref val)).separateAxes, ES3Type_bool.Instance);
	}

	public override object Read<T>(ES3Reader reader)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_000a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0015: Unknown result type (might be due to invalid IL or missing references)
		RotationOverLifetimeModule val = default(RotationOverLifetimeModule);
		ReadInto<T>(reader, val);
		return val;
	}

	public override void ReadInto<T>(ES3Reader reader, object obj)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_014f: Unknown result type (might be due to invalid IL or missing references)
		//IL_019f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0177: Unknown result type (might be due to invalid IL or missing references)
		RotationOverLifetimeModule val = (RotationOverLifetimeModule)obj;
		string text;
		while ((text = reader.ReadPropertyName()) != null)
		{
			switch (text)
			{
			case "enabled":
				((RotationOverLifetimeModule)(ref val)).enabled = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "x":
				((RotationOverLifetimeModule)(ref val)).x = reader.Read<MinMaxCurve>(ES3Type_MinMaxCurve.Instance);
				break;
			case "xMultiplier":
				((RotationOverLifetimeModule)(ref val)).xMultiplier = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "y":
				((RotationOverLifetimeModule)(ref val)).y = reader.Read<MinMaxCurve>(ES3Type_MinMaxCurve.Instance);
				break;
			case "yMultiplier":
				((RotationOverLifetimeModule)(ref val)).yMultiplier = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "z":
				((RotationOverLifetimeModule)(ref val)).z = reader.Read<MinMaxCurve>(ES3Type_MinMaxCurve.Instance);
				break;
			case "zMultiplier":
				((RotationOverLifetimeModule)(ref val)).zMultiplier = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "separateAxes":
				((RotationOverLifetimeModule)(ref val)).separateAxes = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			default:
				reader.Skip();
				break;
			}
		}
	}
}
