using UnityEngine;
using UnityEngine.Scripting;

namespace ES3Types;

[Preserve]
[ES3Properties(new string[] { "enabled", "color" })]
public class ES3Type_ColorOverLifetimeModule : ES3Type
{
	public static ES3Type Instance;

	public ES3Type_ColorOverLifetimeModule()
		: base(typeof(ColorOverLifetimeModule))
	{
		Instance = this;
	}

	public override void Write(object obj, ES3Writer writer)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_002b: Unknown result type (might be due to invalid IL or missing references)
		ColorOverLifetimeModule val = (ColorOverLifetimeModule)obj;
		writer.WriteProperty("enabled", ((ColorOverLifetimeModule)(ref val)).enabled, ES3Type_bool.Instance);
		writer.WriteProperty("color", ((ColorOverLifetimeModule)(ref val)).color, ES3Type_MinMaxGradient.Instance);
	}

	public override object Read<T>(ES3Reader reader)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_000a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0015: Unknown result type (might be due to invalid IL or missing references)
		ColorOverLifetimeModule val = default(ColorOverLifetimeModule);
		ReadInto<T>(reader, val);
		return val;
	}

	public override void ReadInto<T>(ES3Reader reader, object obj)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_0041: Unknown result type (might be due to invalid IL or missing references)
		ColorOverLifetimeModule val = (ColorOverLifetimeModule)obj;
		string text;
		while ((text = reader.ReadPropertyName()) != null)
		{
			if (!(text == "enabled"))
			{
				if (text == "color")
				{
					((ColorOverLifetimeModule)(ref val)).color = reader.Read<MinMaxGradient>(ES3Type_MinMaxGradient.Instance);
				}
				else
				{
					reader.Skip();
				}
			}
			else
			{
				((ColorOverLifetimeModule)(ref val)).enabled = reader.Read<bool>(ES3Type_bool.Instance);
			}
		}
	}
}
