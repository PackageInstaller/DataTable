using System.Collections.Generic;

namespace Newtonsoft.Json.Bson;

internal class BsonObject : BsonToken
{
	private readonly List<BsonProperty> _children;

	public override BsonType Type => BsonType.Object;

	public void Add(string name, BsonToken token)
	{
		_children.Add(new BsonProperty
		{
			Name = new BsonString(name, includeLength: false),
			Value = token
		});
		token.Parent = this;
	}
}
