using UnityEngine;
using UnityEngine.Scripting;

namespace ES3Types;

[Preserve]
[ES3Properties(new string[] { "enabled", "x", "y", "z", "xMultiplier", "yMultiplier", "zMultiplier", "space" })]
public class ES3Type_VelocityOverLifetimeModule : ES3Type
{
	public static ES3Type Instance;

	public ES3Type_VelocityOverLifetimeModule()
		: base(typeof(VelocityOverLifetimeModule))
	{
		Instance = this;
	}

	public override void Write(object obj, ES3Writer writer)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_002b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0047: Unknown result type (might be due to invalid IL or missing references)
		//IL_0063: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d3: Unknown result type (might be due to invalid IL or missing references)
		VelocityOverLifetimeModule val = (VelocityOverLifetimeModule)obj;
		writer.WriteProperty("enabled", ((VelocityOverLifetimeModule)(ref val)).enabled, ES3Type_bool.Instance);
		writer.WriteProperty("x", ((VelocityOverLifetimeModule)(ref val)).x, ES3Type_MinMaxCurve.Instance);
		writer.WriteProperty("y", ((VelocityOverLifetimeModule)(ref val)).y, ES3Type_MinMaxCurve.Instance);
		writer.WriteProperty("z", ((VelocityOverLifetimeModule)(ref val)).z, ES3Type_MinMaxCurve.Instance);
		writer.WriteProperty("xMultiplier", ((VelocityOverLifetimeModule)(ref val)).xMultiplier, ES3Type_float.Instance);
		writer.WriteProperty("yMultiplier", ((VelocityOverLifetimeModule)(ref val)).yMultiplier, ES3Type_float.Instance);
		writer.WriteProperty("zMultiplier", ((VelocityOverLifetimeModule)(ref val)).zMultiplier, ES3Type_float.Instance);
		writer.WriteProperty("space", ((VelocityOverLifetimeModule)(ref val)).space);
	}

	public override object Read<T>(ES3Reader reader)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_000a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0015: Unknown result type (might be due to invalid IL or missing references)
		VelocityOverLifetimeModule val = default(VelocityOverLifetimeModule);
		ReadInto<T>(reader, val);
		return val;
	}

	public override void ReadInto<T>(ES3Reader reader, object obj)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_014f: Unknown result type (might be due to invalid IL or missing references)
		//IL_01c2: Unknown result type (might be due to invalid IL or missing references)
		//IL_0177: Unknown result type (might be due to invalid IL or missing references)
		//IL_0163: Unknown result type (might be due to invalid IL or missing references)
		VelocityOverLifetimeModule val = (VelocityOverLifetimeModule)obj;
		string text;
		while ((text = reader.ReadPropertyName()) != null)
		{
			switch (text)
			{
			case "enabled":
				((VelocityOverLifetimeModule)(ref val)).enabled = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "x":
				((VelocityOverLifetimeModule)(ref val)).x = reader.Read<MinMaxCurve>(ES3Type_MinMaxCurve.Instance);
				break;
			case "y":
				((VelocityOverLifetimeModule)(ref val)).y = reader.Read<MinMaxCurve>(ES3Type_MinMaxCurve.Instance);
				break;
			case "z":
				((VelocityOverLifetimeModule)(ref val)).z = reader.Read<MinMaxCurve>(ES3Type_MinMaxCurve.Instance);
				break;
			case "xMultiplier":
				((VelocityOverLifetimeModule)(ref val)).xMultiplier = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "yMultiplier":
				((VelocityOverLifetimeModule)(ref val)).yMultiplier = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "zMultiplier":
				((VelocityOverLifetimeModule)(ref val)).zMultiplier = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "space":
				((VelocityOverLifetimeModule)(ref val)).space = reader.Read<ParticleSystemSimulationSpace>();
				break;
			default:
				reader.Skip();
				break;
			}
		}
	}
}
