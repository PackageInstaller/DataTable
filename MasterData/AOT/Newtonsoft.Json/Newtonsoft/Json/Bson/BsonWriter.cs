using System;
using System.Globalization;
using Newtonsoft.Json.Utilities;

namespace Newtonsoft.Json.Bson;

[Obsolete("BSON reading and writing has been moved to its own package. See https://www.nuget.org/packages/Newtonsoft.Json.Bson for more details.")]
public class BsonWriter : JsonWriter
{
	private readonly BsonBinaryWriter _writer;

	private BsonToken _root;

	private BsonToken _parent;

	private string _propertyName;

	public override void Flush()
	{
		_writer.Flush();
	}

	private void AddValue(object value, BsonType type)
	{
		AddToken(new BsonValue(value, type));
	}

	internal void AddToken(BsonToken token)
	{
		if (_parent != null)
		{
			if (_parent is BsonObject bsonObject)
			{
				bsonObject.Add(_propertyName, token);
				_propertyName = null;
			}
			else
			{
				((BsonArray)_parent).Add(token);
			}
			return;
		}
		if (token.Type != BsonType.Object && token.Type != BsonType.Array)
		{
			throw JsonWriterException.Create(this, "Error writing {0} value. BSON must start with an Object or Array.".FormatWith(CultureInfo.InvariantCulture, token.Type), null);
		}
		_parent = token;
		_root = token;
	}

	public void WriteObjectId(byte[] value)
	{
		ValidationUtils.ArgumentNotNull(value, "value");
		if (value.Length != 12)
		{
			throw JsonWriterException.Create(this, "An object id must be 12 bytes", null);
		}
		SetWriteState(JsonToken.Undefined, null);
		AddValue(value, BsonType.Oid);
	}

	public void WriteRegex(string pattern, string options)
	{
		ValidationUtils.ArgumentNotNull(pattern, "pattern");
		SetWriteState(JsonToken.Undefined, null);
		AddToken(new BsonRegex(pattern, options));
	}
}
