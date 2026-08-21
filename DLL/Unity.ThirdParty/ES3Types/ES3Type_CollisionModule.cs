using UnityEngine;
using UnityEngine.Scripting;

namespace ES3Types;

[ES3Properties(new string[]
{
	"enabled", "type", "mode", "dampen", "dampenMultiplier", "bounce", "bounceMultiplier", "lifetimeLoss", "lifetimeLossMultiplier", "minKillSpeed",
	"maxKillSpeed", "collidesWith", "enableDynamicColliders", "maxCollisionShapes", "quality", "voxelSize", "radiusScale", "sendCollisionMessages"
})]
[Preserve]
public class ES3Type_CollisionModule : ES3Type
{
	public static ES3Type Instance;

	public ES3Type_CollisionModule()
		: base(typeof(CollisionModule))
	{
		Instance = this;
	}

	public override void Write(object obj, ES3Writer writer)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_0026: Unknown result type (might be due to invalid IL or missing references)
		//IL_003d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0054: Unknown result type (might be due to invalid IL or missing references)
		//IL_0082: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b0: Unknown result type (might be due to invalid IL or missing references)
		//IL_0151: Unknown result type (might be due to invalid IL or missing references)
		CollisionModule val = (CollisionModule)obj;
		writer.WriteProperty("enabled", ((CollisionModule)(ref val)).enabled);
		writer.WriteProperty("type", ((CollisionModule)(ref val)).type);
		writer.WriteProperty("mode", ((CollisionModule)(ref val)).mode);
		writer.WriteProperty("dampen", ((CollisionModule)(ref val)).dampen);
		writer.WriteProperty("dampenMultiplier", ((CollisionModule)(ref val)).dampenMultiplier);
		writer.WriteProperty("bounce", ((CollisionModule)(ref val)).bounce);
		writer.WriteProperty("bounceMultiplier", ((CollisionModule)(ref val)).bounceMultiplier);
		writer.WriteProperty("lifetimeLoss", ((CollisionModule)(ref val)).lifetimeLoss);
		writer.WriteProperty("lifetimeLossMultiplier", ((CollisionModule)(ref val)).lifetimeLossMultiplier);
		writer.WriteProperty("minKillSpeed", ((CollisionModule)(ref val)).minKillSpeed);
		writer.WriteProperty("maxKillSpeed", ((CollisionModule)(ref val)).maxKillSpeed);
		writer.WriteProperty("collidesWith", ((CollisionModule)(ref val)).collidesWith);
		writer.WriteProperty("enableDynamicColliders", ((CollisionModule)(ref val)).enableDynamicColliders);
		writer.WriteProperty("maxCollisionShapes", ((CollisionModule)(ref val)).maxCollisionShapes);
		writer.WriteProperty("quality", ((CollisionModule)(ref val)).quality);
		writer.WriteProperty("voxelSize", ((CollisionModule)(ref val)).voxelSize);
		writer.WriteProperty("radiusScale", ((CollisionModule)(ref val)).radiusScale);
		writer.WriteProperty("sendCollisionMessages", ((CollisionModule)(ref val)).sendCollisionMessages);
	}

	public override object Read<T>(ES3Reader reader)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_000a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0015: Unknown result type (might be due to invalid IL or missing references)
		CollisionModule val = default(CollisionModule);
		ReadInto<T>(reader, val);
		return val;
	}

	public override void ReadInto<T>(ES3Reader reader, object obj)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_0340: Unknown result type (might be due to invalid IL or missing references)
		//IL_02ee: Unknown result type (might be due to invalid IL or missing references)
		//IL_02c5: Unknown result type (might be due to invalid IL or missing references)
		//IL_03af: Unknown result type (might be due to invalid IL or missing references)
		//IL_0317: Unknown result type (might be due to invalid IL or missing references)
		//IL_02d7: Unknown result type (might be due to invalid IL or missing references)
		CollisionModule val = (CollisionModule)obj;
		string text;
		while ((text = reader.ReadPropertyName()) != null)
		{
			switch (text)
			{
			case "enabled":
				((CollisionModule)(ref val)).enabled = reader.Read<bool>();
				break;
			case "type":
				((CollisionModule)(ref val)).type = reader.Read<ParticleSystemCollisionType>();
				break;
			case "mode":
				((CollisionModule)(ref val)).mode = reader.Read<ParticleSystemCollisionMode>();
				break;
			case "dampen":
				((CollisionModule)(ref val)).dampen = reader.Read<MinMaxCurve>(ES3Type_MinMaxCurve.Instance);
				break;
			case "dampenMultiplier":
				((CollisionModule)(ref val)).dampenMultiplier = reader.Read<float>();
				break;
			case "bounce":
				((CollisionModule)(ref val)).bounce = reader.Read<MinMaxCurve>(ES3Type_MinMaxCurve.Instance);
				break;
			case "bounceMultiplier":
				((CollisionModule)(ref val)).bounceMultiplier = reader.Read<float>();
				break;
			case "lifetimeLoss":
				((CollisionModule)(ref val)).lifetimeLoss = reader.Read<MinMaxCurve>(ES3Type_MinMaxCurve.Instance);
				break;
			case "lifetimeLossMultiplier":
				((CollisionModule)(ref val)).lifetimeLossMultiplier = reader.Read<float>();
				break;
			case "minKillSpeed":
				((CollisionModule)(ref val)).minKillSpeed = reader.Read<float>();
				break;
			case "maxKillSpeed":
				((CollisionModule)(ref val)).maxKillSpeed = reader.Read<float>();
				break;
			case "collidesWith":
				((CollisionModule)(ref val)).collidesWith = reader.Read<LayerMask>();
				break;
			case "enableDynamicColliders":
				((CollisionModule)(ref val)).enableDynamicColliders = reader.Read<bool>();
				break;
			case "maxCollisionShapes":
				((CollisionModule)(ref val)).maxCollisionShapes = reader.Read<int>();
				break;
			case "quality":
				((CollisionModule)(ref val)).quality = reader.Read<ParticleSystemCollisionQuality>();
				break;
			case "voxelSize":
				((CollisionModule)(ref val)).voxelSize = reader.Read<float>();
				break;
			case "radiusScale":
				((CollisionModule)(ref val)).radiusScale = reader.Read<float>();
				break;
			case "sendCollisionMessages":
				((CollisionModule)(ref val)).sendCollisionMessages = reader.Read<bool>();
				break;
			default:
				reader.Skip();
				break;
			}
		}
	}
}
