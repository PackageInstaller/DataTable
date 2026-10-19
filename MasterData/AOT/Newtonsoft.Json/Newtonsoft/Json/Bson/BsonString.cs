using System.Runtime.CompilerServices;

namespace Newtonsoft.Json.Bson;

internal class BsonString : BsonValue
{
	[CompilerGenerated]
	private readonly bool IncludeLength__BackingField;

	public BsonString(object value, bool includeLength)
		: base(value, BsonType.String)
	{
		IncludeLength__BackingField = includeLength;
	}
}
