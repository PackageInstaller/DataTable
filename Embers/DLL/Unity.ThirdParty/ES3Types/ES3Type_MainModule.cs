using UnityEngine;
using UnityEngine.Scripting;

namespace ES3Types;

[Preserve]
[ES3Properties(new string[]
{
	"duration", "loop", "prewarm", "startDelay", "startDelayMultiplier", "startLifetime", "startLifetimeMultiplier", "startSpeed", "startSpeedMultiplier", "startSize3D",
	"startSize", "startSizeMultiplier", "startSizeX", "startSizeXMultiplier", "startSizeY", "startSizeYMultiplier", "startSizeZ", "startSizeZMultiplier", "startRotation3D", "startRotation",
	"startRotationMultiplier", "startRotationX", "startRotationXMultiplier", "startRotationY", "startRotationYMultiplier", "startRotationZ", "startRotationZMultiplier", "randomizeRotationDirection", "startColor", "gravityModifier",
	"gravityModifierMultiplier", "simulationSpace", "customSimulationSpace", "simulationSpeed", "scalingMode", "playOnAwake", "maxParticles"
})]
public class ES3Type_MainModule : ES3Type
{
	public static ES3Type Instance;

	public ES3Type_MainModule()
		: base(typeof(MainModule))
	{
		Instance = this;
	}

