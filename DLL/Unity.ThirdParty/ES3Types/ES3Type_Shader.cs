using UnityEngine;
using UnityEngine.Scripting;

namespace ES3Types;

[Preserve]
[ES3Properties(new string[] { "name", "maximumLOD" })]
public class ES3Type_Shader : ES3Type
{
	public static ES3Type Instance;

	public ES3Type_Shader()
		: base(typeof(Shader))
	{
		Instance = this;
	}

	public override void Write(object obj, ES3Writer writer)
	{
		Shader shader = (Shader)obj;
		writer.WriteProperty("name", shader.name, ES3Type_string.Instance);
		writer.WriteProperty("maximumLOD", shader.maximumLOD, ES3Type_int.Instance);
	}

	public override object Read<T>(ES3Reader reader)
	{
		Shader shader = Shader.Find(reader.ReadProperty<string>(ES3Type_string.Instance));
		if (shader == null)
		{
			shader = Shader.Find("Diffuse");
		}
		ReadInto<T>(reader, shader);
		return shader;
	}

	public override void ReadInto<T>(ES3Reader reader, object obj)
	{
		Shader shader = (Shader)obj;
		foreach (string property in reader.Properties)
		{
			if (!(property == "name"))
			{
				if (property == "maximumLOD")
				{
					shader.maximumLOD = reader.Read<int>(ES3Type_int.Instance);
				}
				else
				{
					reader.Skip();
				}
			}
			else
			{
				shader.name = reader.Read<string>(ES3Type_string.Instance);
			}
		}
	}
}
