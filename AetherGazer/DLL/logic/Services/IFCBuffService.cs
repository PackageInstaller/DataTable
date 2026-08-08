using System;

namespace Services;

public interface IFCBuffService
{
	void AddBuffEventHandler(Action<int, int, int, EBuffLife, bool> handler, bool isOnce);

	void RemoveBuffEventHandler(Action<int, int, int, EBuffLife, bool> handler);
}