	public override void Write(object obj, ES3Writer writer)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_0063: Unknown result type (might be due to invalid IL or missing references)
		//IL_009b: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d3: Unknown result type (might be due to invalid IL or missing references)
		//IL_0127: Unknown result type (might be due to invalid IL or missing references)
		//IL_015f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0197: Unknown result type (might be due to invalid IL or missing references)
		//IL_01cf: Unknown result type (might be due to invalid IL or missing references)
		//IL_0223: Unknown result type (might be due to invalid IL or missing references)
		//IL_025b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0293: Unknown result type (might be due to invalid IL or missing references)
		//IL_02cb: Unknown result type (might be due to invalid IL or missing references)
		//IL_031f: Unknown result type (might be due to invalid IL or missing references)
		//IL_033b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0373: Unknown result type (might be due to invalid IL or missing references)
		//IL_03b8: Unknown result type (might be due to invalid IL or missing references)
		MainModule val = (MainModule)obj;
		writer.WriteProperty("duration", ((MainModule)(ref val)).duration, ES3Type_float.Instance);
		writer.WriteProperty("loop", ((MainModule)(ref val)).loop, ES3Type_bool.Instance);
		writer.WriteProperty("prewarm", ((MainModule)(ref val)).prewarm, ES3Type_bool.Instance);
		writer.WriteProperty("startDelay", ((MainModule)(ref val)).startDelay, ES3Type_MinMaxCurve.Instance);
		writer.WriteProperty("startDelayMultiplier", ((MainModule)(ref val)).startDelayMultiplier, ES3Type_float.Instance);
		writer.WriteProperty("startLifetime", ((MainModule)(ref val)).startLifetime, ES3Type_MinMaxCurve.Instance);
		writer.WriteProperty("startLifetimeMultiplier", ((MainModule)(ref val)).startLifetimeMultiplier, ES3Type_float.Instance);
		writer.WriteProperty("startSpeed", ((MainModule)(ref val)).startSpeed, ES3Type_MinMaxCurve.Instance);
		writer.WriteProperty("startSpeedMultiplier", ((MainModule)(ref val)).startSpeedMultiplier, ES3Type_float.Instance);
		writer.WriteProperty("startSize3D", ((MainModule)(ref val)).startSize3D, ES3Type_bool.Instance);
		writer.WriteProperty("startSize", ((MainModule)(ref val)).startSize, ES3Type_MinMaxCurve.Instance);
		writer.WriteProperty("startSizeMultiplier", ((MainModule)(ref val)).startSizeMultiplier, ES3Type_float.Instance);
		writer.WriteProperty("startSizeX", ((MainModule)(ref val)).startSizeX, ES3Type_MinMaxCurve.Instance);
		writer.WriteProperty("startSizeXMultiplier", ((MainModule)(ref val)).startSizeXMultiplier, ES3Type_float.Instance);
		writer.WriteProperty("startSizeY", ((MainModule)(ref val)).startSizeY, ES3Type_MinMaxCurve.Instance);
		writer.WriteProperty("startSizeYMultiplier", ((MainModule)(ref val)).startSizeYMultiplier, ES3Type_float.Instance);
		writer.WriteProperty("startSizeZ", ((MainModule)(ref val)).startSizeZ, ES3Type_MinMaxCurve.Instance);
		writer.WriteProperty("startSizeZMultiplier", ((MainModule)(ref val)).startSizeZMultiplier, ES3Type_float.Instance);
		writer.WriteProperty("startRotation3D", ((MainModule)(ref val)).startRotation3D, ES3Type_bool.Instance);
		writer.WriteProperty("startRotation", ((MainModule)(ref val)).startRotation, ES3Type_MinMaxCurve.Instance);
		writer.WriteProperty("startRotationMultiplier", ((MainModule)(ref val)).startRotationMultiplier, ES3Type_float.Instance);
		writer.WriteProperty("startRotationX", ((MainModule)(ref val)).startRotationX, ES3Type_MinMaxCurve.Instance);
		writer.WriteProperty("startRotationXMultiplier", ((MainModule)(ref val)).startRotationXMultiplier, ES3Type_float.Instance);
		writer.WriteProperty("startRotationY", ((MainModule)(ref val)).startRotationY, ES3Type_MinMaxCurve.Instance);
		writer.WriteProperty("startRotationYMultiplier", ((MainModule)(ref val)).startRotationYMultiplier, ES3Type_float.Instance);
		writer.WriteProperty("startRotationZ", ((MainModule)(ref val)).startRotationZ, ES3Type_MinMaxCurve.Instance);
		writer.WriteProperty("startRotationZMultiplier", ((MainModule)(ref val)).startRotationZMultiplier, ES3Type_float.Instance);
		writer.WriteProperty("flipRotation", ((MainModule)(ref val)).flipRotation, ES3Type_float.Instance);
		writer.WriteProperty("startColor", ((MainModule)(ref val)).startColor, ES3Type_MinMaxGradient.Instance);
		writer.WriteProperty("gravityModifier", ((MainModule)(ref val)).gravityModifier, ES3Type_MinMaxCurve.Instance);
		writer.WriteProperty("gravityModifierMultiplier", ((MainModule)(ref val)).gravityModifierMultiplier, ES3Type_float.Instance);
		writer.WriteProperty("simulationSpace", ((MainModule)(ref val)).simulationSpace);
		writer.WritePropertyByRef("customSimulationSpace", ((MainModule)(ref val)).customSimulationSpace);
		writer.WriteProperty("simulationSpeed", ((MainModule)(ref val)).simulationSpeed, ES3Type_float.Instance);
		writer.WriteProperty("scalingMode", ((MainModule)(ref val)).scalingMode);
		writer.WriteProperty("playOnAwake", ((MainModule)(ref val)).playOnAwake, ES3Type_bool.Instance);
		writer.WriteProperty("maxParticles", ((MainModule)(ref val)).maxParticles, ES3Type_int.Instance);
	}

	public override object Read<T>(ES3Reader reader)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_000a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0015: Unknown result type (might be due to invalid IL or missing references)
		MainModule val = default(MainModule);
		ReadInto<T>(reader, val);
		return val;
	}

	public override void ReadInto<T>(ES3Reader reader, object obj)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_085b: Unknown result type (might be due to invalid IL or missing references)
		//IL_06bd: Unknown result type (might be due to invalid IL or missing references)
		//IL_0719: Unknown result type (might be due to invalid IL or missing references)
		//IL_07e8: Unknown result type (might be due to invalid IL or missing references)
		//IL_078c: Unknown result type (might be due to invalid IL or missing references)
		//IL_068f: Unknown result type (might be due to invalid IL or missing references)
		//IL_061c: Unknown result type (might be due to invalid IL or missing references)
		//IL_08b8: Unknown result type (might be due to invalid IL or missing references)
		//IL_06eb: Unknown result type (might be due to invalid IL or missing references)
		//IL_075e: Unknown result type (might be due to invalid IL or missing references)
		//IL_05ee: Unknown result type (might be due to invalid IL or missing references)
		//IL_0881: Unknown result type (might be due to invalid IL or missing references)
		//IL_0844: Unknown result type (might be due to invalid IL or missing references)
		//IL_064a: Unknown result type (might be due to invalid IL or missing references)
		//IL_07ba: Unknown result type (might be due to invalid IL or missing references)
		MainModule val = (MainModule)obj;
		string text;
		while ((text = reader.ReadPropertyName()) != null)
		{
			switch (text)
			{
			case "duration":
				((MainModule)(ref val)).duration = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "loop":
				((MainModule)(ref val)).loop = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "prewarm":
				((MainModule)(ref val)).prewarm = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "startDelay":
				((MainModule)(ref val)).startDelay = reader.Read<MinMaxCurve>(ES3Type_MinMaxCurve.Instance);
				break;
			case "startDelayMultiplier":
				((MainModule)(ref val)).startDelayMultiplier = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "startLifetime":
				((MainModule)(ref val)).startLifetime = reader.Read<MinMaxCurve>(ES3Type_MinMaxCurve.Instance);
				break;
			case "startLifetimeMultiplier":
				((MainModule)(ref val)).startLifetimeMultiplier = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "startSpeed":
				((MainModule)(ref val)).startSpeed = reader.Read<MinMaxCurve>(ES3Type_MinMaxCurve.Instance);
				break;
			case "startSpeedMultiplier":
				((MainModule)(ref val)).startSpeedMultiplier = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "startSize3D":
				((MainModule)(ref val)).startSize3D = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "startSize":
				((MainModule)(ref val)).startSize = reader.Read<MinMaxCurve>(ES3Type_MinMaxCurve.Instance);
				break;
			case "startSizeMultiplier":
				((MainModule)(ref val)).startSizeMultiplier = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "startSizeX":
				((MainModule)(ref val)).startSizeX = reader.Read<MinMaxCurve>(ES3Type_MinMaxCurve.Instance);
				break;
			case "startSizeXMultiplier":
				((MainModule)(ref val)).startSizeXMultiplier = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "startSizeY":
				((MainModule)(ref val)).startSizeY = reader.Read<MinMaxCurve>(ES3Type_MinMaxCurve.Instance);
				break;
			case "startSizeYMultiplier":
				((MainModule)(ref val)).startSizeYMultiplier = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "startSizeZ":
				((MainModule)(ref val)).startSizeZ = reader.Read<MinMaxCurve>(ES3Type_MinMaxCurve.Instance);
				break;
			case "startSizeZMultiplier":
				((MainModule)(ref val)).startSizeZMultiplier = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "startRotation3D":
				((MainModule)(ref val)).startRotation3D = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "startRotation":
				((MainModule)(ref val)).startRotation = reader.Read<MinMaxCurve>(ES3Type_MinMaxCurve.Instance);
				break;
			case "startRotationMultiplier":
				((MainModule)(ref val)).startRotationMultiplier = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "startRotationX":
				((MainModule)(ref val)).startRotationX = reader.Read<MinMaxCurve>(ES3Type_MinMaxCurve.Instance);
				break;
			case "startRotationXMultiplier":
				((MainModule)(ref val)).startRotationXMultiplier = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "startRotationY":
				((MainModule)(ref val)).startRotationY = reader.Read<MinMaxCurve>(ES3Type_MinMaxCurve.Instance);
				break;
			case "startRotationYMultiplier":
				((MainModule)(ref val)).startRotationYMultiplier = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "startRotationZ":
				((MainModule)(ref val)).startRotationZ = reader.Read<MinMaxCurve>(ES3Type_MinMaxCurve.Instance);
				break;
			case "startRotationZMultiplier":
				((MainModule)(ref val)).startRotationZMultiplier = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "flipRotation":
				((MainModule)(ref val)).flipRotation = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "randomizeRotationDirection":
				((MainModule)(ref val)).flipRotation = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "startColor":
				((MainModule)(ref val)).startColor = reader.Read<MinMaxGradient>(ES3Type_MinMaxGradient.Instance);
				break;
			case "gravityModifier":
				((MainModule)(ref val)).gravityModifier = reader.Read<MinMaxCurve>(ES3Type_MinMaxCurve.Instance);
				break;
			case "gravityModifierMultiplier":
				((MainModule)(ref val)).gravityModifierMultiplier = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "simulationSpace":
				((MainModule)(ref val)).simulationSpace = reader.Read<ParticleSystemSimulationSpace>();
				break;
			case "customSimulationSpace":
				((MainModule)(ref val)).customSimulationSpace = reader.Read<Transform>(ES3Type_Transform.Instance);
				break;
			case "simulationSpeed":
				((MainModule)(ref val)).simulationSpeed = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "scalingMode":
				((MainModule)(ref val)).scalingMode = reader.Read<ParticleSystemScalingMode>();
				break;
			case "playOnAwake":
				((MainModule)(ref val)).playOnAwake = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "maxParticles":
				((MainModule)(ref val)).maxParticles = reader.Read<int>(ES3Type_int.Instance);
				break;
			default:
				reader.Skip();
				break;
			}
		}
	}
}
