using System.Collections;
using System.Collections.Generic;

namespace ACT.World.StateObject;

public interface IInteractActionListAssignable : IEnumerable<InteractActionList>, IEnumerable
{
	IEnumerator IEnumerable.GetEnumerator()
	{
		return GetEnumerator();
	}
}
