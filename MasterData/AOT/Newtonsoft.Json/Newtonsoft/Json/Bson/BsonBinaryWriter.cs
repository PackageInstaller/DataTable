using System.IO;
using System.Text;

namespace Newtonsoft.Json.Bson;

internal class BsonBinaryWriter
{
	private static readonly Encoding Encoding = new UTF8Encoding(encoderShouldEmitUTF8Identifier: false);

	private readonly BinaryWriter _writer;

	public void Flush()
	{
		_writer.Flush();
	}
}
