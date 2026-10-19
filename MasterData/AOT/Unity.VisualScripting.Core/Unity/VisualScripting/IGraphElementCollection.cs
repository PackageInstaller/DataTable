using System;
using System.Collections;
using System.Collections.Generic;

namespace Unity.VisualScripting;

public interface IGraphElementCollection<T> : IKeyedCollection<Guid, T>, ICollection<T>, IEnumerable<T>, IEnumerable, INotifyCollectionChanged<T> where T : IGraphElement
{
}
