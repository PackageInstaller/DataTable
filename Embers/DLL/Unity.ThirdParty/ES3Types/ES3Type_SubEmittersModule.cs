using UnityEngine;
using UnityEngine.Scripting;

namespace ES3Types;

[ES3Properties(new string[] { "properties", "systems", "types" })]
[Preserve]
public class ES3Type_SubEmittersModule : ES3Type
{
	public static ES3Type Instance;

	public ES3Type_SubEmittersModule()
		: base(typeof(SubEmittersModule))
	{
		Instance = this;
	}

	public override void Write(object obj, ES3Writer writer)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_003a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0040: Expected I4, but got Unknown
		//IL_0054: Unknown result type (might be due to invalid IL or missing references)
		//IL_005a: Expected I4, but got Unknown
		SubEmittersModule val = (SubEmittersModule)obj;
		ParticleSystemSubEmitterProperties[] array = (ParticleSystemSubEmitterProperties[])(object)new ParticleSystemSubEmitterProperties[((SubEmittersModule)(ref val)).subEmittersCount];
		ParticleSystem[] array2 = (ParticleSystem[])(object)new ParticleSystem[((SubEmittersModule)(ref val)).subEmittersCount];
		ParticleSystemSubEmitterType[] array3 = (ParticleSystemSubEmitterType[])(object)new ParticleSystemSubEmitterType[((SubEmittersModule)(ref val)).subEmittersCount];
		for (int i = 0; i < ((SubEmittersModule)(ref val)).subEmittersCount; i++)
		{
			array[i] = (ParticleSystemSubEmitterProperties)(int)((SubEmittersModule)(ref val)).GetSubEmitterProperties(i);
			array2[i] = ((SubEmittersModule)(ref val)).GetSubEmitterSystem(i);
			array3[i] = (ParticleSystemSubEmitterType)(int)((SubEmittersModule)(ref val)).GetSubEmitterType(i);
		}
		writer.WriteProperty("properties", array);
		writer.WriteProperty("systems", array2);
		writer.WriteProperty("types", array3);
	}

	public override object Read<T>(ES3Reader reader)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_000a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0015: Unknown result type (might be due to invalid IL or missing references)
		SubEmittersModule val = default(SubEmittersModule);
		ReadInto<T>(reader, val);
		return val;
	}

	public override void ReadInto<T>(ES3Reader reader, object obj)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		SubEmittersModule val = (SubEmittersModule)obj;
		ParticleSystemSubEmitterProperties[] array = null;
		ParticleSystem[] array2 = null;
		ParticleSystemSubEmitterType[] array3 = null;
		string text;
		while ((text = reader.ReadPropertyName()) != null)
		{
			switch (text)
			{
			case "enabled":
				((SubEmittersModule)(ref val)).enabled = reader.Read<bool>(ES3Type_bool.Instance);
				break;
			case "properties":
				array = reader.Read<ParticleSystemSubEmitterProperties[]>(new ES3ArrayType(typeof(ParticleSystemSubEmitterProperties[])));
				break;
			case "systems":
				array2 = reader.Read<ParticleSystem[]>();
				break;
			case "types":
				array3 = reader.Read<ParticleSystemSubEmitterType[]>();
				break;
			default:
				reader.Skip();
				break;
			}
		}
		if (array != null)
		{
			for (int i = 0; i < array.Length; i++)
			{
				((SubEmittersModule)(ref val)).RemoveSubEmitter(i);
				((SubEmittersModule)(ref val)).AddSubEmitter(array2[i], array3[i], array[i]);
			}
		}
	}
}
