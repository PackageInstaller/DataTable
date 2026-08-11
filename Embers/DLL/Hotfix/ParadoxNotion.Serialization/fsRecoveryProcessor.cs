using System;
using System.Collections.Generic;
using System.Linq;
using ParadoxNotion.Serialization.FullSerializer;
using ParadoxNotion.Services;

namespace ParadoxNotion.Serialization;

public class fsRecoveryProcessor<TCanProcess, TMissing> : fsObjectProcessor where TMissing : TCanProcess, IMissingRecoverable
{
	private const string FIELD_NAME_TYPE = "_missingType";

	private const string FIELD_NAME_STATE = "_recoveryState";

	public override bool CanProcess(Type type)
	{
		return typeof(TCanProcess).RTIsAssignableFrom(type);
	}

	public override void OnBeforeDeserialize(Type storageType, ref fsData data)
	{
		if (Threader.applicationIsPlaying || !data.IsDictionary)
		{
			return;
		}
		Dictionary<string, fsData> json = data.AsDictionary;
		if (!json.TryGetValue("$type", out var value))
		{
			return;
		}
		Type type = ReflectionTools.GetType(value.AsString, storageType);
		if (type == null)
		{
			string asString = value.AsString;
			string str = fsJsonPrinter.PrettyJson(data);
			json["_missingType"] = new fsData(asString);
			json["_recoveryState"] = new fsData(str);
			json["$type"] = new fsData(typeof(TMissing).FullName);
		}
		if (!(type == typeof(TMissing)))
		{
			return;
		}
		Type type2 = ReflectionTools.GetType(json["_missingType"].AsString, storageType);
		if (type2 != null)
		{
			Dictionary<string, fsData> asDictionary = fsJsonParser.Parse(json["_recoveryState"].AsString).AsDictionary;
			json = json.Concat(asDictionary.Where((KeyValuePair<string, fsData> kvp) => !json.ContainsKey(kvp.Key))).ToDictionary((KeyValuePair<string, fsData> c) => c.Key, (KeyValuePair<string, fsData> c) => c.Value);
			json["$type"] = new fsData(type2.FullName);
			data = new fsData(json);
		}
	}
}
