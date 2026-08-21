using System;
using System.Collections.Generic;
using System.Linq;
using ParadoxNotion.Serialization.FullSerializer;
using ParadoxNotion.Serialization.FullSerializer.Internal;

namespace ParadoxNotion.Serialization;

public class fsRecoveryProcessor<TCanProcess, TMissing> : fsObjectProcessor where TMissing : TCanProcess, IMissingRecoverable
{
	public override bool CanProcess(Type type)
	{
		return typeof(TCanProcess).RTIsAssignableFrom(type);
	}

	public override void OnBeforeDeserialize(Type storageType, ref fsData data)
	{
		if (!data.IsDictionary)
		{
			return;
		}
		Dictionary<string, fsData> json = data.AsDictionary;
		if (!json.TryGetValue("$type", out var value))
		{
			return;
		}
		Type type = fsTypeCache.GetType(value.AsString, storageType);
		if (type == null)
		{
			json["missingType"] = new fsData(value.AsString);
			json["recoveryState"] = new fsData(data.ToString());
			json["$type"] = new fsData(typeof(TMissing).FullName);
		}
		if (!(type == typeof(TMissing)))
		{
			return;
		}
		Type type2 = fsTypeCache.GetType(json["missingType"].AsString, storageType);
		if (type2 != null)
		{
			Dictionary<string, fsData> asDictionary = fsJsonParser.Parse(json["recoveryState"].AsString).AsDictionary;
			json = json.Concat(asDictionary.Where((KeyValuePair<string, fsData> kvp) => !json.ContainsKey(kvp.Key))).ToDictionary((KeyValuePair<string, fsData> c) => c.Key, (KeyValuePair<string, fsData> c) => c.Value);
			json["$type"] = new fsData(type2.FullName);
			data = new fsData(json);
		}
	}
}
