using System.Globalization;
using System.IO;

namespace Newtonsoft.Json.Linq;

public class JRaw : JValue
{
	internal JRaw(JRaw other, JsonCloneSettings? settings)
		: base(other, settings)
	{
	}

	public JRaw(object? rawJson)
		: base(rawJson, JTokenType.Raw)
	{
	}

	public static JRaw Create(JsonReader reader)
	{
		using StringWriter stringWriter = new StringWriter(CultureInfo.InvariantCulture);
		using JsonTextWriter jsonTextWriter = new JsonTextWriter(stringWriter);
		jsonTextWriter.WriteToken(reader);
		return new JRaw(stringWriter.ToString());
	}

	internal override JToken CloneToken(JsonCloneSettings? settings)
	{
		return new JRaw(this, settings);
	}
}
