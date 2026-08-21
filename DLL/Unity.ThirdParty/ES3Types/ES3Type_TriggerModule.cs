using UnityEngine;
using UnityEngine.Scripting;

namespace ES3Types;

[ES3Properties(new string[] { "enabled", "inside", "outside", "enter", "exit", "radiusScale" })]
[Preserve]
public class ES3Type_TriggerModule : ES3Type
{
	public static ES3Type Instance;

	public ES3Type_TriggerModule()
		: base(typeof(TriggerModule))
	{
		Instance = this;
	}

	public override void Write(object obj, ES3Writer writer)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_002b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0042: Unknown result type (might be due to invalid IL or missing references)
		//IL_0059: Unknown result type (might be due to invalid IL or missing references)
		//IL_0070: Unknown result type (might be due to invalid IL or missing references)
		TriggerModule val = (TriggerModule)obj;
		writer.WriteProperty("enabled", ((TriggerModule)(ref val)).enabled, ES3Type_bool.Instance);
		writer.WriteProperty("inside", ((TriggerModule)(ref val)).inside);
		writer.WriteProperty("outside", ((TriggerModule)(ref val)).outside);
		writer.WriteProperty("enter", ((TriggerModule)(ref val)).enter);
		writer.WriteProperty("exit", ((TriggerModule)(ref val)).exit);
		writer.WriteProperty("radiusScale", ((TriggerModule)(ref val)).radiusScale, ES3Type_float.Instance);
	}

	public override object Read<T>(ES3Reader reader)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_000a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0015: Unknown result type (might be due to invalid IL or missing references)
		TriggerModule val = default(TriggerModule);
		ReadInto<T>(reader, val);
		return val;
	}

	public override void ReadInto<T>(ES3Reader reader, object obj)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_0073: Unknown result type (might be due to invalid IL or missing references)
		//IL_0082: Unknown result type (might be due to invalid IL or missing references)
		//IL_0091: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a0: Unknown result type (might be due to invalid IL or missing references)
		TriggerModule val = (TriggerModule)obj;
		string text;
		while ((text = reader.ReadPropertyName()) != null)
		{
			switch (text)
			{
			case "enabled":
				((TriggerModule)(ref val)).enabled = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "inside":
				((TriggerModule)(ref val)).inside = reader.Read<ParticleSystemOverlapAction>();
				break;
			case "outside":
				((TriggerModule)(ref val)).outside = reader.Read<ParticleSystemOverlapAction>();
				break;
			case "enter":
				((TriggerModule)(ref val)).enter = reader.Read<ParticleSystemOverlapAction>();
				break;
			case "exit":
				((TriggerModule)(ref val)).exit = reader.Read<ParticleSystemOverlapAction>();
				break;
			case "radiusScale":
				((TriggerModule)(ref val)).radiusScale = reader.Read<float>(ES3Type_float.Instance);
				break;
			default:
				reader.Skip();
				break;
			}
		}
	}
}
