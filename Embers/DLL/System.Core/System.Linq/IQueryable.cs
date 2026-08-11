using System.Collections;
using System.Collections.Generic;

namespace System.Linq;

public interface IQueryable<out T> : IEnumerable<T>, IEnumerable
{
}
