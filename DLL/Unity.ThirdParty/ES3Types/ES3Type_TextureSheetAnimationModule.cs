using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Scripting;

namespace ES3Types;

[ES3Properties(new string[]
{
	"enabled", "numTilesX", "numTilesY", "animation", "useRandomRow", "frameOverTime", "frameOverTimeMultiplier", "startFrame", "startFrameMultiplier", "cycleCount",
	"rowIndex", "uvChannelMask", "flipU", "flipV"
})]
[Preserve]
public class ES3Type_TextureSheetAnimationModule : ES3Type
{
	public static ES3Type Instance;

	public ES3Type_TextureSheetAnimationModule()
		: base(typeof(TextureSheetAnimationModule))
	{
		Instance = this;
	}

	public override void Write(object obj, ES3Writer writer)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_0063: Unknown result type (might be due to invalid IL or missing references)
		//IL_007a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0091: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c9: Unknown result type (might be due to invalid IL or missing references)
		//IL_0139: Unknown result type (might be due to invalid IL or missing references)
		TextureSheetAnimationModule val = (TextureSheetAnimationModule)obj;
		writer.WriteProperty("enabled", ((TextureSheetAnimationModule)(ref val)).enabled, ES3Type_bool.Instance);
		writer.WriteProperty("numTilesX", ((TextureSheetAnimationModule)(ref val)).numTilesX, ES3Type_int.Instance);
		writer.WriteProperty("numTilesY", ((TextureSheetAnimationModule)(ref val)).numTilesY, ES3Type_int.Instance);
		writer.WriteProperty("animation", ((TextureSheetAnimationModule)(ref val)).animation);
		writer.WriteProperty("useRandomRow", ((TextureSheetAnimationModule)(ref val)).rowMode);
		writer.WriteProperty("frameOverTime", ((TextureSheetAnimationModule)(ref val)).frameOverTime, ES3Type_MinMaxCurve.Instance);
		writer.WriteProperty("frameOverTimeMultiplier", ((TextureSheetAnimationModule)(ref val)).frameOverTimeMultiplier, ES3Type_float.Instance);
		writer.WriteProperty("startFrame", ((TextureSheetAnimationModule)(ref val)).startFrame, ES3Type_MinMaxCurve.Instance);
		writer.WriteProperty("startFrameMultiplier", ((TextureSheetAnimationModule)(ref val)).startFrameMultiplier, ES3Type_float.Instance);
		writer.WriteProperty("cycleCount", ((TextureSheetAnimationModule)(ref val)).cycleCount, ES3Type_int.Instance);
		writer.WriteProperty("rowIndex", ((TextureSheetAnimationModule)(ref val)).rowIndex, ES3Type_int.Instance);
		writer.WriteProperty("uvChannelMask", ((TextureSheetAnimationModule)(ref val)).uvChannelMask);
	}

	public override object Read<T>(ES3Reader reader)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_000a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0015: Unknown result type (might be due to invalid IL or missing references)
		TextureSheetAnimationModule val = default(TextureSheetAnimationModule);
		ReadInto<T>(reader, val);
		return val;
	}

	public override void ReadInto<T>(ES3Reader reader, object obj)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_01fb: Unknown result type (might be due to invalid IL or missing references)
		//IL_020d: Unknown result type (might be due to invalid IL or missing references)
		//IL_024c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0224: Unknown result type (might be due to invalid IL or missing references)
		//IL_0297: Unknown result type (might be due to invalid IL or missing references)
		TextureSheetAnimationModule val = (TextureSheetAnimationModule)obj;
		string text;
		while ((text = reader.ReadPropertyName()) != null)
		{
			switch (text)
			{
			case "enabled":
				((TextureSheetAnimationModule)(ref val)).enabled = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "numTilesX":
				((TextureSheetAnimationModule)(ref val)).numTilesX = reader.Read<int>(ES3Type_int.Instance);
				break;
			case "numTilesY":
				((TextureSheetAnimationModule)(ref val)).numTilesY = reader.Read<int>(ES3Type_int.Instance);
				break;
			case "animation":
				((TextureSheetAnimationModule)(ref val)).animation = reader.Read<ParticleSystemAnimationType>();
				break;
			case "rowMode":
				((TextureSheetAnimationModule)(ref val)).rowMode = reader.Read<ParticleSystemAnimationRowMode>();
				break;
			case "frameOverTime":
				((TextureSheetAnimationModule)(ref val)).frameOverTime = reader.Read<MinMaxCurve>(ES3Type_MinMaxCurve.Instance);
				break;
			case "frameOverTimeMultiplier":
				((TextureSheetAnimationModule)(ref val)).frameOverTimeMultiplier = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "startFrame":
				((TextureSheetAnimationModule)(ref val)).startFrame = reader.Read<MinMaxCurve>(ES3Type_MinMaxCurve.Instance);
				break;
			case "startFrameMultiplier":
				((TextureSheetAnimationModule)(ref val)).startFrameMultiplier = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "cycleCount":
				((TextureSheetAnimationModule)(ref val)).cycleCount = reader.Read<int>(ES3Type_int.Instance);
				break;
			case "rowIndex":
				((TextureSheetAnimationModule)(ref val)).rowIndex = reader.Read<int>(ES3Type_int.Instance);
				break;
			case "uvChannelMask":
				((TextureSheetAnimationModule)(ref val)).uvChannelMask = reader.Read<UVChannelFlags>();
				break;
			default:
				reader.Skip();
				break;
			}
		}
	}
}
