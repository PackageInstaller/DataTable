using System.Collections;
using System.Collections.Generic;

namespace Unity.VisualScripting;

public interface IUnitPortCollection<TPort> : IKeyedCollection<string, TPort>, ICollection<TPort>, IEnumerable<TPort>, IEnumerable where TPort : IUnitPort
{
	TPort Single();
}
