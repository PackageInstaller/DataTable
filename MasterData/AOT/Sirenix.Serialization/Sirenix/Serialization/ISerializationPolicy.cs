using System.Reflection;

namespace Sirenix.Serialization;

public interface ISerializationPolicy
{
	string ID { get; }

	bool AllowNonSerializableTypes { get; }

	bool ShouldSerializeMember(MemberInfo member);
}
