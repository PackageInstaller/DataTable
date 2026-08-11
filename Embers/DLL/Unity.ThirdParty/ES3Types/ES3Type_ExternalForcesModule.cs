using UnityEngine;
using UnityEngine.Scripting;

namespace ES3Types;

[Preserve]
[ES3Properties(new string[] { "enabled", "multiplier" })]
public class ES3Type_ExternalForcesModule : ES3Type
{
	public static ES3Type Instance;

	public ES3Type_ExternalForcesModule()
		: base(typeof(ExternalForcesModule))
	{
		Instance = this;
	}

	public override void Write(object obj, ES3Writer writer)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		ExternalForcesModule val = (ExternalForcesModule)obj;
		writer.WriteProperty("enabled", ((ExternalForcesModule)(ref val)).enabled, ES3Type_bool.Instance);
		writer.WriteProperty("multiplier", ((ExternalForcesModule)(ref val)).multiplier, ES3Type_float.Instance);
	}

	public override object Read<T>(ES3Reader reader)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_000a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0015: Unknown result type (might be due to invalid IL or missing references)
		ExternalForcesModule val = default(ExternalForcesModule);
		ReadInto<T>(reader, val);
		return val;
	}

	public override void ReadInto<T>(ES3Reader reader, object obj)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		ExternalForcesModule val = (ExternalForcesModule)obj;
		string text;
		while ((text = reader.ReadPropertyName()) != null)
		{
			if (!(text == "enabled"))
			{
				if (text == "multiplier")
				{
					((ExternalForcesModule)(ref val)).multiplier = reader.Read<float>(ES3Type_float.Instance);
				}
				else
				{
					reader.Skip();
				}
			}
			else
			{
				((ExternalForcesModule)(ref val)).enabled = reader.Read<bool>(ES3Type_bool.Instance);
			}
		}
	}
}
