using UnityEngine;
using UnityEngine.Scripting;

namespace ES3Types;

[Preserve]
[ES3Properties(new string[] { "enabled", "size", "sizeMultiplier", "x", "xMultiplier", "y", "yMultiplier", "z", "zMultiplier", "separateAxes" })]
public class ES3Type_SizeOverLifetimeModule : ES3Type
{
	public static ES3Type Instance;

	public ES3Type_SizeOverLifetimeModule()
		: base(typeof(SizeOverLifetimeModule))
	{
		Instance = this;
	}

	public override void Write(object obj, ES3Writer writer)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_002b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0063: Unknown result type (might be due to invalid IL or missing references)
		//IL_009b: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d3: Unknown result type (might be due to invalid IL or missing references)
		SizeOverLifetimeModule val = (SizeOverLifetimeModule)obj;
		writer.WriteProperty("enabled", ((SizeOverLifetimeModule)(ref val)).enabled, ES3Type_bool.Instance);
		writer.WriteProperty("size", ((SizeOverLifetimeModule)(ref val)).size, ES3Type_MinMaxCurve.Instance);
		writer.WriteProperty("sizeMultiplier", ((SizeOverLifetimeModule)(ref val)).sizeMultiplier, ES3Type_float.Instance);
		writer.WriteProperty("x", ((SizeOverLifetimeModule)(ref val)).x, ES3Type_MinMaxCurve.Instance);
		writer.WriteProperty("xMultiplier", ((SizeOverLifetimeModule)(ref val)).xMultiplier, ES3Type_float.Instance);
		writer.WriteProperty("y", ((SizeOverLifetimeModule)(ref val)).y, ES3Type_MinMaxCurve.Instance);
		writer.WriteProperty("yMultiplier", ((SizeOverLifetimeModule)(ref val)).yMultiplier, ES3Type_float.Instance);
		writer.WriteProperty("z", ((SizeOverLifetimeModule)(ref val)).z, ES3Type_MinMaxCurve.Instance);
		writer.WriteProperty("zMultiplier", ((SizeOverLifetimeModule)(ref val)).zMultiplier, ES3Type_float.Instance);
		writer.WriteProperty("separateAxes", ((SizeOverLifetimeModule)(ref val)).separateAxes, ES3Type_bool.Instance);
	}

	public override object Read<T>(ES3Reader reader)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_000a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0015: Unknown result type (might be due to invalid IL or missing references)
		SizeOverLifetimeModule val = default(SizeOverLifetimeModule);
		ReadInto<T>(reader, val);
		return val;
	}

	public override void ReadInto<T>(ES3Reader reader, object obj)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_01e8: Unknown result type (might be due to invalid IL or missing references)
		//IL_01c0: Unknown result type (might be due to invalid IL or missing references)
		//IL_0192: Unknown result type (might be due to invalid IL or missing references)
		//IL_0210: Unknown result type (might be due to invalid IL or missing references)
		SizeOverLifetimeModule val = (SizeOverLifetimeModule)obj;
		string text;
		while ((text = reader.ReadPropertyName()) != null)
		{
			switch (text)
			{
			case "enabled":
				((SizeOverLifetimeModule)(ref val)).enabled = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "size":
				((SizeOverLifetimeModule)(ref val)).size = reader.Read<MinMaxCurve>(ES3Type_MinMaxCurve.Instance);
				break;
			case "sizeMultiplier":
				((SizeOverLifetimeModule)(ref val)).sizeMultiplier = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "x":
				((SizeOverLifetimeModule)(ref val)).x = reader.Read<MinMaxCurve>(ES3Type_MinMaxCurve.Instance);
				break;
			case "xMultiplier":
				((SizeOverLifetimeModule)(ref val)).xMultiplier = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "y":
				((SizeOverLifetimeModule)(ref val)).y = reader.Read<MinMaxCurve>(ES3Type_MinMaxCurve.Instance);
				break;
			case "yMultiplier":
				((SizeOverLifetimeModule)(ref val)).yMultiplier = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "z":
				((SizeOverLifetimeModule)(ref val)).z = reader.Read<MinMaxCurve>(ES3Type_MinMaxCurve.Instance);
				break;
			case "zMultiplier":
				((SizeOverLifetimeModule)(ref val)).zMultiplier = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "separateAxes":
				((SizeOverLifetimeModule)(ref val)).separateAxes = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			default:
				reader.Skip();
				break;
			}
		}
	}
}
