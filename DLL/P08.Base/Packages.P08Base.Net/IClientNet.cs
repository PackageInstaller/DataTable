using System;

namespace Packages.P08Base.Net;

public interface IClientNet
{
	void Init();

	void Connect(string ip, int port, Action callback, Action<int> onError = null);

	void PullEvent();

	void Disconnect();

	void Shutdown();
}
