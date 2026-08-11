using UnityEngine;
using UnityEngine.Scripting;

namespace ES3Types;

[Preserve]
[ES3Properties(new string[]
{
	"enabled", "separateAxes", "strength", "strengthMultiplier", "strengthX", "strengthXMultiplier", "strengthY", "strengthYMultiplier", "strengthZ", "strengthZMultiplier",
	"frequency", "damping", "octaveCount", "octaveMultiplier", "octaveScale", "quality", "scrollSpeed", "scrollSpeedMultiplier", "remapEnabled", "remap",
	"remapMultiplier", "remapX", "remapXMultiplier", "remapY", "remapYMultiplier", "remapZ", "remapZMultiplier"
})]
public class ES3Type_NoiseModule : ES3Type
{
	public static ES3Type Instance;

	public ES3Type_NoiseModule()
		: base(typeof(NoiseModule))
	{
		Instance = this;
	}

	public override void Write(object obj, ES3Writer writer)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_0047: Unknown result type (might be due to invalid IL or missing references)
		//IL_007f: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b7: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ef: Unknown result type (might be due to invalid IL or missing references)
		//IL_01b3: Unknown result type (might be due to invalid IL or missing references)
		//IL_01ca: Unknown result type (might be due to invalid IL or missing references)
		//IL_021e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0256: Unknown result type (might be due to invalid IL or missing references)
		//IL_028e: Unknown result type (might be due to invalid IL or missing references)
		//IL_02c6: Unknown result type (might be due to invalid IL or missing references)
		NoiseModule val = (NoiseModule)obj;
		writer.WriteProperty("enabled", ((NoiseModule)(ref val)).enabled, ES3Type_bool.Instance);
		writer.WriteProperty("separateAxes", ((NoiseModule)(ref val)).separateAxes, ES3Type_bool.Instance);
		writer.WriteProperty("strength", ((NoiseModule)(ref val)).strength, ES3Type_MinMaxCurve.Instance);
		writer.WriteProperty("strengthMultiplier", ((NoiseModule)(ref val)).strengthMultiplier, ES3Type_float.Instance);
		writer.WriteProperty("strengthX", ((NoiseModule)(ref val)).strengthX, ES3Type_MinMaxCurve.Instance);
		writer.WriteProperty("strengthXMultiplier", ((NoiseModule)(ref val)).strengthXMultiplier, ES3Type_float.Instance);
		writer.WriteProperty("strengthY", ((NoiseModule)(ref val)).strengthY, ES3Type_MinMaxCurve.Instance);
		writer.WriteProperty("strengthYMultiplier", ((NoiseModule)(ref val)).strengthYMultiplier, ES3Type_float.Instance);
		writer.WriteProperty("strengthZ", ((NoiseModule)(ref val)).strengthZ, ES3Type_MinMaxCurve.Instance);
		writer.WriteProperty("strengthZMultiplier", ((NoiseModule)(ref val)).strengthZMultiplier, ES3Type_float.Instance);
		writer.WriteProperty("frequency", ((NoiseModule)(ref val)).frequency, ES3Type_float.Instance);
		writer.WriteProperty("damping", ((NoiseModule)(ref val)).damping, ES3Type_bool.Instance);
		writer.WriteProperty("octaveCount", ((NoiseModule)(ref val)).octaveCount, ES3Type_int.Instance);
		writer.WriteProperty("octaveMultiplier", ((NoiseModule)(ref val)).octaveMultiplier, ES3Type_float.Instance);
		writer.WriteProperty("octaveScale", ((NoiseModule)(ref val)).octaveScale, ES3Type_float.Instance);
		writer.WriteProperty("quality", ((NoiseModule)(ref val)).quality);
		writer.WriteProperty("scrollSpeed", ((NoiseModule)(ref val)).scrollSpeed, ES3Type_MinMaxCurve.Instance);
		writer.WriteProperty("scrollSpeedMultiplier", ((NoiseModule)(ref val)).scrollSpeedMultiplier, ES3Type_float.Instance);
		writer.WriteProperty("remapEnabled", ((NoiseModule)(ref val)).remapEnabled, ES3Type_bool.Instance);
		writer.WriteProperty("remap", ((NoiseModule)(ref val)).remap, ES3Type_MinMaxCurve.Instance);
		writer.WriteProperty("remapMultiplier", ((NoiseModule)(ref val)).remapMultiplier, ES3Type_float.Instance);
		writer.WriteProperty("remapX", ((NoiseModule)(ref val)).remapX, ES3Type_MinMaxCurve.Instance);
		writer.WriteProperty("remapXMultiplier", ((NoiseModule)(ref val)).remapXMultiplier, ES3Type_float.Instance);
		writer.WriteProperty("remapY", ((NoiseModule)(ref val)).remapY, ES3Type_MinMaxCurve.Instance);
		writer.WriteProperty("remapYMultiplier", ((NoiseModule)(ref val)).remapYMultiplier, ES3Type_float.Instance);
		writer.WriteProperty("remapZ", ((NoiseModule)(ref val)).remapZ, ES3Type_MinMaxCurve.Instance);
		writer.WriteProperty("remapZMultiplier", ((NoiseModule)(ref val)).remapZMultiplier, ES3Type_float.Instance);
	}

	public override object Read<T>(ES3Reader reader)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_000a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0015: Unknown result type (might be due to invalid IL or missing references)
		NoiseModule val = default(NoiseModule);
		ReadInto<T>(reader, val);
		return val;
	}

	public override void ReadInto<T>(ES3Reader reader, object obj)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_0433: Unknown result type (might be due to invalid IL or missing references)
		//IL_05b5: Unknown result type (might be due to invalid IL or missing references)
		//IL_0608: Unknown result type (might be due to invalid IL or missing references)
		//IL_0630: Unknown result type (might be due to invalid IL or missing references)
		//IL_048f: Unknown result type (might be due to invalid IL or missing references)
		//IL_05e0: Unknown result type (might be due to invalid IL or missing references)
		//IL_0559: Unknown result type (might be due to invalid IL or missing references)
		//IL_04bd: Unknown result type (might be due to invalid IL or missing references)
		//IL_0461: Unknown result type (might be due to invalid IL or missing references)
		//IL_0570: Unknown result type (might be due to invalid IL or missing references)
		NoiseModule val = (NoiseModule)obj;
		string text;
		while ((text = reader.ReadPropertyName()) != null)
		{
			switch (text)
			{
			case "enabled":
				((NoiseModule)(ref val)).enabled = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "separateAxes":
				((NoiseModule)(ref val)).separateAxes = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "strength":
				((NoiseModule)(ref val)).strength = reader.Read<MinMaxCurve>(ES3Type_MinMaxCurve.Instance);
				break;
			case "strengthMultiplier":
				((NoiseModule)(ref val)).strengthMultiplier = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "strengthX":
				((NoiseModule)(ref val)).strengthX = reader.Read<MinMaxCurve>(ES3Type_MinMaxCurve.Instance);
				break;
			case "strengthXMultiplier":
				((NoiseModule)(ref val)).strengthXMultiplier = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "strengthY":
				((NoiseModule)(ref val)).strengthY = reader.Read<MinMaxCurve>(ES3Type_MinMaxCurve.Instance);
				break;
			case "strengthYMultiplier":
				((NoiseModule)(ref val)).strengthYMultiplier = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "strengthZ":
				((NoiseModule)(ref val)).strengthZ = reader.Read<MinMaxCurve>(ES3Type_MinMaxCurve.Instance);
				break;
			case "strengthZMultiplier":
				((NoiseModule)(ref val)).strengthZMultiplier = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "frequency":
				((NoiseModule)(ref val)).frequency = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "damping":
				((NoiseModule)(ref val)).damping = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "octaveCount":
				((NoiseModule)(ref val)).octaveCount = reader.Read<int>(ES3Type_int.Instance);
				break;
			case "octaveMultiplier":
				((NoiseModule)(ref val)).octaveMultiplier = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "octaveScale":
				((NoiseModule)(ref val)).octaveScale = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "quality":
				((NoiseModule)(ref val)).quality = reader.Read<ParticleSystemNoiseQuality>();
				break;
			case "scrollSpeed":
				((NoiseModule)(ref val)).scrollSpeed = reader.Read<MinMaxCurve>(ES3Type_MinMaxCurve.Instance);
				break;
			case "scrollSpeedMultiplier":
				((NoiseModule)(ref val)).scrollSpeedMultiplier = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "remapEnabled":
				((NoiseModule)(ref val)).remapEnabled = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "remap":
				((NoiseModule)(ref val)).remap = reader.Read<MinMaxCurve>(ES3Type_MinMaxCurve.Instance);
				break;
			case "remapMultiplier":
				((NoiseModule)(ref val)).remapMultiplier = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "remapX":
				((NoiseModule)(ref val)).remapX = reader.Read<MinMaxCurve>(ES3Type_MinMaxCurve.Instance);
				break;
			case "remapXMultiplier":
				((NoiseModule)(ref val)).remapXMultiplier = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "remapY":
				((NoiseModule)(ref val)).remapY = reader.Read<MinMaxCurve>(ES3Type_MinMaxCurve.Instance);
				break;
			case "remapYMultiplier":
				((NoiseModule)(ref val)).remapYMultiplier = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "remapZ":
				((NoiseModule)(ref val)).remapZ = reader.Read<MinMaxCurve>(ES3Type_MinMaxCurve.Instance);
				break;
			case "remapZMultiplier":
				((NoiseModule)(ref val)).remapZMultiplier = reader.Read<float>(ES3Type_float.Instance);
				break;
			default:
				reader.Skip();
				break;
			}
		}
	}
}
