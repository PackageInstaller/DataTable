using UnityEngine;
using UnityEngine.Scripting;

namespace ES3Types;

[Preserve]
[ES3Properties(new string[] { "enabled", "color", "range" })]
public class ES3Type_ColorBySpeedModule : ES3Type
{
	public static ES3Type Instance;

	public ES3Type_ColorBySpeedModule()
		: base(typeof(ColorBySpeedModule))
	{
		Instance = this;
	}

	public override void Write(object obj, ES3Writer writer)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_002b: Unknown result type (might be due to invalid IL or missing references)
		ColorBySpeedModule val = (ColorBySpeedModule)obj;
		writer.WriteProperty("enabled", ((ColorBySpeedModule)(ref val)).enabled, ES3Type_bool.Instance);
		writer.WriteProperty("color", ((ColorBySpeedModule)(ref val)).color, ES3Type_MinMaxGradient.Instance);
		writer.WriteProperty("range", ((ColorBySpeedModule)(ref val)).range, ES3Type_Vector2.Instance);
	}

	public override object Read<T>(ES3Reader reader)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_000a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0015: Unknown result type (might be due to invalid IL or missing references)
		ColorBySpeedModule val = default(ColorBySpeedModule);
		ReadInto<T>(reader, val);
		return val;
	}

	public override void ReadInto<T>(ES3Reader reader, object obj)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_004e: Unknown result type (might be due to invalid IL or missing references)
		ColorBySpeedModule val = (ColorBySpeedModule)obj;
		string text;
		while ((text = reader.ReadPropertyName()) != null)
		{
			switch (text)
			{
			case "enabled":
				((ColorBySpeedModule)(ref val)).enabled = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "color":
				((ColorBySpeedModule)(ref val)).color = reader.Read<MinMaxGradient>(ES3Type_MinMaxGradient.Instance);
				break;
			case "range":
				((ColorBySpeedModule)(ref val)).range = reader.Read<Vector2>(ES3Type_Vector2.Instance);
				break;
			default:
				reader.Skip();
				break;
			}
		}
	}
}
