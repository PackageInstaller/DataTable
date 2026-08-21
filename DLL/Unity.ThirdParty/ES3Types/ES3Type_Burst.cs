using UnityEngine;
using UnityEngine.Scripting;

namespace ES3Types;

[Preserve]
[ES3Properties(new string[] { "time", "count", "minCount", "maxCount", "cycleCount", "repeatInterval", "probability" })]
public class ES3Type_Burst : ES3Type
{
	public static ES3Type Instance;

	public ES3Type_Burst()
		: base(typeof(Burst))
	{
		Instance = this;
		priority = 1;
	}

	public override void Write(object obj, ES3Writer writer)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_002b: Unknown result type (might be due to invalid IL or missing references)
		Burst val = (Burst)obj;
		writer.WriteProperty("time", ((Burst)(ref val)).time, ES3Type_float.Instance);
		writer.WriteProperty("count", ((Burst)(ref val)).count, ES3Type_MinMaxCurve.Instance);
		writer.WriteProperty("minCount", ((Burst)(ref val)).minCount, ES3Type_short.Instance);
		writer.WriteProperty("maxCount", ((Burst)(ref val)).maxCount, ES3Type_short.Instance);
		writer.WriteProperty("cycleCount", ((Burst)(ref val)).cycleCount, ES3Type_int.Instance);
		writer.WriteProperty("repeatInterval", ((Burst)(ref val)).repeatInterval, ES3Type_float.Instance);
		writer.WriteProperty("probability", ((Burst)(ref val)).probability, ES3Type_float.Instance);
	}

	public override object Read<T>(ES3Reader reader)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_018b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0108: Unknown result type (might be due to invalid IL or missing references)
		Burst val = default(Burst);
		string text;
		while ((text = reader.ReadPropertyName()) != null)
		{
			switch (text)
			{
			case "time":
				((Burst)(ref val)).time = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "count":
				((Burst)(ref val)).count = reader.Read<MinMaxCurve>(ES3Type_MinMaxCurve.Instance);
				break;
			case "minCount":
				((Burst)(ref val)).minCount = reader.Read<short>(ES3Type_short.Instance);
				break;
			case "maxCount":
				((Burst)(ref val)).maxCount = reader.Read<short>(ES3Type_short.Instance);
				break;
			case "cycleCount":
				((Burst)(ref val)).cycleCount = reader.Read<int>(ES3Type_int.Instance);
				break;
			case "repeatInterval":
				((Burst)(ref val)).repeatInterval = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "probability":
				((Burst)(ref val)).probability = reader.Read<float>(ES3Type_float.Instance);
				break;
			default:
				reader.Skip();
				break;
			}
		}
		return val;
	}
}
