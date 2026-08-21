using UnityEngine;
using UnityEngine.Scripting;

namespace ES3Types;

[Preserve]
[ES3Properties(new string[] { "mode", "curveMultiplier", "curveMax", "curveMin", "constantMax", "constantMin", "constant", "curve" })]
public class ES3Type_MinMaxCurve : ES3Type
{
	public static ES3Type Instance;

	public ES3Type_MinMaxCurve()
		: base(typeof(MinMaxCurve))
	{
		Instance = this;
	}

	public override void Write(object obj, ES3Writer writer)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_000f: Unknown result type (might be due to invalid IL or missing references)
		MinMaxCurve val = (MinMaxCurve)obj;
		writer.WriteProperty("mode", ((MinMaxCurve)(ref val)).mode);
		writer.WriteProperty("curveMultiplier", ((MinMaxCurve)(ref val)).curveMultiplier, ES3Type_float.Instance);
		writer.WriteProperty("curveMax", ((MinMaxCurve)(ref val)).curveMax, ES3Type_AnimationCurve.Instance);
		writer.WriteProperty("curveMin", ((MinMaxCurve)(ref val)).curveMin, ES3Type_AnimationCurve.Instance);
		writer.WriteProperty("constantMax", ((MinMaxCurve)(ref val)).constantMax, ES3Type_float.Instance);
		writer.WriteProperty("constantMin", ((MinMaxCurve)(ref val)).constantMin, ES3Type_float.Instance);
		writer.WriteProperty("constant", ((MinMaxCurve)(ref val)).constant, ES3Type_float.Instance);
		writer.WriteProperty("curve", ((MinMaxCurve)(ref val)).curve, ES3Type_AnimationCurve.Instance);
	}

	[Preserve]
	public override object Read<T>(ES3Reader reader)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_01e0: Unknown result type (might be due to invalid IL or missing references)
		//IL_0132: Unknown result type (might be due to invalid IL or missing references)
		MinMaxCurve val = default(MinMaxCurve);
		string text;
		while ((text = reader.ReadPropertyName()) != null)
		{
			switch (text)
			{
			case "mode":
				((MinMaxCurve)(ref val)).mode = reader.Read<ParticleSystemCurveMode>();
				break;
			case "curveMultiplier":
				((MinMaxCurve)(ref val)).curveMultiplier = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "curveMax":
				((MinMaxCurve)(ref val)).curveMax = reader.Read<AnimationCurve>(ES3Type_AnimationCurve.Instance);
				break;
			case "curveMin":
				((MinMaxCurve)(ref val)).curveMin = reader.Read<AnimationCurve>(ES3Type_AnimationCurve.Instance);
				break;
			case "constantMax":
				((MinMaxCurve)(ref val)).constantMax = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "constantMin":
				((MinMaxCurve)(ref val)).constantMin = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "constant":
				((MinMaxCurve)(ref val)).constant = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "curve":
				((MinMaxCurve)(ref val)).curve = reader.Read<AnimationCurve>(ES3Type_AnimationCurve.Instance);
				break;
			default:
				reader.Skip();
				break;
			}
		}
		return val;
	}

	[Preserve]
	public override void ReadInto<T>(ES3Reader reader, object obj)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_0131: Unknown result type (might be due to invalid IL or missing references)
		MinMaxCurve val = (MinMaxCurve)obj;
		string text;
		while ((text = reader.ReadPropertyName()) != null)
		{
			switch (text)
			{
			case "mode":
				((MinMaxCurve)(ref val)).mode = reader.Read<ParticleSystemCurveMode>();
				break;
			case "curveMultiplier":
				((MinMaxCurve)(ref val)).curveMultiplier = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "curveMax":
				((MinMaxCurve)(ref val)).curveMax = reader.Read<AnimationCurve>(ES3Type_AnimationCurve.Instance);
				break;
			case "curveMin":
				((MinMaxCurve)(ref val)).curveMin = reader.Read<AnimationCurve>(ES3Type_AnimationCurve.Instance);
				break;
			case "constantMax":
				((MinMaxCurve)(ref val)).constantMax = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "constantMin":
				((MinMaxCurve)(ref val)).constantMin = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "constant":
				((MinMaxCurve)(ref val)).constant = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "curve":
				((MinMaxCurve)(ref val)).curve = reader.Read<AnimationCurve>(ES3Type_AnimationCurve.Instance);
				break;
			default:
				reader.Skip();
				break;
			}
		}
	}
}
