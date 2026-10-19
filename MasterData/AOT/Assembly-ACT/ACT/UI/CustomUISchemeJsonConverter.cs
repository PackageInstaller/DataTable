using System;
using Newtonsoft.Json;

namespace ACT.UI;

public class CustomUISchemeJsonConverter : JsonConverter<CustomUIScheme>
{
	public override void WriteJson(JsonWriter writer, CustomUIScheme value, JsonSerializer serializer)
	{
		writer.WriteStartObject();
		writer.WritePropertyName("Id");
		writer.WriteValue(value.Id);
		writer.WritePropertyName("Name");
		writer.WriteValue(value.GetName());
		writer.WritePropertyName("HudTeamCharacters");
		serializer.Serialize(writer, value.HudTeamCharacters, typeof(CustomUITransform));
		writer.WritePropertyName("HookBtnTransform");
		serializer.Serialize(writer, value.HookBtnTransform, typeof(CustomUITransform));
		writer.WritePropertyName("JumpBtnTransform");
		serializer.Serialize(writer, value.JumpBtnTransform, typeof(CustomUITransform));
		writer.WritePropertyName("DodgeBtnTransform");
		serializer.Serialize(writer, value.DodgeBtnTransform, typeof(CustomUITransform));
		writer.WritePropertyName("AttackBtnTransform");
		serializer.Serialize(writer, value.AttackBtnTransform, typeof(CustomUITransform));
		writer.WritePropertyName("SpAttackBtnTransform");
		serializer.Serialize(writer, value.SpAttackBtnTransform, typeof(CustomUITransform));
		writer.WritePropertyName("UltraBtnTransform");
		serializer.Serialize(writer, value.UltraBtnTransform, typeof(CustomUITransform));
		writer.WritePropertyName("BloodBarTransform");
		serializer.Serialize(writer, value.BloodBarTransform, typeof(CustomUITransform));
		writer.WritePropertyName("EnergyBarTransform");
		serializer.Serialize(writer, value.EnergyBarTransform, typeof(CustomUITransform));
		writer.WritePropertyName("BuffListTransform");
		serializer.Serialize(writer, value.BuffListTransform, typeof(CustomUITransform));
		writer.WritePropertyName("AssistTransform");
		serializer.Serialize(writer, value.AssistTransform, typeof(CustomUITransform));
		writer.WritePropertyName("PropBtnTransform");
		serializer.Serialize(writer, value.PropBtnTransform, typeof(CustomUITransform));
		writer.WritePropertyName("SpecialEnergyBarTransform");
		serializer.Serialize(writer, value.SpecialEnergyBarTransform, typeof(CustomUITransform));
		writer.WritePropertyName("ResetTemplateTransforms");
		serializer.Serialize(writer, value.ResetTemplateTransforms);
		writer.WriteEndObject();
	}

	public override CustomUIScheme ReadJson(JsonReader reader, Type objectType, CustomUIScheme existingValue, bool hasExistingValue, JsonSerializer serializer)
	{
		throw new NotImplementedException();
	}
}
