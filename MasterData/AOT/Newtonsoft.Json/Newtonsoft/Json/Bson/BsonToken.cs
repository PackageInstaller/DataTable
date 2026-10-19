namespace Newtonsoft.Json.Bson;

internal abstract class BsonToken
{
	public abstract BsonType Type { get; }

	public BsonToken Parent { set; }
}
