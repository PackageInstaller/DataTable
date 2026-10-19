using System;
using System.Collections.Generic;
using Bamboo.NumberString;
using Newtonsoft.Json;

namespace ACT.UI;

public class CustomUISchemeDicJsonConverter : JsonConverter<Dictionary<int, CustomUIScheme>>
{
	public override void WriteJson(JsonWriter writer, Dictionary<int, CustomUIScheme> value, JsonSerializer serializer)
	{
		writer.WriteStartObject();
		foreach (var (value2, value3) in value)
		{
			writer.WritePropertyName(value2.FastToString());
			serializer.Serialize(writer, value3, typeof(CustomUIScheme));
		}
		writer.WriteEndObject();
	}

	public override Dictionary<int, CustomUIScheme> ReadJson(JsonReader reader, Type objectType, Dictionary<int, CustomUIScheme> existingValue, bool hasExistingValue, JsonSerializer serializer)
	{
		throw new NotImplementedException();
	}
}
