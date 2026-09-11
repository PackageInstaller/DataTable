using System;

public abstract class AMClientHandler<Message> : IClientHandler where Message : class
{
	public INetCallback mCallback { get; set; }

	protected abstract void Run(Message message);

	public void Handle(object packet)
	{
		if (!(packet is Message message))
		{
			XLogger.Error("消息类型转换错误");
		}
		else
		{
			Run(message);
		}
	}

	public Type GetMessageType()
	{
		return typeof(Message);
	}
}
