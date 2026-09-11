namespace System.Runtime.Serialization;

[Serializable]
internal sealed class MemberHolder
{
	internal readonly Type _memberType;

	internal readonly StreamingContext _context;

	internal MemberHolder(Type type, StreamingContext ctx)
	{
		_memberType = type;
		_context = ctx;
	}

	public override int GetHashCode()
	{
		return _memberType.GetHashCode();
	}

	public override bool Equals(object obj)
	{
		if (obj is MemberHolder memberHolder && (object)memberHolder._memberType == _memberType)
		{
			return memberHolder._context.State == _context.State;
		}
		return false;
	}
}
