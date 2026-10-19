using System;
using Unity.VisualScripting.Community.Utility;

namespace Unity.VisualScripting.Community;

[RenamedFrom("Bolt.Addons.Community.Utility.IDelegate")]
public interface IDelegate
{
	string DisplayName { get; }

	TypeParam[] parameters { get; }

	bool initialized { get; set; }

	object GetDelegate();

	Type GetDelegateType();

	void Bind(IDelegate other);

	void Unbind(IDelegate other);
}
