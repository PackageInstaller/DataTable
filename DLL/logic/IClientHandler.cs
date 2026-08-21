using System;

public interface IClientHandler
{
	INetCallback mCallback { get; set; }

	void Handle(object packet);

	Type GetMessageType();
}
