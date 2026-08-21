using UnityEngine;
using UnityEngine.Scripting;

namespace ES3Types;

[Preserve]
[ES3Properties(new string[]
{
	"enabled", "limitX", "limitXMultiplier", "limitY", "limitYMultiplier", "limitZ", "limitZMultiplier", "limit", "limitMultiplier", "dampen",
	"separateAxes", "space"
})]
public class ES3Type_LimitVelocityOverLifetimeModule : ES3Type
{
	public static ES3Type Instance;

	public ES3Type_LimitVelocityOverLifetimeModule()
		: base(typeof(LimitVelocityOverLifetimeModule))
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
		//IL_00d3: Unknown result type (might be due to invalid IL or missing references)
		//IL_0143: Unknown result type (might be due to invalid IL or missing references)
		LimitVelocityOverLifetimeModule val = (LimitVelocityOverLifetimeModule)obj;
		writer.WriteProperty("enabled", ((LimitVelocityOverLifetimeModule)(ref val)).enabled, ES3Type_bool.Instance);
		writer.WriteProperty("limitX", ((LimitVelocityOverLifetimeModule)(ref val)).limitX, ES3Type_MinMaxCurve.Instance);
		writer.WriteProperty("limitXMultiplier", ((LimitVelocityOverLifetimeModule)(ref val)).limitXMultiplier, ES3Type_float.Instance);
		writer.WriteProperty("limitY", ((LimitVelocityOverLifetimeModule)(ref val)).limitY, ES3Type_MinMaxCurve.Instance);
		writer.WriteProperty("limitYMultiplier", ((LimitVelocityOverLifetimeModule)(ref val)).limitYMultiplier, ES3Type_float.Instance);
		writer.WriteProperty("limitZ", ((LimitVelocityOverLifetimeModule)(ref val)).limitZ, ES3Type_MinMaxCurve.Instance);
		writer.WriteProperty("limitZMultiplier", ((LimitVelocityOverLifetimeModule)(ref val)).limitZMultiplier, ES3Type_float.Instance);
		writer.WriteProperty("limit", ((LimitVelocityOverLifetimeModule)(ref val)).limit, ES3Type_MinMaxCurve.Instance);
		writer.WriteProperty("limitMultiplier", ((LimitVelocityOverLifetimeModule)(ref val)).limitMultiplier, ES3Type_float.Instance);
		writer.WriteProperty("dampen", ((LimitVelocityOverLifetimeModule)(ref val)).dampen, ES3Type_float.Instance);
		writer.WriteProperty("separateAxes", ((LimitVelocityOverLifetimeModule)(ref val)).separateAxes, ES3Type_bool.Instance);
		writer.WriteProperty("space", ((LimitVelocityOverLifetimeModule)(ref val)).space);
	}

	public override object Read<T>(ES3Reader reader)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_000a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0015: Unknown result type (might be due to invalid IL or missing references)
		LimitVelocityOverLifetimeModule val = default(LimitVelocityOverLifetimeModule);
		ReadInto<T>(reader, val);
		return val;
	}

	public override void ReadInto<T>(ES3Reader reader, object obj)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_0234: Unknown result type (might be due to invalid IL or missing references)
		//IL_025c: Unknown result type (might be due to invalid IL or missing references)
		//IL_01d8: Unknown result type (might be due to invalid IL or missing references)
		//IL_02a7: Unknown result type (might be due to invalid IL or missing references)
		//IL_0206: Unknown result type (might be due to invalid IL or missing references)
		LimitVelocityOverLifetimeModule val = (LimitVelocityOverLifetimeModule)obj;
		string text;
		while ((text = reader.ReadPropertyName()) != null)
		{
			switch (text)
			{
			case "enabled":
				((LimitVelocityOverLifetimeModule)(ref val)).enabled = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "limitX":
				((LimitVelocityOverLifetimeModule)(ref val)).limitX = reader.Read<MinMaxCurve>(ES3Type_MinMaxCurve.Instance);
				break;
			case "limitXMultiplier":
				((LimitVelocityOverLifetimeModule)(ref val)).limitXMultiplier = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "limitY":
				((LimitVelocityOverLifetimeModule)(ref val)).limitY = reader.Read<MinMaxCurve>(ES3Type_MinMaxCurve.Instance);
				break;
			case "limitYMultiplier":
				((LimitVelocityOverLifetimeModule)(ref val)).limitYMultiplier = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "limitZ":
				((LimitVelocityOverLifetimeModule)(ref val)).limitZ = reader.Read<MinMaxCurve>(ES3Type_MinMaxCurve.Instance);
				break;
			case "limitZMultiplier":
				((LimitVelocityOverLifetimeModule)(ref val)).limitZMultiplier = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "limit":
				((LimitVelocityOverLifetimeModule)(ref val)).limit = reader.Read<MinMaxCurve>(ES3Type_MinMaxCurve.Instance);
				break;
			case "limitMultiplier":
				((LimitVelocityOverLifetimeModule)(ref val)).limitMultiplier = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "dampen":
				((LimitVelocityOverLifetimeModule)(ref val)).dampen = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "separateAxes":
				((LimitVelocityOverLifetimeModule)(ref val)).separateAxes = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "space":
				((LimitVelocityOverLifetimeModule)(ref val)).space = reader.Read<ParticleSystemSimulationSpace>();
				break;
			default:
				reader.Skip();
				break;
			}
		}
	}
}
