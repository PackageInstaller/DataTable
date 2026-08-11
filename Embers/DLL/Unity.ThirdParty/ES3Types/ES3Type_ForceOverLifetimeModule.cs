using UnityEngine;
using UnityEngine.Scripting;

namespace ES3Types;

[Preserve]
[ES3Properties(new string[] { "enabled", "x", "y", "z", "xMultiplier", "yMultiplier", "zMultiplier", "space", "randomized" })]
public class ES3Type_ForceOverLifetimeModule : ES3Type
{
	public static ES3Type Instance;

	public ES3Type_ForceOverLifetimeModule()
		: base(typeof(ForceOverLifetimeModule))
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
		ForceOverLifetimeModule val = (ForceOverLifetimeModule)obj;
		writer.WriteProperty("enabled", ((ForceOverLifetimeModule)(ref val)).enabled, ES3Type_bool.Instance);
		writer.WriteProperty("x", ((ForceOverLifetimeModule)(ref val)).x, ES3Type_MinMaxCurve.Instance);
		writer.WriteProperty("y", ((ForceOverLifetimeModule)(ref val)).y, ES3Type_MinMaxCurve.Instance);
		writer.WriteProperty("z", ((ForceOverLifetimeModule)(ref val)).z, ES3Type_MinMaxCurve.Instance);
		writer.WriteProperty("xMultiplier", ((ForceOverLifetimeModule)(ref val)).xMultiplier, ES3Type_float.Instance);
		writer.WriteProperty("yMultiplier", ((ForceOverLifetimeModule)(ref val)).yMultiplier, ES3Type_float.Instance);
		writer.WriteProperty("zMultiplier", ((ForceOverLifetimeModule)(ref val)).zMultiplier, ES3Type_float.Instance);
		writer.WriteProperty("space", ((ForceOverLifetimeModule)(ref val)).space);
		writer.WriteProperty("randomized", ((ForceOverLifetimeModule)(ref val)).randomized, ES3Type_bool.Instance);
	}

	public override object Read<T>(ES3Reader reader)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_000a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0015: Unknown result type (might be due to invalid IL or missing references)
		ForceOverLifetimeModule val = default(ForceOverLifetimeModule);
		ReadInto<T>(reader, val);
		return val;
	}

	public override void ReadInto<T>(ES3Reader reader, object obj)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_0186: Unknown result type (might be due to invalid IL or missing references)
		//IL_01e5: Unknown result type (might be due to invalid IL or missing references)
		//IL_016f: Unknown result type (might be due to invalid IL or missing references)
		//IL_019a: Unknown result type (might be due to invalid IL or missing references)
		ForceOverLifetimeModule val = (ForceOverLifetimeModule)obj;
		string text;
		while ((text = reader.ReadPropertyName()) != null)
		{
			switch (text)
			{
			case "enabled":
				((ForceOverLifetimeModule)(ref val)).enabled = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "x":
				((ForceOverLifetimeModule)(ref val)).x = reader.Read<MinMaxCurve>(ES3Type_MinMaxCurve.Instance);
				break;
			case "y":
				((ForceOverLifetimeModule)(ref val)).y = reader.Read<MinMaxCurve>(ES3Type_MinMaxCurve.Instance);
				break;
			case "z":
				((ForceOverLifetimeModule)(ref val)).z = reader.Read<MinMaxCurve>(ES3Type_MinMaxCurve.Instance);
				break;
			case "xMultiplier":
				((ForceOverLifetimeModule)(ref val)).xMultiplier = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "yMultiplier":
				((ForceOverLifetimeModule)(ref val)).yMultiplier = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "zMultiplier":
				((ForceOverLifetimeModule)(ref val)).zMultiplier = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "space":
				((ForceOverLifetimeModule)(ref val)).space = reader.Read<ParticleSystemSimulationSpace>();
				break;
			case "randomized":
				((ForceOverLifetimeModule)(ref val)).randomized = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			default:
				reader.Skip();
				break;
			}
		}
	}
}
