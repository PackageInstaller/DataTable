using UnityEngine;
using UnityEngine.Scripting;

namespace ES3Types;

[Preserve]
[ES3Properties(new string[]
{
	"enabled", "size", "sizeMultiplier", "x", "xMultiplier", "y", "yMultiplier", "z", "zMultiplier", "separateAxes",
	"range"
})]
public class ES3Type_SizeBySpeedModule : ES3Type
{
	public static ES3Type Instance;

	public ES3Type_SizeBySpeedModule()
		: base(typeof(SizeBySpeedModule))
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
		SizeBySpeedModule val = (SizeBySpeedModule)obj;
		writer.WriteProperty("enabled", ((SizeBySpeedModule)(ref val)).enabled, ES3Type_bool.Instance);
		writer.WriteProperty("size", ((SizeBySpeedModule)(ref val)).size, ES3Type_MinMaxCurve.Instance);
		writer.WriteProperty("sizeMultiplier", ((SizeBySpeedModule)(ref val)).sizeMultiplier, ES3Type_float.Instance);
		writer.WriteProperty("x", ((SizeBySpeedModule)(ref val)).x, ES3Type_MinMaxCurve.Instance);
		writer.WriteProperty("xMultiplier", ((SizeBySpeedModule)(ref val)).xMultiplier, ES3Type_float.Instance);
		writer.WriteProperty("y", ((SizeBySpeedModule)(ref val)).y, ES3Type_MinMaxCurve.Instance);
		writer.WriteProperty("yMultiplier", ((SizeBySpeedModule)(ref val)).yMultiplier, ES3Type_float.Instance);
		writer.WriteProperty("z", ((SizeBySpeedModule)(ref val)).z, ES3Type_MinMaxCurve.Instance);
		writer.WriteProperty("zMultiplier", ((SizeBySpeedModule)(ref val)).zMultiplier, ES3Type_float.Instance);
		writer.WriteProperty("separateAxes", ((SizeBySpeedModule)(ref val)).separateAxes, ES3Type_bool.Instance);
		writer.WriteProperty("range", ((SizeBySpeedModule)(ref val)).range, ES3Type_Vector2.Instance);
	}

	public override object Read<T>(ES3Reader reader)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_000a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0015: Unknown result type (might be due to invalid IL or missing references)
		SizeBySpeedModule val = default(SizeBySpeedModule);
		ReadInto<T>(reader, val);
		return val;
	}

	public override void ReadInto<T>(ES3Reader reader, object obj)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_0214: Unknown result type (might be due to invalid IL or missing references)
		//IL_01e9: Unknown result type (might be due to invalid IL or missing references)
		//IL_01bb: Unknown result type (might be due to invalid IL or missing references)
		//IL_023c: Unknown result type (might be due to invalid IL or missing references)
		SizeBySpeedModule val = (SizeBySpeedModule)obj;
		string text;
		while ((text = reader.ReadPropertyName()) != null)
		{
			switch (text)
			{
			case "enabled":
				((SizeBySpeedModule)(ref val)).enabled = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "size":
				((SizeBySpeedModule)(ref val)).size = reader.Read<MinMaxCurve>(ES3Type_MinMaxCurve.Instance);
				break;
			case "sizeMultiplier":
				((SizeBySpeedModule)(ref val)).sizeMultiplier = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "x":
				((SizeBySpeedModule)(ref val)).x = reader.Read<MinMaxCurve>(ES3Type_MinMaxCurve.Instance);
				break;
			case "xMultiplier":
				((SizeBySpeedModule)(ref val)).xMultiplier = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "y":
				((SizeBySpeedModule)(ref val)).y = reader.Read<MinMaxCurve>(ES3Type_MinMaxCurve.Instance);
				break;
			case "yMultiplier":
				((SizeBySpeedModule)(ref val)).yMultiplier = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "z":
				((SizeBySpeedModule)(ref val)).z = reader.Read<MinMaxCurve>(ES3Type_MinMaxCurve.Instance);
				break;
			case "zMultiplier":
				((SizeBySpeedModule)(ref val)).zMultiplier = reader.Read<float>(ES3Type_float.Instance);
				break;
			case "separateAxes":
				((SizeBySpeedModule)(ref val)).separateAxes = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "range":
				((SizeBySpeedModule)(ref val)).range = reader.Read<Vector2>(ES3Type_Vector2.Instance);
				break;
			default:
				reader.Skip();
				break;
			}
		}
	}
}
