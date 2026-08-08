using System;
using System.Collections.Generic;
using ParadoxNotion;
using ParadoxNotion.Serialization;
using ParadoxNotion.Serialization.FullSerializer;

namespace NodeCanvas.Framework.Internal;

public class fsBBParameterProcessor : fsRecoveryProcessor<BBParameter, MissingBBParameterType>
{
	public override void OnBeforeDeserializeAfterInstanceCreation(Type storageType, object instance, ref fsData data)
	{
		if (data.IsDictionary)
		{
			Dictionary<string, fsData> asDictionary = data.AsDictionary;
			if (asDictionary.Count == 0 || asDictionary.ContainsKey("_value") || asDictionary.ContainsKey("_name"))
			{
				return;
			}
		}
		if (instance is BBParameter bBParameter && bBParameter.GetType().RTIsGenericType())
		{
			Type varType = bBParameter.varType;
			fsSerializer fsSerializer2 = new fsSerializer();
			object result = null;
			if (fsSerializer2.TryDeserialize(data, varType, ref result).Succeeded && result != null && varType.RTIsAssignableFrom(result.GetType()))
			{
				bBParameter.value = result;
				fsSerializer2.TrySerialize(storageType, instance, out data);
			}
		}
	}
}
