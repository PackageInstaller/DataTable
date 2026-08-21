using UnityEngine;
using UnityEngine.Scripting;

namespace ES3Types;

[ES3Properties(new string[]
{
	"enabled", "ratio", "lifetime", "lifetimeMultiplier", "minVertexDistance", "textureMode", "worldSpace", "dieWithParticles", "sizeAffectsWidth", "sizeAffectsLifetime",
	"inheritParticleColor", "colorOverLifetime", "widthOverTrail", "widthOverTrailMultiplier", "colorOverTrail"
})]
[Preserve]
public class ES3Type_TrailModule : ES3Type
{
	public static ES3Type Instance;

	public ES3Type_TrailModule()
		: base(typeof(TrailModule))
	{
		Instance = this;
	}

	public override void Write(object obj, ES3Writer writer)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_0047: Unknown result type (might be due to invalid IL or missing references)
		//IL_009b: Unknown result type (might be due to invalid IL or missing references)
		//IL_013e: Unknown result type (might be due to invalid IL or missing references)
		//IL_015a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0192: Unknown result type (might be due to invalid IL or missing references)
		TrailModule val = (TrailModule)obj;
		writer.WriteProperty("enabled", ((TrailModule)(ref val)).enabled, ES3Type_bool.Instance);
		writer.WriteProperty("ratio", ((TrailModule)(ref val)).ratio, ES3Type_float.Instance);
		writer.WriteProperty("lifetime", ((TrailModule)(ref val)).lifetime, ES3Type_MinMaxCurve.Instance);
		writer.WriteProperty("lifetimeMultiplier", ((TrailModule)(ref val)).lifetimeMultiplier, ES3Type_float.Instance);
		writer.WriteProperty("minVertexDistance", ((TrailModule)(ref val)).minVertexDistance, ES3Type_float.Instance);
		writer.WriteProperty("textureMode", ((TrailModule)(ref val)).textureMode);
		writer.WriteProperty("worldSpace", ((TrailModule)(ref val)).worldSpace, ES3Type_bool.Instance);
		writer.WriteProperty("dieWithParticles", ((TrailModule)(ref val)).dieWithParticles, ES3Type_bool.Instance);
		writer.WriteProperty("sizeAffectsWidth", ((TrailModule)(ref val)).sizeAffectsWidth, ES3Type_bool.Instance);
		writer.WriteProperty("sizeAffectsLifetime", ((TrailModule)(ref val)).sizeAffectsLifetime, ES3Type_bool.Instance);
		writer.WriteProperty("inheritParticleColor", ((TrailModule)(ref val)).inheritParticleColor, ES3Type_bool.Instance);
		writer.WriteProperty("colorOverLifetime", ((TrailModule)(ref val)).colorOverLifetime, ES3Type_MinMaxGradient.Instance);
		writer.WriteProperty("widthOverTrail", ((TrailModule)(ref val)).widthOverTrail, ES3Type_MinMaxCurve.Instance);
		writer.WriteProperty("widthOverTrailMultiplier", ((TrailModule)(ref val)).widthOverTrailMultiplier, ES3Type_float.Instance);
		writer.WriteProperty("colorOverTrail", ((TrailModule)(ref val)).colorOverTrail, ES3Type_MinMaxGradient.Instance);
	}

	public override object Read<T>(ES3Reader reader)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_000a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0015: Unknown result type (might be due to invalid IL or missing references)
		TrailModule val = default(TrailModule);
		ReadInto<T>(reader, val);
		return val;
	}

	public override void ReadInto<T>(ES3Reader reader, object obj)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_034e: Unknown result type (might be due to invalid IL or missing references)
		//IL_033a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0279: Unknown result type (might be due to invalid IL or missing references)
		//IL_02b9: Unknown result type (might be due to invalid IL or missing references)
		//IL_0376: Unknown result type (might be due to invalid IL or missing references)
		TrailModule val = (TrailModule)obj;
		string text;
		while ((text = reader.ReadPropertyName()) != null)
		{
			switch (text)
			{
			case "enabled":
				((TrailModule)(ref val)).enabled = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "ratio":
				((TrailModule)(ref val)).ratio = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "lifetime":
				((TrailModule)(ref val)).lifetime = reader.Read<MinMaxCurve>(ES3Type_MinMaxCurve.Instance);
				break;
			case "lifetimeMultiplier":
				((TrailModule)(ref val)).lifetimeMultiplier = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "minVertexDistance":
				((TrailModule)(ref val)).minVertexDistance = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "textureMode":
				((TrailModule)(ref val)).textureMode = reader.Read<ParticleSystemTrailTextureMode>();
				break;
			case "worldSpace":
				((TrailModule)(ref val)).worldSpace = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "dieWithParticles":
				((TrailModule)(ref val)).dieWithParticles = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "sizeAffectsWidth":
				((TrailModule)(ref val)).sizeAffectsWidth = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "sizeAffectsLifetime":
				((TrailModule)(ref val)).sizeAffectsLifetime = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "inheritParticleColor":
				((TrailModule)(ref val)).inheritParticleColor = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "colorOverLifetime":
				((TrailModule)(ref val)).colorOverLifetime = reader.Read<MinMaxGradient>(ES3Type_MinMaxGradient.Instance);
				break;
			case "widthOverTrail":
				((TrailModule)(ref val)).widthOverTrail = reader.Read<MinMaxCurve>(ES3Type_MinMaxCurve.Instance);
				break;
			case "widthOverTrailMultiplier":
				((TrailModule)(ref val)).widthOverTrailMultiplier = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "colorOverTrail":
				((TrailModule)(ref val)).colorOverTrail = reader.Read<MinMaxGradient>(ES3Type_MinMaxGradient.Instance);
				break;
			default:
				reader.Skip();
				break;
			}
		}
	}
}
