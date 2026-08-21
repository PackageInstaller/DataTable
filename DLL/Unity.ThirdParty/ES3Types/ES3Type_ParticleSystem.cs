using UnityEngine;
using UnityEngine.Scripting;

namespace ES3Types;

[Preserve]
[ES3Properties(new string[]
{
	"time", "hideFlags", "collision", "colorBySpeed", "colorOverLifetime", "emission", "externalForces", "forceOverLifetime", "inheritVelocity", "lights",
	"limitVelocityOverLifetime", "main", "noise", "rotatonBySpeed", "rotationOverLifetime", "shape", "sizeBySpeed", "sizeOverLifetime", "subEmitters", "textureSheetAnimation",
	"trails", "trigger", "useAutoRandomSeed", "velocityOverLifetime", "isPaused", "isPlaying", "isStopped"
})]
public class ES3Type_ParticleSystem : ES3ComponentType
{
	public static ES3Type Instance;

	public ES3Type_ParticleSystem()
		: base(typeof(ParticleSystem))
	{
		Instance = this;
	}

	protected override void WriteComponent(object obj, ES3Writer writer)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Expected O, but got Unknown
		//IL_003a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0050: Unknown result type (might be due to invalid IL or missing references)
		//IL_0066: Unknown result type (might be due to invalid IL or missing references)
		//IL_007c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0092: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a8: Unknown result type (might be due to invalid IL or missing references)
		//IL_00be: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d4: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ea: Unknown result type (might be due to invalid IL or missing references)
		//IL_0100: Unknown result type (might be due to invalid IL or missing references)
		//IL_0116: Unknown result type (might be due to invalid IL or missing references)
		//IL_012c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0142: Unknown result type (might be due to invalid IL or missing references)
		//IL_0158: Unknown result type (might be due to invalid IL or missing references)
		//IL_016e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0184: Unknown result type (might be due to invalid IL or missing references)
		//IL_019a: Unknown result type (might be due to invalid IL or missing references)
		//IL_01b0: Unknown result type (might be due to invalid IL or missing references)
		//IL_01c6: Unknown result type (might be due to invalid IL or missing references)
		//IL_01dc: Unknown result type (might be due to invalid IL or missing references)
		//IL_0208: Unknown result type (might be due to invalid IL or missing references)
		ParticleSystem val = (ParticleSystem)obj;
		writer.WriteProperty("time", val.time);
		writer.WriteProperty("hideFlags", ((Object)(object)val).hideFlags);
		writer.WriteProperty("collision", val.collision);
		writer.WriteProperty("colorBySpeed", val.colorBySpeed);
		writer.WriteProperty("colorOverLifetime", val.colorOverLifetime);
		writer.WriteProperty("emission", val.emission);
		writer.WriteProperty("externalForces", val.externalForces);
		writer.WriteProperty("forceOverLifetime", val.forceOverLifetime);
		writer.WriteProperty("inheritVelocity", val.inheritVelocity);
		writer.WriteProperty("lights", val.lights);
		writer.WriteProperty("limitVelocityOverLifetime", val.limitVelocityOverLifetime);
		writer.WriteProperty("main", val.main);
		writer.WriteProperty("noise", val.noise);
		writer.WriteProperty("rotationBySpeed", val.rotationBySpeed);
		writer.WriteProperty("rotationOverLifetime", val.rotationOverLifetime);
		writer.WriteProperty("shape", val.shape);
		writer.WriteProperty("sizeBySpeed", val.sizeBySpeed);
		writer.WriteProperty("sizeOverLifetime", val.sizeOverLifetime);
		writer.WriteProperty("subEmitters", val.subEmitters);
		writer.WriteProperty("textureSheetAnimation", val.textureSheetAnimation);
		writer.WriteProperty("trails", val.trails);
		writer.WriteProperty("trigger", val.trigger);
		writer.WriteProperty("useAutoRandomSeed", val.useAutoRandomSeed);
		writer.WriteProperty("velocityOverLifetime", val.velocityOverLifetime);
		writer.WriteProperty("isPaused", val.isPaused);
		writer.WriteProperty("isPlaying", val.isPlaying);
		writer.WriteProperty("isStopped", val.isStopped);
	}

	protected override void ReadComponent<T>(ES3Reader reader, object obj)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Expected O, but got Unknown
		//IL_0511: Unknown result type (might be due to invalid IL or missing references)
		//IL_057d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0439: Unknown result type (might be due to invalid IL or missing references)
		//IL_04f6: Unknown result type (might be due to invalid IL or missing references)
		//IL_046f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0604: Unknown result type (might be due to invalid IL or missing references)
		//IL_04a5: Unknown result type (might be due to invalid IL or missing references)
		//IL_048a: Unknown result type (might be due to invalid IL or missing references)
		//IL_061f: Unknown result type (might be due to invalid IL or missing references)
		//IL_063a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0665: Unknown result type (might be due to invalid IL or missing references)
		//IL_052c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0562: Unknown result type (might be due to invalid IL or missing references)
		//IL_0598: Unknown result type (might be due to invalid IL or missing references)
		//IL_05b3: Unknown result type (might be due to invalid IL or missing references)
		//IL_05ce: Unknown result type (might be due to invalid IL or missing references)
		//IL_0454: Unknown result type (might be due to invalid IL or missing references)
		//IL_05e9: Unknown result type (might be due to invalid IL or missing references)
		//IL_04c0: Unknown result type (might be due to invalid IL or missing references)
		//IL_04db: Unknown result type (might be due to invalid IL or missing references)
		//IL_0547: Unknown result type (might be due to invalid IL or missing references)
		ParticleSystem val = (ParticleSystem)obj;
		val.Stop();
		foreach (string property in reader.Properties)
		{
			switch (property)
			{
			case "time":
				val.time = reader.Read<float>();
				break;
			case "hideFlags":
				((Object)(object)val).hideFlags = reader.Read<HideFlags>();
				break;
			case "collision":
				reader.ReadInto<CollisionModule>(val.collision, ES3Type_CollisionModule.Instance);
				break;
			case "colorBySpeed":
				reader.ReadInto<ColorBySpeedModule>(val.colorBySpeed, ES3Type_ColorBySpeedModule.Instance);
				break;
			case "colorOverLifetime":
				reader.ReadInto<ColorOverLifetimeModule>(val.colorOverLifetime, ES3Type_ColorOverLifetimeModule.Instance);
				break;
			case "sizeOverLifetime":
				reader.ReadInto<SizeOverLifetimeModule>(val.sizeOverLifetime, ES3Type_SizeOverLifetimeModule.Instance);
				break;
			case "shape":
				reader.ReadInto<ShapeModule>(val.shape, ES3Type_ShapeModule.Instance);
				break;
			case "emission":
				reader.ReadInto<EmissionModule>(val.emission, ES3Type_EmissionModule.Instance);
				break;
			case "externalForces":
				reader.ReadInto<ExternalForcesModule>(val.externalForces, ES3Type_ExternalForcesModule.Instance);
				break;
			case "forceOverLifetime":
				reader.ReadInto<ForceOverLifetimeModule>(val.forceOverLifetime, ES3Type_ForceOverLifetimeModule.Instance);
				break;
			case "inheritVelocity":
				reader.ReadInto<InheritVelocityModule>(val.inheritVelocity, ES3Type_InheritVelocityModule.Instance);
				break;
			case "lights":
				reader.ReadInto<LightsModule>(val.lights, ES3Type_LightsModule.Instance);
				break;
			case "limitVelocityOverLifetime":
				reader.ReadInto<LimitVelocityOverLifetimeModule>(val.limitVelocityOverLifetime, ES3Type_LimitVelocityOverLifetimeModule.Instance);
				break;
			case "main":
				reader.ReadInto<MainModule>(val.main, ES3Type_MainModule.Instance);
				break;
			case "noise":
				reader.ReadInto<NoiseModule>(val.noise, ES3Type_NoiseModule.Instance);
				break;
			case "sizeBySpeed":
				reader.ReadInto<SizeBySpeedModule>(val.sizeBySpeed, ES3Type_SizeBySpeedModule.Instance);
				break;
			case "rotationBySpeed":
				reader.ReadInto<RotationBySpeedModule>(val.rotationBySpeed, ES3Type_RotationBySpeedModule.Instance);
				break;
			case "rotationOverLifetime":
				reader.ReadInto<RotationOverLifetimeModule>(val.rotationOverLifetime, ES3Type_RotationOverLifetimeModule.Instance);
				break;
			case "subEmitters":
				reader.ReadInto<SubEmittersModule>(val.subEmitters, ES3Type_SubEmittersModule.Instance);
				break;
			case "textureSheetAnimation":
				reader.ReadInto<TextureSheetAnimationModule>(val.textureSheetAnimation, ES3Type_TextureSheetAnimationModule.Instance);
				break;
			case "trails":
				reader.ReadInto<TrailModule>(val.trails, ES3Type_TrailModule.Instance);
				break;
			case "trigger":
				reader.ReadInto<TriggerModule>(val.trigger, ES3Type_TriggerModule.Instance);
				break;
			case "useAutoRandomSeed":
				val.useAutoRandomSeed = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "velocityOverLifetime":
				reader.ReadInto<VelocityOverLifetimeModule>(val.velocityOverLifetime, ES3Type_VelocityOverLifetimeModule.Instance);
				break;
			case "isPaused":
				if (reader.Read<bool>(ES3Type_bool.Instance))
				{
					val.Pause();
				}
				break;
			case "isPlaying":
				if (reader.Read<bool>(ES3Type_bool.Instance))
				{
					val.Play();
				}
				break;
			case "isStopped":
				if (reader.Read<bool>(ES3Type_bool.Instance))
				{
					val.Stop();
				}
				break;
			default:
				reader.Skip();
				break;
			}
		}
	}
}
