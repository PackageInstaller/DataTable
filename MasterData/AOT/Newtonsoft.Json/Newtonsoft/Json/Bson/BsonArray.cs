using System.Collections.Generic;

namespace Newtonsoft.Json.Bson;

internal class BsonArray : BsonToken
{
	private readonly List<BsonToken> _children;

	public override BsonType Type => BsonType.Array;

	public void Add(BsonToken token)
	{
		_children.Add(token);
		token.Parent = this;
	}
}
