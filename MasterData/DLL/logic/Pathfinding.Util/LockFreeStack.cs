using System.Threading;

namespace Pathfinding.Util;

public class LockFreeStack
{
	public Path head;

	public void Push(Path p)
	{
		Path path;
		do
		{
			p.next = head;
			path = Interlocked.CompareExchange(ref head, p, p.next);
		}
		while (path != p.next);
	}

	public Path PopAll()
	{
		return Interlocked.Exchange(ref head, null);
	}
}
