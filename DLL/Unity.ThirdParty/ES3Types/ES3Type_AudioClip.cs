using UnityEngine;
using UnityEngine.Scripting;

namespace ES3Types;

[ES3Properties(new string[] { "name", "samples", "channels", "frequency", "sampleData" })]
[Preserve]
public class ES3Type_AudioClip : ES3UnityObjectType
{
	public static ES3Type Instance;

	public ES3Type_AudioClip()
		: base(typeof(AudioClip))
	{
		Instance = this;
	}

	protected override void WriteUnityObject(object obj, ES3Writer writer)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Expected O, but got Unknown
		AudioClip val = (AudioClip)obj;
		float[] array = new float[val.samples * val.channels];
		val.GetData(array, 0);
		writer.WriteProperty("name", ((Object)(object)val).name);
		writer.WriteProperty("samples", val.samples);
		writer.WriteProperty("channels", val.channels);
		writer.WriteProperty("frequency", val.frequency);
		writer.WriteProperty("sampleData", array);
	}

	protected override void ReadUnityObject<T>(ES3Reader reader, object obj)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Expected O, but got Unknown
		AudioClip val = (AudioClip)obj;
		foreach (string property in reader.Properties)
		{
			if (property == "sampleData")
			{
				val.SetData(reader.Read<float[]>(ES3Type_floatArray.Instance), 0);
			}
			else
			{
				reader.Skip();
			}
		}
	}

	protected override object ReadUnityObject<T>(ES3Reader reader)
	{
		string text = "";
		int num = 0;
		int num2 = 0;
		int num3 = 0;
		AudioClip val = null;
		foreach (string property in reader.Properties)
		{
			switch (property)
			{
			case "name":
				text = reader.Read<string>(ES3Type_string.Instance);
				break;
			case "samples":
				num = reader.Read<int>(ES3Type_int.Instance);
				break;
			case "channels":
				num2 = reader.Read<int>(ES3Type_int.Instance);
				break;
			case "frequency":
				num3 = reader.Read<int>(ES3Type_int.Instance);
				break;
			case "sampleData":
				val = AudioClip.Create(text, num, num2, num3, false);
				val.SetData(reader.Read<float[]>(ES3Type_floatArray.Instance), 0);
				break;
			default:
				reader.Skip();
				break;
			}
		}
		return val;
	}
}
