using System;
using Newtonsoft.Json;

namespace ACT.UI;

public class CustomUITransformJsonConverter : JsonConverter<CustomUITransform>
{
	public override void WriteJson(JsonWriter writer, CustomUITransform value, JsonSerializer serializer)
	{
		writer.WriteStartObject();
		writer.WritePropertyName("AnchorX");
		writer.WriteValue(value.AnchorX);
		writer.WritePropertyName("AnchorY");
		writer.WriteValue(value.AnchorY);
		writer.WritePropertyName("PosX");
		writer.WriteValue(value.Pos.x);
		writer.WritePropertyName("PosY");
		writer.WriteValue(value.Pos.y);
		writer.WritePropertyName("Diameter");
		writer.WriteValue(value.Diameter);
		writer.WriteEndObject();
	}

	public override CustomUITransform ReadJson(JsonReader reader, Type objectType, CustomUITransform existingValue, bool hasExistingValue, JsonSerializer serializer)
	{
		throw new NotImplementedException();
	}
}
