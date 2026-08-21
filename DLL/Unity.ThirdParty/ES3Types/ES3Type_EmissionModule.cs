using UnityEngine;
using UnityEngine.Scripting;

namespace ES3Types;

[Preserve]
[ES3Properties(new string[] { "enabled", "rateOverTime", "rateOverTimeMultiplier", "rateOverDistance", "rateOverDistanceMultiplier" })]
public class ES3Type_EmissionModule : ES3Type
{
	public static ES3Type Instance;

	public ES3Type_EmissionModule()
		: base(typeof(EmissionModule))
	{
		Instance = this;
	}

	public override void Write(object obj, ES3Writer writer)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_002b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0063: Unknown result type (might be due to invalid IL or missing references)
		EmissionModule val = (EmissionModule)obj;
		writer.WriteProperty("enabled", ((EmissionModule)(ref val)).enabled, ES3Type_bool.Instance);
		writer.WriteProperty("rateOverTime", ((EmissionModule)(ref val)).rateOverTime, ES3Type_MinMaxCurve.Instance);
		writer.WriteProperty("rateOverTimeMultiplier", ((EmissionModule)(ref val)).rateOverTimeMultiplier, ES3Type_float.Instance);
		writer.WriteProperty("rateOverDistance", ((EmissionModule)(ref val)).rateOverDistance, ES3Type_MinMaxCurve.Instance);
		writer.WriteProperty("rateOverDistanceMultiplier", ((EmissionModule)(ref val)).rateOverDistanceMultiplier, ES3Type_float.Instance);
		Burst[] array = (Burst[])(object)new Burst[((EmissionModule)(ref val)).burstCount];
		((EmissionModule)(ref val)).GetBursts(array);
		writer.WriteProperty("bursts", array, ES3Type_BurstArray.Instance);
	}

	public override object Read<T>(ES3Reader reader)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_000a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0015: Unknown result type (might be due to invalid IL or missing references)
		EmissionModule val = default(EmissionModule);
		ReadInto<T>(reader, val);
		return val;
	}

	public override void ReadInto<T>(ES3Reader reader, object obj)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_0078: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a0: Unknown result type (might be due to invalid IL or missing references)
		EmissionModule val = (EmissionModule)obj;
		string text;
		while ((text = reader.ReadPropertyName()) != null)
		{
			switch (text)
			{
			case "enabled":
				((EmissionModule)(ref val)).enabled = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "rateOverTime":
				((EmissionModule)(ref val)).rateOverTime = reader.Read<MinMaxCurve>(ES3Type_MinMaxCurve.Instance);
				break;
			case "rateOverTimeMultiplier":
				((EmissionModule)(ref val)).rateOverTimeMultiplier = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "rateOverDistance":
				((EmissionModule)(ref val)).rateOverDistance = reader.Read<MinMaxCurve>(ES3Type_MinMaxCurve.Instance);
				break;
			case "rateOverDistanceMultiplier":
				((EmissionModule)(ref val)).rateOverDistanceMultiplier = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "bursts":
				((EmissionModule)(ref val)).SetBursts(reader.Read<Burst[]>(ES3Type_BurstArray.Instance));
				break;
			default:
				reader.Skip();
				break;
			}
		}
	}
}
