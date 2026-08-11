using UnityEngine;
using UnityEngine.Scripting;

namespace ES3Types;

[Preserve]
[ES3Properties(new string[]
{
	"enabled", "ratio", "useRandomDistribution", "light", "useParticleColor", "sizeAffectsRange", "alphaAffectsIntensity", "range", "rangeMultiplier", "intensity",
	"intensityMultiplier", "maxLights"
})]
public class ES3Type_LightsModule : ES3Type
{
	public static ES3Type Instance;

	public ES3Type_LightsModule()
		: base(typeof(LightsModule))
	{
		Instance = this;
	}

	public override void Write(object obj, ES3Writer writer)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c9: Unknown result type (might be due to invalid IL or missing references)
		//IL_0101: Unknown result type (might be due to invalid IL or missing references)
		LightsModule val = (LightsModule)obj;
		writer.WriteProperty("enabled", ((LightsModule)(ref val)).enabled, ES3Type_bool.Instance);
		writer.WriteProperty("ratio", ((LightsModule)(ref val)).ratio, ES3Type_float.Instance);
		writer.WriteProperty("useRandomDistribution", ((LightsModule)(ref val)).useRandomDistribution, ES3Type_bool.Instance);
		writer.WritePropertyByRef("light", ((LightsModule)(ref val)).light);
		writer.WriteProperty("useParticleColor", ((LightsModule)(ref val)).useParticleColor, ES3Type_bool.Instance);
		writer.WriteProperty("sizeAffectsRange", ((LightsModule)(ref val)).sizeAffectsRange, ES3Type_bool.Instance);
		writer.WriteProperty("alphaAffectsIntensity", ((LightsModule)(ref val)).alphaAffectsIntensity, ES3Type_bool.Instance);
		writer.WriteProperty("range", ((LightsModule)(ref val)).range, ES3Type_MinMaxCurve.Instance);
		writer.WriteProperty("rangeMultiplier", ((LightsModule)(ref val)).rangeMultiplier, ES3Type_float.Instance);
		writer.WriteProperty("intensity", ((LightsModule)(ref val)).intensity, ES3Type_MinMaxCurve.Instance);
		writer.WriteProperty("intensityMultiplier", ((LightsModule)(ref val)).intensityMultiplier, ES3Type_float.Instance);
		writer.WriteProperty("maxLights", ((LightsModule)(ref val)).maxLights, ES3Type_int.Instance);
	}

	public override object Read<T>(ES3Reader reader)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_000a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0015: Unknown result type (might be due to invalid IL or missing references)
		LightsModule val = default(LightsModule);
		ReadInto<T>(reader, val);
		return val;
	}

	public override void ReadInto<T>(ES3Reader reader, object obj)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_0259: Unknown result type (might be due to invalid IL or missing references)
		//IL_0281: Unknown result type (might be due to invalid IL or missing references)
		LightsModule val = (LightsModule)obj;
		string text;
		while ((text = reader.ReadPropertyName()) != null)
		{
			switch (text)
			{
			case "enabled":
				((LightsModule)(ref val)).enabled = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "ratio":
				((LightsModule)(ref val)).ratio = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "useRandomDistribution":
				((LightsModule)(ref val)).useRandomDistribution = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "light":
				((LightsModule)(ref val)).light = reader.Read<Light>(ES3Type_Light.Instance);
				break;
			case "useParticleColor":
				((LightsModule)(ref val)).useParticleColor = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "sizeAffectsRange":
				((LightsModule)(ref val)).sizeAffectsRange = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "alphaAffectsIntensity":
				((LightsModule)(ref val)).alphaAffectsIntensity = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "range":
				((LightsModule)(ref val)).range = reader.Read<MinMaxCurve>(ES3Type_MinMaxCurve.Instance);
				break;
			case "rangeMultiplier":
				((LightsModule)(ref val)).rangeMultiplier = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "intensity":
				((LightsModule)(ref val)).intensity = reader.Read<MinMaxCurve>(ES3Type_MinMaxCurve.Instance);
				break;
			case "intensityMultiplier":
				((LightsModule)(ref val)).intensityMultiplier = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "maxLights":
				((LightsModule)(ref val)).maxLights = reader.Read<int>(ES3Type_int.Instance);
				break;
			default:
				reader.Skip();
				break;
			}
		}
	}
}
