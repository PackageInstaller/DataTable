using System.IO;
using SharpJson;

namespace Spine;

public static class Json
{
	public static object Deserialize(TextReader text)
	{
		return new JsonDecoder
		{
			parseNumbersAsFloat = true
		}.Decode(text.ReadToEnd());
	}
}
