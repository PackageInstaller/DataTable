using UnityEngine;
using UnityEngine.Scripting;

namespace ES3Types;

[Preserve]
[ES3Properties(new string[] { "enabled", "mode", "curve", "curveMultiplier" })]
public class ES3Type_InheritVelocityModule : ES3Type
{
	public static ES3Type Instance;

	public ES3Type_InheritVelocityModule()
		: base(typeof(InheritVelocityModule))
	{
		Instance = this;
	}

	public override void Write(object obj, ES3Writer writer)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_002b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0042: Unknown result type (might be due to invalid IL or missing references)
		InheritVelocityModule val = (InheritVelocityModule)obj;
		writer.WriteProperty("enabled", ((InheritVelocityModule)(ref val)).enabled, ES3Type_bool.Instance);
		writer.WriteProperty("mode", ((InheritVelocityModule)(ref val)).mode);
		writer.WriteProperty("curve", ((InheritVelocityModule)(ref val)).curve, ES3Type_MinMaxCurve.Instance);
		writer.WriteProperty("curveMultiplier", ((InheritVelocityModule)(ref val)).curveMultiplier, ES3Type_float.Instance);
	}

	public override object Read<T>(ES3Reader reader)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_000a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0015: Unknown result type (might be due to invalid IL or missing references)
		InheritVelocityModule val = default(InheritVelocityModule);
		ReadInto<T>(reader, val);
		return val;
	}

	public override void ReadInto<T>(ES3Reader reader, object obj)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_0059: Unknown result type (might be due to invalid IL or missing references)
		//IL_006d: Unknown result type (might be due to invalid IL or missing references)
		InheritVelocityModule val = (InheritVelocityModule)obj;
		string text;
		while ((text = reader.ReadPropertyName()) != null)
		{
			switch (text)
			{
			case "enabled":
				((InheritVelocityModule)(ref val)).enabled = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "mode":
				((InheritVelocityModule)(ref val)).mode = reader.Read<ParticleSystemInheritVelocityMode>();
				break;
			case "curve":
				((InheritVelocityModule)(ref val)).curve = reader.Read<MinMaxCurve>(ES3Type_MinMaxCurve.Instance);
				break;
			case "curveMultiplier":
				((InheritVelocityModule)(ref val)).curveMultiplier = reader.Read<float>(ES3Type_float.Instance);
				break;
			default:
				reader.Skip();
				break;
			}
		}
	}
}
